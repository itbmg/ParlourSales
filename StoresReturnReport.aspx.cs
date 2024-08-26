using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
public partial class StoresReturnReport : System.Web.UI.Page
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

        Session["filename"] = "Stores Returns Report";
        Session["title"] = "Stores Returns Details";

        double totReturnQty = 0;
        double totReturnVal = 0;
        DataTable Report = new DataTable();
        Report.Columns.Add("Sno");
        Report.Columns.Add("Date");
        Report.Columns.Add("Retrun No");
        Report.Columns.Add("Ref no");
        Report.Columns.Add("ItemName");
        Report.Columns.Add("Return(Qty)");
        Report.Columns.Add("Price");
        Report.Columns.Add("Returnvalue");
        Report.Columns.Add("Remarks");

        vdm = new SalesDBManager();
        string branchid = Session["BranchID"].ToString();
        cmd = new SqlCommand("select productmaster.productname, SR.sno, SR.returntype, SR.doe, SR.branchid, SR.remarks, SR.invoiceno, SR.refno, SR.billtotalvalue, SR.entryby, SR.createdon, SR.status, SSR.productid, SSR.quantity, SSR.price, SSR.storesreturn_sno, SSR.totalvalue, SSR.ordertax  from stores_return AS SR INNER JOIN sub_stores_return AS SSR ON SR.sno=SSR.storesreturn_sno INNER JOIN productmaster ON productmaster.productid = SSR.productid WHERE SR.doe between @d1 and @d2 AND SR.branchid=@branchid ");//, inwarddetails.indentno
        cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate));
        cmd.Parameters.AddWithValue("@d2", GetHighDate(todate));
        cmd.Parameters.AddWithValue("@branchid", branchid);
        DataTable routes = vdm.SelectQuery(cmd).Tables[0];
        DataView view = new DataView(routes);
        DataTable dtinward = view.ToTable(true, "sno", "returntype", "doe", "branchid", "refno", "status", "remarks", "billtotalvalue", "invoiceno");//, "indentno"
        DataTable dtsubinward = view.ToTable(true, "productname", "productid", "quantity", "price", "totalvalue", "storesreturn_sno", "ordertax");
        int J = 1;
       double sumReturnQty = 0;
        double sumReturnval = 0;
        foreach (DataRow dr in dtinward.Rows)
        {
            sumReturnQty = 0;
            sumReturnval = 0;
            foreach (DataRow drSub in dtsubinward.Select("storesreturn_sno='" + dr["sno"].ToString() + "'"))
            {
                DataRow newrow = Report.NewRow();
                newrow["sno"] = J++.ToString();
                newrow["ItemName"] = drSub["productname"].ToString();
                newrow["Price"] = drSub["price"].ToString();
                double qty = 0;
                double.TryParse(drSub["quantity"].ToString(), out qty);
                sumReturnQty += qty;
                totReturnQty += qty;
                newrow["Return(Qty)"] = Math.Round(qty,2);
                double totvalue = 0;
                double.TryParse(drSub["totalvalue"].ToString(), out totvalue);
                totReturnVal += totvalue;
                sumReturnval += totvalue;
                newrow["Returnvalue"] = Math.Round(totvalue, 2);
                Report.Rows.Add(newrow);
            }
            DataRow newrow2 = Report.NewRow();
            newrow2["Retrun No"] = dr["sno"].ToString();
            newrow2["Ref no"] = dr["refno"].ToString();
            newrow2["Remarks"] = dr["remarks"].ToString();
            DateTime dt = Convert.ToDateTime(dr["doe"].ToString());
            newrow2["Date"] = dt.ToString("dd/MMM/yyyy");
            newrow2["Return(Qty)"] = Math.Round(sumReturnQty,2);
            newrow2["Returnvalue"] = Math.Round(sumReturnval, 2);
            Report.Rows.Add(newrow2);
        }

        DataRow newvartical3 = Report.NewRow();
        newvartical3["ItemName"] = "Total";
        newvartical3["Return(Qty)"] = Math.Round(totReturnQty, 2);
        newvartical3["Returnvalue"] = Math.Round(totReturnVal, 2);
        Report.Rows.Add(newvartical3);

        grdreport.DataSource = Report;
        grdreport.DataBind();
        Session["xportdata"] = Report;
    }
}
