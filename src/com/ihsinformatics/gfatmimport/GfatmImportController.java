/* Copyright(C) 2016 Interactive Health Solutions, Pvt. Ltd.

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as
published by the Free Software Foundation; either version 3 of the License (GPLv3), or any later version.
This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

See the GNU General Public License for more details. You should have received a copy of the GNU General Public License along with this program; if not, write to the Interactive Health Solutions, info@ihsinformatics.com
You can also access the license on the internet at the address: http://www.gnu.org/licenses/gpl-3.0.html

Interactive Health Solutions, hereby disclaims all copyright interest in this program written by the contributors.
 */
package com.ihsinformatics.gfatmimport;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.Date;
import java.util.logging.Logger;

import com.ihsinformatics.util.CommandType;
import com.ihsinformatics.util.DatabaseUtil;

/**
 * @author owais.hussain@ihsinformatics.com
 *
 */
public class GfatmImportController extends AbstractImportController {

    private static final Logger log = Logger.getLogger(Class.class.getName());

    public GfatmImportController(DatabaseUtil sourceDb, DatabaseUtil targetDb) {
	this.sourceDb = sourceDb;
	this.targetDb = targetDb;
	this.fromDate = new Date();
	this.toDate = new Date();
    }

    public GfatmImportController(DatabaseUtil sourceDb, DatabaseUtil targetDb,
	    Date fromDate, Date toDate) {
	this.sourceDb = sourceDb;
	this.targetDb = targetDb;
	this.fromDate = fromDate;
	this.toDate = toDate;
    }

    /**
     * Insert data from all sources into data warehouse.
     * 
     * @throws SQLException
     * @throws ClassNotFoundException
     * @throws IllegalAccessException
     * @throws InstantiationException
     * @throws ParseException
     */
    public void importData(int implementationId) throws InstantiationException,
	    IllegalAccessException, ClassNotFoundException, SQLException,
	    ParseException {
	sourceDb.getConnection();
	// Import data from this connection into data warehouse
	try {
	    clearTempTables(implementationId);
	    importLocationData(sourceDb, implementationId);
	    importUserData(sourceDb, implementationId);
	    importUserFormData(sourceDb, implementationId);
	} catch (Exception e) {
	    e.printStackTrace();
	}
    }

    /**
     * Remove all data from temporary tables related to given implementation ID
     * 
     * @param implementationId
     */
    private void clearTempTables(int implementationId) {
	String[] tables = { "_element", "tmp_gfatm_location",
		"tmp_gfatm_location_attribute",
		"tmp_gfatm_location_attribute_type",
		"tmp_gfatm_user_attribute", "tmp_gfatm_user_attribute_type",
		"tmp_gfatm_user_form", "tmp_gfatm_user_form_result",
		"tmp_gfatm_user_form_type", "tmp_gfatm_user_location",
		"tmp_gfatm_user_role", "tmp_gfatm_users" };
	for (String table : tables) {
	    try {
		targetDb.runCommandWithException(CommandType.TRUNCATE,
			"TRUNCATE TABLE " + table);
	    } catch (SQLException e) {
		log.warning("Table: " + table + " not found in data warehouse!");
	    } catch (Exception e) {
		log.warning("Table: " + table + " not found in data warehouse!");
	    }
	}
    }

