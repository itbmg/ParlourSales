using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
public partial class TotalInwardReport : System.Web.UI.Page
{
    SqlCommand cmd;
    ///string BranchID = "";
    SalesDBManager vdm;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Employ_Sno"] == "" || Session["Employ_Sno"] == null)
        {
            Response.Redirect("Login.aspx");
        }
        else
        {
            vdm = new SalesDBManager();
            if (!Page.IsPostBack)
            {
                if (!Page.IsCallback)
                {
                    dtp_FromDate.Text = DateTime.Now.ToString("dd-MM-yyyy HH:mm");//Convert.ToString(lblFromDate.Text); ////     /////
                    dtp_Todate.Text = DateTime.Now.ToString("dd-MM-yyyy HH:mm");// Convert.ToString(lbltodate.Text);/// //// 
                    //lblAddress.Text = Session["Address"].ToString();
                    //lblTitle.Text = Session["TitleName"].ToString();
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
    DataTable Report = new DataTable();
    protected void btn_Generate_Click(object sender, EventArgs e)
    {
        try
        {
            Report.Columns.Add("Sno");
            Report.Columns.Add("Inward Date");
            Report.Columns.Add("Referance No");
            Report.Columns.Add("MRN No");
            Report.Columns.Add("Supplier Name");
            Report.Columns.Add("Product Name");
            Report.Columns.Add("Quantity");
            Report.Columns.Add("Price");
            Report.Columns.Add("Total Amount");
            lblmsg.Text = "";
            string mypo;
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
            }
            datestrig = dtp_Todate.Text.Split(' ');
            if (datestrig.Length > 1)
            {
                if (datestrig[0].Split('-').Length > 0)
                {
                    string[] dates = datestrig[0].Split('-');
                    string[] times = datestrig[1].Split(':');
                    todate = new DateTime(int.Parse(dates[2]), int.Parse(dates[1]), int.Parse(dates[0]), int.Parse(times[0]), int.Parse(times[1]), 0);
                }
            }
            lblFromDate.Text = fromdate.ToString("dd/MM/yyyy");
            lbltodate.Text = todate.ToString("dd/MM/yyyy");
            string branchid = Session["BranchID"].ToString();


            cmd = new SqlCommand("Select inward_maindetails.sno, inward_maindetails.doe, inward_maindetails.refno, inward_maindetails.mrnno, suppliersdetails.name, subcategorymaster.subcategoryname, productmaster.productname, inward_subdetails.qty, inward_subdetails.price, inward_subdetails.totvalue,  productmaster.productid  from inward_maindetails INNER JOIN inward_subdetails ON inward_subdetails.refno=inward_maindetails.sno INNER JOIN productmaster ON productmaster.productid=inward_subdetails.productid INNER JOIN subcategorymaster ON subcategorymaster.subcategoryid =productmaster.subcategoryid INNER JOIN suppliersdetails on suppliersdetails.supplierid = inward_maindetails.supplierid WHERE inward_maindetails.branchid=@branchid AND inward_maindetails.doe BETWEEN @d1 and @d2");
                cmd.Parameters.Add("@d1", GetLowDate(fromdate));
                cmd.Parameters.Add("@d2", GetHighDate(todate));
                cmd.Parameters.Add("@branchid", branchid);
                DataTable dttotalinward = vdm.SelectQuery(cmd).Tables[0];
                if (dttotalinward.Rows.Count > 0)
                {
                    double totalqty = 0;
                    double gtotalqty = 0;
                    double ttotalamount = 0;
                    double gtotalamount = 0;
                    double totalprice = 0;
                    double toatlpq = 0;
                    double totalpriceqty = 0;
                    DateTime dt = DateTime.Now;
                    string prevdate = string.Empty;
                    string prevpono = "";
                    var i = 1;
                    int count = 1;
                    int rowcount = 1;
                    double taxamttotal = 0;
                    double Taxabletotal = 0;
                    foreach (DataRow dr in dttotalinward.Rows)
                    {
                        DataRow newrow = Report.NewRow();
                        newrow["Sno"] = i++.ToString();
                        string prespono = dr["sno"].ToString();
                        string date = dr["doe"].ToString();
                        if (prespono == prevpono)
                        {
                            newrow["Product Name"] = dr["productname"].ToString();
                            double price = 0;
                            double.TryParse(dr["price"].ToString(), out price);
                            totalprice += price;
                            newrow["Price"] = price.ToString("f2");
                            double qty = 0;
                            double.TryParse(dr["qty"].ToString(), out qty);
                            totalqty += qty;
                            newrow["Quantity"] = qty.ToString();
                            double total; double totamount = 0;
                            total = qty * price;
                            totamount += total;
                            double totalamount = total;
                            newrow["Total Amount"] = totalamount.ToString("f2");
                            ttotalamount += totalamount;
                            Report.Rows.Add(newrow);
                            rowcount++;
                            DataTable dtin = new DataTable();
                            DataRow[] drr = dttotalinward.Select("sno='" + prespono + "'");
                            if (drr.Length > 0)
                            {
                                dtin = drr.CopyToDataTable();
                            }
                            int dttotalpocount = dtin.Rows.Count;
                            if (dttotalpocount == rowcount)
                            {
                                gtotalqty += totalqty;
                                gtotalamount += ttotalamount;
                                ttotalamount = 0;
                                totalqty = 0;
                                rowcount = 1;
                            }
                        }
                        else
                        {
                            prevpono = prespono;
                            newrow["Inward Date"] = date.ToString();
                            newrow["Referance No"] = dr["sno"].ToString();
                            newrow["MRN No"] = dr["mrnno"].ToString();
                            newrow["Supplier Name"] = dr["name"].ToString();
                            newrow["Product Name"] = dr["productname"].ToString();
                            double price = 0;
                            double.TryParse(dr["price"].ToString(), out price);
                            totalprice += price;
                            newrow["Price"] = price.ToString("f2");
                            double qty = 0;
                            double.TryParse(dr["qty"].ToString(), out qty);
                            totalqty += qty;
                            newrow["Quantity"] = qty.ToString();
                            double total = 0; double totamount = 0;
                            total = qty * price;
                            totamount += total;
                            double totalamount = total;
                            
                            newrow["Total Amount"] = totalamount.ToString("f2");
                            ttotalamount += totalamount;
                            Report.Rows.Add(newrow);
                            DataTable dtin = new DataTable();
                            DataRow[] drr = dttotalinward.Select("sno='" + prespono + "'");
                            if (drr.Length > 0)
                            {
                                dtin = drr.CopyToDataTable();
                            }
                            int dttotalpocount = dtin.Rows.Count;
                            if (dttotalpocount > 1)
                            {
                                //rowcount++;
                            }
                            else
                            {
                                gtotalqty += totalqty;
                                gtotalamount += ttotalamount;
                                ttotalamount = 0;
                                totalqty = 0;
                                count++;
                                rowcount = 1;
                            }
                        }
                    }
                    gtotalqty += totalqty;
                    gtotalamount += ttotalamount;
                    DataRow salesreport1 = Report.NewRow();
                    salesreport1["Product Name"] = "Grand Total";
                    gtotalqty = Math.Round(gtotalqty, 2);
                    salesreport1["Quantity"] = gtotalqty;
                    gtotalamount = Math.Round(gtotalamount, 2);
                    salesreport1["Total Amount"] = gtotalamount.ToString("f2");
                   
                    Report.Rows.Add(salesreport1);
                    foreach (var column in Report.Columns.Cast<DataColumn>().ToArray())
                    {
                        if (Report.AsEnumerable().All(dr => dr.IsNull(column)))
                            Report.Columns.Remove(column);
                    }
                    grdReports.DataSource = Report;
                    grdReports.DataBind();
                    Session["xportdata"] = Report;
                    Session["filename"] = "Inward Report";
                    hidepanel.Visible = true;
                }
                else
                {
                    lblmsg.Text = "No data were found";
                    hidepanel.Visible = false;
                }

            }
        catch (Exception ex)
        {
            lblmsg.Text = ex.Message;
            hidepanel.Visible = false;
        }
    }

    protected void grdReports_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (e.Row.Cells[8].Text != "Total")
            {
                e.Row.Cells[8].HorizontalAlign = HorizontalAlign.Right;
            }
            if (e.Row.Cells[5].Text == "Total")
            {
                e.Row.Font.Size = FontUnit.Medium;
                e.Row.Font.Bold = true;
            }
            if (e.Row.Cells[5].Text == "Grand Total")
            {
                e.Row.BackColor = System.Drawing.Color.DeepSkyBlue;
                e.Row.Font.Size = FontUnit.Large;
                e.Row.Font.Bold = true;
            }
        }
    }
}