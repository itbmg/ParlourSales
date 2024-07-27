using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

public partial class SummaryReport : System.Web.UI.Page
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

        Session["filename"] = "Summary Report";
        Session["title"] = "Summary Report Details";

        double sumsalequantity = 0;
        double sumsalevalue = 0;
        double gsttaxvalue = 0;
        double grandtotalsumvalue = 0;

        double grandtotalsumsalequantity = 0;
        double grandtotalsumsalevalue = 0;
        double grandtotalgsttaxvalue = 0;
        double grandtotalgrandtotalsumvalue = 0;
        double grand_totaloppbal = 0;
        double grand_totalClosingbal = 0;
        DataTable DailyReport = new DataTable();
        DailyReport.Columns.Add("Sno");
        DailyReport.Columns.Add("ItemName");
        DailyReport.Columns.Add("Price");
        DailyReport.Columns.Add("Opp(Qty)");
        DailyReport.Columns.Add("OppValue");
        DailyReport.Columns.Add("Rec(Qty)");
        DailyReport.Columns.Add("Rec Value");
        DailyReport.Columns.Add("Issue(Qty)");
        DailyReport.Columns.Add("Issue Value");
        DailyReport.Columns.Add("Clos(Qty)");
        DailyReport.Columns.Add("Clos Value");

        cmd = new SqlCommand("SELECT   Sum(possale_subdetails.qty) AS qty, productmaster.productid,productmaster.productname, possale_subdetails.price, Sum(possale_subdetails.totvalue) AS totvalue, Sum(possale_subdetails.ordertax) AS ordertax FROM possale_maindetails INNER JOIN possale_subdetails on possale_subdetails.refno = possale_maindetails.sno INNER JOIN productmaster ON productmaster.productid = possale_subdetails.productid  WHERE possale_maindetails.doe BETWEEN @d1 AND @d2 AND possale_maindetails.branchid=@bid  GROUP BY  productmaster.productname, possale_subdetails.price,productmaster.productid");
        cmd.Parameters.Add("@d1", GetLowDate(fromdate));
        cmd.Parameters.Add("@d2", GetHighDate(todate));
        cmd.Parameters.Add("@bid", BranchID);
        DataTable dtsales = SalesDB.SelectQuery(cmd).Tables[0];
        cmd = new SqlCommand("SELECT   Pmaster.productname,Pmaster.price,Pmaster.productid,subreg.op_bal,subreg.clo_bal from sub_registorclosingdetails as subreg INNER JOIN  productmaster as Pmaster ON subreg.productid=Pmaster.productid  where (subreg.branchid=@branchid) and (subreg.doe between @d1 and @d2)");
        cmd.Parameters.Add("@branchid", BranchID);
        cmd.Parameters.Add("@d1", GetLowDate(fromdate));
        cmd.Parameters.Add("@d2", GetHighDate(todate));
        DataTable dtclosing = SalesDB.SelectQuery(cmd).Tables[0];
        if (dtsales.Rows.Count > 0)
        {
            sumsalequantity = 0;
            sumsalevalue = 0;
            gsttaxvalue = 0;
            grandtotalsumvalue = 0;
            int i = 1;
            foreach (DataRow drtrans in dtclosing.Rows)
            {
                DataRow newrow = DailyReport.NewRow();
                newrow["Sno"] = i++.ToString();
                newrow["ItemName"] = drtrans["productname"].ToString();
                newrow["Price"] = drtrans["price"].ToString();
                double opqty = 0;
                double.TryParse(drtrans["op_bal"].ToString(), out opqty);
                double price = 0;
                double.TryParse(drtrans["price"].ToString(), out price);
                double oppvalue = 0;
                newrow["Opp(Qty)"] = opqty;
                oppvalue = opqty * price;
                newrow["OppValue"] = oppvalue;

                //ftotaloppbal += oppvalue;
                grand_totaloppbal += opqty;
                double closqty = 0;
                double.TryParse(drtrans["clo_bal"].ToString(), out closqty);
                double closvalue = 0;
                closvalue = closqty * price;
                // ftotalClosingbal += closvalue;
                newrow["Clos(Qty)"] = closqty;
                newrow["Clos Value"] = closvalue;
                grand_totalClosingbal += closqty;
                foreach (DataRow dr in dtsales.Select("productid='" + drtrans["productid"].ToString() + "'"))
                {
                    double qty = 0;
                    double.TryParse(dr["qty"].ToString(), out qty);
                    sumsalequantity += qty;
                    grandtotalsumsalequantity += qty;
                    newrow["Issue(Qty)"] = dr["qty"].ToString();
                    double totvalue = 0;
                    double.TryParse(dr["totvalue"].ToString(), out totvalue);
                    sumsalevalue += totvalue;
                    grandtotalsumsalevalue += totvalue;

                    newrow["Issue Value"] = dr["totvalue"].ToString();

                    double ordertax = 0;
                    double.TryParse(dr["ordertax"].ToString(), out ordertax);
                    gsttaxvalue += ordertax;
                    grandtotalgsttaxvalue += ordertax;
                    double ot = Math.Round(ordertax, 2);
                    double grandtotalvalue = totvalue + ordertax;
                    grandtotalsumvalue += grandtotalvalue;
                    grandtotalgrandtotalsumvalue += grandtotalvalue;
                }
                DailyReport.Rows.Add(newrow);

            }
        }


        DataRow newvartical3 = DailyReport.NewRow();
        newvartical3["Issue(Qty)"] = Math.Round(grandtotalsumsalequantity, 2);
        newvartical3["Issue Value"] = Math.Round(grandtotalsumsalevalue, 2);
        newvartical3["Opp(Qty)"] = Math.Round(grand_totaloppbal, 2);
        newvartical3["Clos(Qty)"] = Math.Round(grand_totalClosingbal, 2);
        //newvartical3["GST Tax Value"] = Math.Round(grandtotalgsttaxvalue, 2);
        //newvartical3["Total Value"] = Math.Round(grandtotalgrandtotalsumvalue, 2);
        DailyReport.Rows.Add(newvartical3);


        grdreport.DataSource = DailyReport;
        grdreport.DataBind();
        Session["xportdata"] = DailyReport;
    }
}