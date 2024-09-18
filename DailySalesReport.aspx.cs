using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
public partial class DailySalesReport : System.Web.UI.Page
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
            BranchID = Session["BranchID"].ToString();
            vdm = new SalesDBManager();
            if (!Page.IsPostBack)
            {
                if (!Page.IsCallback)
                {
                    //DateTime dt = DateTime.Now.AddDays(-1);
                    //dtp_FromDate.Text = dt.ToString("dd-MM-yyyy HH:mm");
                    ////dtp_ToDate.Text = dt.ToString("dd-MM-yyyy HH:mm");
                    dtp_FromDate.Text = DateTime.Now.ToString("dd-MM-yyyy HH:mm");
                    dtp_ToDate.Text = DateTime.Now.ToString("dd-MM-yyyy HH:mm");
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
        BranchID = BranchID = ddlbranch.SelectedValue;
        
        SalesDBManager SalesDB = new SalesDBManager();
        DateTime fromdate = DateTime.Now;
        string[] fromdatestrig = dtp_FromDate.Text.Split(' ');
        if (fromdatestrig.Length > 1)
        {
            if (fromdatestrig[0].Split('-').Length > 0)
            {
                string[] dates = fromdatestrig[0].Split('-');
                string[] times = fromdatestrig[1].Split(':');
                fromdate = new DateTime(int.Parse(dates[2]), int.Parse(dates[1]), int.Parse(dates[0]), int.Parse(times[0]), int.Parse(times[1]), 0);
            }
        }
        //fromdate = fromdate.AddDays(-1);
        DateTime todate = DateTime.Now;
        string[] todatestrig = dtp_ToDate.Text.Split(' ');
        if (todatestrig.Length > 1)
        {
            if (todatestrig[0].Split('-').Length > 0)
            {
                string[] dates = todatestrig[0].Split('-');
                string[] times = todatestrig[1].Split(':');
                todate = new DateTime(int.Parse(dates[2]), int.Parse(dates[1]), int.Parse(dates[0]), int.Parse(times[0]), int.Parse(times[1]), 0);
            }
        }

        Session["filename"] = "Daily Sales Report";
        Session["title"] = "Daily Sales Details";
        TimeSpan t = fromdate - todate;
        double days = t.TotalDays;
        if (days == 0)
        {


            double sumsalequantity = 0;
            double sumsalevalue = 0;
            double gsttaxvalue = 0;
            double grandtotalsumvalue = 0;

            double grandtotalsumsalequantity = 0;
            double grandtotalsumsalevalue = 0;
            double grandtotalgsttaxvalue = 0;
            double grandtotalgrandtotalsumvalue = 0;
            double grandtotalCash = 0;
            double grandtotalPhonePay = 0;
            double grandtotalFree = 0;
            double grandtotalCredit = 0;
            DataTable DailyReport = new DataTable();
            DailyReport.Columns.Add("Sno");

            DailyReport.Columns.Add("Date");
            DailyReport.Columns.Add("Invoice no");
            DailyReport.Columns.Add("ItemName");
            DailyReport.Columns.Add("Sale(Qty)");
            DailyReport.Columns.Add("Price");
            DailyReport.Columns.Add("Salevalue");
            DailyReport.Columns.Add("GST Tax Value");
            DailyReport.Columns.Add("Total Value");
            DailyReport.Columns.Add("Cash");
            DailyReport.Columns.Add("Phone Pay");
            DailyReport.Columns.Add("Free");
            DailyReport.Columns.Add("Credit");

            cmd = new SqlCommand("SELECT     sno,  totalpaying,modeofpay FROM possale_maindetails where doe BETWEEN @d1 AND @d2 and branchid=@branchid ");
            cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate));
            cmd.Parameters.AddWithValue("@d2", GetHighDate(todate));
            cmd.Parameters.AddWithValue("@branchid", BranchID);
            DataTable dtInvoice = SalesDB.SelectQuery(cmd).Tables[0];
            int J = 1;
            string date = "";
            if (dtInvoice.Rows.Count > 0)
            {
                foreach (DataRow drsub in dtInvoice.Rows)
                {
                    string refno = drsub["sno"].ToString();
                    cmd = new SqlCommand("SELECT   possale_subdetails.qty, productmaster.productname, possale_subdetails.price,possale_maindetails.doe, possale_subdetails.totvalue,possale_subdetails.ordertax FROM possale_maindetails INNER JOIN possale_subdetails on possale_subdetails.refno = possale_maindetails.sno INNER JOIN productmaster ON productmaster.productid = possale_subdetails.productid  WHERE possale_maindetails.doe BETWEEN @d1 AND @d2 AND possale_maindetails.branchid=@bid AND possale_maindetails.sno=@refno");
                    cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate));
                    cmd.Parameters.AddWithValue("@d2", GetHighDate(todate));
                    cmd.Parameters.AddWithValue("@bid", BranchID);
                    cmd.Parameters.AddWithValue("@refno", refno);
                    DataTable dtsales = SalesDB.SelectQuery(cmd).Tables[0];
                    if (dtsales.Rows.Count > 0)
                    {
                        sumsalequantity = 0;
                        sumsalevalue = 0;
                        gsttaxvalue = 0;
                        grandtotalsumvalue = 0;

                        foreach (DataRow dr in dtsales.Rows)
                        {
                            DataRow newrow = DailyReport.NewRow();
                            newrow["sno"] = J++.ToString();
                            newrow["Invoice no"] = "";
                            newrow["ItemName"] = dr["productname"].ToString();
                            newrow["Price"] = dr["price"].ToString();
                            date = dr["doe"].ToString();

                            newrow["Date"] = "";
                            double qty = 0;
                            double.TryParse(dr["qty"].ToString(), out qty);
                            sumsalequantity += qty;
                            grandtotalsumsalequantity += qty;
                            newrow["Sale(Qty)"] = dr["qty"].ToString();

                            double totvalue = 0;
                            double.TryParse(dr["totvalue"].ToString(), out totvalue);
                            sumsalevalue += totvalue;
                            grandtotalsumsalevalue += totvalue;

                            newrow["Salevalue"] = dr["totvalue"].ToString();

                            double ordertax = 0;
                            double.TryParse(dr["ordertax"].ToString(), out ordertax);
                            gsttaxvalue += ordertax;
                            grandtotalgsttaxvalue += ordertax;
                            double ot = Math.Round(ordertax, 2);
                            newrow["GST Tax Value"] = ot.ToString();

                            double grandtotalvalue = totvalue + ordertax;
                            grandtotalsumvalue += grandtotalvalue;
                            grandtotalgrandtotalsumvalue += grandtotalvalue;
                            newrow["Total Value"] = Math.Round(grandtotalvalue, 2).ToString();
                            DailyReport.Rows.Add(newrow);
                        }
                        DataRow newvartical2 = DailyReport.NewRow();
                        newvartical2["Invoice no"] = refno;
                        DateTime dt = Convert.ToDateTime(date);
                        newvartical2["Date"] = dt.ToString("dd/MMM/yyyy");
                        newvartical2["ItemName"] = "Total";
                        newvartical2["Sale(Qty)"] = Math.Round(sumsalequantity, 2);
                        newvartical2["Salevalue"] = Math.Round(sumsalevalue, 2);
                        newvartical2["GST Tax Value"] = Math.Round(gsttaxvalue, 2);
                        newvartical2["Total Value"] = Math.Round(grandtotalsumvalue, 2);
                        string modeofpay = drsub["modeofpay"].ToString();
                        if (modeofpay.ToLower() == "cash")
                        {
                            newvartical2["Cash"] = drsub["totalpaying"].ToString();
                            double ordercash = 0;
                            double.TryParse(drsub["totalpaying"].ToString(), out ordercash);
                            grandtotalCash += ordercash;
                        }
                        if (modeofpay.ToLower() == "phonepay")
                        {
                            newvartical2["Phone Pay"] = drsub["totalpaying"].ToString();
                            double ordercash = 0;
                            double.TryParse(drsub["totalpaying"].ToString(), out ordercash);
                            grandtotalPhonePay += ordercash;
                        }
                        if (modeofpay.ToLower() == "free")
                        {
                            newvartical2["Free"] = drsub["totalpaying"].ToString();
                            double ordercash = 0;
                            double.TryParse(drsub["totalpaying"].ToString(), out ordercash);
                            grandtotalFree += ordercash;
                        }
                        if (modeofpay.ToLower() == "credit")
                        {
                            newvartical2["Credit"] = drsub["totalpaying"].ToString();
                            double ordercash = 0;
                            double.TryParse(drsub["totalpaying"].ToString(), out ordercash);
                            grandtotalCredit += ordercash;
                        }
                        DailyReport.Rows.Add(newvartical2);
                    }
                }


                DataRow newvartical3 = DailyReport.NewRow();
                newvartical3["Invoice no"] = "Grand Total";
                newvartical3["Sale(Qty)"] = Math.Round(grandtotalsumsalequantity, 2);
                newvartical3["Salevalue"] = Math.Round(grandtotalsumsalevalue, 2);
                newvartical3["GST Tax Value"] = Math.Round(grandtotalgsttaxvalue, 2);
                newvartical3["Total Value"] = Math.Round(grandtotalgrandtotalsumvalue, 2);
                newvartical3["Cash"] = Math.Round(grandtotalCash, 2);
                newvartical3["Phone Pay"] = Math.Round(grandtotalPhonePay, 2);
                newvartical3["Free"] = Math.Round(grandtotalFree, 2);
                newvartical3["Credit"] = Math.Round(grandtotalCredit, 2);
                DailyReport.Rows.Add(newvartical3);

                grdreport.DataSource = DailyReport;
                grdreport.DataBind();
                Session["xportdata"] = DailyReport;
            }
        }
        else
        {
            double sumsalequantity = 0;
            double sumsalevalue = 0;
            double gsttaxvalue = 0;
            double grandtotalsumvalue = 0;

            double grandtotalsumsalequantity = 0;
            double grandtotalsumsalevalue = 0;
            double grandtotalgsttaxvalue = 0;
            double grandtotalgrandtotalsumvalue = 0;
            double grandtotalCash = 0;
            double grandtotalPhonePay = 0;
            double grandtotalFree = 0;
            double grandtotalCredit = 0;
            DataTable DailyReport = new DataTable();
            DailyReport.Columns.Add("Sno");
            DailyReport.Columns.Add("Date");
            DailyReport.Columns.Add("Sale(Qty)");
            DailyReport.Columns.Add("Salevalue");
            DailyReport.Columns.Add("GST Tax Value");
            DailyReport.Columns.Add("Total Value");

            //cmd = new SqlCommand("SELECT     sno,  totalpaying,modeofpay FROM possale_maindetails where doe BETWEEN @d1 AND @d2 and branchid=@branchid ");
            //cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate));
            //cmd.Parameters.AddWithValue("@d2", GetHighDate(todate));
            //cmd.Parameters.AddWithValue("@branchid", BranchID);
            //DataTable dtInvoice = SalesDB.SelectQuery(cmd).Tables[0];
            int J = 1;
            string date = "";
            //if (dtInvoice.Rows.Count > 0)
            //{
            //    foreach (DataRow drsub in dtInvoice.Rows)
            //    {
            cmd = new SqlCommand("SELECT   SUM(possale_subdetails.qty) as qty,CAST(possale_maindetails.doe AS date), SUM(possale_subdetails.totvalue) as totvalue,SUM(possale_subdetails.ordertax) as ordertax FROM possale_maindetails INNER JOIN possale_subdetails on possale_subdetails.refno = possale_maindetails.sno INNER JOIN productmaster ON productmaster.productid = possale_subdetails.productid  WHERE possale_maindetails.doe BETWEEN @d1 AND @d2 AND possale_maindetails.branchid=@bid GROUP BY CAST(possale_maindetails.doe AS date)");
            cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate));
            cmd.Parameters.AddWithValue("@d2", GetHighDate(todate));
            cmd.Parameters.AddWithValue("@bid", BranchID);
            DataTable dtsales = SalesDB.SelectQuery(cmd).Tables[0];
            if (dtsales.Rows.Count > 0)
            {
                sumsalequantity = 0;
                sumsalevalue = 0;
                gsttaxvalue = 0;
                grandtotalsumvalue = 0;

                foreach (DataRow dr in dtsales.Rows)
                {
                    DataRow newrow = DailyReport.NewRow();
                    newrow["sno"] = J++.ToString();
                    date = dr["Column1"].ToString();
                    DateTime dte = Convert.ToDateTime(date);
                    newrow["Date"] = dte.ToString("dd/MMM/yyyy");

                    double qty = 0;
                    double.TryParse(dr["qty"].ToString(), out qty);
                    sumsalequantity += qty;
                    grandtotalsumsalequantity += qty;
                    newrow["Sale(Qty)"] = dr["qty"].ToString();

                    double totvalue = 0;
                    double.TryParse(dr["totvalue"].ToString(), out totvalue);
                    sumsalevalue += totvalue;
                    grandtotalsumsalevalue += totvalue;

                    newrow["Salevalue"] = dr["totvalue"].ToString();

                    double ordertax = 0;
                    double.TryParse(dr["ordertax"].ToString(), out ordertax);
                    gsttaxvalue += ordertax;
                    grandtotalgsttaxvalue += ordertax;
                    double ot = Math.Round(ordertax, 2);
                    newrow["GST Tax Value"] = ot.ToString();

                    double grandtotalvalue = totvalue + ordertax;
                    grandtotalsumvalue += grandtotalvalue;
                    grandtotalgrandtotalsumvalue += grandtotalvalue;
                    newrow["Total Value"] = Math.Round(grandtotalvalue, 2).ToString();
                    DailyReport.Rows.Add(newrow);
                }
                DataRow newvartical2 = DailyReport.NewRow();
                DateTime dt = Convert.ToDateTime(date);
                //newvartical2["Date"] = dt.ToString("dd/MMM/yyyy");
                newvartical2["Date"] = "Total";
                newvartical2["Sale(Qty)"] = Math.Round(sumsalequantity, 2);
                newvartical2["Salevalue"] = Math.Round(sumsalevalue, 2);
                newvartical2["GST Tax Value"] = Math.Round(gsttaxvalue, 2);
                newvartical2["Total Value"] = Math.Round(grandtotalsumvalue, 2);
                DailyReport.Rows.Add(newvartical2);
            }

            //DataRow newvartical3 = DailyReport.NewRow();
            //newvartical3["Date"] = "Grand Total";
            //newvartical3["Sale(Qty)"] = Math.Round(grandtotalsumsalequantity, 2);
            //newvartical3["Salevalue"] = Math.Round(grandtotalsumsalevalue, 2);
            //newvartical3["GST Tax Value"] = Math.Round(grandtotalgsttaxvalue, 2);
            //newvartical3["Total Value"] = Math.Round(grandtotalgrandtotalsumvalue, 2);
            //DailyReport.Rows.Add(newvartical3);


            grdreport.DataSource = DailyReport;
            grdreport.DataBind();
            Session["xportdata"] = DailyReport;
        }
    }
}