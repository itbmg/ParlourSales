using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class Dailyreport : System.Web.UI.Page
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
                    DateTime dt = DateTime.Now.AddDays(-1);
                    dtp_FromDate.Text = dt.ToString("dd-MM-yyyy HH:mm");
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

    protected void grdsiloopening_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (e.Row.Cells[0].Text == "Total")
            {
                e.Row.BackColor = System.Drawing.Color.Aquamarine;
                e.Row.Font.Size = FontUnit.Medium;
                e.Row.Font.Bold = true;
            }
            if (e.Row.Cells[0].Text == "Receipts")
            {
                e.Row.BackColor = System.Drawing.Color.DeepSkyBlue;
                e.Row.Font.Size = FontUnit.Large;
                e.Row.Font.Bold = true;
            }
            if (e.Row.Cells[0].Text == "Buffalo")
            {
                e.Row.BackColor = System.Drawing.Color.LightBlue;
                e.Row.Font.Size = FontUnit.Large;
                e.Row.Font.Bold = true;
            }
        }
    }


    protected void btn_Generate_Click(object sender, EventArgs e)
    {
        getdata();
    }

    private void getdata()
    {
        BranchID = Session["BranchID"].ToString();
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

        Session["filename"] = "Daily Report";
        Session["title"] = "Daily Report Details";

        
        double sumsalequantity = 0;
        double sumsalevalue = 0;
        double gsttaxvalue = 0;
        double grandtotalsumvalue = 0;

        double grandtotalsumsalequantity = 0;
        double grandtotalsumsalevalue = 0;
        double grandtotalgsttaxvalue = 0;
        double grandtotalgrandtotalsumvalue = 0;

        DataTable DailyReport = new DataTable();
        DailyReport.Columns.Add("SubCategory");
        DailyReport.Columns.Add("ItemName");
        DailyReport.Columns.Add("Sale(Qty)");
        DailyReport.Columns.Add("Price");
        DailyReport.Columns.Add("Salevalue");
        DailyReport.Columns.Add("GST Tax Value");
        DailyReport.Columns.Add("Total Value");
        //DailyReport.Columns.Add("Cash");
        //DailyReport.Columns.Add("Phone Pay");

        cmd = new SqlCommand("SELECT    sum(totalpaying) as amount ,modeofpay FROM        possale_maindetails where branchid=@branchid and doe BETWEEN @d1 AND @d2 group by modeofpay");
        cmd.Parameters.Add("@d1", GetLowDate(fromdate));
        cmd.Parameters.Add("@d2", GetHighDate(todate));
        cmd.Parameters.Add("@branchid", BranchID);
        DataTable dtAmount = SalesDB.SelectQuery(cmd).Tables[0];
        if(dtAmount.Rows.Count > 0)
        {
            lblCash.Text = dtAmount.Rows[0]["amount"].ToString();
            lblPhonePay.Text = dtAmount.Rows[1]["amount"].ToString();
        }

        cmd = new SqlCommand("select subcategoryid, subcategoryname from subcategorymaster");
        DataTable dtssubcategory = SalesDB.SelectQuery(cmd).Tables[0];
        if (dtssubcategory.Rows.Count > 0)
        {
            foreach (DataRow drsub in dtssubcategory.Rows)
            {
                string subcatid = drsub["subcategoryid"].ToString();
                string subcategoryname = drsub["subcategoryname"].ToString();

                cmd = new SqlCommand("SELECT   Sum(possale_subdetails.qty) AS qty, productmaster.productname, possale_subdetails.price, Sum(possale_subdetails.totvalue) AS totvalue, Sum(possale_subdetails.ordertax) AS ordertax FROM possale_maindetails INNER JOIN possale_subdetails on possale_subdetails.refno = possale_maindetails.sno INNER JOIN productmaster ON productmaster.productid = possale_subdetails.productid  WHERE possale_maindetails.doe BETWEEN @d1 AND @d2 AND possale_maindetails.branchid=@bid AND productmaster.subcategoryid=@subcatid  GROUP BY  productmaster.productname, possale_subdetails.price");
                cmd.Parameters.Add("@d1", GetLowDate(fromdate));
                cmd.Parameters.Add("@d2", GetHighDate(todate));
                cmd.Parameters.Add("@bid", BranchID);
                cmd.Parameters.Add("@subcatid", subcatid);
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
                        newrow["SubCategory"] = subcategoryname;
                        newrow["ItemName"] = dr["productname"].ToString();
                        newrow["Price"] = dr["price"].ToString();

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
                    newvartical2["SubCategory"] = "Total";
                    newvartical2["Sale(Qty)"] = Math.Round(sumsalequantity, 2);
                    newvartical2["Salevalue"] = Math.Round(sumsalevalue, 2);
                    newvartical2["GST Tax Value"] = Math.Round(gsttaxvalue, 2);
                    newvartical2["Total Value"] = Math.Round(grandtotalsumvalue, 2);
                    DailyReport.Rows.Add(newvartical2);
                }
            }


            DataRow newvartical3 = DailyReport.NewRow();
            newvartical3["SubCategory"] = "Grand Total";
            newvartical3["Sale(Qty)"] = Math.Round(grandtotalsumsalequantity, 2);
            newvartical3["Salevalue"] = Math.Round(grandtotalsumsalevalue, 2);
            newvartical3["GST Tax Value"] = Math.Round(grandtotalgsttaxvalue, 2);
            newvartical3["Total Value"] = Math.Round(grandtotalgrandtotalsumvalue, 2);
            DailyReport.Rows.Add(newvartical3);


            grdreport.DataSource = DailyReport;
            grdreport.DataBind();
            Session["xportdata"] = DailyReport;
        }
    }
}