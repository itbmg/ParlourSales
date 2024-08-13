using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.Data;
using MySql.Data.MySqlClient;
using System.Data.SqlClient;

public class VehicleDBMgr
{
      string ConnectionString;
      public MySqlConnection conn = new MySqlConnection();
      List<string> data = new List<string>();
      public MySqlCommand vecmd;
    //  public string UserName = "";
      object obj_lock = new object();
      public VehicleDBMgr()
      {
          conn.ConnectionString = @"SERVER=120.138.9.118;DATABASE=vyshnavi_sales_2016;UID=vyshnavi_root;PASSWORD=Vyshnavi@123;";
      }
    public  bool insert(MySqlCommand _cmd)
    {

        try
        {
            vecmd = _cmd;
            lock (vecmd)
            {
                vecmd.Connection = conn;
                vecmd.Connection.Open();
                vecmd.ExecuteNonQuery();
                vecmd.Connection.Close();
            }
            return true;
        }
        catch (Exception ex)
        {
            vecmd.Connection.Close();
            throw new ApplicationException(ex.Message);
        }
        //}
    }

    public long insertScalar(MySqlCommand _cmd)
    {
        long sno = 0;
        try
        {
            vecmd = _cmd;
            lock (vecmd)
            {
                vecmd.Connection = conn;
                vecmd.Connection.Open();
                vecmd.ExecuteNonQuery();
                sno = vecmd.LastInsertedId;
                vecmd.Connection.Close();
            }
            return sno;
        }
        catch (Exception ex)
        {
            vecmd.Connection.Close();
            throw new ApplicationException(ex.Message);
        }
        //}
    }

   

    public  DataSet SelectQuery(MySqlCommand _cmd)
    {
        lock (obj_lock)
        {
            vecmd = _cmd;

            lock (vecmd)
            {
                try
                {
                    DataSet ds = new DataSet();
                    vecmd.Connection = conn;
                    conn.Open();
                    //cmd.ExecuteNonQuery();
                    MySqlDataAdapter sda = new MySqlDataAdapter();
                    sda.SelectCommand = vecmd;
                    sda.Fill(ds, "Table");
                    conn.Close();
                    return ds;
                }
                catch (Exception ex)
                {
                    conn.Close();
                    throw new ApplicationException(ex.Message);
                }
            }
        }
    }

    public  bool insertVehicleData(string TableName, string feildsseparatedbycomma)
    {
        lock (obj_lock)
        {
            try
            {
                vecmd = new MySqlCommand("insert into " + TableName + " values(" + feildsseparatedbycomma + ")", conn);
                conn.Open();
                vecmd.ExecuteNonQuery();
                conn.Close();
            }
            catch (MySqlException exe)
            {
                conn.Close();
                throw new ApplicationException(exe.ErrorCode.ToString());
            }
            return true;
        }
    }

    public bool Update(string table, string Updatestring, string condition)
    {
        lock (obj_lock)
        {
            bool flag = false;
            try
            {
                vecmd = new MySqlCommand("update " + table + " set " + Updatestring + "where " + condition, conn);
                conn.Open();
                vecmd.ExecuteNonQuery();
                conn.Close();
                flag = true;
            }
            catch (Exception ex)
            {
                flag = false;
                conn.Close();
                throw new AccessViolationException(ex.Message);
            }
            return flag;
        }
    }

    public bool Update(string table, string[] fieldNames, string[] fieldValues, string[] conFieldNames, string[] conFieldValues, string[] Operators)
    {
        lock (obj_lock)
        {
            string UpdateString = "";
            string ConditionStr = "";
            vecmd = new MySqlCommand();
            MySqlParameter param;
            try
            {
                if (fieldNames.Count() == fieldValues.Count() && conFieldNames.Count() == conFieldValues.Count())
                {
                    for (int i = 0; i < fieldNames.Count(); i++)
                    {
                        UpdateString += fieldNames[i] + ", ";
                        param = new MySqlParameter(fieldNames[i].Split('=')[1], fieldValues[i]);
                        vecmd.Parameters.Add(param);
                    }
                    UpdateString = UpdateString.Substring(0, UpdateString.LastIndexOf(","));

                    for (int j = 0; j < conFieldNames.Count(); j++)
                    {
                        ConditionStr += conFieldNames[j] + Operators[j];
                        param = new MySqlParameter(conFieldNames[j].Split('=')[1], conFieldValues[j]);
                        vecmd.Parameters.Add(param);
                    }

                    vecmd.CommandText = "update " + table + " set " + UpdateString + " where " + ConditionStr;
                    vecmd.Connection = conn;
                    conn.Open();
                    vecmd.ExecuteNonQuery();
                    conn.Close();
                    return true;
                }
                return false;
            }
            catch (MySqlException exe)
            {
                conn.Close();
                throw new ApplicationException(exe.ErrorCode.ToString());
            }
        }

    }

    public   bool Delete(string table, string condition)
    {
        lock (obj_lock)
        {
            bool flag = false;
            try
            {
                vecmd = new MySqlCommand("delete from " + table + " where " + condition, conn);
                conn.Open();
                vecmd.ExecuteNonQuery();
                conn.Close();
                flag = true;

            }
            catch (Exception ex)
            {
                flag = false;
                conn.Close();
                throw new ApplicationException(ex.Message);
            }
            return flag;
        }
    }

