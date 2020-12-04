/* Copyright(C) 2016 Interactive Health Solutions, Pvt. Ltd.

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as
published by the Free Software Foundation; either version 3 of the License (GPLv3), or any later version.
This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program; if not, write to the Interactive Health Solutions, info@ihsinformatics.com
You can also access the license on the internet at the address: http://www.gnu.org/licenses/gpl-3.0.html

Interactive Health Solutions, hereby disclaims all copyright interest in this program written by the contributors.
 */
package com.ihsinformatics.gfatmimport;

import java.beans.PropertyVetoException;
import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.logging.Logger;

import com.ihsinformatics.gfatmimport.util.PooledDataSource;
import com.ihsinformatics.util.CommandType;
import com.ihsinformatics.util.DatabaseUtil;
import com.ihsinformatics.util.DateTimeUtil;

/**
 * @author owais.hussain@ihsinformatics.com
 *
 */
public class DimensionController {

	private static final Logger log = Logger.getLogger(Class.class.getName());
	// Wait for XXXms, which ought to be enough for most of the queries
	public static final int PARALLEL_EXECUTION_DELAY = 500;

	private DatabaseUtil db;

	public DimensionController(DatabaseUtil db) {
		this.db = db;
	}

	/**
	 * Perform dimension modeling
	 */
	public void modelDimensions() {
		Calendar from = Calendar.getInstance();
		from.set(2000, 0, 1);
		Calendar to = Calendar.getInstance();
		Object[][] sources = db.getTableData("_implementation", "implementation_id", "active=1 AND status='RUNNING'");
		// For each source, model dimensions
		for (Object[] source : sources) {
			int implementationId = Integer.parseInt(source[0].toString());
			modelDimensions(from.getTime(), to.getTime(), implementationId);
		}
	}

	public void modelDimensions(Date from, Date to, int implementationId) {
		try {
			log.info("Creating/updating time dimension");
			timeDimension();
		} catch (Exception e) {
			log.warning(e.getMessage());
		}
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("impl_id", implementationId);
		params.put("date_from", from);
		params.put("date_to", to);
		log.info("Creating/updating concept dimensions");
		try {
			db.runStoredProcedure("dim_concept", params);
		} catch (Exception e) {
			log.warning(e.getMessage());
		}
		log.info("Creating/updating location dimensions");
		try {
			db.runStoredProcedure("dim_location", params);
		} catch (Exception e) {
			log.warning(e.getMessage());
		}
		log.info("Creating/updating user dimensions");
		try {
			db.runStoredProcedure("dim_user", params);
		} catch (Exception e) {
			log.warning(e.getMessage());
		}
		log.info("Creating/updating patinet dimensions");
		try {
			db.runStoredProcedure("dim_patient", params);
		} catch (Exception e) {
			log.warning(e.getMessage());
		}
		log.info("Creating/updating user form dimensions");
		try {
			db.runStoredProcedure("dim_user_form", params);
		} catch (Exception e) {
			log.warning(e.getMessage());
		}
		log.info("Creating/updating encounter dimensions");
		try {
			db.runStoredProcedure("dim_encounter", params);
		} catch (Exception e) {
			log.warning(e.getMessage());
		}
		log.info("Creating/updating obs dimensions");
		try {
			db.runStoredProcedure("dim_obs", params);
		} catch (Exception e) {
			log.warning(e.getMessage());
		}
		log.info("Creating/updating lab test dimensions");
		try {
			db.runStoredProcedure("dim_lab_test", params);
		} catch (Exception e) {
			log.warning(e.getMessage());
		}
		log.info("Starting deencounterizing OpenMRS");
		try {
			deencounterizeOpenMrs();
		} catch (Exception e) {
			log.warning(e.getMessage());
		}
		log.info("Starting deencounterizing GFATM");
		try {
			deencounterizeGfatm();
		} catch (Exception e) {
			log.warning(e.getMessage());
		}
		log.info("Starting deencounterizing OpenMRS extensions");
		try {
			denormalizeOpenMrsExtended();
		} catch (Exception e) {
			log.warning(e.getMessage());
		}
		log.info("Deencounterizing process complete");
	}

