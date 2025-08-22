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
using System.Configuration;
using System.IdentityModel.Protocols.WSTrust;
using System;

public partial class DiscountRates : System.Web.UI.Page
{
    SalesDBManager vdm;
    SqlCommand cmd;
    protected void Page_Load(object sender, EventArgs e)
    {
        lblMessage.Visible = false;
    }

    protected void btnGenerate_Click(object sender, EventArgs e)
    {
        GetReport();
    }
    string id = "";

    void GetReport()
    {
        try
        {
            string BranchID = Session["BranchID"].ToString();
            vdm = new SalesDBManager();
            DataTable Report = new DataTable();
            string branchname = "DiscountRates";
            Session["filename"] = branchname + " DiscountRates " + DateTime.Now.ToString("dd/MM/yyyy");
            cmd = new SqlCommand("SELECT     productmaster.productname, productmoniter.productid, productmoniter.discount, branchmaster.branchname, branchmaster.branchid\r\nFROM        productmoniter INNER JOIN\r\n                  productmaster ON productmoniter.productid = productmaster.productid INNER JOIN\r\n                  branchmaster ON productmoniter.branchid = branchmaster.branchid INNER JOIN\r\n                  branchmapping ON branchmaster.branchid = branchmapping.subbranch\r\nWHERE     (branchmaster.flag = '1') AND (branchmaster.branchid = @BranchID) OR\r\n                  (branchmapping.superbranch = @SOID) ORDER BY productmoniter.Rank");
            cmd.Parameters.AddWithValue("@Flag", "1");
            cmd.Parameters.AddWithValue("@SOID", BranchID);
            cmd.Parameters.AddWithValue("@BranchID", BranchID);
            DataTable dtBranch = vdm.SelectQuery(cmd).Tables[0];
            
            //cmd = new SqlCommand("SELECT products_category.Categoryname, productsdata.sno, productsdata.ProductName, branchproducts.product_sno FROM productsdata INNER JOIN products_subcategory ON productsdata.SubCat_sno = products_subcategory.sno INNER JOIN products_category ON products_subcategory.category_sno = products_category.sno INNER JOIN branchproducts ON productsdata.sno = branchproducts.product_sno WHERE (branchproducts.branch_sno = @BranchID)  ORDER BY branchproducts.Rank");
            ////cmd.Parameters.AddWithValue("@Flag", "1");
            //cmd.Parameters.AddWithValue("@BranchID", BranchID);
            //DataTable produtstbl = vdm.SelectQuery(cmd).Tables[0];
            if (dtBranch.Rows.Count > 0)
            {
                DataView view = new DataView(dtBranch);
                DataTable distincttable = view.ToTable(true, "BranchName", "branchid");
                Report = new DataTable();
                Report.Columns.Add("SNo");
                Report.Columns.Add("Agent Code");
                Report.Columns.Add("Agent Name");
                DataTable distinct_Product = view.ToTable(true, "ProductName", "productid");
                foreach (DataRow dr in distinct_Product.Rows)
                {
                    Report.Columns.Add(dr["ProductName"].ToString()).DataType = typeof(Double);
                }
                int i = 1;
                foreach (DataRow branch in distincttable.Rows)
                {
                    DataRow newrow = Report.NewRow();
                    newrow["SNo"] = i;
                    newrow["Agent Code"] = branch["branchid"].ToString();
                    newrow["Agent Name"] = branch["BranchName"].ToString();
                    foreach (DataRow dr in dtBranch.Rows)
                    {
                        try
                        {
                            if (branch["BranchName"].ToString() == dr["BranchName"].ToString())
                            {
                                id = dr["BranchName"].ToString();
                                id += branch["branchid"].ToString();
                                double discount = 0;
                                double.TryParse(dr["discount"].ToString(), out discount);
                                newrow[dr["ProductName"].ToString()] = discount;
                            }
                        }
                        catch
                        {
                        }
                    }
                    Report.Rows.Add(newrow);
                    i++;
                }
            }
            for (int i = Report.Rows.Count - 1; i >= 0; i--)
            {
                if (Report.Rows[i][1] == DBNull.Value)
                    Report.Rows[i].Delete();
            }
            grvExcelData.DataSource = Report;
            grvExcelData.DataBind();
            Session["xportdata"] = Report;
        }
        catch (Exception ex)
        {
            string msg = ex.Message;
            msg += id;
            lblmsg.Text = msg;
        }
    }
    protected void btn_Export_Click(object sender, EventArgs e)
    {
        try
        {
            //DataTable dt = new DataTable("GridView_Data");
            //foreach (TableCell cell in grvExcelData.HeaderRow.Cells)
            //{
            //    if (cell.Text == "Agent Name")
            //    {
            //        dt.Columns.Add(cell.Text);
            //    }
            //    else
            //    {
            //        dt.Columns.Add(cell.Text).DataType = typeof(double);
            //    }
            //}
            //foreach (GridViewRow row in grvExcelData.Rows)
            //{
            //    dt.Rows.Add();
            //    for (int i = 0; i < row.Cells.Count; i++)
            //    {
            //        if (row.Cells[i].Text == "&nbsp;")
            //        {
            //            row.Cells[i].Text = "0";
            //        }
            //        dt.Rows[dt.Rows.Count - 1][i] = row.Cells[i].Text;
            //    }
            //}
            //Session["dtImport"] = dt;
            //using (XLWorkbook wb = new XLWorkbook()) // Ensure ClosedXML is properly referenced
            //{
            //    wb.Worksheets.Add(dt);
            //    Response.Clear();
            //    Response.Buffer = true;
            //    Response.Charset = "";
            //    Response.ContentType = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet";
            //    string FileName = Session["filename"].ToString();
            //    Response.AddHeader("content-disposition", "attachment;filename=" + FileName + ".xlsx");
            //    using (MemoryStream MyMemoryStream = new MemoryStream())
            //    {
            //        wb.SaveAs(MyMemoryStream);
            //        MyMemoryStream.WriteTo(Response.OutputStream);
            //        Response.Flush();
            //        Response.End();
            //    }
            //}
        }
        catch (Exception ex)
        {
            lblmsg.Text = ex.Message;
        }
    }