    public   DataSet GetReports(string table, string columnNames, string condition)
    {
        lock (obj_lock)
        {
            try
            {
                DataSet ds = new DataSet();
                MySqlDataAdapter sda = new MySqlDataAdapter("select " + columnNames + " from " + table + " where " + condition, conn);
                conn.Open();
                sda.Fill(ds, table);
                conn.Close();
                return ds;
            }
            catch (Exception ex)
            {
                conn.Close();
                throw new ApplicationException(ex.Message);
            }
        }
    }
    public   DataSet GetReports(string table, string columnNames)
    {
        lock (obj_lock)
        {
            try
            {
                DataSet ds = new DataSet();
                vecmd = new MySqlCommand("select " + columnNames + " from " + table, conn);
                //MySqlDataAdapter sda = new MySqlDataAdapter("select " + columnNames + " from " + table , conn);
                conn.Open();
                MySqlDataReader dr = vecmd.ExecuteReader();
                if (dr.HasRows)
                    ds = DataReaderToDataSet(dr);
                //sda.Fill(ds, table);
                conn.Close();
                return ds;
            }
            catch (Exception ex)
            {
                conn.Close();
                throw new ApplicationException(ex.Message);
            }
        }
    }

    ///    <summary>
    ///    Converts a MySqlDataReader to a DataSet
    ///    <param name='reader'>
    /// MySqlDataReader to convert.</param>
    ///    <returns>
    /// DataSet filled with the contents of the reader.</returns>
    ///    </summary>
    public   DataSet DataReaderToDataSet(MySqlDataReader reader)
    {
        lock (obj_lock)
        {
            DataSet dataSet = new DataSet();
            do
            {
                // Create new data table

                DataTable schemaTable = reader.GetSchemaTable();
                DataTable dataTable = new DataTable();

                if (schemaTable != null)
                {
                    // A query returning records was executed

                    for (int i = 0; i < schemaTable.Rows.Count; i++)
                    {
                        DataRow dataRow = schemaTable.Rows[i];
                        // Create a column name that is unique in the data table
                        string columnName = (string)dataRow["ColumnName"]; //+ "<C" + i + "/>";
                        // Add the column definition to the data table
                        DataColumn column = new DataColumn(columnName, (Type)dataRow["DataType"]);
                        dataTable.Columns.Add(column);
                    }

                    dataSet.Tables.Add(dataTable);

                    // Fill the data table we just created

                    while (reader.Read())
                    {
                        DataRow dataRow = dataTable.NewRow();

                        for (int i = 0; i < reader.FieldCount; i++)
                            dataRow[i] = reader.GetValue(i);

                        dataTable.Rows.Add(dataRow);
                    }
                }
                else
                {
                    // No records were returned

                    DataColumn column = new DataColumn("RowsAffected");
                    dataTable.Columns.Add(column);
                    dataSet.Tables.Add(dataTable);
                    DataRow dataRow = dataTable.NewRow();
                    dataRow[0] = reader.RecordsAffected;
                    dataTable.Rows.Add(dataRow);
                }
            }
            while (reader.NextResult());
            return dataSet;
        }
    }
    public int Update(MySqlCommand _cmd)
    {
        lock (obj_lock)
        {
            try
            {
                int i = 0;
                vecmd = _cmd;
                lock (vecmd)
                {
                    vecmd.Connection = conn;
                    vecmd.Connection.Open();
                    i= vecmd.ExecuteNonQuery();
                    vecmd.Connection.Close();
                    return i;
                }
            }
            catch (Exception ex)
            {
                vecmd.Connection.Close();
                throw new ApplicationException(ex.Message);
            }
        }
    }

    public void Delete(MySqlCommand _cmd)
    {
        lock (obj_lock)
        {
            try
            {
                vecmd = _cmd;
                vecmd.Connection = conn;
                vecmd.Connection.Open();
                int ii = vecmd.ExecuteNonQuery();
                vecmd.Connection.Close();
            }
            catch (Exception ex)
            {
                vecmd.Connection.Close();
                throw new ApplicationException(ex.Message);
            }
        }
    }
    public static DateTime GetTime(MySqlConnection conn)
    {
        DataSet ds = new DataSet();
        DateTime dt = DateTime.Now;
        MySqlCommand cmd = new MySqlCommand("SELECT NOW()");
        cmd.Connection = conn;
        if (cmd.Connection.State == ConnectionState.Open)
        {
            cmd.Connection.Close();
        }
        conn.Open();
        //cmd.ExecuteNonQuery();
        MySqlDataAdapter sda = new MySqlDataAdapter();
        sda.SelectCommand = cmd;
        sda.Fill(ds, "Table");
        conn.Close();
        if (ds.Tables[0].Rows.Count > 0)
        {
            dt = (DateTime)ds.Tables[0].Rows[0][0];
        }
        //dt = dt.AddMinutes(570);
        return dt;

    }

    internal static DateTime GetTime(SqlConnection conn)
    {
        throw new NotImplementedException();
    }
}