	/**
	 * Fill in Date/Time dimension table by detecting the last date in dimension
	 * 
	 * @throws InstantiationException
	 * @throws IllegalAccessException
	 * @throws ClassNotFoundException
	 * @throws ParseException
	 */
	public void timeDimension()
			throws InstantiationException, IllegalAccessException, ClassNotFoundException, ParseException {
		Object lastSqlDate = db.runCommand(CommandType.SELECT, "select max(full_date) as latest from dim_datetime");
		Calendar start = Calendar.getInstance();
		start.set(Calendar.YEAR, 2000);
		start.set(Calendar.MONTH, Calendar.JANUARY);
		start.set(Calendar.DATE, 1);
		if (lastSqlDate != null) {
			Date latestDate = DateTimeUtil.fromSqlDateString(lastSqlDate.toString());
			start.setTime(latestDate);
		}
		start.add(Calendar.DATE, 1);
		Calendar end = Calendar.getInstance();
		end.set(Calendar.HOUR, 0);
		if (!start.getTime().before(end.getTime())) {
			return;
		}
		while (start.getTime().before(end.getTime())) {
			String sqlDate = "'" + DateTimeUtil.toSqlDateString(start.getTime()) + "'";
			StringBuilder query = new StringBuilder("insert into dim_datetime values ");
			query.append("(0, " + sqlDate + ", ");
			query.append("year(" + sqlDate + "), ");
			query.append("month(" + sqlDate + "), ");
			query.append("day(" + sqlDate + "), ");
			query.append("dayname(" + sqlDate + "), ");
			query.append("monthname(" + sqlDate + "))");
			log.info("Executing: " + query.toString());
			db.runCommand(CommandType.INSERT, query.toString());
			start.add(Calendar.DATE, 1);
		}
	}

	public void deencounterizeGfatm() {
		// Create a temporary table to save questions for each user form type
		db.runCommand(CommandType.DROP, "drop table if exists tmp");
		db.runCommand(CommandType.CREATE,
				"create table tmp select distinct user_form_type_id, element_id, element_name as question from dim_user_form_result");
		// Fetch user form types and names
		Object[][] userFormTypes = db.getTableData("dim_user_form", "distinct user_form_type_id, user_form_type", null);
		if (userFormTypes == null) {
			log.severe("User Form types could not be fetched");
			return;
		}
		List<String> dropQueries = new ArrayList<>();
		List<String> createQueries = new ArrayList<>();
		List<String> alterQueries = new ArrayList<>();

		for (Object[] userFormType : userFormTypes) {
			StringBuilder query = new StringBuilder();
			// Create a de-encounterized table
			Object[][] data = db.getTableData("tmp", "question", "user_form_type_id=" + userFormType[0].toString());
			ArrayList<String> elements = new ArrayList<String>();
			for (int i = 0; i < data.length; i++) {
				if (data[i][0] == null) {
					continue;
				}
				elements.add(data[i][0].toString());
			}
			StringBuilder groupConcat = new StringBuilder();
			Set<String> taken = new HashSet<>();
			for (String s : new String[] { "surrogate_id", "implementation_id", "user_form_id", "user_id", "username",
					"location_id", "location_name", "date_entered" }) {
				taken.add(s);
			}
			for (Object element : elements) {
				// Cleanup undesired characters
				String str = element.toString().replaceAll("[^A-Za-z0-9]", "_").toLowerCase();
				// Reduce the length of column if the name is too long
				if (str.length() > 36) {
					str = str.substring(0, 36) + "_";
				}
				// Append an underscore if the column name is duplicated
				if (taken.contains(str)) {
					str = str + "_";
				}
				groupConcat.append(
						"group_concat(if(ufr.element_name = '" + element + "', ufr.result, NULL)) AS " + str + ", ");
				taken.add(str);
			}

			String userFormName = userFormType[1].toString().toLowerCase().replace(" ", "_").replace("-", "_");
			query.append("create table uform_" + userFormName + " ");
			query.append(
					"select uf.surrogate_id, uf.implementation_id, uf.user_form_id, uf.user_id, u.username, uf.location_id, l.location_name, uf.date_entered, ");
			query.append(groupConcat.toString());
			query.append("'' as BLANK from dim_user_form as uf ");
			query.append("inner join dim_user_form_result as ufr on ufr.user_form_id = uf.user_form_id ");
			query.append(
					"left outer join gfatm_users as u on u.implementation_id = uf.implementation_id and u.user_id = uf.user_id ");
			query.append(
					"left outer join gfatm_location as l on l.implementation_id = uf.implementation_id and l.location_id = uf.location_id ");
			query.append("where uf.user_form_type_id = '" + userFormType[0].toString() + "' ");
			query.append(
					"group by uf.surrogate_id, uf.implementation_id, uf.user_form_id, uf.user_id, u.username, uf.location_id, l.location_name, uf.date_entered");
			dropQueries.add("drop table if exists uform_" + userFormName);
			createQueries.add(query.toString());
			alterQueries.add("alter table uform_" + userFormName + " add primary key surrogate_id (surrogate_id)");
		}
		executeQueryPool(dropQueries.toArray(new String[] {}));
		executeQueryPool(createQueries.toArray(new String[] {}));
		executeQueryPool(alterQueries.toArray(new String[] {}));
	}