    protected void btn_Import_Click(object sender, EventArgs e)
    {
        try
        {
            string FilePath = ConfigurationManager.AppSettings["FilePath"].ToString();
            string filename = string.Empty;
            //To check whether file is selected or not to uplaod
            if (FileUploadToServer.HasFile)
            {
                try
                {
                    string[] allowdFile = { ".xls", ".xlsx" };
                    //Here we are allowing only excel file so verifying selected file pdf or not
                    string FileExt = System.IO.Path.GetExtension(FileUploadToServer.PostedFile.FileName);
                    //Check whether selected file is valid extension or not
                    bool isValidFile = allowdFile.Contains(FileExt);
                    if (!isValidFile)
                    {
                        lblmsg.ForeColor = System.Drawing.Color.Red;
                        lblmsg.Text = "Please upload only Excel";
                    }
                    else
                    {
                        // Get size of uploaded file, here restricting size of file
                        int FileSize = FileUploadToServer.PostedFile.ContentLength;
                        if (FileSize <= 1048576)//1048576 byte = 1MB
                        {
                            //Get file name of selected file
                            filename = Path.GetFileName(Server.MapPath(FileUploadToServer.FileName));

                            //Save selected file into server location
                            FileUploadToServer.SaveAs(Server.MapPath(FilePath) + filename);
                            //Get file path
                            string filePath = Server.MapPath(FilePath) + filename;
                            //Open the connection with excel file based on excel version
                            OleDbConnection con = null;
                            if (FileExt == ".xls")
                            {
                                con = new OleDbConnection(@"Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + filePath + ";Extended Properties=Excel 8.0;");

                            }
                            else if (FileExt == ".xlsx")
                            {
                                con = new OleDbConnection(@"Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + filePath + ";Extended Properties=Excel 12.0;");
                            }

                            con.Close(); con.Open();
                            //Get the list of sheet available in excel sheet
                            DataTable dt = con.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);
                            //Get first sheet name
                            string getExcelSheetName = dt.Rows[0]["Table_Name"].ToString();
                            //Select rows from first sheet in excel sheet and fill into dataset "SELECT * FROM [Sheet1$]";  
                            OleDbCommand ExcelCommand = new OleDbCommand(@"SELECT * FROM [" + getExcelSheetName + @"]", con);
                            OleDbDataAdapter ExcelAdapter = new OleDbDataAdapter(ExcelCommand);
                            DataSet ExcelDataSet = new DataSet();
                            ExcelAdapter.Fill(ExcelDataSet);
                            //Bind the dataset into gridview to display excel contents
                            grvExcelData.DataSource = ExcelDataSet;
                            grvExcelData.DataBind();
                            Session["dtImport"] = ExcelDataSet.Tables[0];
                            btnsave.Visible = true;

                        }
                        else
                        {
                            lblmsg.Text = "Attachment file size should not be greater then 1 MB!";
                        }
                    }
                }
                catch (Exception ex)
                {
                    lblmsg.Text = "Error occurred while uploading a file: " + ex.Message;
                }
            }
            else
            {
                lblmsg.Text = "Please select a file to upload.";
            }
        }
        catch (Exception ex)
        {
            lblmsg.Text = ex.ToString();
            lblmsg.Visible = true;
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
            DataTable dt = (DataTable)Session["dtImport"];
            cmd = new SqlCommand("SELECT branchid, productid, discount FROM productmoniter  ");
            DataTable dtBrnchPrdt = vdm.SelectQuery(cmd).Tables[0];
            int i = 0;
            foreach (DataRow dr in dt.Rows)
            {
                string AgentCode = dr["Agent Code"].ToString();
                myc = AgentCode;
                DataTable dtAgentprdt = new DataTable();
                dtAgentprdt.Columns.Add("branchid");
                dtAgentprdt.Columns.Add("productid");
                dtAgentprdt.Columns.Add("discount");
                DataRow[] drBp = dtBrnchPrdt.Select("branchid='" + dr["Agent Code"].ToString() + "'");
                for (int k = 0; k < drBp.Length; k++)
                {
                    DataRow newrow = dtAgentprdt.NewRow();
                    newrow["branchid"] = drBp[k][0].ToString();
                    newrow["productid"] = drBp[k][1].ToString();
                    newrow["discount"] = drBp[k][2].ToString();
                    dtAgentprdt.Rows.Add(newrow);
                }
                int j = 3;
                foreach (DataColumn dc in dt.Columns)
                {
                    var cell = dc.ColumnName;
                    if (cell == "SNo" || cell == "Agent Code" || cell == "Agent Name")
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
                        if (dtProduct.Rows.Count > 0)
                        {
                            string ProductID = dtProduct.Rows[0]["productid"].ToString();
                            DataTable oldunitprice = new DataTable();
                            oldunitprice.Columns.Add("discount");
                            DataRow[] drAp = dtAgentprdt.Select("productid='" + ProductID + "'");
                            if (drAp.Length == 0)
                            {
                                if (UnitPrice == "0")
                                {

                                }
                                else
                                {
                                    cmd = new SqlCommand("insert into productmoniter (branchid,productid,discount) values (@branchid,@productid,@discount)");
                                    cmd.Parameters.AddWithValue("@branchid", AgentCode);
                                    cmd.Parameters.AddWithValue("@productid", ProductID);
                                    float discount = 0;
                                    float.TryParse(UnitPrice, out discount);
                                    cmd.Parameters.AddWithValue("@discount", discount);
                                    vdm.insert(cmd);
                                }
                            }
                            else
                            {
                                for (int ap = 0; ap < drAp.Length; ap++)
                                {
                                    DataRow newaprow = oldunitprice.NewRow();
                                    newaprow["discount"] = drAp[ap][2].ToString();
                                    oldunitprice.Rows.Add(newaprow);
                                }
                                string oldprice = "0";

                                if (oldunitprice.Rows.Count > 0)
                                {
                                    oldprice = oldunitprice.Rows[0]["discount"].ToString();
                                }
                                float discount = 0;
                                float.TryParse(UnitPrice, out discount);
                                float oldUnitCost = 0;
                                float.TryParse(oldprice, out oldUnitCost);
                                if (discount == oldUnitCost)
                                {

                                }
                                else
                                {
                                    cmd = new SqlCommand("Update productmoniter set discount=@discount where branchid=@branchid and productid=@productid");
                                    cmd.Parameters.AddWithValue("@discount", discount);
                                    cmd.Parameters.AddWithValue("@branchid", AgentCode);
                                    cmd.Parameters.AddWithValue("@productid", ProductID);
                                    vdm.Update(cmd);

                                }
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