    /**
     * Load data from Location-related tables into data warehouse
     * 
     * @param implementationId
     * @param database
     * @throws ClassNotFoundException
     * @throws IllegalAccessException
     * @throws InstantiationException
     */
    public void importLocationData(DatabaseUtil remoteDb, int implementationId)
	    throws InstantiationException, IllegalAccessException,
	    ClassNotFoundException {

	String database = remoteDb.getDbName();
	String insertQuery;
	String updateQuery;
	String selectQuery;

	try {
	    // Location Attribute Type
	    insertQuery = "INSERT INTO tmp_gfatm_location_attribute_type (surrogate_id, implementation_id, location_attribute_type_id, attribute_name, validation_regex, required, description, date_created, created_by, created_at, date_changed, changed_by, changed_at, data_type, uuid) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
	    selectQuery = "SELECT 0,'"
		    + implementationId
		    + "', location_attribute_type_id, attribute_name, validation_regex, required, description, date_created, created_by, created_at, date_changed, changed_by, changed_at, data_type, uuid FROM "
		    + database + ".location_attribute_type AS t "
		    + filter("t.date_created", "t.date_changed");
	    log.info("Inserting data from location_attribute_type into data warehouse");
	    remoteSelectInsert(selectQuery, insertQuery,
		    remoteDb.getConnection(), targetDb.getConnection());
	    // Insert new records
	    insertQuery = "INSERT INTO gfatm_location_attribute_type SELECT * FROM tmp_gfatm_location_attribute_type AS t WHERE NOT EXISTS (SELECT * FROM gfatm_location_attribute_type WHERE implementation_id = t.implementation_id AND uuid = t.uuid)";
	    targetDb.runCommand(CommandType.INSERT, insertQuery);
	    // Update the existing records
	    updateQuery = "UPDATE gfatm_location_attribute_type AS a, tmp_gfatm_location_attribute_type AS t "
		    + "SET a.location_attribute_type_id = t.location_attribute_type_id, a.attribute_name = t.attribute_name, a.validation_regex = t.validation_regex, a.required = t.required, a.description = t.description, a.date_created = t.date_created, a.created_by = t.created_by, a.created_at = t.created_at, a.date_changed = t.date_changed, a.changed_by = t.changed_by, a.changed_at = t.changed_at, a.data_type = t.data_type WHERE a.implementation_id = t.implementation_id = '"
		    + implementationId + "' AND a.uuid = t.uuid";
	    targetDb.runCommand(CommandType.UPDATE, updateQuery);

	    // Location
	    insertQuery = "INSERT INTO tmp_gfatm_location (surrogate_id, implementation_id, location_id, location_name, category, description, address1, address2, address3, city_village, state_province, country, landmark1, landmark2, latitude, longitude, primary_contact, secondary_contact, email, fax, parent_location, date_created, created_by, created_at, date_changed, changed_by, changed_at, uuid) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
	    selectQuery = "SELECT 0,'"
		    + implementationId
		    + "', location_id, location_name, category, description, address1, address2, address3, city_village, state_province, country, landmark1, landmark2, latitude, longitude, primary_contact, secondary_contact, email, fax, parent_location, date_created, created_by, created_at, date_changed, changed_by, changed_at, uuid FROM "
		    + database + ".location AS t "
		    + filter("t.date_created", "t.date_changed");
	    log.info("Inserting data from location into data warehouse");
	    remoteSelectInsert(selectQuery, insertQuery,
		    remoteDb.getConnection(), targetDb.getConnection());
	    // Insert new records
	    insertQuery = "INSERT INTO gfatm_location SELECT * FROM tmp_gfatm_location AS t WHERE NOT EXISTS (SELECT * FROM gfatm_location WHERE implementation_id = t.implementation_id AND uuid = t.uuid)";
	    targetDb.runCommand(CommandType.INSERT, insertQuery);
	    // Update the existing records
	    updateQuery = "UPDATE gfatm_location AS a, tmp_gfatm_location AS t "
		    + "SET a.location_id = t.location_id, a.location_name = t.location_name, a.category = t.category, a.description = t.description, a.address1 = t.address1, a.address2 = t.address2, a.address3 = t.address3, a.city_village = t.city_village, a.state_province = t.state_province, a.country = t.country, a.landmark1 = t.landmark1, a.landmark2 = t.landmark2, a.latitude = t.latitude, a.longitude = t.longitude, a.primary_contact = t.primary_contact, a.secondary_contact = t.secondary_contact, a.email = t.email, a.fax = t.fax, a.parent_location = t.parent_location, a.date_created = t.date_created, a.created_by = t.created_by, a.created_at = t.created_at, a.date_changed = t.date_changed, a.changed_by = t.changed_by, a.changed_at = t.changed_at WHERE a.implementation_id = t.implementation_id = '"
		    + implementationId + "' AND a.uuid = t.uuid";
	    targetDb.runCommand(CommandType.UPDATE, updateQuery);

	    // Location Attribute
	    insertQuery = "INSERT INTO gfatm_location_attribute () VALUES (?,?,?,?,?,?,?,?,?,?,?,?)";
	    selectQuery = "SELECT 0,'" + implementationId + "',  FROM "
		    + database + ".gfatm_location_attribute AS t "
		    + filter("t.date_created", "t.date_changed");
	    log.info("Inserting data from gfatm_location_attribute into data warehouse");
	    remoteSelectInsert(selectQuery, insertQuery,
		    remoteDb.getConnection(), targetDb.getConnection());
	    // Insert new records
	    insertQuery = "INSERT INTO gfatm_location_attribute SELECT * FROM tmp_gfatm_location_attribute AS t WHERE NOT EXISTS (SELECT * FROM gfatm_location_attribute WHERE implementation_id = t.implementation_id AND uuid = t.uuid)";
	    targetDb.runCommand(CommandType.INSERT, insertQuery);
	    // Update the existing records
	    updateQuery = "UPDATE gfatm_location_attribute AS a, tmp_gfatm_location_attribute AS t "
		    + "SET a.location_attribute_id = t.location_attribute_id, a.attribute_type_id = t.attribute_type_id, a.location_id = t.location_id, a.attribute_value = t.attribute_value, a.date_created = t.date_created, a.created_by = t.created_by, a.created_at = t.created_at, a.date_changed = t.date_changed, a.changed_by = t.changed_by, a.changed_at = t.changed_at WHERE a.implementation_id = t.implementation_id = '"
		    + implementationId + "' AND a.uuid = t.uuid";
	    targetDb.runCommand(CommandType.UPDATE, updateQuery);
	} catch (SQLException e) {
	    e.printStackTrace();
	} finally {
	    // User forms exist in separate database
	    remoteDb.setDbName("openmrs");
	}
    }