	/**
	 * Transforms the encounters, observations and forms data into separate
	 * tables
	 */
	public void deencounterizeOpenMrs() {
		// Create a temporary table to save questions for each encounter type
		db.runCommand(CommandType.DROP, "drop table if exists tmp");
		db.runCommand(CommandType.CREATE,
				"create table tmp select distinct encounter_type, concept_id, question from dim_obs");
		// Fetch encounter types and names
		Object[][] encounterTypes = db.getTableData("dim_encounter", "distinct encounter_type, encounter_name", null);
		if (encounterTypes == null) {
			log.severe("Encounter types could not be fetched");
			return;
		}
		List<String> dropQueries = new ArrayList<>();
		List<String> createQueries = new ArrayList<>();
		List<String> alterQueries = new ArrayList<>();

		for (Object[] encounterType : encounterTypes) {
			StringBuilder query = new StringBuilder();
			// Create a de-encounterized table
			Object[][] data = db.getTableData("tmp", "question", "encounter_type=" + encounterType[0].toString());
			ArrayList<String> elements = new ArrayList<String>();
			for (int i = 0; i < data.length; i++) {
				if (data[i][0] == null) {
					continue;
				}
				elements.add(data[i][0].toString());
			}
			if (elements.isEmpty()) {
				continue;
			}
			StringBuilder groupConcat = new StringBuilder();
			Set<String> taken = new HashSet<>();
			for (String s : new String[] { "surrogate_id", "implementation_id", "encounter_id", "provider",
					"location_id", "location_name", "patient_id", "date_entered" }) {
				taken.add(s);
			}
			for (Object element : elements) {
				// Cleanup undesired characters
				String str = element.toString().replaceAll("[^A-Za-z0-9]", "_").toLowerCase();
				// Reduce the length of column if the name is too long
				if (str.length() > 32) {
					str = str.substring(0, 32) + "_xyz";
				}
				// Append an underscore if the column name is duplicated
				if (taken.contains(str)) {
					str = str + "_";
				}
				groupConcat.append("group_concat(if(o.question = '" + element + "', o.answer, NULL)) AS " + str + ", ");
				taken.add(str);
			}
			String encounterName = encounterType[1].toString().toLowerCase().replace(" ", "_").replace("-", "_")
					.replace("/", "_");
			query.append("create table enc_" + encounterName + " engine=InnoDB ");
			query.append(
					"select e.surrogate_id, e.implementation_id, e.encounter_id,  e.provider, e.location_id, l.location_name, e.patient_id, e.date_entered, ");
			query.append(groupConcat.toString());
			query.append("'' as BLANK from dim_encounter as e ");
			query.append("inner join dim_obs as o on o.encounter_id = e.encounter_id and o.voided = 0 ");
			query.append("inner join dim_location as l on l.location_id = e.location_id ");
			query.append("where e.encounter_type = '" + encounterType[0].toString() + "' ");
			// Filter out all child observations (e.g. multi-select)
			query.append("and o.obs_group_id is null ");
			query.append(
					"group by e.surrogate_id, e.implementation_id, e.encounter_id, e.patient_id, e.provider, e.location_id, e.date_entered");
			dropQueries.add("drop table if exists enc_" + encounterName);
			createQueries.add(query.toString());
			alterQueries.add("alter table enc_" + encounterName
					+ " add primary key surrogate_id (surrogate_id), add key patient_id (patient_id), add key encounter_id (encounter_id)");
		}
		executeQueryPool(dropQueries.toArray(new String[] {}));
		// Due to execution length, the create queries should also be split
		int size= createQueries.size();
		String[] createArray = createQueries.toArray(new String[] {});
		String[] a = Arrays.copyOfRange(createArray, 0, (size + 1)/2);
		String[] b = Arrays.copyOfRange(createArray, (size + 1)/2, size);
		log.info("Executing first pool of create queries...");
		executeQueryPool(a);
		log.info("Executing second pool of create queries...");
		executeQueryPool(b);
		executeQueryPool(alterQueries.toArray(new String[] {}));
	}

