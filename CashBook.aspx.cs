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
            grdCashPayable.DataSource = CashPayReport;
            grdCashPayable.DataBind();


            //cmd = new SqlCommand("SELECT BranchID FROM  Collections WHERE (BranchId = @BranchId) AND (PaidDate BETWEEN @d1 AND @d2)");
            //cmd.Parameters.AddWithValue("@BranchID", ddlcompany.SelectedValue);
            //cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate));
            //cmd.Parameters.AddWithValue("@d2", GetHighDate(fromdate));
            //DataTable dtCol = vdm.SelectQuery(cmd).Tables[0];

            //double TotNetAmount = 0;
            //cmd = new SqlCommand("SELECT collections.Branchid, collections.AmountPaid, collections.Denominations, collections.VEmpID, collections.EmpID, empmanage.EmpName FROM collections INNER JOIN empmanage ON collections.EmpID = empmanage.Sno WHERE (collections.Branchid = @BranchID) AND (collections.PaidDate BETWEEN @d1 AND @d2)");
            //cmd.Parameters.AddWithValue("@BranchID", ddlcompany.SelectedValue);
            //cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate));
            //cmd.Parameters.AddWithValue("@d2", GetHighDate(fromdate));
            //DataTable dtClo = vdm.SelectQuery(cmd).Tables[0];
            //if (dtClo.Rows.Count > 0)
            //{

            //    hidePanel.Visible = false;
            //    DiffPanel.Visible = true;
            //    //string llCash = denominationtotal.ToString();

            //    panelGrid.Visible = true;
            //    PanelDen.Visible = false;
            //    DataTable dtDenom = new DataTable();
            //    dtDenom.Columns.Add("Cash");
            //    dtDenom.Columns.Add("Count");
            //    dtDenom.Columns.Add("Amount");
            //    string strDenomin = dtClo.Rows[0]["Denominations"].ToString();
            //    double denominationtotal = 0;
            //    foreach (string str in strDenomin.Split('+'))
            //    {
            //        if (str != "")
            //        {
            //            DataRow newDeno = dtDenom.NewRow();
            //            string[] price = str.Split('x');
            //            if (price.Length > 1)
            //            {
            //                newDeno["Cash"] = price[0];
            //                newDeno["Count"] = price[1];
            //                float denamount = 0;
            //                float.TryParse(price[0], out denamount);
            //                float DencAmount = 0;
            //                float.TryParse(price[1], out DencAmount);
            //                newDeno["Amount"] = Convert.ToDecimal(denamount * DencAmount).ToString("#,##0.00");
            //                denominationtotal += denamount * DencAmount;
            //                dtDenom.Rows.Add(newDeno);
            //            }
            //        }
            //    }
            //    DataRow newDenoTotal = dtDenom.NewRow();
            //    newDenoTotal["Cash"] = "Total";
            //    newDenoTotal["Amount"] = denominationtotal;
            //    dtDenom.Rows.Add(newDenoTotal);
                
            //    double TotalCash = 0;
            //    TotalCash = denominationtotal;
            //    lblTotalAmout.Text = TotalCash.ToString();
            //    double Differnce = 0;
            //    //Differnce = DebitCash - TotalCash;
            //    Differnce = TotalCash - DebitCash;
            //    lblDiffernce.Text = Differnce.ToString();
            //    //lblpreparedby.Text = dtClo.Rows[0]["EmpName"].ToString();
            //    //OppBal


            //    double Zerodiff = 0;
            //    Zerodiff = TotNetAmount - denominationtotal;
            //    Zerodiff = Math.Round(Zerodiff, 0);
            //    lblZeroDiffence.Text = Zerodiff.ToString();
            //    grdDenomination.DataSource = dtDenom;
            //    grdDenomination.DataBind();
            //    lblCash.Text = denominationtotal.ToString();
            //}
            //else
            //{
            //    PanelDen.Visible = true;
            //    panelGrid.Visible = false;
            //    DiffPanel.Visible = true;
            //}
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
            
            //double Cash = 0;
            //double.TryParse(DenCash, out Cash);
            // double TotalAmount = 0;
            double Totalclosing = 0;
            //TotalAmount = Cash + IOU;
            //double diffamount = 0;
            //double.TryParse(lblDiffernce.Text, out diffamount);

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
            DenominationString = DenominationString.Trim();
            cmd = new SqlCommand("SELECT BranchID FROM  Collections WHERE (BranchId = @BranchId) AND (PaidDate BETWEEN @d1 AND @d2)");
            cmd.Parameters.AddWithValue("@BranchID", ddlcompany.SelectedValue);
            cmd.Parameters.AddWithValue("@d1", GetLowDate(fromdate));
            cmd.Parameters.AddWithValue("@d2", GetHighDate(fromdate));
            DataTable dtCol = vdm.SelectQuery(cmd).Tables[0];
            if (dtCol.Rows.Count > 0)
            {
                lblmsg.Text = "Cash Book already closed";

            }
            else
            {

                cmd = new SqlCommand("SELECT cashpayables.Sno, cashpayables.BranchID, cashpayables.CashTo,subpayable.HeadSno, cashpayables.DOE, cashpayables.VocherID, cashpayables.Remarks, SUM(cashpayables.ApprovedAmount) AS Amount, accountheads.HeadName FROM cashpayables INNER JOIN subpayable ON cashpayables.Sno = subpayable.RefNo INNER JOIN accountheads ON subpayable.HeadSno = accountheads.Sno WHERE (cashpayables.BranchID = @BranchID) AND (cashpayables.Status='P') AND (cashpayables.VoucherType = 'Credit') GROUP BY accountheads.Sno ORDER BY accountheads.HeadName");
                cmd.Parameters.AddWithValue("@BranchID", ddlcompany.SelectedValue);
                DataTable dtCredit = vdm.SelectQuery(cmd).Tables[0];
                cmd = new SqlCommand("SELECT cashpayables.onNameof,cashpayables.CashTo, SUM(cashpayables.ApprovedAmount) AS Amount, subpayable.HeadSno, accountheads.HeadName FROM cashpayables INNER JOIN subpayable ON cashpayables.Sno = subpayable.RefNo INNER JOIN accountheads ON subpayable.HeadSno = accountheads.Sno WHERE (cashpayables.BranchID = @BranchID) AND (cashpayables.VoucherType = 'Due') AND (cashpayables.Status<> 'C') AND (cashpayables.Status='P') GROUP BY  accountheads.HeadName ORDER BY accountheads.HeadName");
                cmd.Parameters.AddWithValue("@BranchID", ddlcompany.SelectedValue);
                DataTable dtDebit = vdm.SelectQuery(cmd).Tables[0];
                foreach (DataRow dr in dtDebit.Rows)
                {
                    string IouName = dr["HeadName"].ToString();
                    double iouamtdebit = 0;
                    double iouamtcredit = 0;
                    double TotIouBal = 0;
                    double.TryParse(dr["Amount"].ToString(), out iouamtdebit);
                    foreach (DataRow drcredit in dtCredit.Select("HeadSno='" + dr["HeadSno"].ToString() + "'"))
                    {
                        double.TryParse(drcredit["Amount"].ToString(), out iouamtcredit);
                    }
                    TotIouBal = iouamtdebit - iouamtcredit;
                    if (TotIouBal == 0)
                    {
                    }
                    else
                    {
                        cmd = new SqlCommand("Insert into ioutable (BranchID,IOU,Amount,DOE) values(@BranchID,@IOU,@Amount,@DOE)");
                        cmd.Parameters.AddWithValue("@BranchID", ddlcompany.SelectedValue);
                        cmd.Parameters.AddWithValue("@Amount", TotIouBal);
                        cmd.Parameters.AddWithValue("@IOU", IouName);
                        cmd.Parameters.AddWithValue("@DOE", fromdate);
                        vdm.insert(cmd);
                    }
                }
                cmd = new SqlCommand("Insert into Collections (BranchID,AmountPaid,UserData_sno,PaidDate,PaymentType,Denominations,EmpID,VarifyDate) values(@BranchID,@AmountPaid,@UserData_sno,@PaidDate,@PaymentType,@Denominations,@EmpID,@VarifyDate)");
                cmd.Parameters.AddWithValue("@BranchID", ddlcompany.SelectedValue);
                cmd.Parameters.AddWithValue("@AmountPaid", Math.Round(Totalclosing, 2));
                cmd.Parameters.AddWithValue("@Denominations", DenominationString);
                cmd.Parameters.AddWithValue("@UserData_sno", "1");
                cmd.Parameters.AddWithValue("@PaidDate", fromdate);
                cmd.Parameters.AddWithValue("@VarifyDate", ServerDateCurrentdate);
                cmd.Parameters.AddWithValue("@PaymentType", "Cash");
                cmd.Parameters.AddWithValue("@EmpID", Session["UserSno"].ToString());
                vdm.insert(cmd);
                if (ddlcompany.SelectedValue == "172")
                {

                    string strDenomin = DenominationString;
                    double denominationtotal = 0;
                    foreach (string str in strDenomin.Split('+'))
                    {
                        if (str != "")
                        {
                            string[] price = str.Split('x');
                            if (price.Length > 1)
                            {
                                float denamount = 0;
                                float.TryParse(price[0], out denamount);
                                float DencAmount = 0;
                                float.TryParse(price[1], out DencAmount);
                                denominationtotal += denamount * DencAmount;
                            }
                        }
                    }
                    cmd = new SqlCommand("SELECT  DispNo, PhoneNumber, Sno, EmpID, EmailID, MsgType, name FROM mobilenotable where MsgType=@MsgType");
                    cmd.Parameters.AddWithValue("@MsgType", "3");
                    DataTable dtmobileno = vdm.SelectQuery(cmd).Tables[0];
                    if (dtmobileno.Rows.Count > 0)
                    {
                        foreach (DataRow drmobile in dtmobileno.Rows)
                        {
                            // string Date = fromdate;
                            phonenumber = drmobile["PhoneNumber"].ToString();
                            WebClient client = new WebClient();
                            string strdate = fromdate.ToString("dd/MMM");
                            string message = "";
                            if (Session["TitleName"].ToString() == "Sri Vyshnavi Foods Pvt Ltd")
                            {
                                string baseurl = "http://roundsms.com/api/sendhttp.php?authkey=Y2U3NGE2MGFkM2V&mobiles=" + phonenumber + "&message=%20" + ddlcompany.SelectedItem.Text + "%20CashBook%20Cash In Hand%20Amount%20for%20The%20Date%20Of%20%20" + strdate + "%20Amount%20is =" + denominationtotal + "&sender=VYSNVI&type=1&route=2";
                                // string baseurl = "http://www.smsstriker.com/API/sms.php?username=vaishnavidairy&password=vyshnavi@123&from=VSALES&to=" + phonenumber + "&msg=%20" + ddlcompany.SelectedItem.Text + "%20CashBook%20Cash In Hand%20Amount%20for%20The%20Date%20Of%20%20" + strdate + "%20Amount%20is =" + denominationtotal + "&type=1";
                                message = "" + ddlcompany.SelectedItem.Text + " Closing Amount for The Date Of" + strdate + "ClosingAmoount is =" + denominationtotal + "";
                                Stream data = client.OpenRead(baseurl);
                                StreamReader reader = new StreamReader(data);
                                string ResponseID = reader.ReadToEnd();
                                data.Close();
                                reader.Close();
                            }
                            else
                            {
                                string baseurl = "http://roundsms.com/api/sendhttp.php?authkey=Y2U3NGE2MGFkM2V&mobiles=" + phonenumber + "&message=Dear%20" + ddlcompany.SelectedItem.Text + "%20CashBook%20Closing%20Amount%20for%20The%20Date%20Of%20%20" + strdate + "%20Amount%20is =" + Math.Round(Totalclosing, 2) + "&sender=VYSNVI&type=1&route=2";
                                // string baseurl = "http://www.smsstriker.com/API/sms.php?username=vaishnavidairy&password=vyshnavi@123&from=VFWYRA&to=" + phonenumber + "&msg=Dear%20" + ddlcompany.SelectedItem.Text + "%20CashBook%20Closing%20Amount%20for%20The%20Date%20Of%20%20" + strdate + "%20Amount%20is =" + Math.Round(Totalclosing, 2) + "&type=1";
                                message = "" + ddlcompany.SelectedItem.Text + "Your Incentive Amount Credeted for The Month Of" + strdate + "Amount is =" + Math.Round(Totalclosing, 2) + "";
                                Stream data = client.OpenRead(baseurl);
                                StreamReader reader = new StreamReader(data);
                                string ResponseID = reader.ReadToEnd();
                                data.Close();
                                reader.Close();
                            }
                            //cmd = new SqlCommand("insert into smsinfo (agentid,branchid,mainbranch,msg,mobileno,msgtype,agentname,doe) values (@agentid,@branchid,@mainbranch,@msg,@mobileno,@msgtype,@agentname,@doe)");
                            //cmd.Parameters.AddWithValue("@agentid", BranchID);
                            //cmd.Parameters.AddWithValue("@branchid", soid);
                            //cmd.Parameters.AddWithValue("@mainbranch", Session["SuperBranch"].ToString());
                            //cmd.Parameters.AddWithValue("@msg", message);
                            //cmd.Parameters.AddWithValue("@mobileno", phonenumber);
                            //cmd.Parameters.AddWithValue("@msgtype", "CashBook");
                            //cmd.Parameters.AddWithValue("@agentname", BranchName);
                            //cmd.Parameters.AddWithValue("@doe", ServerDateCurrentdate);
                            //vdm.insert(cmd);

                        }
                    }

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