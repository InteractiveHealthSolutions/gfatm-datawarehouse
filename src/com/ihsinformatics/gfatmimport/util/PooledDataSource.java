/**
 * 
 */
package com.ihsinformatics.gfatmimport.util;

import java.beans.PropertyVetoException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.ihsinformatics.util.DatabaseUtil;
import com.mchange.v2.c3p0.ComboPooledDataSource;

/**
 * @author owais.hussain@ihsinformatics.com
 *
 */
public class PooledDataSource {

	private static PooledDataSource datasource;
	private ComboPooledDataSource cpds;

	public boolean runDMLCommand(String query) {
		Connection connection = null;
		Statement statement = null;
		ResultSet resultSet = null;
		boolean result = false;
		try {
			connection = getConnection();
			statement = connection.createStatement();
			boolean failed = statement.execute(query);
			result = !failed;
		} catch (SQLException e) {
			System.out.println(query + " failed: " + e.getMessage());
		} finally {
			if (resultSet != null)
				try {
					resultSet.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			if (statement != null)
				try {
					statement.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			if (connection != null)
				try {
					connection.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
		}
		return result;
	}

	private PooledDataSource(DatabaseUtil dbUtil) throws IOException, SQLException, PropertyVetoException {
		cpds = new ComboPooledDataSource();
		cpds.setJdbcUrl(dbUtil.getUrl());
		cpds.setDriverClass(dbUtil.getDriverName());
		cpds.setUser(dbUtil.getUsername());
		cpds.setPassword(dbUtil.getPassword());
		// the settings below are optional -- c3p0 can work with defaults
		cpds.setMinPoolSize(1);
		cpds.setInitialPoolSize(0);
		cpds.setAcquireIncrement(2);
		cpds.setMaxPoolSize(128);
		cpds.setMaxStatementsPerConnection(3);
		cpds.setAutoCommitOnClose(true);
		cpds.setAcquireRetryDelay(10000);
		cpds.setMaxIdleTime(30);
	}

	public static PooledDataSource getInstance(DatabaseUtil dbUtil)
			throws IOException, SQLException, PropertyVetoException {
		if (datasource == null) {
			datasource = new PooledDataSource(dbUtil);
			return datasource;
		} else {
			return datasource;
		}
	}

	public Connection getConnection() throws SQLException {
		return this.cpds.getConnection();
	}
}