	/**
	 * Transforms the common-lab module data into separate tables
	 */
	public void denormalizeOpenMrsExtended() {
		// Create a temporary table to save questions for each encounter type
		db.runCommand(CommandType.DROP, "drop table if exists commonlab_tmp");
		db.runCommand(CommandType.CREATE,
				"create table commonlab_tmp select distinct test_type_id, attribute_type_id, attribute_type_name from dim_lab_test_result");
		// Fetch types and names
		Object[][] testTypes = db.getTableData("commonlabtest_type", "distinct test_type_id, short_name", null);
		if (testTypes == null) {
			log.severe("Lab test types could not be fetched");
			return;
		}
		List<String> dropQueries = new ArrayList<>();
		List<String> createQueries = new ArrayList<>();
		List<String> alterQueries = new ArrayList<>();

		for (Object[] testType : testTypes) {
			StringBuilder query = new StringBuilder();
			// Create a de-encounterized table
			Object[][] data = db.getTableData("commonlab_tmp", "attribute_type_name",
					"test_type_id=" + testType[0].toString());
			ArrayList<String> elements = new ArrayList<String>();
			for (int i = 0; i < data.length; i++) {
				if (data[i][0] == null) {
					continue;
				}
				elements.add(data[i][0].toString());
			}
			if (elements.isEmpty()) {
				continue;
			}
			StringBuilder groupConcat = new StringBuilder();
			Set<String> taken = new HashSet<>();
			for (String s : new String[] { "surrogate_id", "implementation_id", "test_order_id", "orderer",
					"patient_id", "encounter_id", "lab_reference_number", "order_date" }) {
				taken.add(s);
			}
			for (Object element : elements) {
				// Cleanup undesired characters
				String str = element.toString().replaceAll("[^A-Za-z0-9]", "_").toLowerCase();
				// Reduce the length of column if the name is too long
				if (str.length() > 36) {
					str = str.substring(0, 36) + "_";
				}
				// Append an underscore if the column name is duplicated
				if (taken.contains(str)) {
					str = str + "_";
				}
				groupConcat.append("group_concat(if(r.attribute_type_name = '" + element
						+ "', r.value_reference, NULL)) AS " + str + ", ");
				taken.add(str);
			}
			String labTestType = testType[1].toString().toLowerCase().replace(" ", "_").replace("-", "_");
			query.append("create table lab_" + labTestType + " engine=InnoDB ");
			query.append(
					"select t.surrogate_id, t.implementation_id, t.test_order_id, t.orderer, t.patient_id, t.encounter_id, t.lab_reference_number, t.order_date, ");
			query.append(groupConcat.toString());
			query.append("'' as BLANK from dim_lab_test as t ");
			query.append("inner join dim_lab_test_result as r on r.test_order_id = t.test_order_id ");
			query.append("where t.test_type_id = '" + testType[0].toString() + "' ");
			query.append(
					"group by t.surrogate_id, t.implementation_id, t.test_order_id, t.orderer, t.patient_id, t.encounter_id, t.lab_reference_number, t.order_date");
			dropQueries.add("drop table if exists lab_" + labTestType);
			createQueries.add(query.toString());
			alterQueries.add("alter table lab_" + labTestType
					+ " add primary key surrogate_id (surrogate_id), add key patient_id (patient_id), add key test_order_id (test_order_id)");
		}
		executeQueryPool(dropQueries.toArray(new String[] {}));
		executeQueryPool(createQueries.toArray(new String[] {}));
		executeQueryPool(alterQueries.toArray(new String[] {}));
	}

	/**
	 * This method splits max number into n equal partitions
	 * 
	 * @param maxNumber
	 * @param nParts
	 * @return
	 */
	public static long[] split(long maxNumber, int nParts) {
		long[] arr = new long[nParts];
		for (int i = 0; i < arr.length; i++)
			maxNumber -= arr[i] = (maxNumber + nParts - i - 1) / (nParts - i);
		return arr;
	}

	/**
	 * Execute a batch of queries in parallel using {@link PooledDataSource}
	 * 
	 * @param queryPool
	 */
	public void executeQueryPool(String[] queryPool) {
		// Create a pool of threads equal to the number of queries
		ExecutorService executor = Executors.newFixedThreadPool(queryPool.length);
		for (String q : queryPool) {
			Runnable worker = new Thread(() -> {
				try {
					log.info("Executing: " + q.toString());
					PooledDataSource.getInstance(db).runDMLCommand(q);
				} catch (IOException | SQLException | PropertyVetoException e) {
					log.warning("Exception caught while executing: " + q + "\n" + e.getMessage());
				}
			});
			executor.execute(worker);
			try {
				Thread.sleep(PARALLEL_EXECUTION_DELAY);
			} catch (InterruptedException e) {
			}
		}
		executor.shutdown();
		while (!executor.isTerminated()) {
			// Wait...
		}
		return;
	}
}
