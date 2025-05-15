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
using System.Configuration;
using System.IdentityModel.Protocols.WSTrust;

public partial class SalesImport : System.Web.UI.Page
{
    SqlCommand cmd;
    string BranchID = "";
    SalesDBManager vdm;
    string leveltype = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["BranchID"] == null)
            Response.Redirect("Login.aspx");
        else
        {
            vdm = new SalesDBManager();
            if (!Page.IsPostBack)
            {
                if (!Page.IsCallback)
                {
                    DateTime dt = DateTime.Now.AddDays(-1);
                    dtp_FromDate.Text = dt.ToString("dd-MM-yyyy HH:mm");
                    bindbranchdetails();
                }
            }
        }
    }

    private DateTime GetLowDate(DateTime dt)
    {
        double Hour, Min, Sec;
        DateTime DT = DateTime.Now;
        DT = dt;
        Hour = -dt.Hour;
        Min = -dt.Minute;
        Sec = -dt.Second;
        DT = DT.AddHours(Hour);
        DT = DT.AddMinutes(Min);
        DT = DT.AddSeconds(Sec);
        return DT;
    }
    private DateTime GetHighDate(DateTime dt)
    {
        double Hour, Min, Sec;
        DateTime DT = DateTime.Now;
        Hour = 23 - dt.Hour;
        Min = 59 - dt.Minute;
        Sec = 59 - dt.Second;
        DT = dt;
        DT = DT.AddHours(Hour);
        DT = DT.AddMinutes(Min);
        DT = DT.AddSeconds(Sec);
        return DT;
    }
    private void bindbranchdetails()
    {
        string leveltype = Session["LevelType"].ToString();

        SalesDBManager SalesDB = new SalesDBManager();
        if (leveltype == "SuperAdmin")
        {
            cmd = new SqlCommand("SELECT  branchmaster.branchid, branchmaster.branchname FROM  branchmaster INNER JOIN branchmapping ON branchmaster.branchid=branchmapping.subbranch where branchmapping.superbranch=@branchid");
            cmd.Parameters.Add("@branchid", Session["BranchID"].ToString());
        }
        else
        {
            cmd = new SqlCommand("SELECT  branchmaster.branchid, branchmaster.branchname FROM  branchmaster INNER JOIN branchmapping ON branchmaster.branchid=branchmapping.subbranch where branchmapping.subbranch=@branchid");
            cmd.Parameters.Add("@branchid", Session["BranchID"].ToString());
        }


        DataTable dtcmp = SalesDB.SelectQuery(cmd).Tables[0];
        ddlbranch.DataSource = dtcmp;
        ddlbranch.DataTextField = "branchname";
        ddlbranch.DataValueField = "branchid";
        ddlbranch.DataBind();
        ddlbranch.ClearSelection();
        ddlbranch.Items.Insert(0, new ListItem { Value = "0", Text = "--Select Branch--", Selected = true });
        ddlbranch.SelectedValue = "0";
    }
    protected void btn_Generate_Click(object sender, EventArgs e)
    {
        getdata();
    }

    private void getdata()
    {
        BranchID = ddlbranch.SelectedValue;
        SalesDBManager SalesDB = new SalesDBManager();
        DateTime fromdate = DateTime.Now;
        DateTime todate = DateTime.Now;
        string[] datestrig = dtp_FromDate.Text.Split(' ');
        if (datestrig.Length > 1)
        {
            if (datestrig[0].Split('-').Length > 0)
            {
                string[] dates = datestrig[0].Split('-');
                string[] times = datestrig[1].Split(':');
                fromdate = new DateTime(int.Parse(dates[2]), int.Parse(dates[1]), int.Parse(dates[0]), int.Parse(times[0]), int.Parse(times[1]), 0);
            }
            if (datestrig[0].Split('-').Length > 0)
            {
                string[] dates = datestrig[0].Split('-');
                string[] times = datestrig[1].Split(':');
                todate = new DateTime(int.Parse(dates[2]), int.Parse(dates[1]), int.Parse(dates[0]), int.Parse(times[0]), int.Parse(times[1]), 0);
            }
        }

        Session["filename"] = "SalesImport " + fromdate;
        Session["title"] = "SalesImport " + fromdate;

        double sumsalequantity = 0;
        double sumsalevalue = 0;
        double gsttaxvalue = 0;
        double grandtotalsumvalue = 0;
        double suminwardqty = 0;
        double grandtotalsuminwardqty = 0;
        double grandtotalsumsalequantity = 0;
        double grandtotalsumsalevalue = 0;
        double grandtotalsuminwardvalue = 0;
        double grandtotalgsttaxvalue = 0;
        double grandtotalgrandtotalsumvalue = 0;
        double grand_totaloppbal = 0;
        double grand_totalClosingbal = 0;
        double grand_totalOppValbal = 0;
        double grand_totalClosValbal = 0;
        double grandtotal_returnqty = 0;
        double grandtotal_returnvalue = 0;



        DataTable DailyReport = new DataTable();
        DailyReport.Columns.Add("Sno");
        DailyReport.Columns.Add("Itemcode");
        DailyReport.Columns.Add("ItemName");
        DailyReport.Columns.Add("Price");
        DailyReport.Columns.Add("Opp(Qty)");
        DailyReport.Columns.Add("Rec(Qty)");
        DailyReport.Columns.Add("Issue(Qty)");
        DailyReport.Columns.Add("Return(Prlr)");
        DailyReport.Columns.Add("Return(Plant)");
        DailyReport.Columns.Add("Clos(Qty)");

        cmd = new SqlCommand("SELECT   Sum(possale_subdetails.qty) AS saleqty, productmaster.productid,productmaster.productname, possale_subdetails.price, Sum(possale_subdetails.totvalue) AS totvalue, Sum(possale_subdetails.ordertax) AS ordertax FROM possale_maindetails INNER JOIN possale_subdetails on possale_subdetails.refno = possale_maindetails.sno INNER JOIN productmaster ON productmaster.productid = possale_subdetails.productid  WHERE possale_maindetails.doe BETWEEN @d1 AND @d2 AND possale_maindetails.branchid=@bid  GROUP BY  productmaster.productname, possale_subdetails.price,productmaster.productid");
        cmd.Parameters.Add("@d1", GetLowDate(fromdate));
        cmd.Parameters.Add("@d2", GetHighDate(todate));
        cmd.Parameters.Add("@bid", BranchID);
        DataTable dtsales = SalesDB.SelectQuery(cmd).Tables[0];
        cmd = new SqlCommand("SELECT   Pmaster.productname,subreg.price,Pmaster.productid,subreg.return_qty ,subreg.op_bal,subreg.clo_bal,subreg.inwardqty,subreg.saleqty from sub_registorclosingdetails as subreg INNER JOIN  productmaster as Pmaster ON subreg.productid=Pmaster.productid  where (subreg.branchid=@branchid) and (subreg.doe between @d1 and @d2) order by Pmaster.productid");
        cmd.Parameters.Add("@branchid", BranchID);
        cmd.Parameters.Add("@d1", GetLowDate(fromdate.AddDays(-1)));
        cmd.Parameters.Add("@d2", GetHighDate(todate.AddDays(-1)));
        DataTable dtOpping = SalesDB.SelectQuery(cmd).Tables[0];
        cmd = new SqlCommand("SELECT SUM(inward_subdetails.qty) AS inwardqty,productmaster.productname, productmaster.productid,(CONVERT(NVARCHAR(10), inward_maindetails.doe, 120)) AS doe  FROM   inward_maindetails INNER JOIN  inward_subdetails ON inward_maindetails.sno = inward_subdetails.refno INNER JOIN productmaster ON productmaster.productid = inward_subdetails.productid  WHERE (inward_maindetails.doe BETWEEN @d11 AND @d22) AND (inward_maindetails.branchid = @bidd) AND (inward_maindetails.status = 'A') group by productmaster.productname, (CONVERT(NVARCHAR(10), inward_maindetails.doe, 120)),productmaster.productid");
        cmd.Parameters.Add("@d11", GetLowDate(fromdate));
        cmd.Parameters.Add("@d22", GetLowDate(fromdate));
        cmd.Parameters.Add("@bidd", BranchID);
        DataTable dtinward = vdm.SelectQuery(cmd).Tables[0];
        cmd = new SqlCommand("SELECT   Pmaster.productname,subreg.price,Pmaster.productid,subreg.return_qty ,subreg.op_bal,subreg.clo_bal,subreg.inwardqty,subreg.saleqty from sub_registorclosingdetails as subreg INNER JOIN  productmaster as Pmaster ON subreg.productid=Pmaster.productid  where (subreg.branchid=@branchid) and (subreg.doe between @d1 and @d2) order by Pmaster.productid");
        cmd.Parameters.Add("@branchid", BranchID);
        cmd.Parameters.Add("@d1", GetLowDate(fromdate));
        cmd.Parameters.Add("@d2", GetHighDate(todate));
        DataTable dtclosing = SalesDB.SelectQuery(cmd).Tables[0];
        cmd = new SqlCommand("select  SSR.productid, Sum(SSR.quantity) as ReturnQty,(CONVERT(NVARCHAR(10), SR.doe, 120)) AS doe   from stores_return AS SR INNER JOIN sub_stores_return AS SSR ON SR.sno=SSR.storesreturn_sno INNER JOIN productmaster ON productmaster.productid = SSR.productid WHERE SR.doe between @d1 and @d2 AND SR.branchid=@branchid and SR.ReturnType='parlor' GROUP BY SSR.productid,(CONVERT(NVARCHAR(10), SR.doe, 120))");//, inwarddetails.indentno
        cmd.Parameters.Add("@d1", GetLowDate(fromdate));
        cmd.Parameters.Add("@d2", GetHighDate(todate));
        cmd.Parameters.Add("@branchid", BranchID);
        DataTable dtRetrunParloor = vdm.SelectQuery(cmd).Tables[0];
        cmd = new SqlCommand("select  SSR.productid, Sum(SSR.quantity) as ReturnQty,(CONVERT(NVARCHAR(10), SR.doe, 120)) AS doe   from stores_return AS SR INNER JOIN sub_stores_return AS SSR ON SR.sno=SSR.storesreturn_sno INNER JOIN productmaster ON productmaster.productid = SSR.productid WHERE SR.doe between @d1 and @d2 AND SR.branchid=@branchid and SR.ReturnType='Company' GROUP BY SSR.productid,(CONVERT(NVARCHAR(10), SR.doe, 120))");//, inwarddetails.indentno
        cmd.Parameters.Add("@d1", GetLowDate(fromdate));
        cmd.Parameters.Add("@d2", GetHighDate(todate));
        cmd.Parameters.Add("@branchid", BranchID);
        DataTable dtRetrunPlant = vdm.SelectQuery(cmd).Tables[0];
        if (dtOpping.Rows.Count > 0)
        {
            sumsalequantity = 0;
            sumsalevalue = 0;
            gsttaxvalue = 0;
            grandtotalsumvalue = 0;
            suminwardqty = 0;
            grandtotalsuminwardqty = 0;
            int i = 1;
            cmd = new SqlCommand("insert into registorclosingdetails( parlorid, createdon, closedby, doe) values (@parlorid, @createdon, @closedby, @doe)");//,color,@color
            cmd.Parameters.Add("@parlorid", BranchID);
            cmd.Parameters.Add("@createdon", fromdate);
            cmd.Parameters.Add("@doe", fromdate);
            cmd.Parameters.Add("@closedby", 1);
            vdm.insert(cmd);
            foreach (DataRow drOpp in dtOpping.Rows)
            {
                DataRow newrow = DailyReport.NewRow();
                newrow["Sno"] = i++.ToString();
                newrow["Itemcode"] = drOpp["productid"].ToString();
                newrow["ItemName"] = drOpp["productname"].ToString();
                newrow["Price"] = drOpp["price"].ToString();
                double opqty = 0;
                double.TryParse(drOpp["clo_bal"].ToString(), out opqty);
                double price = 0;
                double.TryParse(drOpp["price"].ToString(), out price);
                newrow["Opp(Qty)"] = opqty;

                grand_totaloppbal += opqty;
                double closqty = 0;
                foreach (DataRow dra in dtclosing.Select("productid='" + drOpp["productid"].ToString() + "'"))
                {
                    double.TryParse(dra["clo_bal"].ToString(), out closqty);
                }


                double inwardqty = 0;
                foreach (DataRow dra in dtinward.Select("productid='" + drOpp["productid"].ToString() + "'"))
                {
                    double.TryParse(dra["inwardqty"].ToString(), out inwardqty);
                }
                suminwardqty += inwardqty;
                grandtotalsuminwardqty += inwardqty;
                newrow["Rec(Qty)"] = inwardqty.ToString();


                double saleqty = 0;
                foreach (DataRow dra in dtsales.Select("productid='" + drOpp["productid"].ToString() + "'"))
                {
                    double.TryParse(dra["saleqty"].ToString(), out saleqty);
                }
                double ordertax = 0;
                //double.TryParse(drtrans["ordertax"].ToString(), out ordertax);
                sumsalequantity += saleqty;
                grandtotalsumsalequantity += saleqty;
                newrow["Issue(Qty)"] = saleqty.ToString();
                //double.TryParse(drtrans["price"].ToString(), out price);

                double ot = Math.Round(ordertax, 2);

                double return_Parlourqty = 0;
                foreach (DataRow dra in dtRetrunParloor.Select("productid='" + drOpp["productid"].ToString() + "'"))
                {
                    double.TryParse(dra["ReturnQty"].ToString(), out return_Parlourqty);
                }

                double return_Plantqty = 0;
                foreach (DataRow dra in dtRetrunPlant.Select("productid='" + drOpp["productid"].ToString() + "'"))
                {
                    double.TryParse(dra["ReturnQty"].ToString(), out return_Plantqty);
                }
                //double.TryParse(drtrans["return_qty"].ToString(), out returnqty);
                newrow["Return(Prlr)"] = return_Parlourqty;
                newrow["Return(Plant)"] = return_Plantqty;
                grandtotal_returnqty += return_Parlourqty;

                double clos_qty = 0;
                if (closqty == 0)
                {
                    clos_qty = (opqty + inwardqty + return_Parlourqty) - (saleqty + return_Plantqty);
                    closqty = clos_qty;
                }
                newrow["Clos(Qty)"] = closqty;
                DailyReport.Rows.Add(newrow);



            }
        }


        grdreport.DataSource = DailyReport;
        grdreport.DataBind();
        Session["xportdata"] = DailyReport;
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
                            grdreport.DataSource = ExcelDataSet;
                            grdreport.DataBind();
                            Session["dtImport"] = ExcelDataSet.Tables[0];
                            BtnSave.Visible = true;

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

    protected void btn_WIDB_Click(object sender, EventArgs e)
    {
        try
        {
            lblmsg.Text = "";
            BranchID = ddlbranch.SelectedValue;
            SalesDBManager SalesDB = new SalesDBManager();
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);

            DateTime fromdate = DateTime.Now;
            DateTime todate = DateTime.Now;
            string[] datestrig = dtp_FromDate.Text.Split(' ');
            if (datestrig.Length > 1)
            {
                if (datestrig[0].Split('-').Length > 0)
                {
                    string[] dates = datestrig[0].Split('-');
                    string[] times = datestrig[1].Split(':');
                    fromdate = new DateTime(int.Parse(dates[2]), int.Parse(dates[1]), int.Parse(dates[0]), int.Parse(times[0]), int.Parse(times[1]), 0);
                }
                if (datestrig[0].Split('-').Length > 0)
                {
                    string[] dates = datestrig[0].Split('-');
                    string[] times = datestrig[1].Split(':');
                    todate = new DateTime(int.Parse(dates[2]), int.Parse(dates[1]), int.Parse(dates[0]), int.Parse(times[0]), int.Parse(times[1]), 0);
                }
            }
            cmd = new SqlCommand("Delete from registorclosingdetails where parlorid=@parlorid and  createdon between @d1 and @d2");//,color,@color
            cmd.Parameters.Add("@parlorid", BranchID);
            cmd.Parameters.Add("@d1", GetLowDate(fromdate));
            cmd.Parameters.Add("@d2", GetHighDate(fromdate));
            vdm.Delete(cmd);
            cmd = new SqlCommand("Delete from sub_registorclosingdetails where branchid=@branchid and  doe between @d1 and @d2");//,color,@color
            cmd.Parameters.Add("@branchid", BranchID);
            cmd.Parameters.Add("@d1", GetLowDate(fromdate));
            cmd.Parameters.Add("@d2", GetHighDate(fromdate));
            vdm.Delete(cmd);
            cmd = new SqlCommand("insert into registorclosingdetails( parlorid, createdon, closedby, doe) values (@parlorid, @createdon, @closedby, @doe)");//,color,@color
            cmd.Parameters.Add("@parlorid", BranchID);
            cmd.Parameters.Add("@createdon", fromdate);
            cmd.Parameters.Add("@doe", fromdate);
            cmd.Parameters.Add("@closedby", 1);
            vdm.insert(cmd);
            DataTable dt = (DataTable)Session["dtImport"];
            int i = 1;

            /////////////////////////////////////////////////////////////////////
            /// SALES
            /// 
            DateTime dtapril = new DateTime();
            DateTime dtmarch = new DateTime();
            int currentyear = ServerDateCurrentdate.Year;
            int nextyear = ServerDateCurrentdate.Year + 1;
            if (ServerDateCurrentdate.Month > 3)
            {
                string apr = "4/1/" + currentyear;
                dtapril = DateTime.Parse(apr);
                string march = "3/31/" + nextyear;
                dtmarch = DateTime.Parse(march);
            }
            if (ServerDateCurrentdate.Month <= 3)
            {
                string apr = "4/1/" + (currentyear - 1);
                dtapril = DateTime.Parse(apr);
                string march = "3/31/" + (nextyear - 1);
                dtmarch = DateTime.Parse(march);
            }
            cmd = new SqlCommand("SELECT { fn IFNULL(MAX(issueno), 0) } + 1 AS Issueno FROM  possale_maindetails WHERE (branchid = @branchid) and (doe between @d1 and @d2)");
            cmd.Parameters.Add("@branchid", BranchID);
            cmd.Parameters.Add("@d1", GetLowDate(dtapril));
            cmd.Parameters.Add("@d2", GetHighDate(dtmarch));
            DataTable dtratechart = vdm.SelectQuery(cmd).Tables[0];
            string issueno = dtratechart.Rows[0]["Issueno"].ToString();
            cmd = new SqlCommand("select MAX(sno) as outward from possale_maindetails");
            DataTable dt_outward = vdm.SelectQuery(cmd).Tables[0];
            string refno_sale = dt_outward.Rows[0]["outward"].ToString();
            //cmd = new SqlCommand("insert into possale_maindetails(custmorid, custmorname, referencenote, totalitems, totalpayble, totalpaying, balance, description, modeofpay, payiningnote, discount, status, branchid, doe, createdby, issueno, billtotalvalue) values (@custmorid,@custmorname,@referencenote,@totalitems,@totalpayble,@totalpaying,@balance,@description,@modeofpay, @payiningnote,@discount, @status, @branchid, @doe, @createdby, @issueno, @billtotalvalue)");
            //cmd.Parameters.Add("@branchid", BranchID);
            //cmd.Parameters.Add("@custmorid", custmerid);
            //cmd.Parameters.Add("@custmorname", custmorname);
            //cmd.Parameters.Add("@referencenote", refnote);
            //cmd.Parameters.Add("@totalitems", totitems);
            //cmd.Parameters.Add("@totalpayble", totalpayable);
            //cmd.Parameters.Add("@totalpaying", totalpaying);
            //cmd.Parameters.Add("@balance", balance);
            //cmd.Parameters.Add("@description", description);
            //cmd.Parameters.Add("@modeofpay", "Cash");
            //cmd.Parameters.Add("@payiningnote", payingnote);
            //cmd.Parameters.Add("@discount", 0);
            //cmd.Parameters.Add("@status", 1);
            //cmd.Parameters.Add("@doe", ServerDateCurrentdate);
            //cmd.Parameters.Add("@createdby", 1);
            //cmd.Parameters.Add("@issueno", issueno);
            //cmd.Parameters.Add("@billtotalvalue", billtotalvalue);
            //vdm.insert(cmd);

            foreach (DataRow dr in dt.Rows)
            {
                vdm = new SalesDBManager();
                string productid = dr["Itemcode"].ToString();
                string Price = dr["Price"].ToString();
                string OppQty = dr["Clos(Qty)"].ToString();
                string Issued = dr["Clos(Qty)"].ToString();
                string Received = dr["Clos(Qty)"].ToString();
                string Retrun = dr["Clos(Qty)"].ToString();
                string closqty = dr["Clos(Qty)"].ToString();

                
                cmd = new SqlCommand("insert into possale_subdetails(productid, qty, price, totvalue, refno, productname, ordertax) values(@productid,@quantity,@perunit,@totalcost,@in_refno, @productname, @ordertax)");
                cmd.Parameters.Add("@productid", productid);
                cmd.Parameters.Add("@quantity", Issued);
                cmd.Parameters.Add("@perunit", Price);
                // cmd.Parameters.Add("@totalcost", Price*Issued);
                // cmd.Parameters.Add("@ordertax", si.ordertax);
                cmd.Parameters.Add("@in_refno", refno_sale);
                vdm.insert(cmd);





                cmd = new SqlCommand("UPDATE productmoniter set qty=@qty, price=@price WHERE productid=@productid AND branchid=@branchid");
                cmd.Parameters.Add("@branchid", BranchID);
                cmd.Parameters.Add("@productid", productid);
                cmd.Parameters.Add("@qty", closqty);
                cmd.Parameters.Add("@price", Price);
                vdm.Update(cmd);

                cmd = new SqlCommand("select MAX(sno) as refno from registorclosingdetails");
                DataTable dtoutward = vdm.SelectQuery(cmd).Tables[0];
                string refno = dtoutward.Rows[0]["refno"].ToString();
                try
                {
                    cmd = new SqlCommand("insert into sub_registorclosingdetails(refno, productid, price, clo_bal,op_bal,doe,branchid,inwardqty,saleqty,return_qty) values(@refno, @productid, @price, @clo_bal,@op_bal,@doe,@branchid,@inwardqty,@saleqty,@return_qty)");
                    cmd.Parameters.Add("@refno", refno);
                    cmd.Parameters.Add("@productid", productid);
                    cmd.Parameters.Add("@price", Price);
                    cmd.Parameters.Add("@clo_bal", closqty);
                    if (OppQty != "0")
                    {
                        cmd.Parameters.Add("@op_bal", OppQty);
                    }
                    else
                    {
                        cmd.Parameters.Add("@op_bal", "0");
                    }
                    cmd.Parameters.Add("@doe", fromdate);
                    cmd.Parameters.Add("@branchid", BranchID);
                    cmd.Parameters.Add("@inwardqty", Received);
                    cmd.Parameters.Add("@saleqty", Issued);
                    cmd.Parameters.Add("@return_qty", Retrun);
                    vdm.insert(cmd);
                }
                catch
                {

                }
            }
        }
        catch (Exception ex)
        {
        }
    }
}