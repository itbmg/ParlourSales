﻿using System;
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

        Session["filename"] = "Summary Report";
        Session["title"] = "Summary Report Details";

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
        DailyReport.Columns.Add("OppValue");
        DailyReport.Columns.Add("Rec(Qty)");
        DailyReport.Columns.Add("Rec Value");
        DailyReport.Columns.Add("Issue(Qty)");
        DailyReport.Columns.Add("Issue Value");
        DailyReport.Columns.Add("Return(Qty)");
        DailyReport.Columns.Add("Return Value");
        DailyReport.Columns.Add("Clos(Qty)");
        DailyReport.Columns.Add("Clos Value");

        cmd = new SqlCommand("SELECT   Sum(possale_subdetails.qty) AS qty, productmaster.productid,productmaster.productname, possale_subdetails.price, Sum(possale_subdetails.totvalue) AS totvalue, Sum(possale_subdetails.ordertax) AS ordertax FROM possale_maindetails INNER JOIN possale_subdetails on possale_subdetails.refno = possale_maindetails.sno INNER JOIN productmaster ON productmaster.productid = possale_subdetails.productid  WHERE possale_maindetails.doe BETWEEN @d1 AND @d2 AND possale_maindetails.branchid=@bid  GROUP BY  productmaster.productname, possale_subdetails.price,productmaster.productid");
        cmd.Parameters.Add("@d1", GetLowDate(fromdate));
        cmd.Parameters.Add("@d2", GetHighDate(todate));
        cmd.Parameters.Add("@bid", BranchID);
        DataTable dtsales = SalesDB.SelectQuery(cmd).Tables[0];
        cmd = new SqlCommand("SELECT   Pmaster.productname,subreg.price,Pmaster.productid,subreg.return_qty ,subreg.op_bal,subreg.clo_bal,subreg.inwardqty,subreg.saleqty from sub_registorclosingdetails as subreg INNER JOIN  productmaster as Pmaster ON subreg.productid=Pmaster.productid  where (subreg.branchid=@branchid) and (subreg.doe between @d1 and @d2) order by Pmaster.productid");
        cmd.Parameters.Add("@branchid", BranchID);
        cmd.Parameters.Add("@d1", GetLowDate(fromdate));
        cmd.Parameters.Add("@d2", GetHighDate(todate));
        DataTable dtclosing = SalesDB.SelectQuery(cmd).Tables[0];
        if (dtclosing.Rows.Count > 0)
        {
            sumsalequantity = 0;
            sumsalevalue = 0;
            gsttaxvalue = 0;
            grandtotalsumvalue = 0;
            suminwardqty = 0;
            grandtotalsuminwardqty = 0;
            int i = 1;
            foreach (DataRow drtrans in dtclosing.Rows)
            {
                DataRow newrow = DailyReport.NewRow();
                newrow["Sno"] = i++.ToString();
                newrow["Itemcode"] = drtrans["productid"].ToString();
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
                grand_totalOppValbal += oppvalue;
                grand_totalClosValbal += closvalue;

                double inwardqty = 0;
                double.TryParse(drtrans["inwardqty"].ToString(), out inwardqty);
                suminwardqty += inwardqty;
                grandtotalsuminwardqty += inwardqty;
                newrow["Rec(Qty)"] = drtrans["inwardqty"].ToString();
                double totvalue = 0;
                double.TryParse(drtrans["price"].ToString(), out price);
                totvalue = price * inwardqty;
                sumsalevalue += totvalue;
                grandtotalsuminwardvalue += totvalue;
                newrow["Rec Value"] = totvalue;


                double saleqty = 0;
                double.TryParse(drtrans["saleqty"].ToString(), out saleqty);
                double ordertax = 0;
                //double.TryParse(drtrans["ordertax"].ToString(), out ordertax);
                sumsalequantity += saleqty;
                grandtotalsumsalequantity += saleqty;
                newrow["Issue(Qty)"] = drtrans["saleqty"].ToString();
                double totsalevalue = 0;
                double.TryParse(drtrans["price"].ToString(), out price);
                totsalevalue = price * saleqty;
                sumsalevalue += totsalevalue;
                grandtotalsumsalevalue += totsalevalue;
                newrow["Issue Value"] = totsalevalue;

                gsttaxvalue += ordertax;
                grandtotalgsttaxvalue += ordertax;
                double ot = Math.Round(ordertax, 2);
                double grandtotalvalue = totvalue + ordertax;
                grandtotalsumvalue += grandtotalvalue;
                grandtotalgrandtotalsumvalue += grandtotalvalue;

                double totreturnvalue = 0;
                double returnqty = 0;
                double.TryParse(drtrans["return_qty"].ToString(), out returnqty);
                totreturnvalue = price * returnqty;
                newrow["Return(Qty)"] = returnqty;
                grandtotal_returnqty += returnqty;
                newrow["Return Value"] = totreturnvalue;
                grandtotal_returnvalue += totreturnvalue;
                DailyReport.Rows.Add(newrow);

            }
        }


        DataRow newvartical3 = DailyReport.NewRow();
        newvartical3["Rec(Qty)"] = Math.Round(grandtotalsuminwardqty, 2);
        newvartical3["Rec Value"] = Math.Round(grandtotalsuminwardvalue, 2);
        newvartical3["Issue(Qty)"] = Math.Round(grandtotalsumsalequantity, 2);
        newvartical3["Issue Value"] = Math.Round(grandtotalsumsalevalue, 2);
        newvartical3["Opp(Qty)"] = Math.Round(grand_totaloppbal, 2);
        newvartical3["OppValue"] = Math.Round(grand_totalOppValbal, 2);
        newvartical3["Return(Qty)"] = Math.Round(grandtotal_returnqty, 2);
        newvartical3["Return Value"] = Math.Round(grandtotal_returnvalue, 2);
        newvartical3["Clos(Qty)"] = Math.Round(grand_totalClosingbal, 2);
        newvartical3["Clos Value"] = Math.Round(grand_totalClosValbal, 2);
        //newvartical3["GST Tax Value"] = Math.Round(grandtotalgsttaxvalue, 2);
        //newvartical3["Total Value"] = Math.Round(grandtotalgrandtotalsumvalue, 2);
        DailyReport.Rows.Add(newvartical3);


        grdreport.DataSource = DailyReport;
        grdreport.DataBind();
        Session["xportdata"] = DailyReport;
    }
}