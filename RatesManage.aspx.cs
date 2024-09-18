
using System;
using System.Collections.Generic;
using System.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Common;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Data;
using System.IO;
using System.Drawing;
using ClosedXML.Excel;

public partial class RatesManage : System.Web.UI.Page
{
    SalesDBManager vdm;
    SqlCommand cmd;
    protected void Page_Load(object sender, EventArgs e)
    {
        lblMessage.Visible = false;
    }
    protected void btnImport_Click(object sender, EventArgs e)
    {
        try
        {
            vdm = new SalesDBManager();
            string connString = "";
            string filePath = Server.MapPath("~/Files/") + Path.GetFileName(fileuploadExcel.PostedFile.FileName);
            fileuploadExcel.SaveAs(filePath);
            if (filePath.Trim() == ".xls")
            {
                connString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + filePath + ";Extended Properties=\"Excel 8.0;HDR=Yes;IMEX=2\"";
            }
            else if (filePath.Trim() == ".xlsx")
            {
                connString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + filePath + ";Extended Properties=\"Excel 12.0;HDR=Yes;IMEX=2\"";
            }
            OleDbConnection OleDbcon = new OleDbConnection("Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + filePath + ";Extended Properties=Excel 12.0;");
            OleDbCommand cmd = new OleDbCommand("SELECT * FROM [Sheet1$]", OleDbcon);
            OleDbDataAdapter da = new OleDbDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            Session["btnImport"] = dt;
            grvExcelData.DataSource = dt;
            grvExcelData.DataBind();
        }
        catch (Exception ex)
        {
            lblMessage.Text = ex.ToString();
            lblMessage.Visible = true;
        }
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        string myc = "";
        string pname = "";
        try
        {
            vdm = new SalesDBManager();
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
            DataTable dt = (DataTable)Session["btnImport"];
            cmd = new SqlCommand("SELECT branchid, productid, price FROM productmoniter  ");
            DataTable dtBrnchPrdt = vdm.SelectQuery(cmd).Tables[0];
            int i = 0;
            foreach (DataRow dr in dt.Rows)
            {
                string AgentCode = dr["BranchID"].ToString();
                myc = AgentCode;
                DataTable dtAgentprdt = new DataTable();
                dtAgentprdt.Columns.Add("branchid");
                dtAgentprdt.Columns.Add("productid");
                dtAgentprdt.Columns.Add("price");
                DataRow[] drBp = dtBrnchPrdt.Select("branchid='" + dr["BranchID"].ToString() + "'");
                for (int k = 0; k < drBp.Length; k++)
                {
                    DataRow newrow = dtAgentprdt.NewRow();
                    newrow["branchid"] = drBp[k][0].ToString();
                    newrow["productid"] = drBp[k][1].ToString();
                    newrow["price"] = drBp[k][2].ToString();
                    dtAgentprdt.Rows.Add(newrow);
                }
                int j = 3;
                foreach (DataColumn dc in dt.Columns)
                {
                    var cell = dc.ColumnName;
                    if (cell == "SNo" || cell == "BranchID" || cell == "BranchName")
                    {
                    }
                    else
                    {
                        string UnitPrice = dt.Rows[i][j].ToString();
                        if (UnitPrice == "&nbsp;")
                        {
                            UnitPrice = "0";
                        }
                        cmd = new SqlCommand("Select productid from productmaster where ProductName=@ProductName");
                        cmd.Parameters.AddWithValue("@ProductName", dc.ColumnName);
                        pname = dc.ColumnName;
                        DataTable dtProduct = vdm.SelectQuery(cmd).Tables[0];
                        string ProductID = dtProduct.Rows[0]["productid"].ToString();
                        DataTable oldunitprice = new DataTable();
                        oldunitprice.Columns.Add("unitprice");
                        DataRow[] drAp = dtAgentprdt.Select("productid='" + ProductID + "'");
                        if (drAp.Length == 0)
                        {
                            if (UnitPrice == "0")
                            {

                            }
                            else
                            {
                                cmd = new SqlCommand("insert into productmoniter (branchid,productid,price) values (@branchid,@productid,@price)");
                                cmd.Parameters.AddWithValue("@branchid", AgentCode);
                                cmd.Parameters.AddWithValue("@productid", ProductID);
                                float UntCost = 0;
                                float.TryParse(UnitPrice, out UntCost);
                                cmd.Parameters.AddWithValue("@price", UntCost);
                                vdm.insert(cmd);
                            }
                        }
                        else
                        {
                            for (int ap = 0; ap < drAp.Length; ap++)
                            {
                                DataRow newaprow = oldunitprice.NewRow();
                                newaprow["unitprice"] = drAp[ap][2].ToString();
                                oldunitprice.Rows.Add(newaprow);
                            }
                            string oldprice = "0";

                            if (oldunitprice.Rows.Count > 0)
                            {
                                oldprice = oldunitprice.Rows[0]["unitprice"].ToString();
                            }
                            float UnitCost = 0;
                            float.TryParse(UnitPrice, out UnitCost);
                            float oldUnitCost = 0;
                            float.TryParse(oldprice, out oldUnitCost);
                            if (UnitCost == oldUnitCost)
                            {

                            }
                            else
                            {
                                cmd = new SqlCommand("Update productmoniter set price=@price where branchid=@branchid and productid=@productid");
                                cmd.Parameters.AddWithValue("@price", UnitCost);
                                cmd.Parameters.AddWithValue("@branchid", AgentCode);
                                cmd.Parameters.AddWithValue("@productid", ProductID);
                                vdm.Update(cmd);

                            }
                        }
                        j++;
                    }
                }
                i++;
            }
            lblmsg.Text = "Updated Successfully";
        }
        catch (Exception ex)
        {
            string sg = myc;
            string pid = pname;
            if (ex.Message == "Object reference not set to an instance of an object.")
            {
                lblmsg.Text = "Session Expired";
                Response.Redirect("Login.aspx");
            }
            else
            {
                lblmsg.Text = ex.Message;

            }
        }
       
    }
}