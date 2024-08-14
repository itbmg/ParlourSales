using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Net;
using System.IO;

public partial class CashBook : System.Web.UI.Page
{
    SqlCommand cmd;
    string BranchID = "";
    SalesDBManager vdm;
    double submittedcash = 0;
    double totalsale = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["branch"] == null)
        {
            Response.Redirect("Login.aspx");
        }
        else
        {
            BranchID = Session["branch"].ToString();
        }
        //vdm = new SalesDBManager();
        if (!this.IsPostBack)
        {
            if (!Page.IsCallback)
            {
                txtFromdate.Text = DateTime.Now.ToString("dd-MM-yyyy HH:mm");
                lblTitle.Text = Session["TitleName"].ToString();
                bindcompanydetails();

            }
        }
    }
    private void bindcompanydetails()
    {

        SalesDBManager SalesDB = new SalesDBManager();
        cmd = new SqlCommand("SELECT  branchid, branchname FROM  branchmaster");
        DataTable dtcmp = SalesDB.SelectQuery(cmd).Tables[0];
        ddlcompany.DataSource = dtcmp;
        ddlcompany.DataTextField = "branchname";
        ddlcompany.DataValueField = "branchid";
        ddlcompany.DataBind();
        ddlcompany.ClearSelection();
        ddlcompany.Items.Insert(0, new ListItem { Value = "0", Text = "--Select Customer--", Selected = true });
        ddlcompany.SelectedValue = "0";
    }
    protected void btnGenerate_Click(object sender, EventArgs e)
    {
        GetReport();
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
    DataTable RouteReport = new DataTable();
    DataTable CashPayReport = new DataTable();
    DataTable IOUReport = new DataTable();
    
    void GetReport()
    {
        try
        {
            pnlfoter.Visible = true;
            pnlHide.Visible = true;
            hidePanel.Visible = false;
            lblSalesOffice.Text = "";
            lblOppBal.Text = "";
            lblpreparedby.Text = "";
            lblmsg.Text = "";
            lblCash.Text = "";
            lblTotalAmout.Text = "";
            lblDiffernce.Text = "";
            vdm = new SalesDBManager();
            RouteReport = new DataTable();
            CashPayReport = new DataTable();
            IOUReport = new DataTable();
            DateTime fromdate = DateTime.Now;
            string[] fromdatestrig = txtFromdate.Text.Split(' ');
            if (fromdatestrig.Length > 1)
            {
                if (fromdatestrig[0].Split('-').Length > 0)
                {
                    string[] dates = fromdatestrig[0].Split('-');
                    string[] times = fromdatestrig[1].Split(':');
                    fromdate = new DateTime(int.Parse(dates[2]), int.Parse(dates[1]), int.Parse(dates[0]), int.Parse(times[0]), int.Parse(times[1]), 0);
                }
            }
            //Session["filename"] = "Cash Book ->" + Session["branchname"].ToString();
            lblSalesOffice.Text = ddlcompany.SelectedItem.Text;
            //string DOE = txtFromdate.Text;
            //DateTime dtDOE = Convert.ToDateTime(DOE);
            //string ChangedTime = dtDOE.ToString("dd/MMM/yyyy");
            lbl_fromDate.Text = fromdate.ToString("dd/MMM/yyyy");
            string BranchID = ddlcompany.SelectedValue;
            DataTable dtCashBook = new DataTable();
            RouteReport.Columns.Add("BranchName");
            RouteReport.Columns.Add("Reciept No");
            RouteReport.Columns.Add("Received Amount").DataType = typeof(Double);

            //cmd = new SqlCommand("SELECT dispatch.DispName, tripdata.RecieptNo, tripdata.ReceivedAmount FROM tripdata INNER JOIN triproutes ON tripdata.Sno = triproutes.Tripdata_sno INNER JOIN dispatch ON triproutes.RouteID = dispatch.sno INNER JOIN branchdata ON tripdata.BranchID = branchdata.sno WHERE (tripdata.BranchID = @BranchID) AND (tripdata.Cdate BETWEEN @d1 AND @d2) OR (tripdata.Cdate BETWEEN @d1 AND @d2) AND (branchdata.SalesOfficeID = @BranchID)");
            //cmd.Parameters.AddWithValue("@BranchID", ddlcompany.SelectedValue);
            //cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate));
            //cmd.Parameters.AddWithValue("@d2", GetHighDate(fromdate));
            //dtCashBook = vdm.SelectQuery(cmd).Tables[0];
            cmd = new SqlCommand("SELECT   Sum(possale_subdetails.qty) AS outwardqty,  Sum(possale_subdetails.totvalue) AS totvalue, Sum(possale_subdetails.ordertax) AS ordertax,CAST(possale_maindetails.doe AS date),possale_maindetails.issueno FROM possale_maindetails INNER JOIN possale_subdetails on possale_subdetails.refno = possale_maindetails.sno INNER JOIN productmaster ON productmaster.productid = possale_subdetails.productid  WHERE possale_maindetails.doe BETWEEN @d1 AND @d2 AND possale_maindetails.branchid=@bid  GROUP BY  possale_maindetails.issueno,CAST(possale_maindetails.doe AS date)");
            cmd.Parameters.Add("@d1", GetLowDate(fromdate));
            cmd.Parameters.Add("@d2", GetHighDate(fromdate));
            cmd.Parameters.Add("@bid", ddlcompany.SelectedValue);
            DataTable dtouward = vdm.SelectQuery(cmd).Tables[0];

            cmd = new SqlCommand("select submittedcash from registorclosingdetails where parlorid=@branchid and doe between @d1 and @d2");
            cmd.Parameters.Add("@d1", GetLowDate(fromdate).AddDays(-1));
            cmd.Parameters.Add("@d2", GetHighDate(fromdate).AddDays(-1));
            cmd.Parameters.Add("@branchid", ddlcompany.SelectedValue);
            DataTable dtOpp = vdm.SelectQuery(cmd).Tables[0];
            if (dtOpp.Rows.Count > 0)
            {
                lblOppBal.Text = dtOpp.Rows[0]["submittedcash"].ToString();
            }
            //cmd = new SqlCommand("SELECT Branchid, AmountPaid,VarifyDate FROM collections WHERE (Branchid = @BranchID) AND (PaidDate BETWEEN @d1 AND @d2)");
            //cmd.Parameters.AddWithValue("@BranchID", ddlcompany.SelectedValue);
            //cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate));
            //cmd.Parameters.AddWithValue("@d2", GetHighDate(fromdate));
            //DataTable dtclosedtime = vdm.SelectQuery(cmd).Tables[0];
            //if (dtclosedtime.Rows.Count > 0)
            //{
            //    string VarifyDate = dtclosedtime.Rows[0]["VarifyDate"].ToString();
            //    DateTime dtVarifyDate = Convert.ToDateTime(VarifyDate);
            //    string ChangedTime = dtVarifyDate.ToString("dd/MMM/yyyy HH:MM");
            //    lbl_ClosingDate.Text = ChangedTime;
            //}
            //foreach (DataRow dr in dtouward.Rows)
            //{
            //    DataRow newrow = RouteReport.NewRow();
            //    newrow["DispName"] = ddlcompany.SelectedItem;
            //    newrow["Reciept No"] = dr["RecieptNo"].ToString();
            //    double ReceivedAmount = 0;
            //    double.TryParse(dr["totalpaying"].ToString(), out ReceivedAmount);
            //    string Amount = dr["totalpaying"].ToString();
            //    if (Amount == "0")
            //    {
            //    }
            //    else
            //    {
            //        newrow["Received Amount"] = ReceivedAmount;//.ToString("#,##0.00");
            //        RouteReport.Rows.Add(newrow);
            //    }
            //}

            double outward = 0;
            double ordertax = 0;
            double totaloutward = 0;
            foreach (DataRow drout in dtouward.Rows)
            {
                DataRow newrow = RouteReport.NewRow();
                newrow["BranchName"] = ddlcompany.SelectedItem; ;
                newrow["Reciept No"] = drout["issueno"].ToString();
                double.TryParse(drout["totvalue"].ToString(), out outward);
                double.TryParse(drout["ordertax"].ToString(), out ordertax);
                totaloutward = outward + ordertax;
                totaloutward = Math.Round(totaloutward, 2);

                if (totaloutward == 0)
                {
                }
                else
                {
                    newrow["Received Amount"] = totaloutward;//.ToString("#,##0.00");
                    RouteReport.Rows.Add(newrow);
                }
            }

            //RouteReport.DefaultView.Sort = "Reciept No ASC";
            //RouteReport.DefaultView.ToTable(true);
            DataView dv = RouteReport.DefaultView;
            dv.Sort = "Reciept No ASC";
            DataTable sortedDT = dv.ToTable();
            cmd = new SqlCommand("SELECT CashTo as Payments,ApprovedAmount as Amount,VocherID FROM cashpayables WHERE  (BranchID = @BranchID) AND (DOE BETWEEN @d1 AND @d2) AND (Status = 'P') AND (Status <>'C')");
            cmd.Parameters.AddWithValue("@BranchID", ddlcompany.SelectedValue);
            cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate));
            cmd.Parameters.AddWithValue("@d2", GetHighDate(fromdate));
            DataTable dtCashPayble = vdm.SelectQuery(cmd).Tables[0];


            DataRow newvartical = sortedDT.NewRow();
            newvartical["BranchName"] = "Total";
            double val = 0.0;
            foreach (DataColumn dc in sortedDT.Columns)
            {
                if (dc.DataType == typeof(Double))
                {
                    val = 0.0;
                    double.TryParse(sortedDT.Compute("sum([" + dc.ToString() + "])", "[" + dc.ToString() + "]<>'0'").ToString(), out val);
                    newvartical[dc.ToString()] = val;
                    Session["totalsale"] = val;
                }
            }
            sortedDT.Rows.Add(newvartical);
            DataRow newrowBal = sortedDT.NewRow();
            newrowBal["BranchName"] = "Clo Balance";
            double OppBal = 0;
            if (dtOpp.Rows.Count > 0)
            {
                double.TryParse(dtOpp.Rows[0]["submittedcash"].ToString(), out OppBal);
            }
            double TotalAmount = val + OppBal;
            newrowBal["Received Amount"] = val + OppBal;
            sortedDT.Rows.Add(newrowBal);


            grdRouteCash.DataSource = sortedDT;
            grdRouteCash.DataBind();
            CashPayReport.Columns.Add("Vocher ID");
            CashPayReport.Columns.Add("Payments");
            CashPayReport.Columns.Add("Amount").DataType = typeof(Double);
            foreach (DataRow dr in dtCashPayble.Rows)
            {
                DataRow newrow = CashPayReport.NewRow();
                newrow["Vocher ID"] = dr["VocherID"].ToString();
                newrow["Payments"] = dr["Payments"].ToString();
                string Amount = dr["Amount"].ToString();
                if (Amount == "0")
                {
                }
                else
                {
                    newrow["Amount"] = dr["Amount"].ToString();
                    CashPayReport.Rows.Add(newrow);
                }
            }

            DataRow newCash = CashPayReport.NewRow();
            newCash["Payments"] = "Total";
            double valnewCash = 0.0;
            foreach (DataColumn dc in CashPayReport.Columns)
            {
                if (dc.DataType == typeof(Double))
                {
                    valnewCash = 0.0;
                    double.TryParse(CashPayReport.Compute("sum([" + dc.ToString() + "])", "[" + dc.ToString() + "]<>'0'").ToString(), out valnewCash);
                    newCash[dc.ToString()] = valnewCash;
                }
            }
            CashPayReport.Rows.Add(newCash);




            double DebitCash = 0;
            DataRow newDebitBal = CashPayReport.NewRow();
            newDebitBal["Payments"] = "Closing Balance";
            newDebitBal["Amount"] = TotalAmount - valnewCash;
            DebitCash = TotalAmount - valnewCash;
            CashPayReport.Rows.Add(newDebitBal);
            lblhidden.Text = DebitCash.ToString();
            grdCashPayable.DataSource = CashPayReport;
            grdCashPayable.DataBind();

            double TotNetAmount = 0;

            cmd = new SqlCommand("select * from registorclosingdetails where doe between @d1 and @d2 and parlorid=@parlorid");
            cmd.Parameters.Add("@d1", GetLowDate(fromdate));
            cmd.Parameters.Add("@d2", GetHighDate(fromdate));
            cmd.Parameters.AddWithValue("@parlorid", ddlcompany.SelectedValue);
            DataTable dtClo = vdm.SelectQuery(cmd).Tables[0];
            if (dtClo.Rows.Count > 0)
            {

                hidePanel.Visible = false;
                DiffPanel.Visible = true;
                //string llCash = denominationtotal.ToString();

                panelGrid.Visible = true;
                PanelDen.Visible = false;
                DataTable dtDenom = new DataTable();
                dtDenom.Columns.Add("Cash");
                dtDenom.Columns.Add("Count");
                dtDenom.Columns.Add("Amount");
                string strDenomin = dtClo.Rows[0]["Denominations"].ToString();
                double denominationtotal = 0;
                foreach (string str in strDenomin.Split('+'))
                {
                    if (str != "")
                    {
                        DataRow newDeno = dtDenom.NewRow();
                        string[] price = str.Split('x');
                        if (price.Length > 1)
                        {
                            newDeno["Cash"] = price[0];
                            newDeno["Count"] = price[1];
                            float denamount = 0;
                            float.TryParse(price[0], out denamount);
                            float DencAmount = 0;
                            float.TryParse(price[1], out DencAmount);
                            newDeno["Amount"] = Convert.ToDecimal(denamount * DencAmount).ToString("#,##0.00");
                            denominationtotal += denamount * DencAmount;
                            dtDenom.Rows.Add(newDeno);
                        }
                    }
                }
                DataRow newDenoTotal = dtDenom.NewRow();
                newDenoTotal["Cash"] = "Total";
                newDenoTotal["Amount"] = denominationtotal;
                dtDenom.Rows.Add(newDenoTotal);
               
                double TotalCash = 0;
                TotalCash = denominationtotal;
                lblTotalAmout.Text = TotalCash.ToString();
                double Differnce = 0;
                //Differnce = DebitCash - TotalCash;
                Differnce = TotalCash - DebitCash;
                lblDiffernce.Text = Differnce.ToString();
                //OppBal


                double Zerodiff = 0;
                Zerodiff = TotNetAmount - denominationtotal;
                Zerodiff = Math.Round(Zerodiff, 0);
                lblZeroDiffence.Text = Zerodiff.ToString();
                grdDenomination.DataSource = dtDenom;
                grdDenomination.DataBind();
                lblCash.Text = denominationtotal.ToString();
            }
            else
            {
                PanelDen.Visible = true;
                panelGrid.Visible = false;
                DiffPanel.Visible = true;
                double dif = 0;
                double totdif = 0;
                totdif =dif;
                lblDiffernce.Text = totdif.ToString();

            }

        }
        catch (Exception ex)
        {
            lblmsg.Text = ex.Message;
        }
    }
    protected void BtnSave_Click(object sender, EventArgs e)
    {
        try
        {
            vdm = new SalesDBManager();
            //string DenCash = Session["Cash"].ToString();
            double op = 0;
            double.TryParse(lblOppBal.Text, out op);

           

            double Totalclosing = 0;
            //TotalAmount = Cash + IOU;
            //double diffamount = 0;
            double.TryParse(lblhidden.Text, out Totalclosing);
          
            DataTable dt = (DataTable)Session["IOUReport"];
            lblmsg.Text = "";
            DateTime fromdate = new DateTime();
            string[] datestrig = txtFromdate.Text.Split(' ');
            if (datestrig.Length > 1)
            {
                if (datestrig[0].Split('-').Length > 0)
                {
                    string[] dates = datestrig[0].Split('-');
                    string[] times = datestrig[1].Split(':');
                    fromdate = new DateTime(int.Parse(dates[2]), int.Parse(dates[1]), int.Parse(dates[0]), int.Parse(times[0]), int.Parse(times[1]), 0);
                }
            }
            fromdate = fromdate;
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
            string DenominationString = Session["DenominationString"].ToString();
            string tsale = Session["totalsale"].ToString();
            
            DenominationString = DenominationString.Trim();
            cmd = new SqlCommand("select * from registorclosingdetails where doe between @d1 and @d2 and parlorid=@parlorid");
            cmd.Parameters.Add("@d1", GetLowDate(fromdate));
            cmd.Parameters.Add("@d2", GetHighDate(fromdate));
            cmd.Parameters.AddWithValue("@parlorid", ddlcompany.SelectedValue);
            DataTable dtCol = vdm.SelectQuery(cmd).Tables[0];
            if (dtCol.Rows.Count > 0)
            {
                lblmsg.Text = "Cash Book already closed";

            }
            else
            {

                cmd = new SqlCommand("insert into registorclosingdetails( totalsale, totalcash, submittedcash, denominations,parlorid, createdon, closedby, doe) values (@totalsale, @totalcash, @submittedcash, @denominations,@parlorid, @createdon, @closedby, @doe)");//,color,@color
                cmd.Parameters.Add("@totalsale", tsale);
                cmd.Parameters.Add("@totalcash", Totalclosing);//@submittedcash, @submittedslips, @submittedchecks, @description, @parlorid, @createdon, @closedby
                cmd.Parameters.Add("@submittedcash", Totalclosing);
                cmd.Parameters.Add("@parlorid", ddlcompany.SelectedValue);
                cmd.Parameters.Add("@createdon", fromdate);
                cmd.Parameters.Add("@doe", ServerDateCurrentdate);
                cmd.Parameters.Add("@closedby", Session["Employ_Sno"].ToString());
                cmd.Parameters.Add("@denominations", DenominationString);
                vdm.insert(cmd);
                cmd = new SqlCommand("select MAX(sno) as refno from registorclosingdetails");
                DataTable dtoutward = vdm.SelectQuery(cmd).Tables[0];
                string refno = dtoutward.Rows[0]["refno"].ToString();

                cmd = new SqlCommand("select * from productmoniter");
                DataTable dtitem = vdm.SelectQuery(cmd).Tables[0];
                cmd = new SqlCommand("select op_bal,refno, productid, price, clo_bal,doe,branchid from sub_registorclosingdetails where branchid=@branchid and doe between @d1 and @d2");
                cmd.Parameters.Add("@d1", GetLowDate(fromdate).AddDays(-1));
                cmd.Parameters.Add("@d2", GetHighDate(fromdate).AddDays(-1));
                cmd.Parameters.Add("@branchid", ddlcompany.SelectedValue);
                DataTable dtop = vdm.SelectQuery(cmd).Tables[0];

                DateTime dt_fromdate = Convert.ToDateTime(fromdate);
                cmd = new SqlCommand("SELECT SUM(inward_subdetails.qty) AS inwardqty,productmaster.productname, productmaster.productid,(CONVERT(NVARCHAR(10), inward_maindetails.doe, 120)) AS doe  FROM   inward_maindetails INNER JOIN  inward_subdetails ON inward_maindetails.sno = inward_subdetails.refno INNER JOIN productmaster ON productmaster.productid = inward_subdetails.productid  WHERE (inward_maindetails.doe BETWEEN @d11 AND @d22) AND (inward_maindetails.branchid = @bidd) AND (inward_maindetails.status = 'A') group by productmaster.productname, (CONVERT(NVARCHAR(10), inward_maindetails.doe, 120)),productmaster.productid");
                cmd.Parameters.Add("@d11", GetLowDate(dt_fromdate));
                cmd.Parameters.Add("@d22", GetHighDate(dt_fromdate));
                cmd.Parameters.Add("@bidd", ddlcompany.SelectedValue);
                DataTable dtinward = vdm.SelectQuery(cmd).Tables[0];

                cmd = new SqlCommand("SELECT   Sum(possale_subdetails.qty) AS outwardqty, productmaster.productid, Sum(possale_subdetails.totvalue) AS totvalue, Sum(possale_subdetails.ordertax) AS ordertax,CAST(possale_maindetails.doe AS date) FROM possale_maindetails INNER JOIN possale_subdetails on possale_subdetails.refno = possale_maindetails.sno INNER JOIN productmaster ON productmaster.productid = possale_subdetails.productid  WHERE possale_maindetails.doe BETWEEN @d1 AND @d2 AND possale_maindetails.branchid=@bid  GROUP BY  productmaster.productid,CAST(possale_maindetails.doe AS date)");
                cmd.Parameters.Add("@d1", GetLowDate(fromdate));
                cmd.Parameters.Add("@d2", GetHighDate(fromdate));
                cmd.Parameters.Add("@bid", ddlcompany.SelectedValue);
                DataTable dtouward = vdm.SelectQuery(cmd).Tables[0];


                foreach (DataRow dr in dtitem.Rows)
                {
                    double opqty = 0;
                    double inward = 0;
                    double outward = 0;
                    double closing = 0;
                    double ordertax = 0;
                    double totaloutward = 0;
                    foreach (DataRow drop in dtop.Select("productid='" + dr["productid"].ToString() + "'"))
                    {
                        double.TryParse(drop["clo_bal"].ToString(), out opqty);
                    }
                    //string date = "";
                    // DateTime dt = Convert.ToDateTime(dr["doe"].ToString());
                    // string date = dt.AddDays(1).ToString("yyyy-MM-dd");
                    //   double.TryParse(dr["clo_bal"].ToString(), out opqty);
                    foreach (DataRow drin in dtinward.Select("productid='" + dr["productid"].ToString() + "'"))
                    {
                        double.TryParse(drin["inwardqty"].ToString(), out inward);
                    }
                    foreach (DataRow drout in dtouward.Select("productid='" + dr["productid"].ToString() + "'"))
                    {
                        double.TryParse(drout["outwardqty"].ToString(), out outward);
                        double.TryParse(drout["ordertax"].ToString(), out ordertax);
                        totaloutward = outward;// + ordertax;
                        totaloutward = Math.Round(totaloutward, 2);
                    }
                    double total = opqty + inward;
                    closing = total - outward;
                    cmd = new SqlCommand("insert into sub_registorclosingdetails(refno, productid, price, clo_bal,op_bal,doe,branchid,inwardqty,saleqty) values(@refno, @productid, @price, @clo_bal,@op_bal,@doe,@branchid,@inwardqty,@saleqty)");
                    cmd.Parameters.Add("@refno", refno);
                    cmd.Parameters.Add("@productid", dr["productid"].ToString());
                    cmd.Parameters.Add("@price", dr["price"].ToString());
                    cmd.Parameters.Add("@clo_bal", closing);
                    if (opqty != 0)
                    {
                        cmd.Parameters.Add("@op_bal", opqty);
                    }
                    else
                    {
                        cmd.Parameters.Add("@op_bal", "0");
                    }
                    cmd.Parameters.Add("@doe", fromdate);
                    cmd.Parameters.Add("@branchid", ddlcompany.SelectedValue);
                    cmd.Parameters.Add("@inwardqty", inward);
                    cmd.Parameters.Add("@saleqty", outward);
                    vdm.insert(cmd);
                }

                lblmsg.Text = "Cash Book saved successfully";
                GetReport();
            }
        }
        catch (Exception ex)
        {
            lblmsg.Text = ex.Message;
        }
    }
    protected void OnRowDataBound(object sender, System.Web.UI.WebControls.GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(grdDue, "Select$" + e.Row.RowIndex);
            e.Row.Attributes["style"] = "cursor:pointer";
        }
    }
    protected void OnSelectedIndexChanged(object sender, EventArgs e)
    {
        int index = grdDue.SelectedRow.RowIndex;
        string headsno = grdDue.SelectedRow.Cells[0].Text;
        string name = grdDue.SelectedRow.Cells[1].Text;
        string country = grdDue.SelectedRow.Cells[2].Text;
        DateTime fromdate = new DateTime();
        string[] datestrig = txtFromdate.Text.Split(' ');
        if (datestrig.Length > 1)
        {
            if (datestrig[0].Split('-').Length > 0)
            {
                string[] dates = datestrig[0].Split('-');
                string[] times = datestrig[1].Split(':');
                fromdate = new DateTime(int.Parse(dates[2]), int.Parse(dates[1]), int.Parse(dates[0]), int.Parse(times[0]), int.Parse(times[1]), 0);
            }
        }
        //string message = "Row Index: " + index + "\\nName: " + name + "\\nCountry: " + country;
        try
        {
            vdm = new SalesDBManager();
            DataTable Report = new DataTable();

            cmd = new SqlCommand("SELECT BranchID FROM  Collections WHERE (BranchId = @BranchId) AND (PaidDate BETWEEN @d1 AND @d2)");
            cmd.Parameters.AddWithValue("@BranchID", ddlcompany.SelectedValue);
            cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate));
            cmd.Parameters.AddWithValue("@d2", GetHighDate(fromdate));
            DataTable dtCol = vdm.SelectQuery(cmd).Tables[0];
            if (dtCol.Rows.Count > 0)
            {
                lblmsg.Text = "Please Select Details On Current Day Cash Book";

            }
            else
            {
                //cmd = new SqlCommand("SELECT DATE_FORMAT(cashpayables.DOE, '%d %b %y') AS EntryDate, cashpayables.VocherID, accountheads.HeadName,cashpayables.VoucherType, cashpayables.Amount, cashpayables.ApprovedAmount as ApprovedAmount FROM accountheads INNER JOIN subpayable ON accountheads.Sno = subpayable.HeadSno INNER JOIN cashpayables ON subpayable.RefNo = cashpayables.Sno WHERE (cashpayables.BranchID = @BranchID)  AND (subpayable.HeadSno = @HeadSno) and (cashpayables.Status=@Status)  ORDER BY cashpayables.DOE");
                cmd = new SqlCommand("SELECT DATE_FORMAT(cashpayables.DOE, '%d %b %y') AS EntryDate, cashpayables.VocherID, accountheads.HeadName, cashpayables.VoucherType,cashpayables.Amount, cashpayables.ApprovedAmount FROM accountheads INNER JOIN subpayable ON accountheads.Sno = subpayable.HeadSno INNER JOIN cashpayables ON subpayable.RefNo = cashpayables.Sno WHERE (subpayable.HeadSno = @HeadSno) AND (cashpayables.Status = @Status) AND ((cashpayables.VoucherType<>'Debit') OR (cashpayables.VoucherType<>'SalaryAdvance') OR (cashpayables.VoucherType<>'SalaryPayble'))  ORDER BY cashpayables.DOE");
                cmd.Parameters.AddWithValue("@Status", 'P');
                //cmd.Parameters.AddWithValue("@BranchID", ddlcompany.SelectedValue);
                cmd.Parameters.AddWithValue("@HeadSno", headsno);
                DataTable dtCredit = vdm.SelectQuery(cmd).Tables[0];
                Report.Columns.Add("Date");
                Report.Columns.Add("VoucherID");
                Report.Columns.Add("AccountName");
                Report.Columns.Add("IOUAmount").DataType = typeof(Double);
                Report.Columns.Add("CreditAmount").DataType = typeof(Double);
                double DueAmount = 0;
                double CreditAmount = 0;
                if (dtCredit.Rows.Count > 0)
                {
                    foreach (DataRow dr in dtCredit.Rows)
                    {
                        DataRow newrow = Report.NewRow();
                        newrow["Date"] = dr["EntryDate"].ToString();
                        newrow["VoucherID"] = dr["VocherID"].ToString();
                        newrow["AccountName"] = dr["HeadName"].ToString();
                        string VoucherType = dr["VoucherType"].ToString();
                        if (VoucherType == "Due")
                        {
                            double ReceivedAmount = 0;
                            double.TryParse(dr["Amount"].ToString(), out ReceivedAmount);
                            newrow["IOUAmount"] = ReceivedAmount;
                            DueAmount += ReceivedAmount;
                        }
                        if (VoucherType == "Credit")
                        {
                            double ApprovedAmount = 0;
                            double.TryParse(dr["ApprovedAmount"].ToString(), out ApprovedAmount);
                            newrow["CreditAmount"] = ApprovedAmount;
                            CreditAmount += ApprovedAmount;
                        }
                        Report.Rows.Add(newrow);
                    }
                }
                double Amount = 0;
                Amount = DueAmount - CreditAmount;
                //lblmsg.Text = "Due Amount: " + Amount.ToString();
                DataRow newrowbalance = Report.NewRow();
                newrowbalance["AccountName"] = "Due Amount: ";
                newrowbalance["IOUAmount"] = Amount;
                Report.Rows.Add(newrowbalance);
                GrdProducts.DataSource = Report;
                GrdProducts.DataBind();
                ScriptManager.RegisterStartupScript(Page, GetType(), "JsStatus", "PopupOpen();", true);
            }
        }
        catch (Exception ex)
        {
            lblmsg.Text = ex.Message;
        }
    }

    public string phonenumber { get; set; }
}