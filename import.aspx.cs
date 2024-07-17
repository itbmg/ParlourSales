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

public partial class import : System.Web.UI.Page
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
            //string name = Path.GetFileName(fileuploadExcel.PostedFile.FileName); //get the path of the file  

            //if (str.Contains("."))
            //{
            //    int index = str.IndexOf('.');
            //    result = str.Substring(0, index);

            //    re = result;

            //}

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
        try
        {
            DataTable dtmiss = new DataTable();
            dtmiss.Columns.Add("Itemcode");
            dtmiss.Columns.Add("productname");
            DataTable dt = (DataTable)Session["btnImport"];
            int i = 1;
            foreach (DataRow dr in dt.Rows)
            {
                vdm = new SalesDBManager();
                //string productid = dr["productid"].ToString();
                //string qty = dr["qty"].ToString();
                //string price = dr["price"].ToString();
                //string branchid = dr["branchid"].ToString();
                //string minstock = dr["minstock"].ToString();
                //string maxsstock = dr["maxsstock"].ToString();


                string itemname = dr["SWEETNAME"].ToString();
                string BILLINGPRICE = dr["MRP"].ToString();
                string MRP = dr["MRP"].ToString();
                string Categoryid = dr["Categoryid"].ToString();
                string Subcategoryid = dr["Subcategoryid"].ToString();
                string UOM = dr["uom"].ToString();
                string GST = dr["GST"].ToString();
                string IGST = dr["IGST"].ToString();
                string CGST = dr["CGST"].ToString();
                string SGST = dr["SGST"].ToString();
                cmd = new SqlCommand("insert into productmaster(subcategoryid, categoryid, productname, price, billingprice, uim, gsttaxcategory, igst, cgst, sgst,status) values (@subcategoryid, @categoryid, @productname, @price, @billingprice, @uim, @gsttaxcategory, @igst, @cgst, @sgst, @status)");
                cmd.Parameters.Add("@subcategoryid", Subcategoryid);
                cmd.Parameters.Add("@categoryid", Categoryid);
                cmd.Parameters.Add("@productname", itemname);
                cmd.Parameters.Add("@price", MRP);
                cmd.Parameters.Add("@billingprice", BILLINGPRICE);
                cmd.Parameters.Add("@uim", UOM);
                cmd.Parameters.Add("@gsttaxcategory", GST);
                cmd.Parameters.Add("@igst", IGST);
                cmd.Parameters.Add("@cgst", CGST);
                cmd.Parameters.Add("@sgst", SGST);
                cmd.Parameters.Add("@status", "Active");
                vdm.insert(cmd);

                cmd = new SqlCommand("select MAX(productid) as productid from productmaster");
                DataTable dtproduct = vdm.SelectQuery(cmd).Tables[0];
                string productid = dtproduct.Rows[0]["productid"].ToString();

                cmd = new SqlCommand("insert into productmoniter( productid, qty, price, branchid, minstock, maxsstock) values (@productid, @mqty, @mprice,@mbranchid,@minstock,@maxstock)");
                cmd.Parameters.Add("@productid", productid);
                cmd.Parameters.Add("@mqty", "0");
                cmd.Parameters.Add("@mprice", MRP);
                cmd.Parameters.Add("@mbranchid", "1");
                cmd.Parameters.Add("@minstock", "1");
                cmd.Parameters.Add("@maxstock", "100");
                vdm.insert(cmd);

                cmd = new SqlCommand("insert into productmoniter( productid, qty, price, branchid, minstock, maxsstock) values (@productid, @mqty, @mprice,@mbranchid,@minstock,@maxstock)");
                cmd.Parameters.Add("@productid", productid);
                cmd.Parameters.Add("@mqty", "0");
                cmd.Parameters.Add("@mprice", MRP);
                cmd.Parameters.Add("@mbranchid", "2");
                cmd.Parameters.Add("@minstock", "1");
                cmd.Parameters.Add("@maxstock", "100");
                vdm.insert(cmd);

                cmd = new SqlCommand("insert into productmoniter( productid, qty, price, branchid, minstock, maxsstock) values (@productid, @mqty, @mprice,@mbranchid,@minstock,@maxstock)");
                cmd.Parameters.Add("@productid", productid);
                cmd.Parameters.Add("@mqty", "0");
                cmd.Parameters.Add("@mprice", MRP);
                cmd.Parameters.Add("@mbranchid", "3");
                cmd.Parameters.Add("@minstock", "1");
                cmd.Parameters.Add("@maxstock", "100");
                vdm.insert(cmd);

                cmd = new SqlCommand("insert into productmoniter( productid, qty, price, branchid, minstock, maxsstock) values (@productid, @mqty, @mprice,@mbranchid,@minstock,@maxstock)");
                cmd.Parameters.Add("@productid", productid);
                cmd.Parameters.Add("@mqty", "0");
                cmd.Parameters.Add("@mprice", MRP);
                cmd.Parameters.Add("@mbranchid", "4");
                cmd.Parameters.Add("@minstock", "1");
                cmd.Parameters.Add("@maxstock", "100");
                vdm.insert(cmd);

                i++;
            }
            grdmiss.DataSource = dtmiss;
            grdmiss.DataBind();
            Session["xportdata"] = dtmiss;
            Session["filename"] = "Branch Transfer report";
        }
        catch
        {

        }
        lblmsg.Text = "Records inserted successfully";
    }
}