    /**
     * Load data from User-related tables into data warehouse
     * 
     * @param implementationId
     * @param database
     * @throws ClassNotFoundException
     * @throws IllegalAccessException
     * @throws InstantiationException
     */
    public void importUserData(DatabaseUtil remoteDb, int implementationId)
	    throws InstantiationException, IllegalAccessException,
	    ClassNotFoundException {

	String database = remoteDb.getDbName();
	String insertQuery;
	String updateQuery;
	String selectQuery;

	try {
	    // User Form Type
	    insertQuery = "INSERT INTO tmp_gfatm_user_form_type (surrogate_id, implementation_id, user_form_type_id, user_form_type, date_created, created_by, created_at, date_changed, changed_by, changed_at, uuid, description) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)";
	    selectQuery = "SELECT 0,'"
		    + implementationId
		    + "', user_form_type_id, user_form_type, date_created, created_by, created_at, date_changed, changed_by, changed_at, uuid, description FROM "
		    + database + ".user_form_type AS t "
		    + filter("t.date_created", "t.date_changed");
	    log.info("Inserting data from gfatm_user_form_type into data warehouse");
	    remoteSelectInsert(selectQuery, insertQuery,
		    remoteDb.getConnection(), targetDb.getConnection());
	    // Insert new records
	    insertQuery = "INSERT INTO gfatm_user_form_type SELECT * FROM tmp_gfatm_user_form_type AS t WHERE NOT EXISTS (SELECT * FROM gfatm_user_form_type WHERE implementation_id = t.implementation_id AND uuid = t.uuid)";
	    targetDb.runCommand(CommandType.INSERT, insertQuery);
	    // Update the existing records
	    updateQuery = "UPDATE gfatm_user_form_type AS a, tmp_gfatm_user_form_type AS t "
		    + "SET a.user_form_type_id = t.user_form_type_id, a.user_form_type = t.user_form_type, a.date_created = t.date_created, a.created_by = t.created_by, a.created_at = t.created_at, a.date_changed = t.date_changed, a.changed_by = t.changed_by, a.changed_at = t.changed_at, a.description = t.description WHERE a.implementation_id = t.implementation_id = '"
		    + implementationId + "' AND a.uuid = t.uuid";
	    targetDb.runCommand(CommandType.UPDATE, updateQuery);

	} catch (SQLException e) {
	    e.printStackTrace();
	} finally {
	    // User forms exist in separate database
	    remoteDb.setDbName("openmrs");
	}
    }

    /**
     * Load data from User form-related tables into data warehouse
     * 
     * @param implementationId
     * @param database
     * @throws ClassNotFoundException
     * @throws IllegalAccessException
     * @throws InstantiationException
     */
    public void importUserFormData(DatabaseUtil remoteDb, int implementationId)
	    throws InstantiationException, IllegalAccessException,
	    ClassNotFoundException {

	String database = remoteDb.getDbName();
	String insertQuery;
	String updateQuery;
	String selectQuery;

	try {
	    // User forms exist in separate database
	    database = "gfatm";
	    // User Form Type
	    insertQuery = "INSERT INTO tmp_gfatm_user_form_type (surrogate_id, implementation_id, user_form_type_id, user_form_type, date_created, created_by, created_at, date_changed, changed_by, changed_at, uuid, description) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)";
	    selectQuery = "SELECT 0,'"
		    + implementationId
		    + "', user_form_type_id, user_form_type, date_created, created_by, created_at, date_changed, changed_by, changed_at, uuid, description FROM "
		    + database + ".user_form_type AS t "
		    + filter("t.date_created", "t.date_changed");
	    log.info("Inserting data from gfatm_user_form_type into data warehouse");
	    remoteSelectInsert(selectQuery, insertQuery,
		    remoteDb.getConnection(), targetDb.getConnection());
	    // Insert new records
	    insertQuery = "INSERT INTO gfatm_user_form_type SELECT * FROM tmp_gfatm_user_form_type AS t WHERE NOT EXISTS (SELECT * FROM gfatm_user_form_type WHERE implementation_id = t.implementation_id AND uuid = t.uuid)";
	    targetDb.runCommand(CommandType.INSERT, insertQuery);
	    // Update the existing records
	    updateQuery = "UPDATE gfatm_user_form_type AS a, tmp_gfatm_user_form_type AS t "
		    + "SET a.user_form_type_id = t.user_form_type_id, a.user_form_type = t.user_form_type, a.date_created = t.date_created, a.created_by = t.created_by, a.created_at = t.created_at, a.date_changed = t.date_changed, a.changed_by = t.changed_by, a.changed_at = t.changed_at, a.description = t.description WHERE a.implementation_id = t.implementation_id = '"
		    + implementationId + "' AND a.uuid = t.uuid";
	    targetDb.runCommand(CommandType.UPDATE, updateQuery);

	} catch (SQLException e) {
	    e.printStackTrace();
	} finally {
	    // User forms exist in separate database
	    remoteDb.setDbName("openmrs");
	}
    }
}
