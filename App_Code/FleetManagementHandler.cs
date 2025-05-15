using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.SessionState;
using System.Data.SqlClient;
using System.Web.Script.Serialization;
using System.Data;
using System.Web.Services;
using System.Net.Mail;
using System.Net;
using System.Text;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;
using MySql.Data.MySqlClient;
using System.Collections;

/// <summary>
/// Summary description for FleetManagementHandler
/// </summary>
public class FleetManagementHandler : IHttpHandler, IRequiresSessionState
{
    SqlCommand cmd;
    SalesDBManager vdm = new SalesDBManager();
    MySqlCommand mycmd;
    DBManagerSales vdsm = new DBManagerSales();
    AccessControldbmanger Accescontrol_db = new AccessControldbmanger();
    private SqlDbType sisno;
    public FleetManagementHandler()
    {
        //
        // TODO: Add constructor logic here
        //
    }
    public bool IsReusable
    {
        get { return true; }
    }
    private static string GetJson(object obj)
    {
        JavaScriptSerializer jsonSerializer = new JavaScriptSerializer();
        jsonSerializer.MaxJsonLength = 2147483647;
        return jsonSerializer.Serialize(obj);
    }
    class GetJsonData
    {
        public string op { set; get; }
    }
    //  [WebMethod(Description="Delete Template",BufferResponse=false)]
    public void ProcessRequest(HttpContext context)
    {
        try
        {

            string operation = context.Request["op"];
            switch (operation)
            {
                case "btnsave_employedetails":
                    btnsave_employedetails(context);
                    break;
                case "savecompanyDetails":
                    savecompanyDetails(context);
                    break;
                case "get_company_details":
                    get_company_details(context);
                    break;
                case "Save_branchetails":
                    Save_branchetails(context);
                    break;
                case "get_Branch_details":
                    get_Branch_details(context);
                    break;
                case "get_category_details":
                    get_category_details(context);
                    break;
                case "btnsave_categoryclick":
                    btnsave_categoryclick(context);
                    break;
                case "btnsave_subcategory":
                    btnsave_subcategory(context);
                    break;
                case "get_subcategory_details":
                    get_subcategory_details(context);
                    break;
                case "btnsave_UOM":
                    btnsave_UOM(context);
                    break;
                case "get_UOM_details":
                    get_UOM_details(context);
                    break;
                case "btnsave_state":
                    btnsave_state(context);
                    break;
                case "get_state_details":
                    get_state_details(context);
                    break;
                case "btnsave_gstregtype":
                    btnsave_gstregtype(context);
                    break;
                case "get_gstregtype_details":
                    get_gstregtype_details(context);
                    break;
                case "btn_save_parlor":
                    btn_save_parlor(context);
                    break;
                case "btn_save_subdistibutor":
                    btn_save_subdistibutor(context);
                    break;
                case "get_parlor_details":
                    get_parlor_details(context);
                    break;
                case "get_subdistibutor_details":
                    get_subdistibutor_details(context);
                    break;
                case "btnsave_Departmentclick":
                    btnsave_Departmentclick(context);
                    break;
                case "get_Department_details":
                    get_Department_details(context);
                    break;
                case "btnsave_designation":
                    btnsave_designation(context);
                    break;
                case "get_designation_details":
                    get_designation_details(context);
                    break;
                case "save_supplierdetails":
                    save_supplierdetails(context);
                    break;
                case "get_supplierdetails":
                    get_supplierdetails(context);
                    break;
                case "get_denamination_details":
                    get_denamination_details(context);
                    break;

                case "saveitemdetails":
                    saveitemdetails(context);
                    break;

                case "get_product_details":
                    get_product_details(context);
                    break;
                case "get_distibutorproduct_details":
                    get_distibutorproduct_details(context);
                    break;
                case "get_productwise_details":
                    get_productwise_details(context);
                    break;
                case "save_customer_details":
                    save_customer_details(context);
                    break;
                case "get_customer_details":
                    get_customer_details(context);
                    break;
                case "get_posproductsale_details":
                    get_posproductsale_details(context);
                    break;
                case "get_paidpossale_details":
                    get_paidpossale_details(context);
                    break;
                case "get_posproducthold_details":
                    get_posproducthold_details(context);
                    break;
                case "get_userlogin":
                    get_userlogin(context);
                    break;
                case "get_daywiseregister_details":
                    get_daywiseregister_details(context);
                    break;

                case "save_openregisterDetails":
                    save_openregisterDetails(context);
                    break;
                case "get_registordetails":
                    get_registordetails(context);
                    break;

                case "get_sale_details":
                    get_sale_details(context);
                    break;
                case "get_subcategorywisesalevalue_details":
                    get_subcategorywisesalevalue_details(context);
                    break;
                case "getdatewise_subcategorywisesalevalue":
                    getdatewise_subcategorywisesalevalue(context);
                    break;
                case "get_subcatitemwisesalevalue_details":
                    get_subcatitemwisesalevalue_details(context);
                    break;
                case "getdatewise_WEEKsubcategorywisesalevalue":
                    getdatewise_WEEKsubcategorywisesalevalue(context);
                    break;
                case "inward_approveclick":
                    inward_approveclick(context);
                    break;
                case "get_inward_details":
                    get_inward_details(context);
                    break;
                case "get_inwordpending_details":
                    get_inwordpending_details(context);
                    break;
                case "get_dailyinward_details":
                    get_dailyinward_details(context);
                    break;
                case "get_stocktransfer_details":
                    get_stocktransfer_details(context);
                    break;
                case "get_stocktransferpending_details":
                    get_stocktransferpending_details(context);
                    break;
                case "stocktranfer_approveclick":
                    stocktranfer_approveclick(context);
                    break;
                case "get_storereturn_details":
                    get_storereturn_details(context);
                    break;
                case "get_saledetails":
                    get_saledetails(context);
                    break;
                case "get_parlorwisesale_details":
                    get_parlorwisesale_details(context);
                    break;
                case "get_itemwisesalevalue_details":
                    get_itemwisesalevalue_details(context);
                    break;
                case "get_overallitemwisesalevalue":
                    get_overallitemwisesalevalue(context);
                    break;
                case "get_itemmonitor_details":
                    get_itemmonitor_details(context);
                    break;
                case "get_stock_details":
                    get_stock_details(context);
                    break;
                case "get_possaledetails_details":
                    get_possaledetails_details(context);
                    break;
                case "get_storereturnpending_details":
                    get_storereturnpending_details(context);
                    break;
                case "storereturn_approveclick":
                    storereturn_approveclick(context);
                    break;
                case "get_employewise_parlor_details":
                    get_employewise_parlor_details(context);
                    break;
                case "get_branchassigntoemp_details":
                    get_branchassigntoemp_details(context);
                    break;
                case "get_cashclosingdetails_details":
                    get_cashclosingdetails_details(context);
                    break;
                case "subcategorywise_hoursalevalue":
                    subcategorywise_hoursalevalue(context);
                    break;
                case "get_possalevalue_details":
                    get_possalevalue_details(context);
                    break;
                case "get_currentweekpossalevalue_details":
                    get_currentweekpossalevalue_details(context);
                    break;
                case "get_lastweekpossalevalue_details":
                    get_lastweekpossalevalue_details(context);
                    break;
                case "get_weekpossalevalue_details":
                    get_weekpossalevalue_details(context);
                    break;
                case "get_weekwisepossale_details":
                    get_weekwisepossale_details(context);
                    break;
                case "get_monthwisepossale_details":
                    get_monthwisepossale_details(context);
                    break;
                case "get_mnthweekwisepossale_details":
                    get_mnthweekwisepossale_details(context);
                    break;
                case "get_parloritemdata_details":
                    get_parloritemdata_details(context);
                    break;
                case "get_salescategory_details":
                    get_salescategory_details(context);
                    break;
                case "get_salesproduct_details":
                    get_salesproduct_details(context);
                    break;
                case "get_distibutorsale_details_click":
                    get_distibutorsale_details_click(context);
                    break;
                case "get_distibutorsale_details":
                    get_distibutorsale_details(context);
                    break;
                case "get_distibutorsales_Sub_details_click":
                    get_distibutorsales_Sub_details_click(context);
                    break;


                //sales
                case "intialize_productsmanagement_products":
                    intialize_productsmanagement_products(context);
                    break;
                case "get_subcategory_data":
                    get_subcategory_data(context);
                    break;
                case "get_salesitemdata_details":
                    get_salesitemdata_details(context);
                    break;
                case "ValidateLogin":
                    ValidateLogin(context);
                    break;
                case "get_agentindent_details":
                    get_agentindent_details(context);
                    break;
                case "get_Sales_details":
                    get_Sales_details(context);
                    break;
                case "get_Bal_Trans":
                    get_Bal_Trans(context);
                    break;
                case "GetHeadOfAccounts":
                    GetHeadOfAccounts(context);
                    break;
                case "SaveHeadMasterClick":
                    SaveHeadMasterClick(context);
                    break;
                case "GetAllSalesOffice":
                    GetAllSalesOffice(context);
                    break;
                case "GetHeadNames":
                    GetHeadNames(context);
                    break;
                //case "GetSalesOffice":
                //    GetSalesOffice(context);
                //    break;
                case "GetApproveEmployeeNames":
                    GetApproveEmployeeNames(context);
                    break;

                case "BtnGetVoucherClick":
                    BtnGetVoucherClick(context);
                    break;
                case "BtnPayVoucherClick":
                    BtnPayVoucherClick(context);
                    break;
                case "btnViewVoucherGeneretaeClick":
                    btnViewVoucherGeneretaeClick(context);
                    break;

                case "GetSubPaybleValues":
                    GetSubPaybleValues(context);
                    break;

                case "Get_Voucher_Print_Details":
                    Get_Voucher_Print_Details(context);
                    break;
                case "btnVoucherCancelClick":
                    btnVoucherCancelClick(context);
                    break;
                case "GetHeadLimit":
                    GetHeadLimit(context);
                    break;
                case "BtnClearRaiseVoucherClick":
                    BtnClearRaiseVoucherClick(context);
                    break;
                case "BtnVarifyVoucherSaveClick":
                    BtnVarifyVoucherSaveClick(context);
                    break;
                case "GetBtnViewVoucherclick":
                    GetBtnViewVoucherclick(context);
                    break;
                case "GetAppriveSubPaybleValues":
                    GetAppriveSubPaybleValues(context);
                    break;
                case "btnApproveVoucherclick":
                    btnApproveVoucherclick(context);
                    break;
                case "btnRejectVoucherclick":
                    btnRejectVoucherclick(context);
                    break;
                case "btnVoucherUpdateClick":
                    btnVoucherUpdateClick(context);
                    break;
                case "btn_approve_voucher_grid":
                    btn_approve_voucher_grid(context);
                    break;

                case "BtnGetCashBookClosing":
                    BtnGetCashBookClosing(context);
                    break;


                    
                default:
                    var jsonString = string.Empty;
                    context.Request.InputStream.Position = 0;
                    using (var inputStream = new StreamReader(context.Request.InputStream))
                    {
                        jsonString = HttpUtility.UrlDecode(inputStream.ReadToEnd());
                    }
                    if (jsonString != "")
                    {
                        var js = new JavaScriptSerializer();
                        // var title1 = context.Request.Params[1];
                        GetJsonData obj = js.Deserialize<GetJsonData>(jsonString);
                        switch (obj.op)
                        {
                            //save_possale

                        }
                    }
                    else
                    {
                        var js = new JavaScriptSerializer();
                        var title1 = context.Request.Params[1];
                        GetJsonData obj = js.Deserialize<GetJsonData>(title1);
                        switch (obj.op)
                        {
                            case "save_expencessdetails":
                                save_expencessdetails(context);
                                break;
                            case "save_possale":
                                save_possale(context);
                                break;
                            case "Update_possale":
                                Update_possale(context);
                                break;

                            case "Edit_Item_Bal_Trans":
                                Edit_Item_Bal_Trans(context);
                                break;
                            case "save_inwarddetails":
                                save_inwarddetails(context);
                                break;
                            case "backdatesave_parlorerclosingregister":
                                backdatesave_parlorerclosingregister(context);
                                break;
                            case "save_parlorerclosingregister":
                                save_parlorerclosingregister(context);
                                break;
                            case "update_itemstockdetails":
                                update_itemstockdetails(context);
                                break;
                            case "save_stocktransfer_details":
                                save_stocktransfer_details(context);
                                break;
                            case "save_storereturn_details":
                                save_storereturn_details(context);
                                break;
                            case "save_jounel_voucher_click":
                                save_jounel_voucher_click(context);
                                break;

                            case "indent_save_click":
                                indent_save_click(context);
                                break;
                            case "subdistibuterrate_save":
                                subdistibuterrate_save(context);
                                break;
                            case "save_distibutorsale_details":
                                save_distibutorsale_details(context);
                                break;

                            case "btnOrderSaveClick":
                                btnOrderSaveClick(context);
                                break;
                            case "BtnRaiseVoucherClick":
                                BtnRaiseVoucherClick(context);
                                break;


                        }
                    }
                    break;
            }
        }
        catch (Exception ex)
        {
            string response = GetJson(ex.ToString());
            context.Response.Write(response);
        }
    }

    private void BtnGetCashBookClosing(HttpContext context)
    {
        context.Session["DenominationString"] = context.Request["DenominationString"];
        string msg = "success";
        string response = GetJson(msg);
        context.Response.Write(response);
    }
    private void btn_approve_voucher_grid(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            string VoucherID = context.Request["VoucherID"];
            string Approvalamt = context.Request["Amount"];
            double Amount = 0;
            double.TryParse(Approvalamt, out Amount);
            string Remarks = context.Request["remarks"];
            string Status = "A";
            string BranchID = "0";
            string LevelType = context.Session["LevelType"].ToString();
            if (LevelType == "AccountsOfficer" || LevelType == "Director")
            {
                BranchID = context.Request["branchID"];
            }
            else
            {
                BranchID = context.Session["branch"].ToString();
            }
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
            cmd = new SqlCommand("select * from registorclosingdetails where doe between @d1 and @d2 and parlorid=@parlorid");
            cmd.Parameters.Add("@d1", GetLowDate(ServerDateCurrentdate));
            cmd.Parameters.Add("@d2", GetHighDate(ServerDateCurrentdate));
            cmd.Parameters.AddWithValue("@parlorid", context.Session["BranchID"].ToString());
            DataTable dtcashbookstatus = vdm.SelectQuery(cmd).Tables[0];
            if (dtcashbookstatus.Rows.Count > 0)
            {
                string msg = "Cash Book Has Been Closed For This Day";
                string response = GetJson(msg);
                context.Response.Write(response);
            }
            else
            {
                cmd = new SqlCommand("Update cashpayables set Remarks=@Remarks,DOE=@DOE, ApprovedAmount=@ApprovedAmount ,ApprovalRemarks=@ApprovalRemarks,Status=@Status where Sno=@VocherID and BranchID=@BranchID");
                cmd.Parameters.AddWithValue("@Status", Status);
                cmd.Parameters.AddWithValue("@ApprovedAmount", Approvalamt);
                cmd.Parameters.AddWithValue("@ApprovalRemarks", Remarks);
                cmd.Parameters.AddWithValue("@Remarks", Remarks);
                cmd.Parameters.AddWithValue("@VocherID", VoucherID);
                cmd.Parameters.AddWithValue("@BranchID", BranchID);
                cmd.Parameters.AddWithValue("@DOE", ServerDateCurrentdate);
                vdm.Update(cmd);
                string msg = "Voucher Approved successfully";
                string response = GetJson(msg);
                context.Response.Write(response);
            }
        }
        catch (Exception ex)
        {
            string msg = ex.Message;
            string response = GetJson(msg);
            context.Response.Write(response);
        }
    }

    private void btnVoucherUpdateClick(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            string VoucherID = context.Request["VoucherID"];
            string Remarks = context.Request["Remarks"];
            string BranchID = "0";
            string LevelType = context.Session["LevelType"].ToString();
            if (LevelType == "AccountsOfficer" || LevelType == "Director")
            {
                BranchID = context.Request["BranchID"];
            }
            else
            {
                BranchID = context.Session["branch"].ToString();
            }
            cmd = new SqlCommand("Update cashpayables set Remarks=@Remarks where BranchID=@BranchID and Sno=@VocherID");
            cmd.Parameters.AddWithValue("@VocherID", VoucherID);
            cmd.Parameters.AddWithValue("@Remarks", Remarks);
            cmd.Parameters.AddWithValue("@BranchID", BranchID);
            vdm.Update(cmd);
            string msg = "Voucher Updated successfully";
            string response = GetJson(msg);
            context.Response.Write(response);
        }
        catch
        {
        }
    }

    private void GetAppriveSubPaybleValues(HttpContext context)
    {

        try
        {
            vdm = new SalesDBManager();
            string VoucherID = context.Request["VoucherID"];
            context.Session["VoucherID"] = VoucherID;
            List<Subpayables> SubpayableList = new List<Subpayables>();
            string BranchID = "0";
            string LevelType = context.Session["LevelType"].ToString();
            if (LevelType == "AccountsOfficer" || LevelType == "Director")
            {
                BranchID = context.Request["BranchID"];
            }
            else
            {
                BranchID = context.Session["branch"].ToString();
            }
            cmd = new SqlCommand("SELECT Sno FROM cashpayables WHERE (Sno = @VocherID) AND (BranchID = @BranchID)");
            cmd.Parameters.AddWithValue("@VocherID", VoucherID);
            cmd.Parameters.AddWithValue("@BranchID", BranchID);
            DataTable dtCash = vdm.SelectQuery(cmd).Tables[0];
            string RefNo = dtCash.Rows[0]["Sno"].ToString();
            cmd = new SqlCommand("SELECT accountheads.HeadName, subpayable.Amount, accountheads.Sno FROM subpayable INNER JOIN accountheads ON subpayable.HeadSno = accountheads.Sno WHERE  (subpayable.RefNo = @RefNo)");
            cmd.Parameters.AddWithValue("@RefNo", RefNo);
            DataTable dtCashSubPayable = vdm.SelectQuery(cmd).Tables[0];
            foreach (DataRow dr in dtCashSubPayable.Rows)
            {
                Subpayables GetSubpayable = new Subpayables();
                GetSubpayable.HeadSno = dr["Sno"].ToString();
                GetSubpayable.HeadOfAccount = dr["HeadName"].ToString();
                GetSubpayable.Amount = dr["Amount"].ToString();
                SubpayableList.Add(GetSubpayable);
            }
            string response = GetJson(SubpayableList);
            context.Response.Write(response);
        }
        catch
        {
        }
    }

    private void GetBtnViewVoucherclick(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            string VoucherID = context.Request["VoucherID"];
            string BranchID = "0";
            string LevelType = context.Session["LevelType"].ToString();
            if (LevelType == "AccountsOfficer" || LevelType == "Director")
            {
                BranchID = context.Request["BranchID"];
            }
            else
            {
                BranchID = context.Session["branch"].ToString();
            }
            List<VoucherClass> Voucherlist = new List<VoucherClass>();
            cmd = new SqlCommand("SELECT  employe_details.employename,cashpayables.Empid, cashpayables.Approvedby,cashpayables.VocherID, cashpayables.VoucherType, cashpayables.CashTo, cashpayables.onNameof, cashpayables.Amount, cashpayables.ApprovedAmount, empmanage_1.employename AS ApproveEmpName, cashpayables.Status, cashpayables.ApprovalRemarks, cashpayables.Remarks FROM employe_details empmanage_1 INNER JOIN cashpayables ON empmanage_1.Sno = cashpayables.Approvedby LEFT OUTER JOIN employe_details ON cashpayables.Empid = employe_details.Sno WHERE (cashpayables.Sno = @VoucherID) AND (cashpayables.BranchID = @BranchID)");
            cmd.Parameters.AddWithValue("@VoucherID", VoucherID);
            cmd.Parameters.AddWithValue("@BranchID", BranchID);
            DataTable dtVouchers = vdm.SelectQuery(cmd).Tables[0];
            if (dtVouchers.Rows.Count > 0)
            {
                foreach (DataRow dr in dtVouchers.Rows)
                {
                    VoucherClass getVoucher = new VoucherClass();
                    getVoucher.EmpName = dr["employename"].ToString();
                    getVoucher.VoucherType = dr["VoucherType"].ToString();
                    getVoucher.CashTo = dr["CashTo"].ToString();
                    getVoucher.Description = dr["onNameof"].ToString();
                    getVoucher.Amount = dr["Amount"].ToString();
                    getVoucher.ApprovalAmount = dr["ApprovedAmount"].ToString();
                    getVoucher.ApproveEmpName = dr["ApproveEmpName"].ToString();
                    getVoucher.Status = dr["Status"].ToString();
                    getVoucher.ApprovalRemarks = dr["ApprovalRemarks"].ToString();
                    getVoucher.Remarks = dr["Remarks"].ToString();
                    getVoucher.Empid = dr["EmpID"].ToString();
                    getVoucher.ApprovedBy = dr["Approvedby"].ToString();
                    getVoucher.branchvoucherid = dr["VocherID"].ToString();
                    Voucherlist.Add(getVoucher);
                }
                string response = GetJson(Voucherlist);
                context.Response.Write(response);
            }
            else
            {
                string msg = "No voucher found";
                string response = GetJson(msg);
                context.Response.Write(response);
            }
        }
        catch
        {
        }
    }

    private void BtnVarifyVoucherSaveClick(HttpContext context)
    {
        vdm = new SalesDBManager();
        string VoucherID = context.Request["VoucherID"];
        string ReceivedAmount = context.Request["ReceivedAmount"];
        string Due = context.Request["Due"];
        cmd = new SqlCommand("Update cashpayables set Status=@Status,ReceivedAmount=@ReceivedAmount,DueAmount=@DueAmount where BranchID=@BranchID and VocherID=@VocherID");
        cmd.Parameters.AddWithValue("@Status", "V");
        cmd.Parameters.AddWithValue("@VocherID", VoucherID);
        double RAmount = 0;
        double.TryParse(ReceivedAmount, out RAmount);
        cmd.Parameters.AddWithValue("@ReceivedAmount", ReceivedAmount);
        double RDue = 0;
        double.TryParse(Due, out RDue);
        cmd.Parameters.AddWithValue("@DueAmount", RDue);
        cmd.Parameters.AddWithValue("@BranchID", context.Session["branch"].ToString());
        vdm.Update(cmd);
        string msg = "Voucher Varified successfully";
        string response = GetJson(msg);
        context.Response.Write(response);
    }

    private void BtnClearRaiseVoucherClick(HttpContext context)
    {

        try
        {
            vdm = new SalesDBManager();
            string Description = context.Request["Description"];
            string Amount = context.Request["Amount"];
            string VoucherType = context.Request["VoucherType"];
            string CashTo = context.Request["CashTo"];
            string EmpName = context.Request["Employee"];
            string Remarks = context.Request["EmpName"];
            string EmpApprove = context.Request["AprovedBy"];
            cmd = new SqlCommand("Select IFNULL(MAX(VocherID),0)+1 as VocherID  from cashpayables where BranchID=@BranchID");
            cmd.Parameters.AddWithValue("@BranchID", context.Session["branch"].ToString());
            DataTable dtTripId = vdm.SelectQuery(cmd).Tables[0];
            string VocherID = "0";
            if (dtTripId.Rows.Count > 0)
            {
                VocherID = dtTripId.Rows[0]["VocherID"].ToString();
            }
            else
            {
                VocherID = "1";
            }
            cmd = new SqlCommand("Insert into cashpayables (BranchID,CashTo,DOE,VocherID,Remarks,Amount,EmpId,Approvedby,onNameof,Status,Created_by,VoucherType) values (@BranchID,@CashTo,@DOE,@VocherID,@Remarks,@Amount,@EmpId,@Approvedby,@onNameof,@Status,@Created_by,@VoucherType)");
            cmd.Parameters.AddWithValue("@BranchID", context.Session["branch"].ToString());
            cmd.Parameters.AddWithValue("@CashTo", CashTo);
            cmd.Parameters.AddWithValue("@DOE", DateTime.Now);
            cmd.Parameters.AddWithValue("@VocherID", VocherID);
            cmd.Parameters.AddWithValue("@Remarks", Remarks);
            cmd.Parameters.AddWithValue("@Amount", Amount);
            cmd.Parameters.AddWithValue("@EmpId", EmpName);
            cmd.Parameters.AddWithValue("@Approvedby", EmpApprove);
            cmd.Parameters.AddWithValue("@onNameof", Description);
            cmd.Parameters.AddWithValue("@Status", "R");
            cmd.Parameters.AddWithValue("@Created_by", context.Session["UserSno"].ToString());
            cmd.Parameters.AddWithValue("@VoucherType", VoucherType);
            vdm.insert(cmd);
            string msg = VocherID;
            string response = GetJson(msg);
            context.Response.Write(response);
        }
        catch (Exception ex)
        {
            string msg = ex.Message;
            string response = GetJson(msg);
            context.Response.Write(response);
        }
    }

    private void GetHeadLimit(HttpContext context)
    {
        vdm = new SalesDBManager();
        string HeadSno = context.Request["HeadSno"];
        cmd = new SqlCommand("SELECT Sno, BranchId, HeadName, LimitAmount FROM accountheads WHERE (Sno = @Sno)");
        cmd.Parameters.AddWithValue("@Sno", HeadSno);
        DataTable dtHead = vdm.SelectQuery(cmd).Tables[0];
        string HeadLimit = "0";
        if (dtHead.Rows.Count > 0)
        {
            HeadLimit = dtHead.Rows[0]["LimitAmount"].ToString();
        }
        string response = GetJson(HeadLimit);
        context.Response.Write(response);
    }

    private void btnVoucherCancelClick(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            string VoucherID = context.Request["VoucherID"];
            string branch = context.Session["branch"].ToString();
            cmd = new SqlCommand("Update cashpayables set Status=@Status where Sno=@VocherID");
            cmd.Parameters.AddWithValue("@Status", "C");
            cmd.Parameters.AddWithValue("@VocherID", VoucherID);
            vdm.Update(cmd);
            string msg = "Voucher Cancel successfully";
            string response = GetJson(msg);
            context.Response.Write(response);
        }
        catch (Exception ex)
        {
            string msg = ex.Message;
            string response = GetJson(msg);
            context.Response.Write(response);
        }
    }

    class VoucherPrintdetails1
    {
        public string voucherid { get; set; }
        public string approveemp { get; set; }
        public string date { get; set; }
        public string nameof { get; set; }
        public string Remarks { get; set; }
        public string vouchertype { get; set; }
        public string amount { get; set; }
        public string branchid { get; set; }
        public string VoucherID { get; set; }
        public string Title { get; set; }
        public string lblReceived { get; set; }
    }

    private void Get_Voucher_Print_Details(HttpContext context)//akbar
    {

        try
        {
            vdm = new SalesDBManager();
            string BrachSOID = "";
            if (context.Session["BrachSOID"] == null)
            {
                BrachSOID = context.Session["branch"].ToString();
            }
            else
            {
                BrachSOID = context.Session["BrachSOID"].ToString();
            }
            string VoucherID = context.Request["VoucherID"].ToString();
            string title = context.Session["TitleName"].ToString();
            // cmd = new SqlCommand("SELECT cashpayables.onNameof, cashpayables.DOE, cashpayables.Sno, cashpayables.Amount, cashpayables.Remarks,cashpayables.ApprovalRemarks, cashpayables.VoucherType, empmanage.EmpName FROM cashpayables INNER JOIN empmanage ON cashpayables.Approvedby = empmanage.Sno WHERE (cashpayables.VocherID = @VocherID) AND (cashpayables.BranchID = @BranchID)");
            cmd = new SqlCommand("SELECT cashpayables.onNameof, cashpayables.DOE,cashpayables.VocherID, cashpayables.Sno, cashpayables.Amount, cashpayables.ApprovedAmount, cashpayables.Remarks, cashpayables.ApprovalRemarks,cashpayables.VoucherType, employe_details.employename as EmpName FROM cashpayables LEFT OUTER JOIN employe_details ON cashpayables.Approvedby = employe_details.Sno WHERE (cashpayables.Sno = @VocherID) AND (cashpayables.BranchID = @BranchID)");
            // cmd = new SqlCommand("SELECT cashpayables.onNameof, cashpayables.DOE,cashpayables.VocherID, cashpayables.Sno, cashpayables.Amount, cashpayables.ApprovedAmount, cashpayables.Remarks, cashpayables.ApprovalRemarks,cashpayables.VoucherType, empmanage.EmpName FROM cashpayables LEFT OUTER JOIN empmanage ON cashpayables.Approvedby = empmanage.Sno WHERE (cashpayables.Sno = @VocherID) "); 
            cmd.Parameters.AddWithValue("@VocherID", VoucherID);
            cmd.Parameters.AddWithValue("@BranchID", BrachSOID);
            DataTable dtCash = vdm.SelectQuery(cmd).Tables[0];
            List<VoucherPrintdetails1> VoucherPrintdetailslist = new List<VoucherPrintdetails1>();
            cmd = new SqlCommand("SELECT branchid as sno, BranchName, BranchCode FROM branchmaster WHERE (branchid = @BranchID)");
            cmd.Parameters.AddWithValue("@BranchID", BrachSOID);
            DataTable dtCode = vdm.SelectQuery(cmd).Tables[0];

            string voucherid = "";
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
            DateTime dtapril = new DateTime();
            DateTime dtmarch = new DateTime();
            int currentyear = ServerDateCurrentdate.Year;
            int nextyear = ServerDateCurrentdate.Year + 1;
            int currntyearnum = 0;
            int nextyearnum = 0;
            if (ServerDateCurrentdate.Month > 3)
            {
                string apr = "4/1/" + currentyear;
                dtapril = DateTime.Parse(apr);
                string march = "3/31/" + nextyear;
                dtmarch = DateTime.Parse(march);
                currntyearnum = currentyear;
                nextyearnum = nextyear;
            }
            if (ServerDateCurrentdate.Month <= 3)
            {
                string apr = "4/1/" + (currentyear - 1);
                dtapril = DateTime.Parse(apr);
                string march = "3/31/" + (nextyear - 1);
                dtmarch = DateTime.Parse(march);
                currntyearnum = currentyear - 1;
                nextyearnum = nextyear - 1;
            }
            if (dtCash.Rows.Count > 0)
            {
                VoucherPrintdetails1 obj1 = new VoucherPrintdetails1();
                //lblVoucherno.Text = txtVoucherNo.Text;
                voucherid = dtCode.Rows[0]["BranchCode"].ToString() + "/VOC/" + dtapril.ToString("yy") + "-" + dtmarch.ToString("yy") + "/" + dtCash.Rows[0]["VocherID"].ToString();
                obj1.voucherid = voucherid;
                string DOE = dtCash.Rows[0]["DOE"].ToString();
                DateTime dtDOE = Convert.ToDateTime(DOE);

                obj1.approveemp = dtCash.Rows[0]["EmpName"].ToString();

                string ChangedTime = dtDOE.ToString("dd/MMM/yyyy");
                obj1.date = ChangedTime;
                obj1.nameof = dtCash.Rows[0]["onNameof"].ToString();
                string AppRemarks = dtCash.Rows[0]["ApprovalRemarks"].ToString();
                if (AppRemarks == "")
                {
                    obj1.Remarks = dtCash.Rows[0]["Remarks"].ToString();
                }
                else
                {
                    obj1.Remarks = dtCash.Rows[0]["ApprovalRemarks"].ToString();
                }
                obj1.vouchertype = dtCash.Rows[0]["VoucherType"].ToString().ToUpper() + " VOUCHER";
                obj1.amount = dtCash.Rows[0]["Amount"].ToString();
                obj1.VoucherID = VoucherID;
                obj1.branchid = BrachSOID;

                obj1.Title = title;
                string Amont = "";
                if (dtCash.Rows[0]["VoucherType"].ToString() == "Credit")
                {
                    Amont = dtCash.Rows[0]["ApprovedAmount"].ToString();
                }
                else
                {
                    Amont = dtCash.Rows[0]["Amount"].ToString();
                }
                string[] Ones = { "", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Ninteen" };

                string[] Tens = { "Ten", "Twenty", "Thirty", "Fourty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninty" };

                int Num = int.Parse(Amont);

                string letters = NumToWordBD(Num) + " Rupees Only";
                obj1.lblReceived = letters;

                VoucherPrintdetailslist.Add(obj1);
                string response = GetJson(VoucherPrintdetailslist);
                context.Response.Write(response);
            }
        }
        catch
        {
        }
    }

    public static string NumToWordBD(Int64 Num)
    {
        string[] Below20 = { "", "One ", "Two ", "Three ", "Four ",
      "Five ", "Six " , "Seven ", "Eight ", "Nine ", "Ten ", "Eleven ",
    "Twelve " , "Thirteen ", "Fourteen ","Fifteen ",
      "Sixteen " , "Seventeen ","Eighteen " , "Nineteen " };
        string[] Below100 = { "", "", "Twenty ", "Thirty ",
      "Forty ", "Fifty ", "Sixty ", "Seventy ", "Eighty ", "Ninety " };
        string InWords = "";
        if (Num >= 1 && Num < 20)
            InWords += Below20[Num];
        if (Num >= 20 && Num <= 99)
            InWords += Below100[Num / 10] + Below20[Num % 10];
        if (Num >= 100 && Num <= 999)
            InWords += NumToWordBD(Num / 100) + " Hundred " + NumToWordBD(Num % 100);
        if (Num >= 1000 && Num <= 99999)
            InWords += NumToWordBD(Num / 1000) + " Thousand " + NumToWordBD(Num % 1000);
        if (Num >= 100000 && Num <= 9999999)
            InWords += NumToWordBD(Num / 100000) + " Lakh " + NumToWordBD(Num % 100000);
        if (Num >= 10000000)
            InWords += NumToWordBD(Num / 10000000) + " Crore " + NumToWordBD(Num % 10000000);
        return InWords;
    }

    private void GetSubPaybleValues(HttpContext context)
    {

        try
        {
            vdm = new SalesDBManager();
            string VoucherID = context.Request["VoucherID"];
            string branchid = "0";
            if (context.Session["BrachSOID"] == null)
            {
                branchid = context.Session["branch"].ToString();
            }
            else
            {
                branchid = context.Session["BrachSOID"].ToString();
            }

            List<Subpayables> SubpayableList = new List<Subpayables>();
            cmd = new SqlCommand("SELECT Sno FROM cashpayables WHERE (Sno = @VocherID) AND (BranchID = @BranchID)");
            cmd.Parameters.AddWithValue("@VocherID", VoucherID);
            cmd.Parameters.AddWithValue("@BranchID", branchid);
            DataTable dtCash = vdm.SelectQuery(cmd).Tables[0];
            string RefNo = dtCash.Rows[0]["Sno"].ToString();
            cmd = new SqlCommand("SELECT accountheads.HeadName, subpayable.Amount, accountheads.Sno FROM subpayable INNER JOIN accountheads ON subpayable.HeadSno = accountheads.Sno WHERE  (subpayable.RefNo = @RefNo)");
            cmd.Parameters.AddWithValue("@RefNo", RefNo);
            DataTable dtCashSubPayable = vdm.SelectQuery(cmd).Tables[0];
            foreach (DataRow dr in dtCashSubPayable.Rows)
            {
                Subpayables GetSubpayable = new Subpayables();
                GetSubpayable.HeadSno = dr["Sno"].ToString();
                GetSubpayable.HeadOfAccount = dr["HeadName"].ToString();
                GetSubpayable.Amount = dr["Amount"].ToString();
                SubpayableList.Add(GetSubpayable);
            }
            string response = GetJson(SubpayableList);
            context.Response.Write(response);
        }
        catch (Exception ex)
        {
            string response = GetJson(ex.Message);
            context.Response.Write(response);
        }
    }
    class Subpayables
    {
        public string HeadSno { get; set; }
        public string HeadOfAccount { get; set; }
        public string Amount { get; set; }
    }
    private void btnViewVoucherGeneretaeClick(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            List<VoucherClass> Voucherlist = new List<VoucherClass>();
            string fromdate = context.Request["fromdate"];
            string ToDate = context.Request["ToDate"];
            string statusType = context.Request["Type"];
            string FormType = context.Request["FormType"];
            DateTime dtFromdate = Convert.ToDateTime(fromdate);
            DateTime dtTodate = Convert.ToDateTime(ToDate);
            DataTable dtVouchers = new DataTable();
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
            string BranchID = "0";
            string LevelType = context.Session["LevelType"].ToString();
            if (FormType != "VoucherPrint")
            {
                if (LevelType == "AccountsOfficer" || LevelType == "Director")
                {
                    BranchID = context.Request["BranchID"];
                    if (statusType == "All")
                    {
                        cmd = new SqlCommand("SELECT cashpayables.BranchID,cashpayables.Empid, cashpayables.Approvedby, cashpayables.Status,cashpayables.Sno, cashpayables.VocherID, cashpayables.CashTo, cashpayables.AccountType, cashpayables.onNameof, cashpayables.DOE, cashpayables.Amount, cashpayables.ApprovedAmount, cashpayables.Remarks, cashpayables.ApprovalRemarks, cashpayables.CashierRemarks, cashpayables.VoucherType,  employe_details.employename, empmanage_1.employename AS ApproveEmpName FROM cashpayables LEFT OUTER JOIN employe_details empmanage_1 ON cashpayables.Approvedby = empmanage_1.Sno LEFT OUTER JOIN employe_details ON cashpayables.Empid = employe_details.Sno WHERE (cashpayables.BranchID = @BranchID) AND (cashpayables.DOE BETWEEN @d1 AND @d2)");
                        cmd.Parameters.AddWithValue("@d1", GetLowDate(ServerDateCurrentdate).AddDays(-3));
                        cmd.Parameters.AddWithValue("@d2", GetHighDate(ServerDateCurrentdate));
                        cmd.Parameters.AddWithValue("@BranchID", BranchID);
                    }
                    else
                    {
                        cmd = new SqlCommand("SELECT cashpayables.BranchID,cashpayables.Empid, cashpayables.Approvedby, cashpayables.Status,cashpayables.Sno, cashpayables.VocherID, cashpayables.CashTo, cashpayables.AccountType, cashpayables.onNameof, cashpayables.DOE, cashpayables.Amount, cashpayables.ApprovedAmount, cashpayables.Remarks, cashpayables.ApprovalRemarks, cashpayables.CashierRemarks, cashpayables.VoucherType, employe_details.employename, empmanage_1.employename AS ApproveEmpName FROM cashpayables LEFT OUTER JOIN employe_details empmanage_1 ON cashpayables.Approvedby = empmanage_1.Sno LEFT OUTER JOIN employe_details ON cashpayables.Empid = employe_details.Sno WHERE (cashpayables.BranchID = @BranchID) AND (cashpayables.DOE BETWEEN @d1 AND @d2) AND (cashpayables.Status = @status)");
                        cmd.Parameters.AddWithValue("@d1", GetLowDate(ServerDateCurrentdate).AddDays(-30));
                        cmd.Parameters.AddWithValue("@d2", GetHighDate(ServerDateCurrentdate));
                        cmd.Parameters.AddWithValue("@BranchID", BranchID);
                        cmd.Parameters.AddWithValue("@status", statusType);
                    }
                }
                else
                {
                    BranchID = context.Session["BranchID"].ToString();
                    //if (BranchID == "3928")
                    //{
                    //    cmd = new SqlCommand("SELECT cashpayables.BranchID,cashpayables.Empid, cashpayables.Approvedby,cashpayables.Status,cashpayables.Sno, cashpayables.VocherID, cashpayables.CashTo,cashpayables.AccountType, cashpayables.onNameof, cashpayables.DOE, cashpayables.Amount, cashpayables.ApprovedAmount, cashpayables.Remarks, cashpayables.ApprovalRemarks, cashpayables.CashierRemarks, cashpayables.VoucherType, empmanage.EmpName, empmanage_1.EmpName AS ApproveEmpName FROM cashpayables INNER JOIN empmanage empmanage_1 ON cashpayables.Approvedby = empmanage_1.Sno LEFT OUTER JOIN empmanage ON cashpayables.Empid = empmanage.Sno WHERE ( (cashpayables.BranchID = @BranchID) AND (cashpayables.DOE BETWEEN @d1 AND @d2) AND (cashpayables.Status = @Status)) OR ((cashpayables.BranchID = @BranchID) AND (cashpayables.DOE BETWEEN @d1 AND @d2) AND (cashpayables.Status = @Status1))");
                    //    cmd.Parameters.AddWithValue("@d1", GetLowDate(ServerDateCurrentdate).AddDays(-45));
                    //    cmd.Parameters.AddWithValue("@d2", GetHighDate(ServerDateCurrentdate));
                    //    cmd.Parameters.AddWithValue("@Status", "A");
                    //    cmd.Parameters.AddWithValue("@Status1", "R");
                    //    cmd.Parameters.AddWithValue("@BranchID", BranchID);
                    //}
                    //else
                    //{
                    cmd = new SqlCommand("SELECT cashpayables.BranchID,cashpayables.Empid, cashpayables.Approvedby,cashpayables.Status,cashpayables.Sno, cashpayables.VocherID, cashpayables.CashTo,cashpayables.AccountType, cashpayables.onNameof, cashpayables.DOE, cashpayables.Amount, cashpayables.ApprovedAmount, cashpayables.Remarks, cashpayables.ApprovalRemarks, cashpayables.CashierRemarks, cashpayables.VoucherType, employe_details.employename, empmanage_1.employename AS ApproveEmpName FROM cashpayables INNER JOIN employe_details empmanage_1 ON cashpayables.Approvedby = empmanage_1.Sno LEFT OUTER JOIN employe_details ON cashpayables.Empid = employe_details.Sno WHERE ( (cashpayables.BranchID = @BranchID) AND (cashpayables.DOE BETWEEN @d1 AND @d2) AND (cashpayables.Status = @Status)) OR ((cashpayables.BranchID = @BranchID) AND (cashpayables.DOE BETWEEN @d1 AND @d2) AND (cashpayables.Status = @Status1))");
                    cmd.Parameters.AddWithValue("@d1", GetLowDate(ServerDateCurrentdate).AddDays(-7));
                    cmd.Parameters.AddWithValue("@d2", GetHighDate(ServerDateCurrentdate));
                    cmd.Parameters.AddWithValue("@Status", "A");
                    cmd.Parameters.AddWithValue("@Status1", "R");
                    cmd.Parameters.AddWithValue("@BranchID", BranchID);
                    //}
                }
                dtVouchers = vdm.SelectQuery(cmd).Tables[0];
            }
            else
            {
                cmd = new SqlCommand("SELECT cashpayables.BranchID,cashpayables.Empid, cashpayables.Approvedby, cashpayables.Status,cashpayables.Sno, cashpayables.VocherID, cashpayables.CashTo, cashpayables.AccountType, cashpayables.onNameof, cashpayables.DOE, cashpayables.Amount,cashpayables.ApprovedAmount, cashpayables.Remarks, cashpayables.ApprovalRemarks, cashpayables.CashierRemarks, cashpayables.VoucherType, employe_details.employename as EmpName, employe_details_1.employename AS ApproveEmpName FROM cashpayables LEFT OUTER JOIN employe_details employe_details_1 ON  cashpayables.Approvedby = employe_details_1.Sno  LEFT OUTER JOIN employe_details ON cashpayables.Empid = employe_details.Sno WHERE  (cashpayables.BranchID = @BranchID) AND(cashpayables.DOE BETWEEN @d1 AND @d2) ");
                cmd.Parameters.AddWithValue("@d1", GetLowDate(dtFromdate));
                cmd.Parameters.AddWithValue("@d2", GetHighDate(dtTodate));
                cmd.Parameters.AddWithValue("@BranchID", context.Session["branch"]);
                dtVouchers = vdm.SelectQuery(cmd).Tables[0];
            }
            if (dtVouchers.Rows.Count > 0)
            {
                foreach (DataRow dr in dtVouchers.Rows)
                {
                    VoucherClass getVoucher = new VoucherClass();
                    getVoucher.Empid = dr["Empid"].ToString();
                    getVoucher.ApprovedBy = dr["Approvedby"].ToString();
                    getVoucher.VoucherID = dr["Sno"].ToString();
                    string EmpName = dr["employename"].ToString();
                    string VoucherType = dr["VoucherType"].ToString();
                    if (VoucherType == "Credit")
                    {
                        getVoucher.Amount = dr["ApprovedAmount"].ToString();
                        getVoucher.Remarks = dr["ApprovalRemarks"].ToString();
                    }
                    else
                    {
                        getVoucher.Amount = dr["Amount"].ToString();
                        getVoucher.Remarks = dr["Remarks"].ToString();

                    }
                    getVoucher.VoucherType = dr["VoucherType"].ToString();
                    if (EmpName == "")
                    {
                        EmpName = "select";
                    }
                    getVoucher.EmpName = EmpName;
                    getVoucher.BranchID = dr["BranchID"].ToString();
                    getVoucher.CashTo = dr["CashTo"].ToString();
                    getVoucher.Description = dr["onNameof"].ToString();
                    getVoucher.AccountType = dr["AccountType"].ToString();
                    getVoucher.ApprovalAmount = dr["ApprovedAmount"].ToString();
                    getVoucher.ApproveEmpName = dr["ApproveEmpName"].ToString();
                    string Status = dr["Status"].ToString();
                    if (Status == "R")
                    {
                        Status = "Raised";
                    }
                    if (Status == "A")
                    {
                        Status = "Approved";
                    }
                    if (Status == "C")
                    {
                        Status = "Rejected";
                    }
                    if (Status == "P")
                    {
                        Status = "Paid";
                    }
                    getVoucher.Status = Status;
                    getVoucher.ApprovalRemarks = dr["ApprovalRemarks"].ToString();
                    getVoucher.branchvoucherid = dr["VocherID"].ToString();
                    Voucherlist.Add(getVoucher);
                }
            }
            string response = GetJson(Voucherlist);
            context.Response.Write(response);
        }
        catch
        {
        }
    }

    private void BtnPayVoucherClick(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            string VoucherID = context.Request["VoucherID"];
            string ApprovalAmount = context.Request["ApprovalAmount"];
            double Amount = 0;
            double.TryParse(ApprovalAmount, out Amount);
            string Remarks = context.Request["Remarks"];
            string Force = context.Request["Force"];
            string VoucherType = context.Request["VoucherType"];
            string DOE = context.Request["DOE"];
            string Denominations = context.Request["DenominationString"];
            DateTime dtpaidtime = new DateTime();
            dtpaidtime = DateTime.Parse(DOE);
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);

            cmd = new SqlCommand("select * from registorclosingdetails where doe between @d1 and @d2 and parlorid=@parlorid");
            cmd.Parameters.Add("@d1", GetLowDate(ServerDateCurrentdate));
            cmd.Parameters.Add("@d2", GetHighDate(ServerDateCurrentdate));
            cmd.Parameters.AddWithValue("@parlorid", context.Session["BranchID"].ToString());
            DataTable dtcashbookstatus = vdm.SelectQuery(cmd).Tables[0];

            
            if (dtcashbookstatus.Rows.Count > 0)
            {
                string msg = "Cash Book Has Been Closed For This Day";
                string response = GetJson(msg);
                context.Response.Write(response);
            }
            else
            {
                cmd = new SqlCommand("Update cashpayables set ApprovedAmount=@ApprovedAmount, DOE=@DOE,CashierRemarks=@CashierRemarks,Status=@Status,ForceApproval=@ForceApproval,Denominations=@Denominations where BranchID=@BranchID and Sno=@VocherID");
                cmd.Parameters.AddWithValue("@ApprovedAmount", Amount);
                cmd.Parameters.AddWithValue("@CashierRemarks", Remarks);
                cmd.Parameters.AddWithValue("@Status", "P");
                cmd.Parameters.AddWithValue("@ForceApproval", Force);
                cmd.Parameters.AddWithValue("@VocherID", VoucherID);
                cmd.Parameters.AddWithValue("@Denominations", Denominations);
                string branchid = context.Session["branch"].ToString();
                if (branchid == "570")
                {
                    cmd.Parameters.AddWithValue("@DOE", dtpaidtime);
                }
                if (branchid != "570")
                {
                    cmd.Parameters.AddWithValue("@DOE", ServerDateCurrentdate);
                }
                cmd.Parameters.AddWithValue("@BranchID", context.Session["BranchID"].ToString());
                vdm.Update(cmd);
                string msg = "Voucher Paid successfully";
                string response = GetJson(msg);
                context.Response.Write(response);
            }
        }
        catch (Exception ex)
        {
            string msg = ex.Message;
            string response = GetJson(msg);
            context.Response.Write(response);
        }
    }

    private void BtnGetVoucherClick(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            string VoucherID = context.Request["VoucherID"];
            List<VoucherClass> Voucherlist = new List<VoucherClass>();
            cmd = new SqlCommand("SELECT  empmanage.EmpName,cashpayables.Empid, cashpayables.Approvedby, cashpayables.VoucherType, cashpayables.CashTo, cashpayables.onNameof, cashpayables.Amount, cashpayables.ApprovedAmount, empmanage_1.EmpName AS ApproveEmpName, cashpayables.Status, cashpayables.ApprovalRemarks, cashpayables.Remarks FROM empmanage empmanage_1 INNER JOIN cashpayables ON empmanage_1.Sno = cashpayables.Approvedby LEFT OUTER JOIN empmanage ON cashpayables.Empid = empmanage.Sno WHERE (cashpayables.Sno = @VoucherID) AND (cashpayables.BranchID = @BranchID)");
            cmd.Parameters.AddWithValue("@VoucherID", VoucherID);
            cmd.Parameters.AddWithValue("@BranchID", context.Session["branch"].ToString());
            DataTable dtVouchers = vdm.SelectQuery(cmd).Tables[0];
            if (dtVouchers.Rows.Count > 0)
            {
                foreach (DataRow dr in dtVouchers.Rows)
                {
                    VoucherClass getVoucher = new VoucherClass();
                    getVoucher.EmpName = dr["EmpName"].ToString();
                    getVoucher.VoucherType = dr["VoucherType"].ToString();
                    getVoucher.CashTo = dr["CashTo"].ToString();
                    getVoucher.Description = dr["onNameof"].ToString();
                    getVoucher.Amount = dr["Amount"].ToString();
                    getVoucher.ApprovalAmount = dr["Amount"].ToString();
                    getVoucher.ApproveEmpName = dr["ApproveEmpName"].ToString();
                    getVoucher.Status = dr["Status"].ToString();
                    getVoucher.ApprovalRemarks = dr["Remarks"].ToString();
                    getVoucher.Remarks = dr["Remarks"].ToString();
                    getVoucher.Empid = dr["EmpID"].ToString();
                    getVoucher.ApprovedBy = dr["Approvedby"].ToString();
                    Voucherlist.Add(getVoucher);
                }
                string response = GetJson(Voucherlist);
                context.Response.Write(response);
            }
            else
            {
                string msg = "No voucher found";
                string response = GetJson(msg);
                context.Response.Write(response);
            }
        }
        catch
        {
        }
    }
    private void btnRejectVoucherclick(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            string VoucherID = context.Request["VoucherID"];
            string Approvalamt = context.Request["Approvalamt"];
            string Remarks = context.Request["Remarks"];
            string Status = context.Request["Status"];
            string AppRemarks = context.Request["AppRemarks"];
            string BranchID = "0";
            string LevelType = context.Session["LevelType"].ToString();
            if (LevelType == "AccountsOfficer" || LevelType == "Director")
            {
                BranchID = context.Request["BranchID"];
            }
            else
            {
                BranchID = context.Session["branch"].ToString();
            }
            cmd = new SqlCommand("Update cashpayables set  Remarks=@Remarks,ApprovedAmount=@ApprovedAmount ,ApprovalRemarks=@ApprovalRemarks,Status=@Status where  Sno=@VocherID and BranchID=@BranchID ");
            cmd.Parameters.AddWithValue("@Status", Status);
            cmd.Parameters.AddWithValue("@ApprovedAmount", Approvalamt);
            cmd.Parameters.AddWithValue("@ApprovalRemarks", AppRemarks);
            cmd.Parameters.AddWithValue("@VocherID", VoucherID);
            cmd.Parameters.AddWithValue("@BranchID", BranchID);
            cmd.Parameters.AddWithValue("@Remarks", Remarks);
            vdm.Update(cmd);
            string msg = "Voucher Reject successfully";
            string response = GetJson(msg);
            context.Response.Write(response);

        }
        catch (Exception ex)
        {
            string msg = ex.Message;
            string response = GetJson(msg);
            context.Response.Write(response);
        }
    }
    private void btnApproveVoucherclick(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            string VoucherID = context.Request["VoucherID"];
            string Approvalamt = context.Request["Approvalamt"];
            double Amount = 0;
            double.TryParse(Approvalamt, out Amount);
            string Remarks = context.Request["Remarks"];
            string AppRemarks = context.Request["AppRemarks"];
            string Status = context.Request["Status"];
            string BranchID = "0";
            string LevelType = context.Session["LevelType"].ToString();
            if (LevelType == "AccountsOfficer" || LevelType == "Director")
            {
                BranchID = context.Request["BranchID"];
            }
            else
            {
                BranchID = context.Session["branch"].ToString();
            }

            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
            cmd = new SqlCommand("select * from registorclosingdetails where doe between @d1 and @d2 and parlorid=@parlorid");
            cmd.Parameters.Add("@d1", GetLowDate(ServerDateCurrentdate));
            cmd.Parameters.Add("@d2", GetHighDate(ServerDateCurrentdate));
            cmd.Parameters.AddWithValue("@parlorid", BranchID);
            DataTable dtexisting = vdm.SelectQuery(cmd).Tables[0];

            //cmd = new SqlCommand("SELECT Branchid, UserData_sno, AmountPaid, Denominations, Remarks, Sno, PaidDate FROM collections WHERE (Branchid = @BranchID) AND (PaidDate BETWEEN @d1 AND @d2)");
            //cmd.Parameters.AddWithValue("@BranchID", BranchID);
            //cmd.Parameters.AddWithValue("@d1", GetLowDate(ServerDateCurrentdate));
            //cmd.Parameters.AddWithValue("@d2", GetHighDate(ServerDateCurrentdate));
            //DataTable dtexisting = vdm.SelectQuery(cmd).Tables[0];
            if (dtexisting.Rows.Count > 0)
            {
                string msg = "Cash Book Has Been Closed For This Day";
                string response = GetJson(msg);
                context.Response.Write(response);
            }
            else
            {
                cmd = new SqlCommand("Update cashpayables set Remarks=@Remarks,DOE=@DOE, ApprovedAmount=@ApprovedAmount ,ApprovalRemarks=@ApprovalRemarks,Status=@Status where Sno=@VocherID and BranchID=@BranchID");
                cmd.Parameters.AddWithValue("@Status", Status);
                cmd.Parameters.AddWithValue("@ApprovedAmount", Amount);
                cmd.Parameters.AddWithValue("@ApprovalRemarks", AppRemarks);
                cmd.Parameters.AddWithValue("@Remarks", Remarks);
                cmd.Parameters.AddWithValue("@VocherID", VoucherID);
                cmd.Parameters.AddWithValue("@BranchID", BranchID);
                cmd.Parameters.AddWithValue("@DOE", ServerDateCurrentdate);
                vdm.Update(cmd);
                string msg = "Voucher Approved successfully";
                string response = GetJson(msg);
                context.Response.Write(response);
            }

        }
        catch (Exception ex)
        {
            string msg = ex.Message;
            string response = GetJson(msg);
            context.Response.Write(response);
        }
    }
    private void GetRaisedVouchers(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            List<VoucherClass> Voucherlist = new List<VoucherClass>();
            string LevelType = context.Session["LevelType"].ToString();
            string status = context.Request["Type"];
            string fromdate = context.Request["fromdate"];
            string ToDate = context.Request["ToDate"];
            DateTime dtFromdate = Convert.ToDateTime(fromdate);
            DateTime dtTodate = Convert.ToDateTime(ToDate);
            if (LevelType == "Manager")
            {
                //cmd = new SqlCommand("SELECT cashpayables.Sno, cashpayables.Empid,empmanage.EmpName, cashpayables.VocherID, cashpayables.Amount FROM cashpayables INNER JOIN empmanage ON cashpayables.Empid = empmanage.Sno WHERE (cashpayables.BranchID = @BranchID) AND (cashpayables.Status = @Status)");
                cmd = new SqlCommand("SELECT cashpayables.vocherid, cashpayables.Sno,cashpayables.onNameof, cashpayables.Empid,cashpayables.VoucherType, empmanage.EmpName, cashpayables.VocherID, cashpayables.Amount, cashpayables.Remarks,cashpayables.onNameof FROM cashpayables LEFT OUTER JOIN empmanage ON cashpayables.Empid = empmanage.Sno WHERE (cashpayables.BranchID = @BranchID) AND (cashpayables.Status = @Status) and (cashpayables.Approvedby=@ApproveEmp)");
                cmd.Parameters.AddWithValue("@ApproveEmp", context.Session["UserSno"].ToString());
                cmd.Parameters.AddWithValue("@BranchID", context.Session["branch"].ToString());
                cmd.Parameters.AddWithValue("@Status", "R");
            }
            if (LevelType == "AccountsOfficer" || LevelType == "Director")
            {
                string BranchID = context.Request["BranchID"];
                if (status == "R")
                {
                    cmd = new SqlCommand("SELECT cashpayables.vocherid, cashpayables.Sno,cashpayables.onNameof, cashpayables.Empid,cashpayables.VoucherType, empmanage.EmpName, cashpayables.VocherID, cashpayables.Amount, cashpayables.Remarks,cashpayables.onNameof FROM cashpayables LEFT OUTER JOIN empmanage ON cashpayables.Empid = empmanage.Sno WHERE (cashpayables.Status = @Status) AND (cashpayables.BranchID = @BranchID)");
                }
                else
                {
                    cmd = new SqlCommand("SELECT cashpayables.vocherid, cashpayables.Sno, cashpayables.onNameof, cashpayables.Empid, cashpayables.VoucherType, empmanage.EmpName, cashpayables.VocherID,cashpayables.Amount, cashpayables.Remarks FROM cashpayables LEFT OUTER JOIN empmanage ON cashpayables.Empid = empmanage.Sno WHERE (cashpayables.Status = @Status) AND (cashpayables.BranchID = @BranchID) AND (cashpayables.DOE BETWEEN @d1 AND @d2) AND (cashpayables.VoucherType <> @vtype)");
                }
                cmd.Parameters.AddWithValue("@BranchID", BranchID);
                cmd.Parameters.AddWithValue("@d1", GetLowDate(dtFromdate));
                cmd.Parameters.AddWithValue("@d2", GetHighDate(dtTodate));
                cmd.Parameters.AddWithValue("@vtype", "Credit");
                cmd.Parameters.AddWithValue("@Status", status);
            }
            DataTable dtVoucher = vdm.SelectQuery(cmd).Tables[0];
            foreach (DataRow dr in dtVoucher.Rows)
            {
                VoucherClass getVoucher = new VoucherClass();
                getVoucher.VoucherID = dr["sno"].ToString();
                getVoucher.branchvoucherid = dr["vocherid"].ToString();
                getVoucher.EmpName = dr["onNameof"].ToString();
                getVoucher.VoucherType = dr["VoucherType"].ToString();
                double amount = 0;
                double.TryParse(dr["Amount"].ToString(), out amount);
                getVoucher.Amount = amount.ToString("F2");
                getVoucher.Empid = dr["Empid"].ToString();
                getVoucher.Sno = dr["Sno"].ToString();
                Voucherlist.Add(getVoucher);
            }
            string response = GetJson(Voucherlist);
            context.Response.Write(response);
        }
        catch
        {
        }
    }
    class VoucherClass
    {
        public string VoucherID { get; set; }
        public string EmpName { get; set; }
        public string Amount { get; set; }
        public string Empid { get; set; }
        public string Sno { get; set; }
        public string ApproveEmpName { get; set; }
        public string VoucherType { get; set; }
        public string CashTo { get; set; }
        public string Description { get; set; }
        public string ApprovalRemarks { get; set; }
        public string ApprovalAmount { get; set; }
        public string Status { get; set; }
        public string Remarks { get; set; }
        public string ApprovedBy { get; set; }
        public string AccountType { get; set; }
        public string BranchID { get; set; }
        public string Title { get; set; }
        public string auditstatus { get; set; }
        public string branchvoucherid { get; set; }
        public string branchVocherID { get; set; }
    }

    class CashForms
    {
        public string op { set; get; }
        public List<CashDetails> CashDetails { set; get; }
        public string Description { set; get; }
        public string Amount { set; get; }
        public string Remarks { set; get; }
        public string EmpApprove { set; get; }
        public string VoucherType { set; get; }
        public string CashTo { set; get; }
        public string Employee { set; get; }
        public string btnSave { set; get; }
        public string spnVoucherID { set; get; }
        public string AccountType { set; get; }
        public string CashType { set; get; }
        public string ddlBillHead { set; get; }
        public string BranchID { set; get; }
        public string transactiontype { set; get; }
        public string inserntivetype { set; get; }
        public string SalesOfficeid { set; get; }
        public string Routeid { set; get; }
        public string agentid { set; get; }
        public string structureexistornot { set; get; }
        public string frmdate { set; get; }
        public string todate { set; get; }
        public string SalesOfficeName { get; set; }
        public string Routename { get; set; }
        public string Agentname { get; set; }
        public string status { get; set; }
        public string incentivesno { get; set; }
        public string leakpercent { get; set; }
        public string salestype { get; set; }
        public string collectiontype { get; set; }
        public string mobileno { get; set; }
    }

    class CashDetails
    {
        public string SNo { set; get; }
        public string Account { set; get; }
        public string amount { set; get; }
        public string Qty { set; get; }
    }
    private void BtnRaiseVoucherClick(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            var js = new JavaScriptSerializer();
            var title1 = context.Request.Params[1];
            CashForms obj = js.Deserialize<CashForms>(title1);
            string Description = obj.Description;
            string Amount = obj.Amount;
            string Remarks = obj.Remarks;
            string EmpApprove = obj.EmpApprove;
            string VoucherType = obj.VoucherType;
            string CashTo = obj.CashTo;
            string Employee = obj.Employee;
            string btnSave = obj.btnSave;
            string CashType = obj.CashType;
            string transactiontype = obj.transactiontype;
            string BranchID = "0";
            string LevelType = context.Session["LevelType"].ToString();
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
            DateTime dtapril = new DateTime();
            DateTime dtmarch = new DateTime();
            int currentyear = ServerDateCurrentdate.Year;
            int nextyear = ServerDateCurrentdate.Year + 1;
            int backmonth = ServerDateCurrentdate.Month - 1;
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
            if (LevelType == "AccountsOfficer" || LevelType == "Director")
            {
                BranchID = obj.BranchID;
            }
            else
            {
                BranchID = context.Session["branch"].ToString();
            }
            string msg = "";
            if (btnSave == "Raise") //SELECT { fn IFNULL(MAX(mrnno), 0) } + 1 AS mrnno
            {
                cmd = new SqlCommand("SELECT  { fn IFNULL(MAX(VocherID), 0) } + 1 AS VocherID FROM cashpayables WHERE (BranchID = @BranchID) AND (DOR BETWEEN @d1 AND @d2)");
                cmd.Parameters.AddWithValue("@BranchID", BranchID);
                cmd.Parameters.AddWithValue("@d1", GetLowDate(dtapril));
                cmd.Parameters.AddWithValue("@d2", GetHighDate(dtmarch));
                DataTable dtTripId = vdm.SelectQuery(cmd).Tables[0];
                string VocherID = "0";
                if (dtTripId.Rows.Count > 0)
                {
                    VocherID = dtTripId.Rows[0]["VocherID"].ToString();
                }
                else
                {
                    VocherID = "1";
                }
                if (VoucherType == "Credit")
                {
                    cmd = new SqlCommand("Insert into cashpayables (BranchID,CashTo,DOE,VocherID,ApprovalRemarks,ApprovedAmount,onNameof,Status,Created_by,VoucherType,DOR) values (@BranchID,@CashTo,@DOE,@VocherID,@ApprovalRemarks,@ApprovedAmount,@onNameof,@Status,@Created_by,@VoucherType,@DOR)");
                    cmd.Parameters.AddWithValue("@BranchID", BranchID);
                    cmd.Parameters.AddWithValue("@CashTo", CashTo);
                    cmd.Parameters.AddWithValue("@DOE", ServerDateCurrentdate);
                    cmd.Parameters.AddWithValue("@DOR", ServerDateCurrentdate);
                    cmd.Parameters.AddWithValue("@VocherID", VocherID);
                    cmd.Parameters.AddWithValue("@ApprovalRemarks", Remarks);
                    cmd.Parameters.AddWithValue("@ApprovedAmount", Amount);
                    cmd.Parameters.AddWithValue("@onNameof", Description);
                    cmd.Parameters.AddWithValue("@Status", "P");
                    cmd.Parameters.AddWithValue("@Created_by", context.Session["UserSno"].ToString());
                    cmd.Parameters.AddWithValue("@VoucherType", VoucherType);
                    vdm.insert(cmd);
                    // Get Max Sno
                    cmd = new SqlCommand("SELECT MAX(Sno) FROM cashpayables");
                    DataTable dtCashRefno = vdm.SelectQuery(cmd).Tables[0];
                    string CashSno = "0";
                    if (dtCashRefno.Rows.Count > 0)
                    {
                        CashSno = dtCashRefno.Rows[0]["Refno"].ToString();
                    }
                    foreach (CashDetails o in obj.CashDetails)
                    {
                        cmd = new SqlCommand("Insert into Subpayable (RefNo,HeadSno,Amount) values (@RefNo,@HeadSno,@Amount)");
                        cmd.Parameters.AddWithValue("@RefNo", CashSno);
                        cmd.Parameters.AddWithValue("@HeadSno", o.SNo);
                        cmd.Parameters.AddWithValue("@Amount", o.amount);
                        vdm.insert(cmd);
                    }
                    if (CashType == "Cash")
                    {
                        cmd = new SqlCommand("Update BranchAccounts set Amount=Amount-@Amount where BranchID=@BranchID");
                        cmd.Parameters.AddWithValue("@Amount", Amount);
                        cmd.Parameters.AddWithValue("@BranchID", BranchID);
                        vdm.Update(cmd);
                    }
                    cmd = new SqlCommand("Update branch_denomination set amount=amount+@amount,ones=ones+@ones where BranchID=@BranchID");
                    cmd.Parameters.AddWithValue("@amount", Amount);
                    cmd.Parameters.AddWithValue("@ones", Amount);
                    cmd.Parameters.AddWithValue("@BranchID", context.Session["branch"].ToString());
                    vdm.Update(cmd);
                    if (CashType == "Bills")
                    {
                        cmd = new SqlCommand("Insert into cashpayables (BranchID,CashTo,DOE,VocherID,Remarks,Amount,Approvedby,onNameof,Status,Created_by,VoucherType,DOR) values (@BranchID,@CashTo,@DOE,@VocherID,@Remarks,@Amount,@Approvedby,@onNameof,@Status,@Created_by,@VoucherType,@DOR)");
                        cmd.Parameters.AddWithValue("@BranchID", BranchID);
                        cmd.Parameters.AddWithValue("@CashTo", obj.ddlBillHead);
                        cmd.Parameters.AddWithValue("@DOE", ServerDateCurrentdate);
                        cmd.Parameters.AddWithValue("@DOR", ServerDateCurrentdate);
                        cmd.Parameters.AddWithValue("@VocherID", VocherID);
                        cmd.Parameters.AddWithValue("@Remarks", Remarks);
                        cmd.Parameters.AddWithValue("@Amount", Amount);
                        cmd.Parameters.AddWithValue("@Approvedby", EmpApprove);
                        cmd.Parameters.AddWithValue("@onNameof", Description);
                        cmd.Parameters.AddWithValue("@Status", "R");
                        cmd.Parameters.AddWithValue("@Created_by", context.Session["UserSno"].ToString());
                        cmd.Parameters.AddWithValue("@VoucherType", "Debit");
                        long CSno = vdm.insertScalar(cmd);
                        foreach (CashDetails o in obj.CashDetails)
                        {
                            cmd = new SqlCommand("Insert into Subpayable (RefNo,HeadSno,Amount) values (@RefNo,@HeadSno,@Amount)");
                            cmd.Parameters.AddWithValue("@RefNo", CSno);
                            cmd.Parameters.AddWithValue("@HeadSno", o.SNo);
                            cmd.Parameters.AddWithValue("@Amount", o.amount);
                            vdm.insert(cmd);
                        }
                    }
                }
                else
                {
                    if (LevelType == "AccountsOfficer" || LevelType == "Director")
                    {
                        cmd = new SqlCommand("Insert into cashpayables (BranchID,CashTo,DOE,VocherID,Remarks,Amount,Approvedby,onNameof,Status,Created_by,VoucherType,ApprovalRemarks,ApprovedAmount,DOR) values (@BranchID,@CashTo,@DOE,@VocherID,@Remarks,@Amount,@Approvedby,@onNameof,@Status,@Created_by,@VoucherType,@ApprovalRemarks,@ApprovedAmount,@DOR)");
                        cmd.Parameters.AddWithValue("@ApprovalRemarks", Remarks);
                        cmd.Parameters.AddWithValue("@ApprovedAmount", Amount);
                        cmd.Parameters.AddWithValue("@Status", "A");
                        cmd.Parameters.AddWithValue("@Approvedby", context.Session["UserSno"].ToString());
                    }
                    else
                    {
                        cmd = new SqlCommand("Insert into cashpayables (BranchID,CashTo,DOE,VocherID,Remarks,Amount,Approvedby,onNameof,Status,Created_by,VoucherType,DOR) values (@BranchID,@CashTo,@DOE,@VocherID,@Remarks,@Amount,@Approvedby,@onNameof,@Status,@Created_by,@VoucherType,@DOR)");
                        cmd.Parameters.AddWithValue("@Status", "R");
                        cmd.Parameters.AddWithValue("@Approvedby", EmpApprove);
                    }
                    cmd.Parameters.AddWithValue("@BranchID", BranchID);
                    cmd.Parameters.AddWithValue("@CashTo", CashTo);
                    cmd.Parameters.AddWithValue("@DOE", ServerDateCurrentdate);
                    cmd.Parameters.AddWithValue("@DOR", ServerDateCurrentdate);
                    cmd.Parameters.AddWithValue("@VocherID", VocherID);
                    cmd.Parameters.AddWithValue("@Remarks", Remarks);
                    cmd.Parameters.AddWithValue("@Amount", Amount);
                    cmd.Parameters.AddWithValue("@onNameof", Description);
                    cmd.Parameters.AddWithValue("@Created_by", context.Session["UserSno"].ToString());
                    cmd.Parameters.AddWithValue("@VoucherType", VoucherType);
                    vdm.insert(cmd);
                    // Need to cahange
                    cmd = new SqlCommand("SELECT MAX(Sno) as Refno FROM cashpayables");
                    DataTable dtCashRefno = vdm.SelectQuery(cmd).Tables[0];
                    string CashSno = "0";
                    if (dtCashRefno.Rows.Count>0)
                    {
                        CashSno = dtCashRefno.Rows[0]["Refno"].ToString();
                    }
                    foreach (CashDetails o in obj.CashDetails)
                    {
                        cmd = new SqlCommand("Insert into Subpayable (RefNo,HeadSno,Amount) values (@RefNo,@HeadSno,@Amount)");
                        cmd.Parameters.AddWithValue("@RefNo", CashSno);
                        cmd.Parameters.AddWithValue("@HeadSno", o.SNo);
                        cmd.Parameters.AddWithValue("@Amount", o.amount);
                        vdm.insert(cmd);
                    }
                    //if (transactiontype != "Employee" || transactiontype != "Select")
                    //{
                    //    cmd = new SqlCommand("SELECT sno, name, ledgercode FROM othercolletion_name where name=@name");
                    //    cmd.Parameters.AddWithValue("@name", Description);
                    //    DataTable dtothrescollection = vdm.SelectQuery(cmd).Tables[0];
                    //    if (dtothrescollection.Rows.Count > 0)
                    //    {
                    //        string othersid = dtothrescollection.Rows[0]["sno"].ToString();
                    //        cmd = new SqlCommand("update othercolletion_name set  name=@name where sno=@sno");
                    //        cmd.Parameters.AddWithValue("@name", Description);
                    //        cmd.Parameters.AddWithValue("@sno", othersid);
                    //        if (vdm.Update(cmd) == 0)
                    //        {
                    //            cmd = new SqlCommand("insert into othercolletion_name (name)values(@name)");
                    //            cmd.Parameters.AddWithValue("@name", Description);
                    //            vdm.insert(cmd);
                    //        }
                    //    }
                    //    else
                    //    {
                    //        cmd = new SqlCommand("insert into othercolletion_name (name)values(@name)");
                    //        cmd.Parameters.AddWithValue("@name", Description);
                    //        vdm.insert(cmd);
                    //    }
                        
                    //}
                   
                }
                msg = "Voucher raised successfully";
            }
            else
            {
                string VocherID = obj.spnVoucherID;
                cmd = new SqlCommand("Update  cashpayables Set Amount=@Amount,EmpId=@EmpId,Remarks=@Remarks,onNameof=@onNameof,Modify_by=@Modify_by,CashTo=@CashTo,Approvedby=@Approvedby,VoucherType=@VoucherType where Sno=@VocherId and BranchID=@BranchID");
                cmd.Parameters.AddWithValue("@Amount", Amount);
                cmd.Parameters.AddWithValue("@EmpId", Employee);
                cmd.Parameters.AddWithValue("@Remarks", Remarks);
                cmd.Parameters.AddWithValue("@Modify_by", context.Session["UserSno"].ToString());
                cmd.Parameters.AddWithValue("@CashTo", CashTo);
                cmd.Parameters.AddWithValue("@Approvedby", EmpApprove);
                cmd.Parameters.AddWithValue("@VocherId", VocherID);
                cmd.Parameters.AddWithValue("@BranchID", BranchID);
                cmd.Parameters.AddWithValue("@onNameof", Description);
                cmd.Parameters.AddWithValue("@VoucherType", VoucherType);
                vdm.Update(cmd);
                cmd = new SqlCommand("SELECT Sno FROM cashpayables WHERE (BranchID = @BranchID) AND (Sno = @VocherID)");
                cmd.Parameters.AddWithValue("@BranchID", BranchID);
                cmd.Parameters.AddWithValue("@VocherID", VocherID);
                DataTable dtCash = vdm.SelectQuery(cmd).Tables[0];
                if (dtCash.Rows.Count > 0)
                {
                    string CashRefNo = dtCash.Rows[0]["Sno"].ToString();
                    cmd = new SqlCommand("Delete from Subpayable where RefNo=@RefNo");
                    cmd.Parameters.AddWithValue("@RefNo", CashRefNo);
                    vdm.Delete(cmd);
                    foreach (CashDetails o in obj.CashDetails)
                    {
                        cmd = new SqlCommand("Insert into Subpayable (RefNo,HeadSno,Amount) values (@RefNo,@HeadSno,@Amount)");
                        cmd.Parameters.AddWithValue("@RefNo", CashRefNo);
                        cmd.Parameters.AddWithValue("@HeadSno", o.SNo);
                        cmd.Parameters.AddWithValue("@Amount", o.amount);
                        vdm.insert(cmd);
                    }
                }
                msg = "Voucher Updated successfully";
            }
            string response = GetJson(msg);
            context.Response.Write(response);
        }
        catch (Exception ex)
        {
            string msg = ex.Message;
            string response = GetJson(msg);
            context.Response.Write(response);
        }
    }
    class Employee
    {
        public string Sno { get; set; }
        public string UserName { get; set; }
    }

    private void GetApproveEmployeeNames(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            DataTable dtEmployee = new DataTable();
            cmd = new SqlCommand("SELECT Sno, employename FROM employe_details WHERE (BranchID = @BranchID) and (Leveltype='Manager' OR LevelType = 'AccountsOfficer')");
            cmd.Parameters.AddWithValue("@BranchID", context.Session["branch"].ToString());
            dtEmployee = vdm.SelectQuery(cmd).Tables[0];
            List<Employee> Employeelist = new List<Employee>();
            foreach (DataRow dr in dtEmployee.Rows)
            {
                Employee b = new Employee() { Sno = dr["Sno"].ToString(), UserName = dr["employename"].ToString() };
                Employeelist.Add(b);
            }
            cmd = new SqlCommand("SELECT Sno, employename FROM employe_details WHERE (LevelType = 'AccountsOfficer') AND (BranchID = @SuperBranch)");
            cmd.Parameters.AddWithValue("@SuperBranch", context.Session["SuperBranch"].ToString());
            DataTable dtDirector = vdm.SelectQuery(cmd).Tables[0];
            foreach (DataRow dr in dtDirector.Rows)
            {
                Employee b = new Employee() { Sno = dr["Sno"].ToString(), UserName = dr["employename"].ToString() };
                Employeelist.Add(b);
            }
            string response = GetJson(Employeelist);
            context.Response.Write(response);
        }
        catch
        {
        }
    }


    //private void get_company_details(HttpContext context)
    //{
    //    try
    //    {
    //        vdm = new SalesDBManager();
    //        string SalesType = context.Session["salestype"].ToString();
    //        List<SoClass> Solist = new List<SoClass>();
    //        if (SalesType == "Plant")
    //        {
    //            cmd = new SqlCommand("SELECT branchdata.sno, branchdata.BranchName,branchdata.Address FROM branchmappingtable INNER JOIN branchdata ON branchmappingtable.SubBranch = branchdata.sno where  (branchmappingtable.SuperBranch=@BranchID) AND (branchdata.SALESTYPE=@st) AND (branchdata.flag=@flag)");
    //            cmd.Parameters.AddWithValue("@st", "4");
    //            cmd.Parameters.AddWithValue("@BranchId", context.Session["branch"].ToString());
    //            cmd.Parameters.AddWithValue("@flag", "1");

    //            DataTable dtBranch = vdm.SelectQuery(cmd).Tables[0];
    //            foreach (DataRow dr in dtBranch.Rows)
    //            {
    //                SoClass GetSoClass = new SoClass();
    //                GetSoClass.Sno = dr["sno"].ToString();
    //                GetSoClass.BranchName = dr["BranchName"].ToString();
    //                GetSoClass.Address = dr["Address"].ToString();
    //                Solist.Add(GetSoClass);
    //            }
    //            cmd = new SqlCommand("SELECT BranchName,sno,Address FROM  branchdata WHERE (sno = @BranchID)");
    //            cmd.Parameters.AddWithValue("@BranchID", context.Session["branch"].ToString());
    //            DataTable dtPlant = vdm.SelectQuery(cmd).Tables[0];
    //            foreach (DataRow dr in dtPlant.Rows)
    //            {
    //                SoClass GetSoClass = new SoClass();
    //                GetSoClass.Sno = dr["sno"].ToString();
    //                GetSoClass.BranchName = dr["BranchName"].ToString();
    //                GetSoClass.Address = dr["Address"].ToString();
    //                Solist.Add(GetSoClass);
    //            }
    //            cmd = new SqlCommand("SELECT branchdata.BranchName, branchdata.sno,branchdata.Address FROM branchdata INNER JOIN branchmappingtable ON branchdata.sno = branchmappingtable.SubBranch WHERE (branchmappingtable.SuperBranch = @SuperBranch) and (branchdata.SalesType=@SalesType)  ");
    //            cmd.Parameters.AddWithValue("@SuperBranch", context.Session["branch"].ToString());
    //            cmd.Parameters.AddWithValue("@SalesType", "23");
    //            DataTable dtNewPlant = vdm.SelectQuery(cmd).Tables[0];
    //            foreach (DataRow dr in dtNewPlant.Rows)
    //            {
    //                SoClass GetSoClass = new SoClass();
    //                GetSoClass.Sno = dr["sno"].ToString();
    //                GetSoClass.BranchName = dr["BranchName"].ToString();
    //                GetSoClass.Address = dr["Address"].ToString();
    //                Solist.Add(GetSoClass);
    //            }

    //            string errresponse = GetJson(Solist);
    //            context.Response.Write(errresponse);
    //        }

    //        else
    //        {
    //            cmd = new SqlCommand("SELECT BranchName, sno FROM  branchdata WHERE (sno = @BranchID)");
    //            cmd.Parameters.AddWithValue("@BranchID", context.Session["branch"].ToString());
    //            DataTable dtPlant = vdm.SelectQuery(cmd).Tables[0];
    //            foreach (DataRow dr in dtPlant.Rows)
    //            {
    //                SoClass GetSoClass = new SoClass();
    //                GetSoClass.Sno = dr["sno"].ToString();
    //                GetSoClass.BranchName = dr["BranchName"].ToString();
    //                Solist.Add(GetSoClass);
    //            }
    //            string errresponse = GetJson(Solist);
    //            context.Response.Write(errresponse);
    //        }
    //    }
    //    catch
    //    {
    //    }
    //}

    private void GetHeadNames(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            List<HeadClass> HeadClasslist = new List<HeadClass>();
            string BranchID = "0";
            string LevelType = context.Session["LevelType"].ToString();
            if (LevelType == "AccountsOfficer" || LevelType == "Director")
            {
                BranchID = context.Request["BranchID"];
            }
            else
            {
                BranchID = context.Session["branch"].ToString();
            }
            cmd = new SqlCommand("Select Sno,HeadName,LimitAmount,AccountType,AgentID,EmpID from accountheads Where (BranchID=@BranchID) and (flag=@flag)  order by HeadName");
            cmd.Parameters.AddWithValue("@BranchID", BranchID);
            cmd.Parameters.AddWithValue("@flag", "1");
            DataTable dtVehicle = vdm.SelectQuery(cmd).Tables[0];
            foreach (DataRow dr in dtVehicle.Rows)
            {
                HeadClass getVehicles = new HeadClass();
                getVehicles.Sno = dr["Sno"].ToString();
                getVehicles.HeadName = dr["HeadName"].ToString();
                getVehicles.Limit = dr["LimitAmount"].ToString();
                HeadClasslist.Add(getVehicles);
            }
            string response = GetJson(HeadClasslist);
            context.Response.Write(response);
        }
        catch
        {
        }
    }


    public class SoClass
    {
        public string BranchName { get; set; }
        public string Sno { get; set; }
        public string Salestype { get; set; }
        public string color { get; set; }
        public string ExpencePeriod { get; set; }
        public string mobile { get; set; }
        public string Address { get; set; }
        public string routeid { get; set; }
    }
    private void GetAllSalesOffice(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();

            List<SoClass> Solist = new List<SoClass>();
            //string BranchID = context.Session["branch"].ToString();

            DataTable dtBranch = new DataTable();
            dtBranch.Columns.Add("BranchName");
            dtBranch.Columns.Add("sno");
            //cmd = new  SqlCommand("SELECT branchdata.BranchName, branchdata.sno FROM branchdata INNER JOIN branchmappingtable ON branchdata.sno = branchmappingtable.SubBranch WHERE (branchmappingtable.SuperBranch = @SuperBranch) and (branchdata.SalesType=@SalesType)  ");
            //cmd.Parameters.AddWithValue("@SuperBranch", BranchID);
            //cmd.Parameters.AddWithValue("@SalesType", "4");
            //cmd.Parameters.AddWithValue("@SalesType1", "26");
            //DataTable dtRoutedata = vdm.SelectQuery(cmd).Tables[0];
            //foreach (DataRow dr in dtRoutedata.Rows)
            //{
            //    DataRow newrow = dtBranch.NewRow();
            //    newrow["BranchName"] = dr["BranchName"].ToString();
            //    newrow["sno"] = dr["sno"].ToString();
            //    dtBranch.Rows.Add(newrow);
            //}
            cmd = new SqlCommand("select branchid, BranchName from branchmaster");
            DataTable dtPlant = vdm.SelectQuery(cmd).Tables[0];
            foreach (DataRow dr in dtPlant.Rows)
            {
                DataRow newrow = dtBranch.NewRow();
                newrow["BranchName"] = dr["BranchName"].ToString();
                newrow["sno"] = dr["Branchid"].ToString();
                dtBranch.Rows.Add(newrow);
            }
            foreach (DataRow dr in dtBranch.Rows)
            {
                SoClass GetSoClass = new SoClass();
                GetSoClass.Sno = dr["sno"].ToString();
                GetSoClass.BranchName = dr["BranchName"].ToString();
                Solist.Add(GetSoClass);
            }
            string errresponse = GetJson(Solist);
            context.Response.Write(errresponse);
        }
        catch (Exception ex)
        {

        }
    }

    private void SaveHeadMasterClick(HttpContext context)
    {

        try
        {
            vdm = new SalesDBManager();
            string HeadAccount = context.Request["Decription"];
            string serial = context.Request["serial"];
            string AccountType = context.Request["AccountType"];
            string btnSave = context.Request["btnSave"];
            string Limit = context.Request["Limit"];
            string EMPID = context.Request["EMPID"];
            string BranchID = context.Request["BranchID"];
            string Ledgercode = context.Request["Ledgercode"];
            string flag = context.Request["flag"];
            double LimitAmount = 0;
            double.TryParse(Limit, out LimitAmount);
            if (btnSave == "MODIFY")
            {
                if (AccountType == "Others")
                {
                    cmd = new SqlCommand("Update accountheads set flag=@flag,  HeadName=@HeadName,LimitAmount=@LimitAmount,AccountType=@AccountType,accountcode=@accountcode where Sno=@Sno");
                    cmd.Parameters.AddWithValue("@AccountType", AccountType);
                }
                cmd.Parameters.AddWithValue("@HeadName", HeadAccount);
                cmd.Parameters.AddWithValue("@LimitAmount", LimitAmount);
                cmd.Parameters.AddWithValue("@accountcode", Ledgercode);
                cmd.Parameters.AddWithValue("@flag", flag);
                cmd.Parameters.AddWithValue("@Sno", serial);
                vdm.Update(cmd);
                string Msg = "Account Name Updated Successfully";
                string response = GetJson(Msg);
                context.Response.Write(response);
            }
            else
            {
                if (BranchID == "")
                {
                    string LevelType = context.Session["LevelType"].ToString();
                    if (LevelType == "AccountsOfficer" || LevelType == "Director")
                    {
                        AccountType = "Others";
                        cmd = new SqlCommand("Insert Into accountheads (HeadName,LimitAmount,AccountType,accountcode,flag) values(@HeadName,@LimitAmount,@AccountType,@accountcode,@flag)");
                        cmd.Parameters.AddWithValue("@AccountType", AccountType);
                        cmd.Parameters.AddWithValue("@HeadName", HeadAccount);
                        cmd.Parameters.AddWithValue("@LimitAmount", LimitAmount);
                        cmd.Parameters.AddWithValue("@accountcode", Ledgercode);
                        cmd.Parameters.AddWithValue("@flag", flag);
                        vdm.insert(cmd);
                        string Msg = "Account Name saved Successfully";
                        string response = GetJson(Msg);
                        context.Response.Write(response);
                    }
                    else
                    {
                        string Msg = "Please Select SalesOffice";
                        string response = GetJson(Msg);
                        context.Response.Write(response);
                    }
                }
                else
                {
                    if (AccountType == "Others")
                    {
                        cmd = new SqlCommand("Insert Into accountheads (HeadName,BranchID,LimitAmount,AccountType,accountcode,flag) values(@HeadName,@BranchID,@LimitAmount,@AccountType,@accountcode,@flag)");
                        cmd.Parameters.AddWithValue("@AccountType", AccountType);
                        cmd.Parameters.AddWithValue("@accountcode", Ledgercode);
                    }
                    cmd.Parameters.AddWithValue("@flag", flag);
                    cmd.Parameters.AddWithValue("@HeadName", HeadAccount);
                    cmd.Parameters.AddWithValue("@LimitAmount", LimitAmount);
                    cmd.Parameters.AddWithValue("@BranchID", BranchID);
                    vdm.insert(cmd);
                    string Msg = "Account Name saved Successfully";
                    string response = GetJson(Msg);
                    context.Response.Write(response);
                }
            }
        }
        catch (Exception ex)
        {
            string Msg = ex.Message;
            string response = GetJson(Msg);
            context.Response.Write(response);
        }
    }


    private void GetHeadOfAccounts(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            string branchid = context.Request["BranchID"];
            string LevelType = context.Session["LevelType"].ToString();
            if (LevelType == "AccountsOfficer" || LevelType == "Director")
            {
                if (branchid == "")
                {
                    cmd = new SqlCommand("SELECT Sno, HeadName, LimitAmount, AccountType, AgentID, EmpID,accountcode,flag FROM accountheads WHERE (BranchId IS NULL) ORDER BY HeadName");
                }
                else
                {
                    cmd = new SqlCommand("Select Sno,HeadName,LimitAmount,AccountType,AgentID,EmpID,accountcode,flag from accountheads Where BranchID=@BranchID order by HeadName");
                    cmd.Parameters.AddWithValue("@BranchID", branchid);
                }
            }
            else
            {
                cmd = new SqlCommand("Select Sno,HeadName,LimitAmount,AccountType,AgentID,EmpID,accountcode,flag from accountheads Where BranchID=@BranchID order by HeadName");
                cmd.Parameters.AddWithValue("@BranchID", branchid);
            }
            DataTable dtVehicle = vdm.SelectQuery(cmd).Tables[0];
            List<HeadClass> HeadClasslist = new List<HeadClass>();
            foreach (DataRow dr in dtVehicle.Rows)
            {
                HeadClass getVehicles = new HeadClass();
                getVehicles.Sno = dr["Sno"].ToString();
                getVehicles.HeadName = dr["HeadName"].ToString();
                getVehicles.Limit = dr["LimitAmount"].ToString();
                getVehicles.flag = dr["flag"].ToString();
                getVehicles.accountcode = dr["accountcode"].ToString();
                string AccountType = dr["AccountType"].ToString();
                getVehicles.AccountType = AccountType;
                if (AccountType == "Others")
                {
                    getVehicles.Code = "0";
                }
                HeadClasslist.Add(getVehicles);
            }
            string response = GetJson(HeadClasslist);
            context.Response.Write(response);
        }
        catch
        {
        }
    }
    class HeadClass
    {
        public string Sno { get; set; }
        public string HeadName { get; set; }
        public string Limit { get; set; }
        public string AccountType { get; set; }
        public string accountcode { get; set; }
        public string Code { get; set; }
        public string flag { get; set; }
    }


    public class empdetails
    {
        public string username { get; set; }
        public string sno { get; set; }
        public string branchid { get; set; }
    }
    private void get_userlogin(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            string branchid = "1";
            string username = context.Request["username"].ToString();
            string pwd = context.Request["passward"].ToString();
            cmd = new SqlCommand("SELECT sno, employename, userid, password, emailid, phone, branchtype, leveltype, departmentid, branchid  FROM employe_details where userid=@username AND password=@pwd");
            cmd.Parameters.Add("@username", username);
            cmd.Parameters.Add("@pwd", pwd);
            DataTable routes = vdm.SelectQuery(cmd).Tables[0];
            List<empdetails> ProductDetails = new List<empdetails>();
            if (routes.Rows.Count > 0)
            {
                foreach (DataRow dr in routes.Rows)
                {
                    empdetails getproductdetails = new empdetails();
                    getproductdetails.sno = dr["sno"].ToString();
                    context.Session["userid"] = dr["sno"].ToString();
                    context.Session["username"] = dr["employename"].ToString();
                    getproductdetails.username = dr["employename"].ToString();
                    getproductdetails.branchid = dr["branchid"].ToString();
                    context.Session["branchid"] = dr["branchid"].ToString();
                    ProductDetails.Add(getproductdetails);
                }
                string response = GetJson(ProductDetails);
                context.Response.Write(response);
            }
            else
            {
                string response = GetJson(ProductDetails);
                context.Response.Write(response);
            }

        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    public class ProductDetails
    {
        public string productname { get; set; }
        public string description { get; set; }
        public string subcatname { get; set; }
        public string sku { get; set; }
        public string category { get; set; }
        public string categoryid { get; set; }
        public string categoryname { get; set; }
        public string productcode { get; set; }
        public string shortname { get; set; }
        public string modifierset { get; set; }
        public string availablestores { get; set; }
        public string color { get; set; }
        public string uim { get; set; }
        public string subcategoryid { get; set; }
        public string subcategoryname { get; set; }
        public string brandid { get; set; }
        public string supplierid { get; set; }
        public string supplier { get; set; }
        public string price { get; set; }
        public string mrp { get; set; }
        public string moniterqty { get; set; }
        public string puim { get; set; }
        public string sectionid { get; set; }
        public string productid { get; set; }
        public string minstock { get; set; }
        public string maxstock { get; set; }
        public string imagepath { get; set; }
        public string ftplocation { get; set; }
        public string availablestores1 { get; set; }
        public string hsncode { get; set; }
        public string sgst { get; set; }
        public string cgst { get; set; }
        public string igst { get; set; }
        public string gst_tax_cat { get; set; }
        public string billingprice { get; set; }
        public string GSTTaxCategory { get; set; }
        public string status { get; set; }
    }

    private void saveitemdetails(HttpContext context)
    {
        try
        {

            vdm = new SalesDBManager();
            string category = context.Request["category"];
            string subcategory = context.Request["subcategory"];
            string uom = context.Request["uom"];
            string itemname = context.Request["itemname"];
            string sku = context.Request["sku"];
            string billingprice = context.Request["billingprice"];
            string mrp = context.Request["mrp"];
            string hsncode = context.Request["hsncode"];
            string igst = context.Request["igst"];
            string cgst = context.Request["cgst"];
            string sgst = context.Request["sgst"];
            string discription = context.Request["discription"];
            string gsttaxtype = context.Request["gsttaxtype"];
            string Status = context.Request["Status"];
            string btnSave = context.Request["btnVal"];
            string sno = context.Request["sno"];
            string branchid = context.Session["BranchID"].ToString();
            string createdby = context.Session["Employ_Sno"].ToString();
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
            if (btnSave == "Save")
            {
                cmd = new SqlCommand("insert into productmaster ( categoryid,  subcategoryid, uim,  productname, billingprice, price,  productcode, hsncode, sub_cat_code, sku, description, igst, cgst, sgst, gsttaxcategory, status, createdby, createdon, supplierid) values (@category, @subcategory, @uom, @itemname, @billingprice, @mrp, @hsncode, @hsncodee, @subcatcode,@sku,@discription,@igst,@cgst,@sgst,@gsttaxtype,@Status, @createdby, @createdon, @supplierid)");//,color,@color
                cmd.Parameters.Add("@category", category);
                cmd.Parameters.Add("@subcategory", subcategory);
                cmd.Parameters.Add("@uom", uom);
                cmd.Parameters.Add("@itemname", itemname);
                cmd.Parameters.Add("@billingprice", billingprice);
                cmd.Parameters.Add("@mrp", mrp);
                cmd.Parameters.Add("@hsncode", hsncode);
                cmd.Parameters.Add("@hsncodee", hsncode);
                cmd.Parameters.Add("@subcatcode", subcategory);
                cmd.Parameters.Add("@sku", sku);
                cmd.Parameters.Add("@discription", discription);
                cmd.Parameters.Add("@igst", igst);
                cmd.Parameters.Add("@cgst", cgst);
                cmd.Parameters.Add("@sgst", sgst);
                cmd.Parameters.Add("@gsttaxtype", gsttaxtype);
                cmd.Parameters.Add("@Status", Status);
                cmd.Parameters.Add("@createdby", createdby);
                cmd.Parameters.Add("@createdon", ServerDateCurrentdate);
                cmd.Parameters.Add("@supplierid", "1");
                vdm.insert(cmd);
                cmd = new SqlCommand("select MAX(productid) as productid from productmaster");
                DataTable dtproduct = vdm.SelectQuery(cmd).Tables[0];
                string productid = dtproduct.Rows[0]["productid"].ToString();

                cmd = new SqlCommand("insert into productmoniter( productid, qty, price, branchid, minstock, maxsstock) values (@productid, @mqty, @mprice,@mbranchid,@minstock,@maxstock)");
                cmd.Parameters.Add("@productid", productid);
                cmd.Parameters.Add("@mqty", "0");
                cmd.Parameters.Add("@mprice", billingprice);
                cmd.Parameters.Add("@mbranchid", branchid);
                cmd.Parameters.Add("@minstock", "1");
                cmd.Parameters.Add("@maxstock", "100");
                vdm.insert(cmd);

                string Response = GetJson("Item Details are Successfully Inserted");
                context.Response.Write(Response);
            }
            else
            {
                cmd = new SqlCommand("UPDATE productmaster SET categoryid = @category,  subcategoryid = @subcategory, uim=@uom,  productname=@itemname, billingprice=@billingprice, price=@mrp,  productcode=@hsncode, hsncode=@hsncodee, sub_cat_code=@subcatcode, sku=@sku, description=@discription, igst=@igst, cgst=@cgst, sgst=@sgst, gsttaxcategory=@gsttaxtype, status=@Status, modifiedon=@createdon, modifiedby=@createdby WHERE productid=@sno");//,color,@color
                cmd.Parameters.Add("@category", category);
                cmd.Parameters.Add("@subcategory", subcategory);
                cmd.Parameters.Add("@uom", uom);
                cmd.Parameters.Add("@itemname", itemname);
                cmd.Parameters.Add("@billingprice", billingprice);
                cmd.Parameters.Add("@mrp", mrp);
                cmd.Parameters.Add("@hsncode", hsncode);
                cmd.Parameters.Add("@hsncodee", hsncode);
                cmd.Parameters.Add("@subcatcode", subcategory);
                cmd.Parameters.Add("@sku", sku);
                cmd.Parameters.Add("@discription", discription);
                cmd.Parameters.Add("@igst", igst);
                cmd.Parameters.Add("@cgst", cgst);
                cmd.Parameters.Add("@sgst", sgst);
                cmd.Parameters.Add("@gsttaxtype", gsttaxtype);
                cmd.Parameters.Add("@Status", Status);
                cmd.Parameters.Add("@createdby", createdby);
                cmd.Parameters.Add("@createdon", ServerDateCurrentdate);
                cmd.Parameters.Add("@sno", sno);
                vdm.Update(cmd);

                cmd = new SqlCommand("UPDATE productmoniter SET price=@mprice where productid=@productid and  branchid=@branchid");
                cmd.Parameters.Add("@productid", sno);
                cmd.Parameters.Add("@mqty", "0");
                cmd.Parameters.Add("@mprice", billingprice);
                cmd.Parameters.Add("@branchid", branchid);
                cmd.Parameters.Add("@minstock", "1");
                cmd.Parameters.Add("@maxstock", "100");
                vdm.Update(cmd);

                string Response = GetJson("Item Details are Successfully Modified");
                context.Response.Write(Response);
            }
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    private void get_product_details(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            string branchid = context.Session["BranchID"].ToString();
            string subcatid = context.Request["subcatid"].ToString();
            if (subcatid == "0")
            {
                cmd = new SqlCommand("SELECT productmaster.productid, productmaster.categoryid,productmaster.price as mrp, productmaster.imagepath, productmaster.subcategoryid, productmaster.uim AS Puim,  productmaster.productname, productmaster.billingprice,   productmaster.productcode, productmaster.hsncode, productmaster.sub_cat_code, productmaster.sku, productmaster.description, productmaster.igst, productmaster.cgst, productmaster.sgst, productmaster.gsttaxcategory, productmaster.status, productmaster.createdby, productmaster.createdon, uimmaster.uim, productmoniter.qty, productmoniter.price, categorymaster.category, subcategorymaster.subcategoryname, productmaster.supplierid  FROM productmaster INNER JOIN productmoniter ON productmaster.productid=productmoniter.productid INNER JOIN categorymaster ON productmaster.categoryid = categorymaster.categoryid INNER JOIN subcategorymaster ON productmaster.subcategoryid = subcategorymaster.subcategoryid LEFT OUTER JOIN uimmaster ON uimmaster.sno=productmaster.uim  WHERE (productmoniter.branchid = @branchid)");
            }
            else
            {
                cmd = new SqlCommand("SELECT productmaster.productid, productmaster.categoryid,productmaster.price as mrp, productmaster.imagepath, productmaster.subcategoryid, productmaster.uim AS Puim,  productmaster.productname, productmaster.billingprice,   productmaster.productcode, productmaster.hsncode, productmaster.sub_cat_code, productmaster.sku, productmaster.description, productmaster.igst, productmaster.cgst, productmaster.sgst, productmaster.gsttaxcategory, productmaster.status, productmaster.createdby, productmaster.createdon, uimmaster.uim, productmoniter.qty, productmoniter.price, categorymaster.category, subcategorymaster.subcategoryname, productmaster.supplierid  FROM productmaster INNER JOIN productmoniter ON productmaster.productid=productmoniter.productid INNER JOIN categorymaster ON productmaster.categoryid = categorymaster.categoryid INNER JOIN subcategorymaster ON productmaster.subcategoryid = subcategorymaster.subcategoryid LEFT OUTER JOIN uimmaster ON uimmaster.sno=productmaster.uim  WHERE (productmoniter.branchid = @branchid) AND (productmaster.subcategoryid=@subcatid)");
                cmd.Parameters.Add("@subcatid", subcatid);
            }// cmd = new SqlCommand("SELECT productmaster.hsncode, productmaster.sgst, productmaster.cgst, productmaster.igst, productmaster.imagepath, productmaster.productid, productmaster.subcategoryid, productmoniter.qty, productmaster.productname, productmaster.productcode,  productmaster.sub_cat_code,  productmaster.sku,  productmaster.description, productmaster.supplierid,  productmaster.modifierset,uimmaster.uim, productmaster.availablestores,  productmaster.color,  productmaster.uim AS puim,  productmaster.price FROM  productmaster  INNER JOIN productmoniter ON productmaster.productid=productmoniter.productid LEFT OUTER JOIN uimmaster ON uimmaster.sno=productmaster.uim  WHERE (productmoniter.branchid = @branchid)");
            cmd.Parameters.Add("@branchid", branchid);
            DataTable routes = vdm.SelectQuery(cmd).Tables[0];
            List<ProductDetails> ProductDetails = new List<ProductDetails>();
            foreach (DataRow dr in routes.Rows)
            {
                ProductDetails getproductdetails = new ProductDetails();
                getproductdetails.categoryid = dr["categoryid"].ToString();
                getproductdetails.subcategoryid = dr["subcategoryid"].ToString();
                getproductdetails.category = dr["category"].ToString();
                getproductdetails.subcategoryname = dr["subcategoryname"].ToString();
                getproductdetails.productname = dr["productname"].ToString();
                getproductdetails.productcode = dr["productcode"].ToString();
                getproductdetails.shortname = dr["sub_cat_code"].ToString();
                getproductdetails.sku = dr["sku"].ToString();
                getproductdetails.description = dr["description"].ToString();
                getproductdetails.supplierid = dr["supplierid"].ToString();
                // getproductdetails.modifierset = dr["modifierset"].ToString();
                double quantity = Convert.ToDouble(dr["qty"].ToString());
                quantity = Math.Round(quantity, 2);
                getproductdetails.moniterqty = quantity.ToString();
                // getproductdetails.availablestores1 = dr["availablestores"].ToString();
                // getproductdetails.color = dr["color"].ToString();
                getproductdetails.uim = dr["uim"].ToString();
                getproductdetails.puim = dr["Puim"].ToString();
                getproductdetails.hsncode = dr["hsncode"].ToString();
                getproductdetails.sgst = dr["sgst"].ToString();
                getproductdetails.cgst = dr["cgst"].ToString();
                getproductdetails.igst = dr["igst"].ToString();
                getproductdetails.mrp = dr["mrp"].ToString();
                getproductdetails.price = dr["price"].ToString();
                getproductdetails.productid = dr["productid"].ToString();
                getproductdetails.subcategoryid = dr["subcategoryid"].ToString();
                // getproductdetails.imagepath = dr["imagepath"].ToString();
                getproductdetails.billingprice = dr["price"].ToString();
                getproductdetails.GSTTaxCategory = dr["gsttaxcategory"].ToString();
                getproductdetails.ftplocation = "ftp://223.196.32.30/PURCHASE/";
                getproductdetails.status = dr["status"].ToString();
                ProductDetails.Add(getproductdetails);
            }
            string response = GetJson(ProductDetails);
            context.Response.Write(response);
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }


    private void get_distibutorproduct_details(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            string branchid = context.Session["BranchID"].ToString();
            string subcatid = context.Request["subcatid"].ToString();
            string distibutorid = context.Request["distibutorid"].ToString();
            if (subcatid == "0")
            {
                cmd = new SqlCommand("SELECT productmaster.productid, productmaster.categoryid, productmaster.imagepath, productmaster.subcategoryid, productmaster.uim AS Puim,  productmaster.productname, productmaster.billingprice,   productmaster.productcode, productmaster.hsncode, productmaster.sub_cat_code, productmaster.sku, productmaster.description, productmaster.igst, productmaster.cgst, productmaster.sgst, productmaster.gsttaxcategory, productmaster.status, productmaster.createdby, productmaster.createdon, uimmaster.uim, productmoniter.qty, productmoniter.price, categorymaster.category, subcategorymaster.subcategoryname, productmaster.supplierid  FROM productmaster INNER JOIN productmoniter ON productmaster.productid=productmoniter.productid INNER JOIN categorymaster ON productmaster.categoryid = categorymaster.categoryid INNER JOIN subcategorymaster ON productmaster.subcategoryid = subcategorymaster.subcategoryid LEFT OUTER JOIN uimmaster ON uimmaster.sno=productmaster.uim  WHERE (productmoniter.branchid = @branchid)");
            }
            else
            {
                cmd = new SqlCommand("SELECT productmaster.productid, productmaster.categoryid, productmaster.imagepath, productmaster.subcategoryid, productmaster.uim AS Puim,  productmaster.productname, productmaster.billingprice,   productmaster.productcode, productmaster.hsncode, productmaster.sub_cat_code, productmaster.sku, productmaster.description, productmaster.igst, productmaster.cgst, productmaster.sgst, productmaster.gsttaxcategory, productmaster.status, productmaster.createdby, productmaster.createdon, uimmaster.uim, productmoniter.qty, productmoniter.price, categorymaster.category, subcategorymaster.subcategoryname, productmaster.supplierid  FROM productmaster INNER JOIN productmoniter ON productmaster.productid=productmoniter.productid INNER JOIN categorymaster ON productmaster.categoryid = categorymaster.categoryid INNER JOIN subcategorymaster ON productmaster.subcategoryid = subcategorymaster.subcategoryid LEFT OUTER JOIN uimmaster ON uimmaster.sno=productmaster.uim  WHERE (productmoniter.branchid = @branchid) AND (productmaster.subcategoryid=@subcatid)");
                cmd.Parameters.Add("@subcatid", subcatid);
            }// cmd = new SqlCommand("SELECT productmaster.hsncode, productmaster.sgst, productmaster.cgst, productmaster.igst, productmaster.imagepath, productmaster.productid, productmaster.subcategoryid, productmoniter.qty, productmaster.productname, productmaster.productcode,  productmaster.sub_cat_code,  productmaster.sku,  productmaster.description, productmaster.supplierid,  productmaster.modifierset,uimmaster.uim, productmaster.availablestores,  productmaster.color,  productmaster.uim AS puim,  productmaster.price FROM  productmaster  INNER JOIN productmoniter ON productmaster.productid=productmoniter.productid LEFT OUTER JOIN uimmaster ON uimmaster.sno=productmaster.uim  WHERE (productmoniter.branchid = @branchid)");
            cmd.Parameters.Add("@branchid", branchid);
            DataTable routes = vdm.SelectQuery(cmd).Tables[0];

            cmd = new SqlCommand("SELECT sno, distibutorid, price, I_createdby, doe, productid  FROM    distibutorratemoniter Where distibutorid=@distibutorid");
            cmd.Parameters.Add("@distibutorid", distibutorid);
            DataTable distibutoritems = vdm.SelectQuery(cmd).Tables[0];

            List<ProductDetails> ProductDetails = new List<ProductDetails>();
            foreach (DataRow dr in routes.Rows)
            {
                string price = "";
                ProductDetails getproductdetails = new ProductDetails();
                getproductdetails.categoryid = dr["categoryid"].ToString();
                getproductdetails.subcategoryid = dr["subcategoryid"].ToString();
                getproductdetails.category = dr["category"].ToString();
                getproductdetails.subcategoryname = dr["subcategoryname"].ToString();
                getproductdetails.productname = dr["productname"].ToString();
                getproductdetails.productcode = dr["productcode"].ToString();
                getproductdetails.shortname = dr["sub_cat_code"].ToString();
                getproductdetails.sku = dr["sku"].ToString();
                getproductdetails.description = dr["description"].ToString();
                getproductdetails.supplierid = dr["supplierid"].ToString();
                // getproductdetails.modifierset = dr["modifierset"].ToString();
                double quantity = Convert.ToDouble(dr["qty"].ToString());
                quantity = Math.Round(quantity, 2);
                getproductdetails.moniterqty = quantity.ToString();
                // getproductdetails.availablestores1 = dr["availablestores"].ToString();
                // getproductdetails.color = dr["color"].ToString();
                getproductdetails.uim = dr["uim"].ToString();
                getproductdetails.puim = dr["Puim"].ToString();
                getproductdetails.hsncode = dr["hsncode"].ToString();
                getproductdetails.sgst = dr["sgst"].ToString();
                getproductdetails.cgst = dr["cgst"].ToString();
                getproductdetails.igst = dr["igst"].ToString();
                foreach (DataRow dra in distibutoritems.Select("productid='" + dr["productid"].ToString() + "'"))
                {
                    price = dra["price"].ToString();
                }
                getproductdetails.price = price;
                getproductdetails.productid = dr["productid"].ToString();
                getproductdetails.subcategoryid = dr["subcategoryid"].ToString();
                // getproductdetails.imagepath = dr["imagepath"].ToString();
                getproductdetails.billingprice = dr["billingprice"].ToString();
                getproductdetails.GSTTaxCategory = dr["gsttaxcategory"].ToString();
                getproductdetails.ftplocation = "ftp://223.196.32.30/PURCHASE/";
                getproductdetails.status = dr["status"].ToString();
                ProductDetails.Add(getproductdetails);
            }
            string response = GetJson(ProductDetails);
            context.Response.Write(response);
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }



    private void get_productwise_details(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            string branchid = context.Session["BranchID"].ToString();
            string productid = context.Request["productid"].ToString();
            cmd = new SqlCommand("SELECT productmaster.hsncode, productmaster.sgst, productmaster.cgst, productmaster.igst, productmaster.imagepath, productmaster.productid, productmaster.subcategoryid, productmoniter.qty, productmaster.productname, productmaster.productcode,  productmaster.sub_cat_code,  productmaster.sku,  productmaster.description, productmaster.supplierid,  productmaster.modifierset,uimmaster.uim, productmaster.availablestores,  productmaster.color,  productmaster.uim AS puim,  productmaster.price FROM  productmaster  INNER JOIN productmoniter ON productmaster.productid=productmoniter.productid LEFT OUTER JOIN uimmaster ON uimmaster.sno=productmaster.uim  WHERE (productmoniter.branchid = @branchid) AND (productmoniter.productid = @productid)");
            cmd.Parameters.Add("@branchid", branchid);
            DataTable routes = vdm.SelectQuery(cmd).Tables[0];
            List<ProductDetails> ProductDetails = new List<ProductDetails>();
            foreach (DataRow dr in routes.Rows)
            {
                ProductDetails getproductdetails = new ProductDetails();
                getproductdetails.productname = dr["productname"].ToString();
                getproductdetails.productcode = dr["productcode"].ToString();
                getproductdetails.shortname = dr["sub_cat_code"].ToString();
                getproductdetails.sku = dr["sku"].ToString();
                getproductdetails.description = dr["description"].ToString();
                getproductdetails.supplierid = dr["supplierid"].ToString();
                getproductdetails.modifierset = dr["modifierset"].ToString();
                double quantity = Convert.ToDouble(dr["qty"].ToString());
                quantity = Math.Round(quantity, 2);
                getproductdetails.moniterqty = quantity.ToString();
                getproductdetails.availablestores1 = dr["availablestores"].ToString();
                getproductdetails.color = dr["color"].ToString();
                getproductdetails.uim = dr["uim"].ToString();
                getproductdetails.puim = dr["puim"].ToString();
                getproductdetails.hsncode = dr["hsncode"].ToString();
                getproductdetails.sgst = dr["sgst"].ToString();
                getproductdetails.cgst = dr["cgst"].ToString();
                getproductdetails.igst = dr["igst"].ToString();
                getproductdetails.price = dr["price"].ToString();
                getproductdetails.productid = dr["productid"].ToString();
                getproductdetails.subcategoryid = dr["subcategoryid"].ToString();
                getproductdetails.imagepath = dr["imagepath"].ToString();
                getproductdetails.ftplocation = "ftp://223.196.32.30/PURCHASE/";
                ProductDetails.Add(getproductdetails);
            }
            string response = GetJson(ProductDetails);
            context.Response.Write(response);
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    private void save_customer_details(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            string name = context.Request["cname"];
            string email = context.Request["email"];
            string phno = context.Request["phno"];
            string f1 = context.Request["f1"];
            string f2 = context.Request["f2"];
            string btnSave = "Save";
            string branchid = context.Session["BranchID"].ToString();
            DateTime createdon = DateTime.Now;
            if (btnSave == "Save")
            {
                cmd = new SqlCommand("insert into customermaster (name, email, phno, f1, f2, branchid, doe) values (@name, @email, @phno, @f1, @f2, @branchid, @doe)");//,color,@color
                cmd.Parameters.Add("@name", name);
                cmd.Parameters.Add("@email", email);
                cmd.Parameters.Add("@phno", phno);
                cmd.Parameters.Add("@f1", f1);
                cmd.Parameters.Add("@f2", f2);
                cmd.Parameters.Add("@doe", createdon);
                cmd.Parameters.Add("@branchid", branchid);
                vdm.insert(cmd);
                string Response = GetJson("Section Details are Successfully Inserted");
                context.Response.Write(Response);
            }
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    public class customerMaster
    {
        public string sectionname { get; set; }
        public string Color { get; set; }
        public string SectionId { get; set; }
        public string status { get; set; }
        public string Sectioncode { get; set; }
        public string sno { get; set; }
    }

    private void get_customer_details(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            string branchid = context.Session["BranchID"].ToString();
            cmd = new SqlCommand("SELECT sno, name, email, phno, f1, f2, branchid, doe FROM customermaster ORDER BY sno DESC");
            DataTable routes = vdm.SelectQuery(cmd).Tables[0];
            List<customerMaster> SectionMaster = new List<customerMaster>();
            foreach (DataRow dr in routes.Rows)
            {
                customerMaster getsectiondetails = new customerMaster();
                getsectiondetails.sectionname = dr["name"].ToString();
                getsectiondetails.sno = dr["sno"].ToString();
                SectionMaster.Add(getsectiondetails);
            }
            string response = GetJson(SectionMaster);
            context.Response.Write(response);
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
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

    public class OutwardDetails
    {
        public string custmerid { get; set; }
        public string refnote { get; set; }
        public string payingnote { get; set; }
        public string modeofpay { get; set; }
        public string description { get; set; }
        public string balance { get; set; }
        public string totalpaying { get; set; }
        public string totalpayable { get; set; }
        public string totitems { get; set; }
        public string sno { get; set; }
        public string custmorname { get; set; }
        public string discount { get; set; }
        public string doe { get; set; }
        public string saleno { get; set; }
        public string btnvalue { get; set; }
        public string billtotalvalue { get; set; }
        public string address { get; set; }
        public string phone { get; set; }
        public string gstin { get; set; }
        public List<SubOutward> fillitems { get; set; }
    }

    public class SubOutward
    {
        public string productname { get; set; }
        public string PerUnitRs { get; set; }
        public string Quantity { get; set; }
        public string TotalCost { get; set; }
        public string hdnproductsno { get; set; }
        public string cgst { get; set; }
        public string sgst { get; set; }
        public string ordertax { get; set; }
        public string InvoiceNo { get; set; }
        public string igst { get; set; }
    }
    

    public class getOutwardData
    {
        public List<OutwardDetails> OutwardDetails { get; set; }
        public List<SubOutward> SubOutward { get; set; }
    }

    private void save_possale(HttpContext context)
    {
        try
        {
            var js = new JavaScriptSerializer();
            var title1 = context.Request.Params[1];
            OutwardDetails obj = js.Deserialize<OutwardDetails>(title1);
            string custmerid = obj.custmerid;
            string custmorname = obj.custmorname;
            string refnote = obj.refnote;
            string totitems = obj.totitems;
            string totalpayable = obj.totalpayable;
            string totalpaying = obj.totalpaying;
            string balance = obj.balance;
            string description = obj.description;
            string modeofpay = obj.modeofpay;
            string payingnote = obj.payingnote;
            string discount = obj.discount;
            string btnval = obj.btnvalue;
            string billtotalvalue = obj.billtotalvalue;
            string status = "";
            if (btnval == "Save")
            {
                status = "C";
            }
            else
            {
                status = "H";
            }
            // string btnval = "Save";
            string branchid = context.Session["BranchID"].ToString();
            string createdby = context.Session["Employ_Sno"].ToString();
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
            vdm = new SalesDBManager();
            if (btnval == "Save" || btnval == "Hold")
            {
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
                cmd.Parameters.Add("@branchid", branchid);
                cmd.Parameters.Add("@d1", GetLowDate(dtapril));
                cmd.Parameters.Add("@d2", GetHighDate(dtmarch));
                DataTable dtratechart = vdm.SelectQuery(cmd).Tables[0];
                string issueno = dtratechart.Rows[0]["Issueno"].ToString();
                cmd = new SqlCommand("insert into possale_maindetails(custmorid, custmorname, referencenote, totalitems, totalpayble, totalpaying, balance, description, modeofpay, payiningnote, discount, status, branchid, doe, createdby, issueno, billtotalvalue) values (@custmorid,@custmorname,@referencenote,@totalitems,@totalpayble,@totalpaying,@balance,@description,@modeofpay, @payiningnote,@discount, @status, @branchid, @doe, @createdby, @issueno, @billtotalvalue)");
                cmd.Parameters.Add("@branchid", branchid);
                cmd.Parameters.Add("@custmorid", custmerid);
                cmd.Parameters.Add("@custmorname", custmorname);
                cmd.Parameters.Add("@referencenote", refnote);
                cmd.Parameters.Add("@totalitems", totitems);
                cmd.Parameters.Add("@totalpayble", totalpayable);
                cmd.Parameters.Add("@totalpaying", totalpaying);
                cmd.Parameters.Add("@balance", balance);
                cmd.Parameters.Add("@description", description);
                cmd.Parameters.Add("@modeofpay", modeofpay);
                cmd.Parameters.Add("@payiningnote", payingnote);
                cmd.Parameters.Add("@discount", discount);
                cmd.Parameters.Add("@status", status);
                cmd.Parameters.Add("@doe", ServerDateCurrentdate);
                cmd.Parameters.Add("@createdby", createdby);
                cmd.Parameters.Add("@issueno", issueno);
                cmd.Parameters.Add("@billtotalvalue", billtotalvalue);
                vdm.insert(cmd);
                cmd = new SqlCommand("select MAX(sno) as outward from possale_maindetails");
                DataTable dtoutward = vdm.SelectQuery(cmd).Tables[0];
                string refno = dtoutward.Rows[0]["outward"].ToString();
                foreach (SubOutward si in obj.fillitems)
                {
                    if (si.hdnproductsno != "0")
                    {
                        cmd = new SqlCommand("insert into possale_subdetails(productid, qty, price, totvalue, refno, productname, ordertax) values(@productid,@quantity,@perunit,@totalcost,@in_refno, @productname, @ordertax)");
                        cmd.Parameters.Add("@productname", si.productname);
                        cmd.Parameters.Add("@productid", si.hdnproductsno);
                        cmd.Parameters.Add("@quantity", si.Quantity);
                        cmd.Parameters.Add("@perunit", si.PerUnitRs);
                        cmd.Parameters.Add("@totalcost", si.TotalCost);
                        cmd.Parameters.Add("@ordertax", si.ordertax);
                        cmd.Parameters.Add("@in_refno", refno);
                        vdm.insert(cmd);

                        cmd = new SqlCommand("UPDATE productmoniter set qty=qty-@qty WHERE productid=@productid AND branchid=@bid");
                        cmd.Parameters.Add("@qty", si.Quantity);
                        cmd.Parameters.Add("@productid", si.hdnproductsno);
                        cmd.Parameters.Add("@bid", branchid);
                        vdm.Update(cmd);
                    }
                }
                string msg = "Sale successfully added";
                string Response = GetJson(msg);
                context.Response.Write(Response);
            }
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    private void save_expencessdetails(HttpContext context)
    {
        try
        {
            var js = new JavaScriptSerializer();
            var title1 = context.Request.Params[1];
            OutwardDetails obj = js.Deserialize<OutwardDetails>(title1);
            string btnval = obj.btnvalue;

            // string btnval = "Save";
            string branchid = context.Session["BranchID"].ToString();
            string createdby = context.Session["Employ_Sno"].ToString();
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
            vdm = new SalesDBManager();
            if (btnval == "Save" || btnval == "Hold")
            {
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
                foreach (SubOutward si in obj.fillitems)
                {
                    if (si.hdnproductsno != "0")
                    {
                        cmd = new SqlCommand("insert into posexpencess_details(productname, qty, price, totvalue, doe, createdby, createdon, branchid) values(@productname,@quantity,@perunit,@totalcost, @doe, @ceatedby, @doe1, @branchid)");
                        cmd.Parameters.Add("@productname", si.productname);
                        cmd.Parameters.Add("@quantity", si.Quantity);
                        cmd.Parameters.Add("@perunit", si.PerUnitRs);
                        cmd.Parameters.Add("@totalcost", si.TotalCost);
                        cmd.Parameters.Add("@doe", ServerDateCurrentdate);
                        cmd.Parameters.Add("@doe1", ServerDateCurrentdate);
                        cmd.Parameters.Add("@ceatedby", createdby);
                        cmd.Parameters.Add("@branchid", branchid);
                        vdm.insert(cmd);
                    }
                }
                string msg = "Expencess successfully added";
                string Response = GetJson(msg);
                context.Response.Write(Response);
            }
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    public class inwardDetails
    {
        public string invoicedate { get; set; }
        public string date { get; set; }
        public string refnote { get; set; }
        public string supplier { get; set; }
        public string reciveornot { get; set; }
        public string description { get; set; }
        public string sno { get; set; }
        public string btnvalue { get; set; }
        public string totalvalue { get; set; }
        public string mrnno { get; set; }
        public string status { get; set; }
        public string supplierid { get; set; }
        public string frombranch { get; set; }
        public string tobranch { get; set; }
        public string toname { get; set; }
        public string fromname { get; set; }
        public string returntype { get; set; }
        public string vendor { get; set; }
        public List<Subinward> fillitems { get; set; }
    }

    public class Subinward
    {
        public string productname { get; set; }
        public string PerUnitRs { get; set; }
        public string Quantity { get; set; }
        public string TotalCost { get; set; }
        public string hdnproductsno { get; set; }
        public string cgst { get; set; }
        public string sgst { get; set; }
        public string igst { get; set; }
        public string ordertax { get; set; }
        public string inword_refno { get; set; }
        public string subcategoryname { get; set; }
        public string sno { get; set; }
    }

    public class getInwardData  //new
    {
        public List<inwardDetails> InwardDetails { get; set; }
        public List<Subinward> SubInward { get; set; }
    }
    private void save_inwarddetails(HttpContext context)
    {
        try
        {
            var js = new JavaScriptSerializer();
            var title1 = context.Request.Params[1];
            inwardDetails obj = js.Deserialize<inwardDetails>(title1);
            string date = obj.date;
            string refnote = obj.refnote;
            string supplier = obj.supplier;
            string reciveornot = obj.reciveornot;
            string description = obj.description;
            string btnval = obj.btnvalue;
            string sno = obj.sno;
            string status = "A";
            string billtotalvalue = obj.totalvalue;
            string branchid = context.Session["BranchID"].ToString();
            string createdby = context.Session["Employ_Sno"].ToString();
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
            vdm = new SalesDBManager();
            if (btnval == "Save")
            {
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
                cmd = new SqlCommand("SELECT { fn IFNULL(MAX(mrnno), 0) } + 1 AS mrnno FROM  inward_maindetails WHERE (branchid = @branchid) and (doe between @d1 and @d2)");
                cmd.Parameters.Add("@branchid", branchid);
                cmd.Parameters.Add("@d1", GetLowDate(dtapril));
                cmd.Parameters.Add("@d2", GetHighDate(dtmarch));
                DataTable dtratechart = vdm.SelectQuery(cmd).Tables[0];
                string mrnno = dtratechart.Rows[0]["mrnno"].ToString();
                cmd = new SqlCommand("insert into inward_maindetails(supplierid, refno, doe, modeofrecivig, description, status, branchid, createdby, createdon, mrnno, billtotalvalue) values (@supplierid, @refno, @doe, @modeofrecivig, @description, @status, @branchid, @createdby, @createdon, @mrnno, @billtotalvalue)");
                cmd.Parameters.Add("@branchid", branchid);
                cmd.Parameters.Add("@doe", date);
                cmd.Parameters.Add("@supplierid", supplier);
                cmd.Parameters.Add("@refno", refnote);
                cmd.Parameters.Add("@modeofrecivig", reciveornot);
                cmd.Parameters.Add("@description", description);
                cmd.Parameters.Add("@status", status);
                cmd.Parameters.Add("@createdon", ServerDateCurrentdate);
                cmd.Parameters.Add("@createdby", createdby);
                cmd.Parameters.Add("@mrnno", mrnno);
                cmd.Parameters.Add("@billtotalvalue", billtotalvalue);
                vdm.insert(cmd);
                cmd = new SqlCommand("select MAX(sno) as inward from inward_maindetails");
                DataTable dtoutward = vdm.SelectQuery(cmd).Tables[0];
                string refno = dtoutward.Rows[0]["inward"].ToString();
                foreach (Subinward si in obj.fillitems)
                {
                    if (si.hdnproductsno != "0")
                    {
                        cmd = new SqlCommand("insert into inward_subdetails(productid, qty, price, totvalue, refno) values(@productid,@quantity,@perunit,@totalcost,@in_refno)");
                        cmd.Parameters.Add("@productid", si.hdnproductsno);
                        cmd.Parameters.Add("@quantity", si.Quantity);
                        cmd.Parameters.Add("@perunit", si.PerUnitRs);
                        cmd.Parameters.Add("@totalcost", si.TotalCost);
                        cmd.Parameters.Add("@in_refno", refno);
                        vdm.insert(cmd);

                        cmd = new SqlCommand("UPDATE productmoniter set qty=qty+@qty, price=@price WHERE productid=@productid AND branchid=@branchid");
                        cmd.Parameters.Add("@branchid", branchid);
                        cmd.Parameters.Add("@productid", si.hdnproductsno);
                        cmd.Parameters.Add("@qty", si.Quantity);
                        cmd.Parameters.Add("@price", si.PerUnitRs);
                        vdm.Update(cmd);
                    }
                }
                string msg = "Inward Details successfully added";
                string Response = GetJson(msg);
                context.Response.Write(Response);
            }
            else
            {
                cmd = new SqlCommand("UPDATE inward_maindetails SET supplierid=@supplierid, refno=@refno, modeofrecivig=@modeofrecivig, description=@description,  billtotalvalue=@billtotalvalue, modifiedby=@createdby, modifyon=@createdon WHERE sno=@sno AND branchid=@branchid");
                cmd.Parameters.Add("@branchid", branchid);
                //cmd.Parameters.Add("@doe", date);
                cmd.Parameters.Add("@supplierid", supplier);
                cmd.Parameters.Add("@refno", refnote);
                cmd.Parameters.Add("@modeofrecivig", reciveornot);
                cmd.Parameters.Add("@description", description);
                cmd.Parameters.Add("@createdon", ServerDateCurrentdate);
                cmd.Parameters.Add("@createdby", createdby);
                cmd.Parameters.Add("@sno", sno);
                cmd.Parameters.Add("@billtotalvalue", billtotalvalue);
                vdm.Update(cmd);
                foreach (Subinward si in obj.fillitems)
                {
                    if (si.hdnproductsno != "0")
                    {
                        cmd = new SqlCommand("update inward_subdetails set  qty=@quantity, price=@perunit,totvalue=@totalcost Where refno=@refno and productid=@productid");
                        cmd.Parameters.Add("@productid", si.hdnproductsno);
                        cmd.Parameters.Add("@quantity", si.Quantity);
                        cmd.Parameters.Add("@perunit", si.PerUnitRs);
                        cmd.Parameters.Add("@totalcost", si.TotalCost);
                        cmd.Parameters.Add("@refno", sno);
                        if (vdm.Update(cmd) == 0)
                        {
                            cmd = new SqlCommand("insert into inward_subdetails(productid, qty, price, totvalue, refno) values(@productid,@quantity,@perunit,@totalcost,@in_refno)");
                            cmd.Parameters.Add("@productid", si.hdnproductsno);
                            cmd.Parameters.Add("@quantity", si.Quantity);
                            cmd.Parameters.Add("@perunit", si.PerUnitRs);
                            cmd.Parameters.Add("@totalcost", si.TotalCost);
                            cmd.Parameters.Add("@in_refno", sno);
                            vdm.insert(cmd);
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    private void inward_approveclick(HttpContext context)
    {

        try
        {
            vdm = new SalesDBManager();
            string julydt = "07/01/2017";
            DateTime gst_dt = Convert.ToDateTime(julydt);
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
            string branchid = context.Session["BranchID"].ToString();
            string sno = context.Request["sno"].ToString();
            cmd = new SqlCommand("UPDATE inward_maindetails SET status='A' WHERE sno=@sno");
            cmd.Parameters.Add("@sno", sno);
            vdm.Update(cmd);

            cmd = new SqlCommand("SELECT  inward_subdetails.productid, inward_subdetails.qty  FROM inward_maindetails INNER JOIN  inward_subdetails ON inward_maindetails.sno = inward_subdetails.refno WHERE inward_subdetails.refno=@psno");
            cmd.Parameters.Add("@psno", sno);
            DataTable dtsubreturn = vdm.SelectQuery(cmd).Tables[0];
            if (dtsubreturn.Rows.Count > 0)
            {
                foreach (DataRow dr in dtsubreturn.Rows)
                {
                    string productid = dr["productid"].ToString();
                    string quantity = dr["qty"].ToString();
                    cmd = new SqlCommand("Update productmoniter set qty=qty+@quantity where productid=@productid AND branchid=@branchid");
                    cmd.Parameters.Add("@productid", productid);
                    cmd.Parameters.Add("@branchid", branchid);
                    cmd.Parameters.Add("@quantity", quantity);
                    vdm.Update(cmd);
                }
            }
            string Response = GetJson("Inward Details are Successfully Aproved");
            context.Response.Write(Response);
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    private void get_dailyinward_details(HttpContext context)
    {
        vdm = new SalesDBManager();
        string julydt = "07/01/2017";
        DateTime gst_dt = Convert.ToDateTime(julydt);
        DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
        string branchid = context.Session["BranchID"].ToString();
        cmd = new SqlCommand("Select SUM(totvalue) as totvalue, productmaster.subcategoryid, subcategorymaster.subcategoryname from inward_maindetails INNER JOIN inward_subdetails ON inward_subdetails.refno=inward_maindetails.sno INNER JOIN productmaster ON productmaster.productid=inward_subdetails.productid INNER JOIN subcategorymaster ON subcategorymaster.subcategoryid =productmaster.subcategoryid WHERE inward_maindetails.branchid=@bid AND inward_maindetails.doe BETWEEN @d1 and @d2  group by productmaster.subcategoryid, subcategorymaster.subcategoryname");//, inwarddetails.indentno
        cmd.Parameters.Add("@d1", GetLowDate(ServerDateCurrentdate).AddDays(-5));
        cmd.Parameters.Add("@d2", GetHighDate(ServerDateCurrentdate));
        cmd.Parameters.Add("@bid", branchid);
        DataTable dtroutes = vdm.SelectQuery(cmd).Tables[0];
        List<Subinward> subinwardlist = new List<Subinward>();
        if (dtroutes.Rows.Count > 0)
        {
            foreach (DataRow dr in dtroutes.Rows)
            {
                Subinward getsubinward = new Subinward();
                getsubinward.subcategoryname = dr["subcategoryname"].ToString();
                getsubinward.TotalCost = dr["totvalue"].ToString();
                getsubinward.sno = dr["subcategoryid"].ToString();
                subinwardlist.Add(getsubinward);
            }
        }
        string response = GetJson(subinwardlist);
        context.Response.Write(response);
        // 
    }

    private void get_inward_details(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            string julydt = "07/01/2017";
            DateTime gst_dt = Convert.ToDateTime(julydt);
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
            string branchid = context.Session["BranchID"].ToString();
            cmd = new SqlCommand("SELECT suppliersdetails.name, ISD.productid, ISD.qty, ISD.price, ISD.totvalue, ISD.refno, IMD.supplierid, IMD.sno, IMD.doe, IMD.billtotalvalue, IMD.mrnno, IMD.status, IMD.description, IMD.modeofrecivig, IMD.refno AS referanceno, productmaster.productname  FROM  inward_maindetails AS IMD INNER JOIN inward_subdetails AS ISD ON IMD.sno = ISD.refno  INNER JOIN  productmaster ON ISD.productid = productmaster.productid INNER JOIN suppliersdetails ON  IMD.supplierid = suppliersdetails.supplierid WHERE  (IMD.branchid = @bid) AND (IMD.doe BETWEEN @d1 AND @d2)");//, inwarddetails.indentno
            cmd.Parameters.Add("@d1", GetLowDate(ServerDateCurrentdate).AddDays(-25));
            cmd.Parameters.Add("@d2", GetHighDate(ServerDateCurrentdate));
            cmd.Parameters.Add("@bid", branchid);
            DataTable routes = vdm.SelectQuery(cmd).Tables[0];
            DataView view = new DataView(routes);
            DataTable dtinward = view.ToTable(true, "sno", "supplierid", "name", "doe", "billtotalvalue", "mrnno", "status", "description", "modeofrecivig", "referanceno");//, "indentno"
            DataTable dtsubinward = view.ToTable(true, "productid", "qty", "price", "totvalue", "refno", "productname");
            List<getInwardData> getInwarddetails = new List<getInwardData>();
            List<inwardDetails> inwardlist = new List<inwardDetails>();
            List<Subinward> subinwardlist = new List<Subinward>();
            foreach (DataRow dr in dtinward.Rows)
            {
                inwardDetails getInward = new inwardDetails();
                getInward.date = ((DateTime)dr["doe"]).ToString("dd-MM-yyyy");//dr["inwarddate"].ToString();
                getInward.totalvalue = dr["billtotalvalue"].ToString();
                getInward.supplierid = dr["supplierid"].ToString();
                getInward.supplier = dr["name"].ToString();
                getInward.status = dr["status"].ToString();
                getInward.reciveornot = dr["modeofrecivig"].ToString();
                getInward.sno = dr["sno"].ToString();
                getInward.mrnno = dr["mrnno"].ToString();
                getInward.description = dr["description"].ToString();
                getInward.refnote = dr["referanceno"].ToString();
                inwardlist.Add(getInward);
            }
            foreach (DataRow dr in dtsubinward.Rows)
            {
                Subinward getsubinward = new Subinward();
                getsubinward.hdnproductsno = dr["productid"].ToString();
                getsubinward.productname = dr["productname"].ToString();
                getsubinward.Quantity = dr["qty"].ToString();
                double quantity = Convert.ToDouble(dr["qty"].ToString());
                quantity = Math.Round(quantity, 2);
                getsubinward.PerUnitRs = dr["price"].ToString();
                getsubinward.TotalCost = dr["totvalue"].ToString();
                getsubinward.inword_refno = dr["refno"].ToString();
                subinwardlist.Add(getsubinward);
            }
            getInwardData getInwadDatas = new getInwardData();
            getInwadDatas.InwardDetails = inwardlist;
            getInwadDatas.SubInward = subinwardlist;
            getInwarddetails.Add(getInwadDatas);
            string response = GetJson(getInwarddetails);
            context.Response.Write(response);
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }//new 

    private void get_inwordpending_details(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            string julydt = "07/01/2017";
            DateTime gst_dt = Convert.ToDateTime(julydt);
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
            string branchid = context.Session["BranchID"].ToString();
            string sno = context.Request["sno"].ToString();
            cmd = new SqlCommand("SELECT suppliersdetails.name, ISD.productid, ISD.qty, ISD.price, ISD.totvalue, ISD.refno, IMD.supplierid, IMD.sno, IMD.doe, IMD.billtotalvalue, IMD.mrnno, IMD.status, IMD.description, IMD.modeofrecivig, IMD.refno AS referanceno, productmaster.productname  FROM  inward_maindetails AS IMD INNER JOIN inward_subdetails AS ISD ON IMD.sno = ISD.refno  INNER JOIN  productmaster ON ISD.productid = productmaster.productid INNER JOIN suppliersdetails ON  IMD.supplierid = suppliersdetails.supplierid WHERE  (IMD.status = @status) AND (IMD.sno=@sno)");
            cmd.Parameters.Add("@status", "P");
            cmd.Parameters.Add("@sno", sno);
            DataTable routes = vdm.SelectQuery(cmd).Tables[0];
            DataView view = new DataView(routes);
            DataTable dtinward = view.ToTable(true, "sno", "supplierid", "name", "doe", "billtotalvalue", "mrnno", "status", "description", "modeofrecivig", "referanceno");//, "indentno"
            DataTable dtsubinward = view.ToTable(true, "productid", "qty", "price", "totvalue", "refno", "productname");
            List<getInwardData> getInwarddetails = new List<getInwardData>();
            List<inwardDetails> inwardlist = new List<inwardDetails>();
            List<Subinward> subinwardlist = new List<Subinward>();
            foreach (DataRow dr in dtinward.Rows)
            {
                inwardDetails getInward = new inwardDetails();
                getInward.date = ((DateTime)dr["doe"]).ToString("dd-MM-yyyy");//dr["inwarddate"].ToString();
                getInward.totalvalue = dr["billtotalvalue"].ToString();
                getInward.supplierid = dr["supplierid"].ToString();
                getInward.supplier = dr["name"].ToString();
                getInward.status = dr["status"].ToString();
                getInward.reciveornot = dr["modeofrecivig"].ToString();
                getInward.sno = dr["sno"].ToString();
                getInward.mrnno = dr["mrnno"].ToString();
                getInward.description = dr["description"].ToString();
                getInward.refnote = dr["referanceno"].ToString();
                inwardlist.Add(getInward);
            }
            foreach (DataRow dr in dtsubinward.Rows)
            {
                Subinward getsubinward = new Subinward();
                getsubinward.hdnproductsno = dr["productid"].ToString();
                getsubinward.productname = dr["productname"].ToString();
                getsubinward.Quantity = dr["qty"].ToString();
                double quantity = Convert.ToDouble(dr["qty"].ToString());
                quantity = Math.Round(quantity, 2);
                getsubinward.PerUnitRs = dr["price"].ToString();
                getsubinward.TotalCost = dr["totvalue"].ToString();
                getsubinward.inword_refno = dr["refno"].ToString();
                subinwardlist.Add(getsubinward);
            }
            getInwardData getInwadDatas = new getInwardData();
            getInwadDatas.InwardDetails = inwardlist;
            getInwadDatas.SubInward = subinwardlist;
            getInwarddetails.Add(getInwadDatas);
            string response = GetJson(getInwarddetails);
            context.Response.Write(response);
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    private void save_stocktransfer_details(HttpContext context)
    {
        try
        {
            var js = new JavaScriptSerializer();
            var title1 = context.Request.Params[1];
            inwardDetails obj = js.Deserialize<inwardDetails>(title1);
            string date = obj.date;
            string refnote = obj.refnote;
            string frombranch = obj.frombranch;
            string tobranch = obj.tobranch;
            string description = obj.description;
            string btnval = obj.btnvalue;
            string sno = obj.sno;
            string status = "A";
            string billtotalvalue = obj.totalvalue;
            string branchid = context.Session["BranchID"].ToString();
            string createdby = context.Session["Employ_Sno"].ToString();
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
            vdm = new SalesDBManager();
            if (btnval == "Save")
            {
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
                cmd = new SqlCommand("SELECT { fn IFNULL(MAX(invoiceno), 0) } + 1 AS invoiceno FROM  stocktransferdetails WHERE (branchid = @branchid) and (doe between @d1 and @d2)");
                cmd.Parameters.Add("@branchid", branchid);
                cmd.Parameters.Add("@d1", GetLowDate(dtapril));
                cmd.Parameters.Add("@d2", GetHighDate(dtmarch));
                DataTable dtratechart = vdm.SelectQuery(cmd).Tables[0];
                string invoiceno = dtratechart.Rows[0]["invoiceno"].ToString();
                cmd = new SqlCommand("insert into stocktransferdetails(frombranch, tobranch, doe, branchid, status, invoiceno, invoicedate, remarks, billtotalvalue, refnote, createdby, createdon) values (@frombranch, @tobranch, @doe, @branchid, @status, @invoiceno, @invoicedate, @description, @billtotalvalue, @refno, @createdby, @createdon)");
                cmd.Parameters.Add("@branchid", branchid);
                cmd.Parameters.Add("@doe", date);
                cmd.Parameters.Add("@frombranch", frombranch);
                cmd.Parameters.Add("@tobranch", tobranch);
                cmd.Parameters.Add("@refno", refnote);
                cmd.Parameters.Add("@description", description);
                cmd.Parameters.Add("@status", status);
                cmd.Parameters.Add("@invoicedate", ServerDateCurrentdate);
                cmd.Parameters.Add("@createdon", ServerDateCurrentdate);
                cmd.Parameters.Add("@createdby", createdby);
                cmd.Parameters.Add("@invoiceno", invoiceno);
                cmd.Parameters.Add("@billtotalvalue", billtotalvalue);
                vdm.insert(cmd);
                cmd = new SqlCommand("select MAX(sno) as stno from stocktransferdetails");
                DataTable dtoutward = vdm.SelectQuery(cmd).Tables[0];
                string refno = dtoutward.Rows[0]["stno"].ToString();
                foreach (Subinward si in obj.fillitems)
                {
                    if (si.hdnproductsno != "0")
                    {
                        cmd = new SqlCommand("insert into stocktransfersubdetails(productid, quantity, price, totvalue, stock_refno) values (@productid,@quantity,@perunit,@totalcost,@in_refno)");
                        cmd.Parameters.Add("@productid", si.hdnproductsno);
                        cmd.Parameters.Add("@quantity", si.Quantity);
                        cmd.Parameters.Add("@perunit", si.PerUnitRs);
                        cmd.Parameters.Add("@totalcost", si.TotalCost);
                        cmd.Parameters.Add("@in_refno", refno);
                        vdm.insert(cmd);
                    }
                }
                string msg = "Stocktransfer Details successfully added";
                string Response = GetJson(msg);
                context.Response.Write(Response);
            }
            else
            {
                cmd = new SqlCommand("UPDATE stocktransferdetails SET frombranch=@frombranch, tobranch=@tobranch, refnote=@refnote, doe=@doe, billtotalvalue=@billtotalvalue, remarks=@description WHERE sno=@sno AND branchid=@branchid");
                cmd.Parameters.Add("@sno", sno);
                cmd.Parameters.Add("@branchid", branchid);
                cmd.Parameters.Add("@doe", date);
                cmd.Parameters.Add("@frombranch", frombranch);
                cmd.Parameters.Add("@tobranch", tobranch);
                cmd.Parameters.Add("@refno", refnote);
                cmd.Parameters.Add("@description", description);
                cmd.Parameters.Add("@billtotalvalue", billtotalvalue);
                vdm.Update(cmd);
                foreach (Subinward si in obj.fillitems)
                {
                    if (si.hdnproductsno != "0")
                    {
                        cmd = new SqlCommand("update stocktransfersubdetails set  quantity=@quantity, price=@perunit,totvalue=@totalcost Where stock_refno=@refno and productid=@productid");
                        cmd.Parameters.Add("@productid", si.hdnproductsno);
                        cmd.Parameters.Add("@quantity", si.Quantity);
                        cmd.Parameters.Add("@perunit", si.PerUnitRs);
                        cmd.Parameters.Add("@totalcost", si.TotalCost);
                        cmd.Parameters.Add("@refno", sno);
                        if (vdm.Update(cmd) == 0)
                        {
                            cmd = new SqlCommand("insert into stocktransfersubdetails(productid, quantity, price, totvalue, stock_refno) values (@productid,@quantity,@perunit,@totalcost,@in_refno)");
                            cmd.Parameters.Add("@productid", si.hdnproductsno);
                            cmd.Parameters.Add("@quantity", si.Quantity);
                            cmd.Parameters.Add("@perunit", si.PerUnitRs);
                            cmd.Parameters.Add("@totalcost", si.TotalCost);
                            cmd.Parameters.Add("@in_refno", sno);
                            vdm.insert(cmd);
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    private void get_stocktransfer_details(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            string julydt = "07/01/2017";
            DateTime gst_dt = Convert.ToDateTime(julydt);
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
            string branchid = context.Session["BranchID"].ToString();

            cmd = new SqlCommand("SELECT STD.sno, STD.billtotalvalue, STD.frombranch, STD.tobranch, STD.doe, STD.branchid, STD.status, STD.invoiceno, STD.invoicedate, STD.remarks, STSD.productid, STSD.quantity, STSD.price, STSD.totvalue, SUP.branchname as fromname, SUP1.branchname as toname, PM.productname, STSD.stock_refno FROM stocktransferdetails AS STD INNER JOIN stocktransfersubdetails AS STSD ON STD.sno=STSD.stock_refno INNER JOIN branchmaster AS SUP ON SUP.branchid = STD.frombranch INNER JOIN branchmaster AS SUP1 ON SUP1.branchid = STD.tobranch INNER JOIN productmaster AS PM on PM.productid = STSD.productid WHERE STD.doe BETWEEN @D1 AND @D2 AND STD.branchid=@branchid AND STD.status=@status");//, inwarddetails.indentno
            cmd.Parameters.Add("@d1", GetLowDate(ServerDateCurrentdate).AddDays(-25));
            cmd.Parameters.Add("@d2", GetHighDate(ServerDateCurrentdate));
            cmd.Parameters.Add("@branchid", branchid);
            cmd.Parameters.Add("@status", "P");
            DataTable routes = vdm.SelectQuery(cmd).Tables[0];
            DataView view = new DataView(routes);
            DataTable dtinward = view.ToTable(true, "sno", "frombranch", "tobranch", "doe", "branchid", "invoiceno", "status", "invoicedate", "remarks", "fromname", "toname", "billtotalvalue");//, "indentno"
            DataTable dtsubinward = view.ToTable(true, "productid", "quantity", "price", "totvalue", "stock_refno", "productname");
            List<getInwardData> getInwarddetails = new List<getInwardData>();
            List<inwardDetails> inwardlist = new List<inwardDetails>();
            List<Subinward> subinwardlist = new List<Subinward>();
            foreach (DataRow dr in dtinward.Rows)
            {
                inwardDetails getInward = new inwardDetails();
                getInward.date = ((DateTime)dr["doe"]).ToString("dd-MM-yyyy");//dr["inwarddate"].ToString();
                getInward.totalvalue = dr["billtotalvalue"].ToString();
                getInward.frombranch = dr["frombranch"].ToString();
                getInward.tobranch = dr["tobranch"].ToString();
                getInward.fromname = dr["fromname"].ToString();
                getInward.toname = dr["toname"].ToString();
                getInward.status = dr["status"].ToString();
                getInward.sno = dr["sno"].ToString();
                getInward.mrnno = dr["invoiceno"].ToString();
                getInward.description = dr["remarks"].ToString();
                inwardlist.Add(getInward);

            }
            foreach (DataRow dr in dtsubinward.Rows)
            {
                Subinward getsubinward = new Subinward();
                getsubinward.hdnproductsno = dr["productid"].ToString();
                getsubinward.productname = dr["productname"].ToString();
                getsubinward.Quantity = dr["quantity"].ToString();
                double quantity = Convert.ToDouble(dr["quantity"].ToString());
                quantity = Math.Round(quantity, 2);
                getsubinward.PerUnitRs = dr["price"].ToString();
                getsubinward.TotalCost = dr["totvalue"].ToString();
                getsubinward.inword_refno = dr["stock_refno"].ToString();
                subinwardlist.Add(getsubinward);
            }
            getInwardData getInwadDatas = new getInwardData();
            getInwadDatas.InwardDetails = inwardlist;
            getInwadDatas.SubInward = subinwardlist;
            getInwarddetails.Add(getInwadDatas);
            string response = GetJson(getInwarddetails);
            context.Response.Write(response);
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }//new 

    private void get_posproductsale_details(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
            string branchid = context.Session["BranchID"].ToString();
            cmd = new SqlCommand("select address, phone, gstin from branchmaster WHERE branchid=@branchid");
            cmd.Parameters.Add("@branchid", branchid);
            DataTable dtbranch = vdm.SelectQuery(cmd).Tables[0];

            cmd = new SqlCommand("select MAX(sno) as outward from possale_maindetails WHERE branchid=@branchid AND status='C'");
            cmd.Parameters.Add("@branchid", branchid);
            DataTable dtREF = vdm.SelectQuery(cmd).Tables[0];
            string refno = dtREF.Rows[0]["outward"].ToString();
            cmd = new SqlCommand("SELECT branchmaster.address, branchmaster.phone, branchmaster.gstin, PM.sno, PM.custmorid, customermaster.name AS custmorname, PM.referencenote, PM.totalitems,  PM.totalpayble, PM.totalpaying, PM.balance, PM.description, PM.modeofpay, PM.payiningnote, PM.discount, PM.status, PM.branchid, PM.doe,  PM.createdby, PM.issueno, PS.refno, PS.productid, PS.productname, PS.qty, PS.totvalue, PS.ordertax, productmaster.sgst, productmaster.cgst, productmaster.igst, productmoniter.price  FROM  possale_maindetails AS PM INNER JOIN  possale_subdetails AS PS ON PM.sno = PS.refno INNER JOIN  customermaster ON PM.custmorid = customermaster.sno INNER JOIN productmaster ON PS.productid = productmaster.productid INNER JOIN branchmaster ON branchmaster.branchid=PM.branchid INNER JOIN productmoniter ON productmoniter.productid=PS.productid WHERE (PM.sno = @SNO) AND productmoniter.branchid=@BID");
            cmd.Parameters.Add("@SNO", refno);
            cmd.Parameters.Add("@BID", branchid);
            DataTable routes = vdm.SelectQuery(cmd).Tables[0];
            DataView view = new DataView(routes);
            DataTable dtoutward = view.ToTable(true, "sno", "custmorid", "totalitems", "totalpayble", "totalpaying", "balance", "doe", "issueno", "custmorname", "modeofpay", "discount", "address", "phone", "gstin");
            DataTable dtsuboutward = view.ToTable(true, "productid", "productname", "qty", "price", "totvalue", "sgst", "cgst", "igst", "ordertax");
            List<getOutwardData> getOutwarddetails = new List<getOutwardData>();
            List<OutwardDetails> outwardlist = new List<OutwardDetails>();
            List<SubOutward> suboutwardlist = new List<SubOutward>();
            foreach (DataRow dr in dtoutward.Rows)
            {
                OutwardDetails getoutward = new OutwardDetails();
                getoutward.custmerid = dr["custmorid"].ToString();
                getoutward.doe = ((DateTime)dr["doe"]).ToString("dd-MM-yyyy HH:mm:ss");//dr["inwarddate"].ToString();//((DateTime)dr["inwarddate"]).ToString("yyyy-MM-dd");
                getoutward.custmorname = dr["custmorname"].ToString();
                getoutward.totitems = dr["totalitems"].ToString();
                getoutward.totalpayable = dr["totalpayble"].ToString();
                getoutward.totalpaying = dr["totalpaying"].ToString();
                getoutward.balance = dr["balance"].ToString();
                getoutward.saleno = dr["issueno"].ToString();
                getoutward.modeofpay = dr["modeofpay"].ToString();
                getoutward.discount = dr["discount"].ToString();
                getoutward.address = dr["address"].ToString();
                getoutward.phone = dr["phone"].ToString();
                getoutward.gstin = dr["gstin"].ToString();
                outwardlist.Add(getoutward);
            }
            foreach (DataRow dr in dtsuboutward.Rows)
            {
                SubOutward getsuboutward = new SubOutward();
                getsuboutward.productname = dr["productname"].ToString();
                getsuboutward.Quantity = dr["qty"].ToString();
                getsuboutward.hdnproductsno = dr["productid"].ToString();
                getsuboutward.PerUnitRs = dr["price"].ToString();
                getsuboutward.TotalCost = dr["totvalue"].ToString();
                getsuboutward.sgst = dr["sgst"].ToString();
                getsuboutward.cgst = dr["cgst"].ToString();
                getsuboutward.ordertax = dr["ordertax"].ToString();
                suboutwardlist.Add(getsuboutward);
            }
            getOutwardData getoutwadDatas = new getOutwardData();
            getoutwadDatas.OutwardDetails = outwardlist;
            getoutwadDatas.SubOutward = suboutwardlist;
            getOutwarddetails.Add(getoutwadDatas);
            string response = GetJson(getOutwarddetails);
            context.Response.Write(response);
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    private void get_posproducthold_details(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
            string branchid = context.Session["BranchID"].ToString();
            cmd = new SqlCommand("select MAX(sno) as outward from possale_maindetails WHERE branchid=@branchid and status='H'");
            cmd.Parameters.Add("@branchid", branchid);
            DataTable dtREF = vdm.SelectQuery(cmd).Tables[0];
            string refno = dtREF.Rows[0]["outward"].ToString();
            cmd = new SqlCommand("SELECT PM.sno, PM.custmorid, customermaster.name AS custmorname, PM.referencenote, PM.totalitems, PM.totalpayble, PM.totalpaying, PM.balance, PM.description, PM.modeofpay, PM.payiningnote, PM.discount, PM.status, PM.branchid, PM.doe,  PM.createdby, PM.issueno, PS.refno, PS.productid, PS.productname, PS.qty, PS.price, PS.totvalue, PS.ordertax, productmaster.sgst, productmaster.cgst, productmaster.igst  FROM  possale_maindetails AS PM INNER JOIN  possale_subdetails AS PS ON PM.sno = PS.refno INNER JOIN  customermaster ON PM.custmorid = customermaster.sno INNER JOIN productmaster ON PS.productid = productmaster.productid WHERE  (PM.sno = @SNO)");
            cmd.Parameters.Add("@SNO", refno);
            DataTable routes = vdm.SelectQuery(cmd).Tables[0];
            DataView view = new DataView(routes);
            DataTable dtoutward = view.ToTable(true, "sno", "custmorid", "totalitems", "totalpayble", "totalpaying", "balance", "doe", "issueno", "custmorname", "modeofpay");
            DataTable dtsuboutward = view.ToTable(true, "productid", "productname", "qty", "price", "totvalue", "sgst", "cgst", "igst", "ordertax");
            List<getOutwardData> getOutwarddetails = new List<getOutwardData>();
            List<OutwardDetails> outwardlist = new List<OutwardDetails>();
            List<SubOutward> suboutwardlist = new List<SubOutward>();
            foreach (DataRow dr in dtoutward.Rows)
            {
                OutwardDetails getoutward = new OutwardDetails();
                getoutward.custmerid = dr["custmorid"].ToString();
                getoutward.doe = ((DateTime)dr["doe"]).ToString("dd-MM-yyyy HH:mm:ss");//dr["inwarddate"].ToString();//((DateTime)dr["inwarddate"]).ToString("yyyy-MM-dd");
                getoutward.custmorname = dr["custmorname"].ToString();
                getoutward.totitems = dr["totalitems"].ToString();
                getoutward.totalpayable = dr["totalpayble"].ToString();
                getoutward.totalpaying = dr["totalpaying"].ToString();
                getoutward.balance = dr["balance"].ToString();
                getoutward.saleno = dr["issueno"].ToString();
                getoutward.modeofpay = dr["modeofpay"].ToString();
                outwardlist.Add(getoutward);
            }
            foreach (DataRow dr in dtsuboutward.Rows)
            {
                SubOutward getsuboutward = new SubOutward();
                getsuboutward.productname = dr["productname"].ToString();
                getsuboutward.Quantity = dr["qty"].ToString();
                getsuboutward.hdnproductsno = dr["productid"].ToString();
                getsuboutward.PerUnitRs = dr["price"].ToString();
                getsuboutward.TotalCost = dr["totvalue"].ToString();
                getsuboutward.ordertax = dr["ordertax"].ToString();
                getsuboutward.sgst = dr["sgst"].ToString();
                getsuboutward.cgst = dr["cgst"].ToString();
                suboutwardlist.Add(getsuboutward);
            }
            getOutwardData getoutwadDatas = new getOutwardData();
            getoutwadDatas.OutwardDetails = outwardlist;
            getoutwadDatas.SubOutward = suboutwardlist;
            getOutwarddetails.Add(getoutwadDatas);
            string response = GetJson(getOutwarddetails);
            context.Response.Write(response);
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    public class saledetails
    {
        public string saletype { get; set; }
        public string salevalue { get; set; }
        public string purchasevalue { get; set; }
        public string expencesvalue { get; set; }
        public string profit { get; set; }
        public string parlorid { get; set; }
        public string branchname { get; set; }

        public string productname { get; set; }
        public string PerUnitRs { get; set; }
        public string Quantity { get; set; }
        public string TotalCost { get; set; }
        public string hdnproductsno { get; set; }
        public string cgst { get; set; }
        public string sgst { get; set; }
        public string ordertax { get; set; }
        public string refno { get; set; }
    }

    private void get_daywiseregister_details(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            string branchid = context.Session["BranchID"].ToString();
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
            DataTable report = new DataTable();
            report.Columns.Add("totamount").DataType = typeof(double);
            report.Columns.Add("modeofpay");


            //registrationopendetials
            cmd = new SqlCommand("SELECT sno, parlorid, opendby, cashinhand, doe  FROM   registrationopendetials where parlorid=@bid AND doe between @d1 and @d2");
            cmd.Parameters.Add("@bid", branchid);
            cmd.Parameters.Add("@d1", GetLowDate(ServerDateCurrentdate));
            cmd.Parameters.Add("@d2", GetHighDate(ServerDateCurrentdate));
            DataTable dtcashinhand = vdm.SelectQuery(cmd).Tables[0];
            string cash = "";
            if (dtcashinhand.Rows.Count > 0)
            {
                cash = dtcashinhand.Rows[0]["cashinhand"].ToString();
            }
            else
            {
                cash = "0";
            }
            double cashinhand = Convert.ToDouble(cash);
            DataRow newrow = report.NewRow();
            newrow["totamount"] = cash;
            newrow["modeofpay"] = "cashinhand";
            report.Rows.Add(newrow);

            cmd = new SqlCommand("SELECT SUM(totalpayble) AS totamount, modeofpay  FROM  possale_maindetails  WHERE (branchid = @branchid) AND (doe BETWEEN @sd1 AND @sd2)  GROUP BY modeofpay");
            cmd.Parameters.Add("@branchid", branchid);
            cmd.Parameters.Add("@sd1", GetLowDate(ServerDateCurrentdate));
            cmd.Parameters.Add("@sd2", GetHighDate(ServerDateCurrentdate));
            DataTable dtsaldtls = vdm.SelectQuery(cmd).Tables[0];
            List<saledetails> SectionMaster = new List<saledetails>();
            DataTable dttotmerg = new DataTable();
            dtsaldtls.Merge(report);
            foreach (DataRow dr in dtsaldtls.Rows)
            {
                saledetails getsectiondetails = new saledetails();
                getsectiondetails.saletype = dr["modeofpay"].ToString();
                getsectiondetails.salevalue = dr["totamount"].ToString();
                SectionMaster.Add(getsectiondetails);
            }
            string response = GetJson(SectionMaster);
            context.Response.Write(response);
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    private void savecompanyDetails(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            string cmpname = context.Request["cmpname"];
            string cmpcode = context.Request["cmpcode"];
            string Status = context.Request["Status"];
            string btnVal = context.Request["btnVal"];
            string sno = context.Request["sno"];
            string branchid = context.Session["BranchID"].ToString();
            string createdby = context.Session["Employ_Sno"].ToString();
            DateTime createdon = DateTime.Now;
            if (btnVal == "Save")
            {
                cmd = new SqlCommand("insert into companymaster (cmpname, cmpcode, status, doe, createdby, branchid) values (@cmpname, @cmpcode, @Status, @doe, @createdby, @branchid)");//,color,@color
                cmd.Parameters.Add("@cmpname", cmpname);
                cmd.Parameters.Add("@cmpcode", cmpcode);
                cmd.Parameters.Add("@Status", Status);
                cmd.Parameters.Add("@doe", createdon);
                cmd.Parameters.Add("@createdby", createdby);
                cmd.Parameters.Add("@branchid", branchid);
                vdm.insert(cmd);
                string Response = GetJson("Company Details are Successfully Inserted");
                context.Response.Write(Response);
            }
            else
            {
                cmd = new SqlCommand("UPDATE companymaster SET cmpname=@cmpname, cmpcode=@cmpcode, Status=@Status, modifiedby=@modifiedby, modifiedon=@modifiedon WHERE sno=@sno");//,color,@color
                cmd.Parameters.Add("@cmpname", cmpname);
                cmd.Parameters.Add("@cmpcode", cmpcode);
                cmd.Parameters.Add("@Status", Status);
                cmd.Parameters.Add("@sno", sno);
                cmd.Parameters.Add("@modifiedby", createdby);
                cmd.Parameters.Add("@modifiedon", createdon);
                vdm.Update(cmd);
                string Response = GetJson("Company Details are Successfully Modified");
                context.Response.Write(Response);
            }
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    private void btnsave_employedetails(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            string dept = context.Request["dept"];
            string designation = context.Request["designation"];
            string empname = context.Request["empname"];
            string password = context.Request["password"];
            string mobileno = context.Request["mobileno"];
            string emailid = context.Request["emailid"];
            string adharno = context.Request["adharno"];
            string empaddress = context.Request["empaddress"];
            string Status = context.Request["status"];
            string btnVal = context.Request["btnval"];
            string sno = context.Request["sno"];
            string username = context.Request["username"];
            string lveltype = context.Request["lveltype"];

            string branchid = context.Session["BranchID"].ToString();
            string createdby = context.Session["Employ_Sno"].ToString();
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
            if (btnVal == "Save")
            {
                cmd = new SqlCommand("insert into employe_details (employename, userid, password, emailid, phone, branchtype, leveltype, departmentid, branchid, designationid, createdon, createdby) values (@empname, @username, @password, @emailid, @mobileno, @branchtype, @branchtype, @branchtype, @branchtype, @branchtype, @leveltype, @dept, @branchid, @designation, @doe, @createdby)");//,color,@color
                cmd.Parameters.Add("@dept", dept);
                cmd.Parameters.Add("@designation", designation);
                cmd.Parameters.Add("@empname", empname);
                cmd.Parameters.Add("@password", password);
                cmd.Parameters.Add("@mobileno", mobileno);
                cmd.Parameters.Add("@emailid", emailid);
                cmd.Parameters.Add("@adharno", adharno);
                cmd.Parameters.Add("@empaddress", empaddress);
                cmd.Parameters.Add("@Status", Status);
                cmd.Parameters.Add("@doe", ServerDateCurrentdate);
                cmd.Parameters.Add("@createdby", createdby);
                cmd.Parameters.Add("@branchid", branchid);
                cmd.Parameters.Add("@username", username);
                cmd.Parameters.Add("@branchtype", "Parlor");
                cmd.Parameters.Add("@leveltype", lveltype);
                vdm.insert(cmd);
                string Response = GetJson("Employee Details are Successfully Inserted");
                context.Response.Write(Response);
            }
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    public class companydetails
    {
        public string cmpname { get; set; }
        public string cmpcode { get; set; }
        public string doe { get; set; }
        public string status { get; set; }
        public string branchid { get; set; }
        public string sno { get; set; }
    }
    private void get_company_details(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            string branchid = context.Session["BranchID"].ToString();
            cmd = new SqlCommand("SELECT sno, cmpname, cmpcode, status, doe, createdby, branchid FROM companymaster ORDER BY sno DESC");
            DataTable routes = vdm.SelectQuery(cmd).Tables[0];
            List<companydetails> SectionMaster = new List<companydetails>();
            foreach (DataRow dr in routes.Rows)
            {
                companydetails getsectiondetails = new companydetails();
                getsectiondetails.cmpname = dr["cmpname"].ToString();
                getsectiondetails.cmpcode = dr["cmpcode"].ToString();
                getsectiondetails.status = dr["status"].ToString();
                getsectiondetails.doe = dr["doe"].ToString();
                getsectiondetails.branchid = dr["branchid"].ToString();
                getsectiondetails.sno = dr["sno"].ToString();
                SectionMaster.Add(getsectiondetails);
            }
            string response = GetJson(SectionMaster);
            context.Response.Write(response);
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    private void Save_branchetails(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            string cmpid = context.Request["cmpid"];
            string branchname = context.Request["branchname"];
            string branchcode = context.Request["branchcode"];
            string address = context.Request["address"];
            string status = context.Request["status"];
            string btnVal = context.Request["btnVal"];
            string sno = context.Request["sno"];
            string branchid = context.Session["BranchID"].ToString();
            string createdby = context.Session["Employ_Sno"].ToString();
            DateTime createdon = DateTime.Now;
            if (btnVal == "Save")
            {
                cmd = new SqlCommand("insert into locationmaster (cmpid, branchname, branchcode, status, doe, createdby, branchid, address) values (@cmpname, @branchname, @branchcode, @Status, @doe, @createdby, @branchid, @address)");//,color,@color
                cmd.Parameters.Add("@cmpname", cmpid);
                cmd.Parameters.Add("@branchname", branchname);
                cmd.Parameters.Add("@branchcode", branchcode);
                cmd.Parameters.Add("@Status", status);
                cmd.Parameters.Add("@doe", createdon);
                cmd.Parameters.Add("@createdby", createdby);
                cmd.Parameters.Add("@branchid", branchid);
                cmd.Parameters.Add("@address", address);
                vdm.insert(cmd);
                string Response = GetJson("Branch Details are Successfully Inserted");
                context.Response.Write(Response);
            }
            else
            {
                cmd = new SqlCommand("UPDATE locationmaster SET cmpid=@cmpid, branchname=@branchname, branchcode=@branchcode, status=@Status, address=@address, modifieby=@modifiedby, modifiedon=@modifiedon WHERE sno=@sno");//,color,@color
                cmd.Parameters.Add("@cmpid", cmpid);
                cmd.Parameters.Add("@branchname", branchname);
                cmd.Parameters.Add("@branchcode", branchcode);
                cmd.Parameters.Add("@Status", status);
                cmd.Parameters.Add("@sno", sno);
                cmd.Parameters.Add("@modifiedby", createdby);
                cmd.Parameters.Add("@modifiedon", createdon);
                cmd.Parameters.Add("@address", address);
                vdm.Update(cmd);
                string Response = GetJson("Branch Details are Successfully Modified");
                context.Response.Write(Response);
            }
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    public class Branchdetails
    {
        public string cmpid { get; set; }
        public string Branchname { get; set; }
        public string Branchcode { get; set; }
        public string doe { get; set; }
        public string status { get; set; }
        public string branchid { get; set; }
        public string sno { get; set; }
        public string cmpname { get; set; }
    }
    private void get_Branch_details(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            string branchid = context.Session["BranchID"].ToString();
            cmd = new SqlCommand("SELECT companymaster.cmpname, locationmaster.sno, locationmaster.cmpid, locationmaster.branchname, locationmaster.branchcode, locationmaster.status, locationmaster.doe, locationmaster.createdby, locationmaster.branchid FROM locationmaster INNER JOIN companymaster ON companymaster.sno = locationmaster.cmpid  ORDER BY sno DESC");
            DataTable routes = vdm.SelectQuery(cmd).Tables[0];
            List<Branchdetails> SectionMaster = new List<Branchdetails>();
            foreach (DataRow dr in routes.Rows)
            {
                Branchdetails getsectiondetails = new Branchdetails();
                getsectiondetails.cmpid = dr["cmpid"].ToString();
                getsectiondetails.cmpname = dr["cmpname"].ToString();
                getsectiondetails.Branchname = dr["branchname"].ToString();
                getsectiondetails.Branchcode = dr["branchcode"].ToString();
                getsectiondetails.status = dr["status"].ToString();
                getsectiondetails.doe = dr["doe"].ToString();
                getsectiondetails.branchid = dr["branchid"].ToString();
                getsectiondetails.sno = dr["sno"].ToString();
                SectionMaster.Add(getsectiondetails);
            }
            string response = GetJson(SectionMaster);
            context.Response.Write(response);
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    private void btnsave_categoryclick(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            string cmpid = context.Request["categoryname"];
            string branchname = context.Request["categorycode"];
            string status = context.Request["Status"];
            string btnVal = context.Request["btnVal"];
            string sno = context.Request["sno"];
            string branchid = context.Session["BranchID"].ToString();
            string createdby = context.Session["Employ_Sno"].ToString();
            DateTime createdon = DateTime.Now;
            if (btnVal == "Save")
            {
                cmd = new SqlCommand("insert into categorymaster (category, cat_code, status, createdon, createdby) values (@category, @cat_code, @status, @createdon, @createdby)");//,color,@color
                cmd.Parameters.Add("@category", cmpid);
                cmd.Parameters.Add("@cat_code", branchname);
                cmd.Parameters.Add("@Status", status);
                cmd.Parameters.Add("@createdon", createdon);
                cmd.Parameters.Add("@createdby", createdby);
                vdm.insert(cmd);
                string Response = GetJson("Category Details are Successfully Inserted");
                context.Response.Write(Response);
            }
            else
            {
                cmd = new SqlCommand("UPDATE categorymaster SET category=@category, cat_code=@cat_code,  status=@Status WHERE categoryid=@sno");//,color,@color
                cmd.Parameters.Add("@category", cmpid);
                cmd.Parameters.Add("@cat_code", branchname);
                cmd.Parameters.Add("@Status", status);
                cmd.Parameters.Add("@sno", sno);
                vdm.Update(cmd);
                string Response = GetJson("Category Details are Successfully Modified");
                context.Response.Write(Response);
            }
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }


    public class categorydetails
    {
        public string catid { get; set; }
        public string category { get; set; }
        public string cat_code { get; set; }
        public string status { get; set; }
        public string doe { get; set; }
        public string sno { get; set; }
        public string subcategory { get; set; }
        public string subcat_code { get; set; }
        public string UOM { get; set; }
        public string statename { get; set; }
        public string statecode { get; set; }
        public string gststatecode { get; set; }
        public string gstregtype { get; set; }

    }
    private void get_category_details(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            cmd = new SqlCommand("SELECT category, cat_code, status, categoryid FROM categorymaster");
            DataTable routes = vdm.SelectQuery(cmd).Tables[0];
            List<categorydetails> SectionMaster = new List<categorydetails>();
            foreach (DataRow dr in routes.Rows)
            {
                categorydetails getsectiondetails = new categorydetails();
                getsectiondetails.category = dr["category"].ToString();
                getsectiondetails.cat_code = dr["cat_code"].ToString();
                getsectiondetails.status = dr["status"].ToString();
                getsectiondetails.sno = dr["categoryid"].ToString();
                SectionMaster.Add(getsectiondetails);
            }
            string response = GetJson(SectionMaster);
            context.Response.Write(response);
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    private void btnsave_subcategory(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            string catid = context.Request["catid"];
            string subcategory = context.Request["subcategory"];
            string subcategorycode = context.Request["subcategorycode"];
            string status = context.Request["Status"];
            string btnVal = context.Request["btnVal"];
            string sno = context.Request["sno"];
            string branchid = context.Session["BranchID"].ToString();
            string createdby = context.Session["Employ_Sno"].ToString();
            DateTime createdon = DateTime.Now;
            if (btnVal == "Save")
            {
                cmd = new SqlCommand("insert into subcategorymaster (categoryid, subcategoryname, sub_cat_code, status, createdon, createdby) values (@catid,@subcategory, @subcategorycode, @status, @createdon, @createdby)");//,color,@color
                cmd.Parameters.Add("@catid", catid);
                cmd.Parameters.Add("@subcategory", subcategory);
                cmd.Parameters.Add("@subcategorycode", subcategorycode);
                cmd.Parameters.Add("@Status", status);
                cmd.Parameters.Add("@createdon", createdon);
                cmd.Parameters.Add("@createdby", createdby);
                vdm.insert(cmd);
                string Response = GetJson("Sub Category Details are Successfully Inserted");
                context.Response.Write(Response);
            }
            else
            {
                cmd = new SqlCommand("UPDATE subcategorymaster SET categoryid=@categoryid, subcategoryname=@subcategory, sub_cat_code=@subcategorycode,  status=@Status WHERE subcategoryid=@sno");//,color,@color
                cmd.Parameters.Add("@categoryid", catid);
                cmd.Parameters.Add("@subcategory", subcategory);
                cmd.Parameters.Add("@subcategorycode", subcategorycode);
                cmd.Parameters.Add("@Status", status);
                cmd.Parameters.Add("@sno", sno);
                vdm.Update(cmd);
                string Response = GetJson("Sub Category Details are Successfully Modified");
                context.Response.Write(Response);
            }
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    private void get_subcategory_details(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            cmd = new SqlCommand("SELECT categorymaster.category, subcategorymaster.subcategoryid,  subcategorymaster.categoryid, subcategorymaster.subcategoryname, subcategorymaster.sub_cat_code, subcategorymaster.status  FROM  categorymaster INNER JOIN subcategorymaster ON categorymaster.categoryid = subcategorymaster.categoryid  order by subcategorymaster.rank");
            DataTable routes = vdm.SelectQuery(cmd).Tables[0];
            List<categorydetails> SectionMaster = new List<categorydetails>();
            foreach (DataRow dr in routes.Rows)
            {
                categorydetails getsectiondetails = new categorydetails();
                getsectiondetails.catid = dr["categoryid"].ToString();
                getsectiondetails.category = dr["category"].ToString();
                getsectiondetails.subcategory = dr["subcategoryname"].ToString();
                getsectiondetails.subcat_code = dr["sub_cat_code"].ToString();
                getsectiondetails.status = dr["status"].ToString();
                getsectiondetails.sno = dr["subcategoryid"].ToString();
                SectionMaster.Add(getsectiondetails);
            }
            string response = GetJson(SectionMaster);
            context.Response.Write(response);
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    private void btnsave_UOM(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            string uom = context.Request["uom"];
            string status = context.Request["Status"];
            string btnVal = context.Request["btnval"];
            string sno = context.Request["sno"];
            string branchid = context.Session["BranchID"].ToString();
            string createdby = context.Session["Employ_Sno"].ToString();
            DateTime createdon = DateTime.Now;
            if (btnVal == "Save")
            {
                cmd = new SqlCommand("insert into  uimmaster(uim, status, createdon, createdby) values (@uim, @status, @createdon, @createdby)");//,color,@color
                cmd.Parameters.Add("@catid", uom);
                cmd.Parameters.Add("@Status", status);
                cmd.Parameters.Add("@createdon", createdon);
                cmd.Parameters.Add("@createdby", createdby);
                vdm.insert(cmd);
                string Response = GetJson("UOM Details are Successfully Inserted");
                context.Response.Write(Response);
            }
            else
            {
                cmd = new SqlCommand("UPDATE uimmaster SET uim=@uim, status=@status WHERE sno=@sno");//,color,@color
                cmd.Parameters.Add("@uim", uom);
                cmd.Parameters.Add("@Status", status);
                cmd.Parameters.Add("@sno", sno);
                vdm.Update(cmd);
                string Response = GetJson("UOM Details are Successfully Modified");
                context.Response.Write(Response);
            }
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    private void get_UOM_details(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            cmd = new SqlCommand("SELECT sno, uim, status FROM uimmaster");
            DataTable routes = vdm.SelectQuery(cmd).Tables[0];
            List<categorydetails> SectionMaster = new List<categorydetails>();
            foreach (DataRow dr in routes.Rows)
            {
                categorydetails getsectiondetails = new categorydetails();
                getsectiondetails.UOM = dr["uim"].ToString();
                getsectiondetails.status = dr["status"].ToString();
                getsectiondetails.sno = dr["sno"].ToString();
                SectionMaster.Add(getsectiondetails);
            }
            string response = GetJson(SectionMaster);
            context.Response.Write(response);
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    private void btnsave_state(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            string statename = context.Request["statename"];
            string statecode = context.Request["statecode"];
            string gststatecode = context.Request["gststatecode"];
            string status = context.Request["Status"];
            string btnVal = context.Request["btnval"];
            string sno = context.Request["sno"];
            string branchid = context.Session["BranchID"].ToString();
            string createdby = context.Session["Employ_Sno"].ToString();
            DateTime createdon = DateTime.Now;
            if (btnVal == "Save")
            {
                cmd = new SqlCommand("insert into  statemastar(statename, statecode, gststatecode, status, createdon, createdby) values (@statename, @statecode, @gststatecode, @Status,  @createdon, @createdby)");//,color,@color
                cmd.Parameters.Add("@statename", statename);
                cmd.Parameters.Add("@statecode", statecode);
                cmd.Parameters.Add("@gststatecode", gststatecode);
                cmd.Parameters.Add("@Status", status);
                cmd.Parameters.Add("@createdon", createdon);
                cmd.Parameters.Add("@createdby", createdby);
                vdm.insert(cmd);
                string Response = GetJson("State Details are Successfully Inserted");
                context.Response.Write(Response);
            }
            else
            {
                cmd = new SqlCommand("UPDATE statemastar SET statename=@statename, statecode=@statecode, gststatecode=@gststatecode, status=@status WHERE sno=@sno");//,color,@color
                cmd.Parameters.Add("@statename", statename);
                cmd.Parameters.Add("@statecode", statecode);
                cmd.Parameters.Add("@gststatecode", gststatecode);
                cmd.Parameters.Add("@Status", status);
                cmd.Parameters.Add("@sno", sno);
                vdm.Update(cmd);
                string Response = GetJson("State Details are Successfully Modified");
                context.Response.Write(Response);
            }
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    private void get_state_details(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            cmd = new SqlCommand("SELECT statename, statecode, gststatecode, status, sno FROM statemastar");
            DataTable routes = vdm.SelectQuery(cmd).Tables[0];
            List<categorydetails> SectionMaster = new List<categorydetails>();
            foreach (DataRow dr in routes.Rows)
            {
                categorydetails getsectiondetails = new categorydetails();
                getsectiondetails.statename = dr["statename"].ToString();
                getsectiondetails.statecode = dr["statecode"].ToString();
                getsectiondetails.gststatecode = dr["gststatecode"].ToString();
                getsectiondetails.status = dr["status"].ToString();
                getsectiondetails.sno = dr["sno"].ToString();
                SectionMaster.Add(getsectiondetails);
            }
            string response = GetJson(SectionMaster);
            context.Response.Write(response);
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    private void btnsave_gstregtype(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            string regtype = context.Request["regtype"];
            string status = context.Request["Status"];
            string btnVal = context.Request["btnval"];
            string sno = context.Request["sno"];
            string branchid = context.Session["BranchID"].ToString();
            string createdby = context.Session["Employ_Sno"].ToString();
            DateTime createdon = DateTime.Now;
            if (btnVal == "Save")
            {
                cmd = new SqlCommand("insert into  Gstregtype(gstregtype, status, createdon, createdby) values (@regtype, @status, @createdon, @createdby)");//,color,@color
                cmd.Parameters.Add("@regtype", regtype);
                cmd.Parameters.Add("@Status", status);
                cmd.Parameters.Add("@createdon", createdon);
                cmd.Parameters.Add("@createdby", createdby);
                vdm.insert(cmd);
                string Response = GetJson("Gst regtype Details are Successfully Inserted");
                context.Response.Write(Response);
            }
            else
            {
                cmd = new SqlCommand("UPDATE Gstregtype SET gstregtype=@regtype, status=@status WHERE sno=@sno");//,color,@color
                cmd.Parameters.Add("@regtype", regtype);
                cmd.Parameters.Add("@Status", status);
                cmd.Parameters.Add("@sno", sno);
                vdm.Update(cmd);
                string Response = GetJson("Gst regtype Details are Successfully Modified");
                context.Response.Write(Response);
            }
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    private void get_gstregtype_details(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            cmd = new SqlCommand("SELECT gstregtype, status, sno FROM Gstregtype");
            DataTable routes = vdm.SelectQuery(cmd).Tables[0];
            List<categorydetails> SectionMaster = new List<categorydetails>();
            foreach (DataRow dr in routes.Rows)
            {
                categorydetails getsectiondetails = new categorydetails();
                getsectiondetails.gstregtype = dr["gstregtype"].ToString();
                getsectiondetails.status = dr["status"].ToString();
                getsectiondetails.sno = dr["sno"].ToString();
                SectionMaster.Add(getsectiondetails);
            }
            string response = GetJson(SectionMaster);
            context.Response.Write(response);
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    private void btn_save_parlor(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            string cmpid = context.Request["cmpid"];
            string locationid = context.Request["branchid"];
            string parlorname = context.Request["parlorname"];
            string parlorcode = context.Request["parlorcode"];
            string parlortype = context.Request["parlortype"];
            string pramotername = context.Request["pramotername"];
            string state = context.Request["state"];
            string mobileno = context.Request["mobileno"];
            string email = context.Request["email"];
            string panno = context.Request["panno"];
            string tinno = context.Request["tinno"];
            string cstno = context.Request["cstno"];
            string gstin = context.Request["gstin"];
            string regtype = context.Request["regtype"];
            string tallyledger = context.Request["tallyledger"];
            string sapledger = context.Request["sapledger"];
            string sapledgercode = context.Request["sapledgercode"];
            string address = context.Request["address"];
            string status = context.Request["Status"];
            string btnVal = context.Request["btnval"];
            string sno = context.Request["sno"];
            string branchid = context.Session["BranchID"].ToString();
            string createdby = context.Session["Employ_Sno"].ToString();
            DateTime createdon = DateTime.Now;
            if (btnVal == "Save")
            {
                cmd = new SqlCommand("insert into  branchmaster(cmpid, locationid,  branchname, branchcode, branchtype, address, phone, emailid, pramotername, tino, stno, cstno,  gstin, regtype, stateid, flag, panno, status, createdby, createdon, tallyledger, sapledger, sapledgercode) values (@cmpid, @locationid, @branchname, @branchcode, @branchtype, @address, @phone, @emailid, @pramotername, @tino, @stno, @cstno, @gstin, @regtype, @stateid, @flag, @panno, @status, @createdby, @createdon, @tallyledger, @sapledger, @sapledgercode)");//,color,@color
                cmd.Parameters.Add("@cmpid", cmpid);
                cmd.Parameters.Add("@locationid", locationid);
                cmd.Parameters.Add("@branchname", parlorname);
                cmd.Parameters.Add("@branchcode", parlorcode);
                cmd.Parameters.Add("@branchtype", parlortype);
                cmd.Parameters.Add("@address", address);
                cmd.Parameters.Add("@phone", mobileno);
                cmd.Parameters.Add("@emailid", email);
                cmd.Parameters.Add("@pramotername", pramotername);
                cmd.Parameters.Add("@tino", tinno);
                cmd.Parameters.Add("@stno", "st");
                cmd.Parameters.Add("@cstno", cstno);
                cmd.Parameters.Add("@gstin", gstin);
                cmd.Parameters.Add("@regtype", regtype);
                cmd.Parameters.Add("@stateid", state);
                cmd.Parameters.Add("@flag", "1");
                cmd.Parameters.Add("@panno", panno);
                cmd.Parameters.Add("@status", status);
                cmd.Parameters.Add("@createdby", createdby);
                cmd.Parameters.Add("@createdon", createdon);
                cmd.Parameters.Add("@tallyledger", tallyledger);
                cmd.Parameters.Add("@sapledger", sapledger);
                cmd.Parameters.Add("@sapledgercode", sapledgercode);
                vdm.insert(cmd);
                string Response = GetJson("Parlor Details are Successfully Inserted");
                context.Response.Write(Response);
            }
            else
            {
                cmd = new SqlCommand("UPDATE branchmaster SET tallyledger=@tallyledger, sapledger=@sapledger, sapledgercode=@sapledgercode, cmpid=@cmpid,locationid=@locationid, branchname=@branchname, branchcode=@branchcode, branchtype=@branchtype, address=@address, phone=@phone, emailid=@emailid, pramotername=@pramotername, tino=@tino, stno=@stno, cstno=@cstno,  gstin=@gstin, regtype=@regtype, stateid=@stateid, flag=@flag, panno=@panno,  status=@status WHERE branchid=@sno");//,color,@color
                cmd.Parameters.Add("@cmpid", cmpid);
                cmd.Parameters.Add("@locationid", locationid);
                cmd.Parameters.Add("@branchname", parlorname);
                cmd.Parameters.Add("@branchcode", parlorcode);
                cmd.Parameters.Add("@branchtype", parlortype);
                cmd.Parameters.Add("@address", address);
                cmd.Parameters.Add("@phone", mobileno);
                cmd.Parameters.Add("@emailid", email);
                cmd.Parameters.Add("@pramotername", pramotername);
                cmd.Parameters.Add("@tino", tinno);
                cmd.Parameters.Add("@stno", "st");
                cmd.Parameters.Add("@cstno", cstno);
                cmd.Parameters.Add("@gstin", gstin);
                cmd.Parameters.Add("@regtype", regtype);
                cmd.Parameters.Add("@stateid", state);
                cmd.Parameters.Add("@flag", "1");
                cmd.Parameters.Add("@panno", panno);
                cmd.Parameters.Add("@status", status);
                cmd.Parameters.Add("@sno", sno);
                cmd.Parameters.Add("@tallyledger", tallyledger);
                cmd.Parameters.Add("@sapledger", sapledger);
                cmd.Parameters.Add("@sapledgercode", sapledgercode);
                vdm.Update(cmd);
                string Response = GetJson("Parlor Details are Successfully Modified");
                context.Response.Write(Response);
            }
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    private void btn_save_subdistibutor(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            string cmpid = context.Request["cmpid"];
            string locationid = context.Request["branchid"];
            string parlorname = context.Request["parlorname"];
            string parlorcode = context.Request["parlorcode"];
            string parlortype = context.Request["parlortype"];
            string pramotername = context.Request["pramotername"];
            string state = context.Request["state"];
            string mobileno = context.Request["mobileno"];
            string email = context.Request["email"];
            string panno = context.Request["panno"];
            string tinno = context.Request["tinno"];
            string cstno = context.Request["cstno"];
            string gstin = context.Request["gstin"];
            string regtype = context.Request["regtype"];
            string tallyledger = context.Request["tallyledger"];
            string sapledger = context.Request["sapledger"];
            string sapledgercode = context.Request["sapledgercode"];
            string address = context.Request["address"];
            string status = context.Request["Status"];
            string btnVal = context.Request["btnval"];
            string sno = context.Request["sno"];
            string branchid = context.Session["BranchID"].ToString();
            string createdby = context.Session["Employ_Sno"].ToString();
            DateTime createdon = DateTime.Now;
            if (btnVal == "Save")
            {
                cmd = new SqlCommand("insert into  subdistibutor(cmpid, locationid,  distibutorname, branchcode, branchtype, address, phone, emailid, pramotername, tino, stno, cstno,  gstin, regtype, stateid, flag, panno, status, createdby, createdon, tallyledger, sapledger, sapledgercode) values (@cmpid, @locationid, @branchname, @branchcode, @branchtype, @address, @phone, @emailid, @pramotername, @tino, @stno, @cstno, @gstin, @regtype, @stateid, @flag, @panno, @status, @createdby, @createdon, @tallyledger, @sapledger, @sapledgercode)");//,color,@color
                cmd.Parameters.Add("@cmpid", cmpid);
                cmd.Parameters.Add("@locationid", locationid);
                cmd.Parameters.Add("@branchname", parlorname);
                cmd.Parameters.Add("@branchcode", parlorcode);
                cmd.Parameters.Add("@branchtype", parlortype);
                cmd.Parameters.Add("@address", address);
                cmd.Parameters.Add("@phone", mobileno);
                cmd.Parameters.Add("@emailid", email);
                cmd.Parameters.Add("@pramotername", pramotername);
                cmd.Parameters.Add("@tino", tinno);
                cmd.Parameters.Add("@stno", "st");
                cmd.Parameters.Add("@cstno", cstno);
                cmd.Parameters.Add("@gstin", gstin);
                cmd.Parameters.Add("@regtype", regtype);
                cmd.Parameters.Add("@stateid", state);
                cmd.Parameters.Add("@flag", "1");
                cmd.Parameters.Add("@panno", panno);
                cmd.Parameters.Add("@status", status);
                cmd.Parameters.Add("@createdby", createdby);
                cmd.Parameters.Add("@createdon", createdon);
                cmd.Parameters.Add("@tallyledger", tallyledger);
                cmd.Parameters.Add("@sapledger", sapledger);
                cmd.Parameters.Add("@sapledgercode", sapledgercode);
                vdm.insert(cmd);
                string Response = GetJson("Distibutor Details are Successfully Inserted");
                context.Response.Write(Response);
            }
            else
            {
                cmd = new SqlCommand("UPDATE subdistibutor SET tallyledger=@tallyledger, sapledger=@sapledger, sapledgercode=@sapledgercode, cmpid=@cmpid,locationid=@locationid, distibutorname=@branchname, branchcode=@branchcode, branchtype=@branchtype, address=@address, phone=@phone, emailid=@emailid, pramotername=@pramotername, tino=@tino, stno=@stno, cstno=@cstno,  gstin=@gstin, regtype=@regtype, stateid=@stateid, flag=@flag, panno=@panno,  status=@status WHERE branchid=@sno");//,color,@color
                cmd.Parameters.Add("@cmpid", cmpid);
                cmd.Parameters.Add("@locationid", locationid);
                cmd.Parameters.Add("@branchname", parlorname);
                cmd.Parameters.Add("@branchcode", parlorcode);
                cmd.Parameters.Add("@branchtype", parlortype);
                cmd.Parameters.Add("@address", address);
                cmd.Parameters.Add("@phone", mobileno);
                cmd.Parameters.Add("@emailid", email);
                cmd.Parameters.Add("@pramotername", pramotername);
                cmd.Parameters.Add("@tino", tinno);
                cmd.Parameters.Add("@stno", "st");
                cmd.Parameters.Add("@cstno", cstno);
                cmd.Parameters.Add("@gstin", gstin);
                cmd.Parameters.Add("@regtype", regtype);
                cmd.Parameters.Add("@stateid", state);
                cmd.Parameters.Add("@flag", "1");
                cmd.Parameters.Add("@panno", panno);
                cmd.Parameters.Add("@status", status);
                cmd.Parameters.Add("@sno", sno);
                cmd.Parameters.Add("@tallyledger", tallyledger);
                cmd.Parameters.Add("@sapledger", sapledger);
                cmd.Parameters.Add("@sapledgercode", sapledgercode);
                vdm.Update(cmd);
                string Response = GetJson("Distibutor Details are Successfully Modified");
                context.Response.Write(Response);
            }
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    public class parlordetails
    {
        public string parlorid { get; set; }
        public string parlorname { get; set; }
        public string address { get; set; }
        public string status { get; set; }
        public string phone { get; set; }
        public string sno { get; set; }
        public string tinno { get; set; }
        public string stno { get; set; }
        public string cstno { get; set; }
        public string emailid { get; set; }
        public string gstin { get; set; }
        public string regtype { get; set; }
        public string stateid { get; set; }
        public string parlorcode { get; set; }
        public string parlortype { get; set; }
        public string panno { get; set; }
        public string pramotername { get; set; }
        public string locationid { get; set; }
        public string cmpid { get; set; }
        public string tallyledger { get; set; }
        public string sapledger { get; set; }
        public string sapledgercode { get; set; }


    }

    private void get_parlor_details(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            string LevelType = context.Session["LevelType"].ToString();
            string BranchID = context.Session["BranchID"].ToString();
            if (LevelType == "SuperAdmin" || LevelType == "AccountsOfficer")
            {
                cmd = new SqlCommand("SELECT cmpid, locationid, branchid, branchname, address, phone, tino, stno, cstno, emailid, gstin, regtype, stateid, titlename, branchcode, pramoterid, lat, long, flag,  panno, branchtype, status, pramotername, tallyledger, sapledger, sapledgercode FROM  branchmaster as aa INNER JOIN branchmapping as bb ON aa.branchid=bb.subbranch where bb.superbranch=@branchid ");
            }
            else
            {
                cmd = new SqlCommand("SELECT cmpid, locationid, branchid, branchname, address, phone, tino, stno, cstno, emailid, gstin, regtype, stateid, titlename, branchcode, pramoterid, lat, long, flag,  panno, branchtype, status, pramotername, tallyledger, sapledger, sapledgercode FROM  branchmaster  as aa INNER JOIN branchmapping as bb ON aa.branchid=bb.subbranch where bb.subbranch=@branchid");
            }
            cmd.Parameters.Add("@branchid", BranchID);

            DataTable routes = vdm.SelectQuery(cmd).Tables[0];
            List<parlordetails> SectionMaster = new List<parlordetails>();
            foreach (DataRow dr in routes.Rows)
            {
                parlordetails getsectiondetails = new parlordetails();
                getsectiondetails.cmpid = dr["cmpid"].ToString();
                getsectiondetails.locationid = dr["locationid"].ToString();
                getsectiondetails.parlorid = dr["branchid"].ToString();
                getsectiondetails.parlorname = dr["branchname"].ToString();
                getsectiondetails.address = dr["address"].ToString();
                getsectiondetails.phone = dr["phone"].ToString();
                getsectiondetails.tinno = dr["tino"].ToString();
                getsectiondetails.cstno = dr["cstno"].ToString();
                getsectiondetails.emailid = dr["emailid"].ToString();
                getsectiondetails.gstin = dr["gstin"].ToString();
                getsectiondetails.regtype = dr["regtype"].ToString();
                getsectiondetails.stateid = dr["stateid"].ToString();
                getsectiondetails.parlorcode = dr["branchcode"].ToString();
                getsectiondetails.panno = dr["panno"].ToString();
                getsectiondetails.parlortype = dr["branchtype"].ToString();
                getsectiondetails.status = dr["status"].ToString();
                getsectiondetails.sno = dr["branchid"].ToString();
                getsectiondetails.pramotername = dr["pramotername"].ToString();
                getsectiondetails.tallyledger = dr["tallyledger"].ToString();
                getsectiondetails.sapledger = dr["sapledger"].ToString();
                getsectiondetails.sapledgercode = dr["sapledgercode"].ToString();
                SectionMaster.Add(getsectiondetails);
            }
            string response = GetJson(SectionMaster);
            context.Response.Write(response);
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    private void get_subdistibutor_details(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            cmd = new SqlCommand("SELECT cmpid, locationid, sno, distibutorname, address, phone, tino, stno, cstno, emailid, gstin, regtype, stateid, titlename, branchcode, pramoterid, lat, long, flag,  panno, branchtype, status, pramotername, tallyledger, sapledger, sapledgercode FROM  subdistibutor");
            DataTable routes = vdm.SelectQuery(cmd).Tables[0];
            List<parlordetails> SectionMaster = new List<parlordetails>();
            foreach (DataRow dr in routes.Rows)
            {
                parlordetails getsectiondetails = new parlordetails();
                getsectiondetails.cmpid = dr["cmpid"].ToString();
                getsectiondetails.locationid = dr["locationid"].ToString();
                getsectiondetails.parlorid = dr["sno"].ToString();
                getsectiondetails.parlorname = dr["distibutorname"].ToString();
                getsectiondetails.address = dr["address"].ToString();
                getsectiondetails.phone = dr["phone"].ToString();
                getsectiondetails.tinno = dr["tino"].ToString();
                getsectiondetails.cstno = dr["cstno"].ToString();
                getsectiondetails.emailid = dr["emailid"].ToString();
                getsectiondetails.gstin = dr["gstin"].ToString();
                getsectiondetails.regtype = dr["regtype"].ToString();
                getsectiondetails.stateid = dr["stateid"].ToString();
                getsectiondetails.parlorcode = dr["branchcode"].ToString();
                getsectiondetails.panno = dr["panno"].ToString();
                getsectiondetails.parlortype = dr["branchtype"].ToString();
                getsectiondetails.status = dr["status"].ToString();
                getsectiondetails.sno = dr["sno"].ToString();
                getsectiondetails.pramotername = dr["pramotername"].ToString();
                getsectiondetails.tallyledger = dr["tallyledger"].ToString();
                getsectiondetails.sapledger = dr["sapledger"].ToString();
                getsectiondetails.sapledgercode = dr["sapledgercode"].ToString();
                SectionMaster.Add(getsectiondetails);
            }
            string response = GetJson(SectionMaster);
            context.Response.Write(response);
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    private void btnsave_Departmentclick(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            string Department = context.Request["Department"];
            string deptcode = context.Request["deptcode"];
            string status = context.Request["Status"];
            string btnVal = context.Request["btnval"];
            string sno = context.Request["sno"];
            string branchid = context.Session["BranchID"].ToString();
            string createdby = context.Session["Employ_Sno"].ToString();
            DateTime createdon = DateTime.Now;
            if (btnVal == "Save")
            {
                cmd = new SqlCommand("insert into  departmentmaster(department, deptcode, status, createdon, createdby) values (@department, @deptcode,  @Status,  @createdon, @createdby)");//,color,@color
                cmd.Parameters.Add("@department", Department);
                cmd.Parameters.Add("@deptcode", deptcode);
                cmd.Parameters.Add("@Status", status);
                cmd.Parameters.Add("@createdon", createdon);
                cmd.Parameters.Add("@createdby", createdby);
                vdm.insert(cmd);
                string Response = GetJson("Department Details are Successfully Inserted");
                context.Response.Write(Response);
            }
            else
            {
                cmd = new SqlCommand("UPDATE departmentmaster SET department=@department, deptcode=@deptcode, status=@status WHERE sno=@sno");//,color,@color
                cmd.Parameters.Add("@department", Department);
                cmd.Parameters.Add("@deptcode", deptcode);
                cmd.Parameters.Add("@Status", status);
                cmd.Parameters.Add("@sno", sno);
                vdm.Update(cmd);
                string Response = GetJson("Department Details are Successfully Modified");
                context.Response.Write(Response);
            }
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    public class Deptdetails
    {
        public string department { get; set; }
        public string deptcode { get; set; }
        public string status { get; set; }
        public string sno { get; set; }
        public string designation { get; set; }
        public string desgcode { get; set; }

    }
    private void get_Department_details(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            cmd = new SqlCommand("SELECT department, deptcode, status, sno FROM departmentmaster");
            DataTable routes = vdm.SelectQuery(cmd).Tables[0];
            List<Deptdetails> DeptMaster = new List<Deptdetails>();
            foreach (DataRow dr in routes.Rows)
            {
                Deptdetails getdeptdetails = new Deptdetails();
                getdeptdetails.department = dr["department"].ToString();
                getdeptdetails.deptcode = dr["deptcode"].ToString();
                getdeptdetails.status = dr["status"].ToString();
                getdeptdetails.sno = dr["sno"].ToString();
                DeptMaster.Add(getdeptdetails);
            }
            string response = GetJson(DeptMaster);
            context.Response.Write(response);
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    public class supplierdetails
    {
        public string supname { get; set; }
        public string email { get; set; }
        public string phoneno { get; set; }
        public string gstno { get; set; }
        public string address { get; set; }
        public string status { get; set; }
        public string state { get; set; }
        public string gstregtype { get; set; }
        public string btnVal { get; set; }
        public string sno { get; set; }
        public string branchid { get; set; }
        public string createdby { get; set; }
    }
    private void btnsave_designation(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            string designation = context.Request["designation"];
            string designationcode = context.Request["designationcode"];
            string status = context.Request["Status"];
            string btnVal = context.Request["btnval"];
            string sno = context.Request["sno"];
            string branchid = context.Session["BranchID"].ToString();
            string createdby = context.Session["Employ_Sno"].ToString();
            DateTime createdon = DateTime.Now;
            if (btnVal == "Save")
            {
                cmd = new SqlCommand("insert into  designationmaster(designation, designationcode, status, createdon, createdby) values (@designation, @designationcode,  @Status,  @createdon, @createdby)");//,color,@color
                cmd.Parameters.Add("@designation", designation);
                cmd.Parameters.Add("@designationcode", designationcode);
                cmd.Parameters.Add("@Status", status);
                cmd.Parameters.Add("@createdon", createdon);
                cmd.Parameters.Add("@createdby", createdby);
                vdm.insert(cmd);
                string Response = GetJson("Designation Details are Successfully Inserted");
                context.Response.Write(Response);
            }
            else
            {
                cmd = new SqlCommand("UPDATE designationmaster SET designation=@designation, designationcode=@designationcode, status=@status WHERE sno=@sno");//,color,@color
                cmd.Parameters.Add("@designation", designation);
                cmd.Parameters.Add("@designationcode", designationcode);
                cmd.Parameters.Add("@Status", status);
                cmd.Parameters.Add("@sno", sno);
                vdm.Update(cmd);
                string Response = GetJson("Designation Details are Successfully Modified");
                context.Response.Write(Response);
            }
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    private void save_supplierdetails(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            string supname = context.Request["supname"];
            string email = context.Request["email"];
            string phoneno = context.Request["phoneno"];
            string gstno = context.Request["gstno"];
            string address = context.Request["address"];
            string status = context.Request["Status"];
            string state = context.Request["state"];
            string gstregtype = context.Request["gstregtype"];
            string btnVal = context.Request["btnval"];
            string sno = context.Request["sno"];
            string branchid = context.Session["BranchID"].ToString();
            string createdby = context.Session["Employ_Sno"].ToString();
            DateTime createdon = DateTime.Now;
            if (btnVal == "Save")
            {
                cmd = new SqlCommand("insert into  suppliersdetails(name, email, mobileno, gstno, address, stateid, gstregtype, branchid, status, createdon, createdby) values (@name, @email, @mobileno, @gstno, @address, @state, @gstregtype, @branchid, @Status,  @createdon, @createdby)");//,color,@color
                cmd.Parameters.Add("@name", supname);
                cmd.Parameters.Add("@email", email);
                cmd.Parameters.Add("@mobileno", phoneno);
                cmd.Parameters.Add("@gstno", gstno);
                cmd.Parameters.Add("@address", address);
                cmd.Parameters.Add("@state", state);
                cmd.Parameters.Add("@branchid", branchid);
                cmd.Parameters.Add("@Status", status);
                cmd.Parameters.Add("@createdon", createdon);
                cmd.Parameters.Add("@createdby", createdby);
                cmd.Parameters.Add("@gstregtype", gstregtype);
                vdm.insert(cmd);
                string Response = GetJson("Supplier Details are Successfully Inserted");
                context.Response.Write(Response);
            }
            else
            {
                //cmd = new SqlCommand("UPDATE suppliermaster SET designation=@designation, designationcode=@designationcode, status=@status WHERE sno=@sno");//,color,@color
                //cmd.Parameters.Add("@designation", designation);
                //cmd.Parameters.Add("@designationcode", designationcode);
                //cmd.Parameters.Add("@Status", status);
                //cmd.Parameters.Add("@sno", sno);
                //vdm.Update(cmd);
                //string Response = GetJson("Designation Details are Successfully Modified");
                //context.Response.Write(Response);
            }
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }
    //
    private void get_designation_details(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            cmd = new SqlCommand("SELECT sno, designation, designationcode, status, createdon, createdby  FROM  designationmaster");
            DataTable routes = vdm.SelectQuery(cmd).Tables[0];
            List<Deptdetails> DeptMaster = new List<Deptdetails>();
            foreach (DataRow dr in routes.Rows)
            {
                Deptdetails getdeptdetails = new Deptdetails();
                getdeptdetails.designation = dr["designation"].ToString();
                getdeptdetails.desgcode = dr["designationcode"].ToString();
                getdeptdetails.status = dr["status"].ToString();
                getdeptdetails.sno = dr["sno"].ToString();
                DeptMaster.Add(getdeptdetails);
            }
            string response = GetJson(DeptMaster);
            context.Response.Write(response);
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    private void get_supplierdetails(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            cmd = new SqlCommand("SELECT supplierid, name, email, mobileno, gstno, address, stateid, gstregtype, branchid, status  FROM  suppliersdetails");
            DataTable routes = vdm.SelectQuery(cmd).Tables[0];
            List<supplierdetails> DeptMaster = new List<supplierdetails>();
            foreach (DataRow dr in routes.Rows)
            {
                supplierdetails getdeptdetails = new supplierdetails();
                getdeptdetails.supname = dr["name"].ToString();
                getdeptdetails.email = dr["email"].ToString();
                getdeptdetails.phoneno = dr["mobileno"].ToString();
                getdeptdetails.gstno = dr["gstno"].ToString();
                getdeptdetails.address = dr["address"].ToString();
                getdeptdetails.state = dr["stateid"].ToString();
                getdeptdetails.gstregtype = dr["gstregtype"].ToString();
                getdeptdetails.branchid = dr["branchid"].ToString();
                getdeptdetails.status = dr["status"].ToString();
                getdeptdetails.sno = dr["supplierid"].ToString();
                DeptMaster.Add(getdeptdetails);
            }
            string response = GetJson(DeptMaster);
            context.Response.Write(response);
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    private void save_openregisterDetails(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            string cashinhand = context.Request["cashinhand"];
            string btnVal = context.Request["btnval"];
            string branchid = context.Session["BranchID"].ToString();
            string createdby = context.Session["Employ_Sno"].ToString();
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
            if (btnVal == "Open Register")
            {
                cmd = new SqlCommand("insert into registrationopendetials(cashinhand, ob, parlorid, doe, createdon, opendby) values (@cashinhand, @ob,  @parlorid, @doe,  @createdon, @createdby)");//,color,@color
                cmd.Parameters.Add("@cashinhand", cashinhand);
                cmd.Parameters.Add("@ob", cashinhand);
                cmd.Parameters.Add("@parlorid", branchid);
                cmd.Parameters.Add("@doe", ServerDateCurrentdate);
                cmd.Parameters.Add("@createdon", ServerDateCurrentdate);
                cmd.Parameters.Add("@createdby", createdby);
                vdm.insert(cmd);
                string Response = GetJson("Register is Opend Successfully");
                context.Response.Write(Response);
            }
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    private void get_registordetails(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            string parlorid = context.Session["BranchID"].ToString();
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
            cmd = new SqlCommand("SELECT sno, cashinhand, cashsale, chequesale, giftcardsale, ccsale, stripesale, othersale, totalsale, expenses, totalcash, submittedcash, submittedslips, submittedchecks, description, parlorid, createdon, doe, closedby  FROM registorclosingdetails where doe between @d1 and @d2 AND  parlorid=@parlorid");
            cmd.Parameters.Add("@parlorid", parlorid);
            cmd.Parameters.Add("@d1", GetLowDate(ServerDateCurrentdate).AddDays(-1));
            cmd.Parameters.Add("@d2", GetHighDate(ServerDateCurrentdate).AddDays(-1));
            DataTable dtcloseregistor = vdm.SelectQuery(cmd).Tables[0];
            string response = "ok";
            if (dtcloseregistor.Rows.Count > 0)
            {
                cmd = new SqlCommand("SELECT sno, cashinhand, ob, parlorid, doe, createdon, opendby FROM  registrationopendetials where doe between @d1 and @d2 AND  parlorid=@parlorid");
                cmd.Parameters.Add("@parlorid", parlorid);
                cmd.Parameters.Add("@d1", GetLowDate(ServerDateCurrentdate));
                cmd.Parameters.Add("@d2", GetHighDate(ServerDateCurrentdate));
                DataTable dtopenregistor = vdm.SelectQuery(cmd).Tables[0];
                if (dtopenregistor.Rows.Count > 0)
                {

                }
                else
                {
                    response = GetJson("Please Open The Registor Details");
                }
            }
            else
            {
                response = GetJson("Please Close The Yesterday Registor Details");
            }
            context.Response.Write(response);
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }


    public class RegcloseDetails
    {
        public string cashinhand { get; set; }
        public string cashsale { get; set; }
        public string chequesale { get; set; }
        public string giftcardsale { get; set; }
        public string ccsale { get; set; }
        public string stripesale { get; set; }
        public string othersale { get; set; }
        public string totalsale { get; set; }
        public string expenses { get; set; }
        public string totalcash { get; set; }
        public string submittedcash { get; set; }
        public string submittedslips { get; set; }
        public string submittedchecks { get; set; }
        public string description { get; set; }
        public string btnreg { get; set; }
        public string doe { get; set; }
        public string sno { get; set; }
        public string phonepay { get; set; }
        public string paytm { get; set; }
        public List<SubRegcloseDetails> closeitems { get; set; }
    }

    public class SubRegcloseDetails
    {
        public string dinamination { get; set; }
        public string Quantity { get; set; }
        public string hdnproductsno { get; set; }
        public string price { get; set; }
    }

    public class getRegcloseDetails
    {
        public List<RegcloseDetails> RegDetails { get; set; }
        public List<SubRegcloseDetails> SubRegclose { get; set; }
    }

    private void backdatesave_parlorerclosingregister(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            var js = new JavaScriptSerializer();
            var title1 = context.Request.Params[1];
            RegcloseDetails obj = js.Deserialize<RegcloseDetails>(title1);
            string cashinhand = obj.cashinhand;
            string cashsale = obj.cashsale;
            string chequesale = obj.chequesale;
            string giftcardsale = obj.giftcardsale;
            string ccsale = obj.ccsale;
            string stripesale = obj.stripesale;
            string othersale = obj.othersale;
            string totalsale = obj.totalsale;
            string expenses = obj.expenses;
            string totalcash = obj.totalcash;
            string submittedcash = obj.submittedcash;
            string submittedslips = obj.submittedslips;
            string submittedchecks = obj.submittedchecks;
            string description = obj.description;
            string btnreg = obj.btnreg;
            string phonepay = obj.phonepay;
            string paytm = obj.paytm;
            string branchid = context.Session["BranchID"].ToString();
            string createdby = context.Session["Employ_Sno"].ToString();
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
            DateTime closedate = ServerDateCurrentdate.AddDays(-1);
            cmd = new SqlCommand("select * from registorclosingdetails where parlorid=@branchid AND doe between @d1 and @d2");
            cmd.Parameters.Add("@d1", GetLowDate(closedate));
            cmd.Parameters.Add("@d2", GetHighDate(closedate));
            cmd.Parameters.Add("@branchid", branchid);
            DataTable dtexisting = vdm.SelectQuery(cmd).Tables[0];
            if (dtexisting.Rows.Count == 0)
            {
                if (btnreg == "closereg")
                {
                    cmd = new SqlCommand("insert into registorclosingdetails(cashinhand, cashsale, chequesale, giftcardsale, ccsale, stripesale, othersale, totalsale, expenses, totalcash, submittedcash, submittedslips, submittedchecks, description, parlorid, createdon, closedby, doe, paytm, phonepay) values (@cashinhand, @cashsale,  @chequesale,  @giftcardsale, @ccsale, @stripesale, @othersale, @totalsale, @expenses, @totalcash, @submittedcash, @submittedslips, @submittedchecks, @description, @parlorid, @createdon, @closedby, @doe, @paytm, @phonepay)");//,color,@color
                    cmd.Parameters.Add("@cashinhand", cashinhand);
                    cmd.Parameters.Add("@cashsale", cashsale);
                    cmd.Parameters.Add("@chequesale", chequesale);
                    cmd.Parameters.Add("@giftcardsale", giftcardsale);
                    cmd.Parameters.Add("@ccsale", ccsale);
                    cmd.Parameters.Add("@stripesale", stripesale);
                    cmd.Parameters.Add("@othersale", othersale);
                    cmd.Parameters.Add("@totalsale", totalsale);
                    cmd.Parameters.Add("@expenses", expenses);
                    cmd.Parameters.Add("@totalcash", totalcash);//@submittedcash, @submittedslips, @submittedchecks, @description, @parlorid, @createdon, @closedby
                    cmd.Parameters.Add("@submittedcash", submittedcash);
                    cmd.Parameters.Add("@submittedslips", submittedslips);
                    cmd.Parameters.Add("@submittedchecks", submittedchecks);
                    cmd.Parameters.Add("@description", description);
                    cmd.Parameters.Add("@paytm", paytm);
                    cmd.Parameters.Add("@phonepay", phonepay);
                    cmd.Parameters.Add("@parlorid", branchid);
                    cmd.Parameters.Add("@createdon", ServerDateCurrentdate);
                    cmd.Parameters.Add("@doe", closedate);
                    cmd.Parameters.Add("@closedby", createdby);
                    vdm.insert(cmd);
                    cmd = new SqlCommand("select MAX(sno) as refno from registorclosingdetails");
                    DataTable dtoutward = vdm.SelectQuery(cmd).Tables[0];
                    string refno = dtoutward.Rows[0]["refno"].ToString();
                    foreach (SubRegcloseDetails si in obj.closeitems)
                    {
                        if (si.hdnproductsno != "0")
                        {
                            cmd = new SqlCommand("insert into registorclosing_dinaminationdetails(dinaminationid, dinamination, qty, refno) values(@productid, @dinamination, @quantity, @in_refno)");
                            cmd.Parameters.Add("@dinamination", si.dinamination);
                            cmd.Parameters.Add("@productid", si.hdnproductsno);
                            cmd.Parameters.Add("@quantity", si.Quantity);
                            cmd.Parameters.Add("@in_refno", refno);
                            vdm.insert(cmd);
                        }
                    }
                    cmd = new SqlCommand("select * from productmoniter where branchid=@branchid");
                    cmd.Parameters.Add("@branchid", branchid);
                    DataTable dtitem = vdm.SelectQuery(cmd).Tables[0];
                    cmd = new SqlCommand("select sno, refno, productid, price, op_bal as opQty, inwardqty, saleqty, clo_bal as  closeqty, branchid, doe, return_qty\r\n from sub_registorclosingdetails where (branchid=@branchid) and (doe between @d1 and @d2)");
                    cmd.Parameters.AddWithValue("@d1", GetLowDate((closedate).AddDays(-1)));
                    cmd.Parameters.AddWithValue("@d2", GetHighDate((closedate).AddDays(-1)));
                    cmd.Parameters.AddWithValue("@branchid", branchid);
                    DataTable dtop = vdm.SelectQuery(cmd).Tables[0];

                    DateTime dt_fromdate = Convert.ToDateTime(closedate);
                    cmd = new SqlCommand("SELECT SUM(inward_subdetails.qty) AS inwardqty,productmaster.productname, productmaster.productid,(CONVERT(NVARCHAR(10), inward_maindetails.doe, 120)) AS doe  FROM   inward_maindetails INNER JOIN  inward_subdetails ON inward_maindetails.sno = inward_subdetails.refno INNER JOIN productmaster ON productmaster.productid = inward_subdetails.productid  WHERE (inward_maindetails.doe BETWEEN @d11 AND @d22) AND (inward_maindetails.branchid = @bidd) AND (inward_maindetails.status = 'A') group by productmaster.productname, (CONVERT(NVARCHAR(10), inward_maindetails.doe, 120)),productmaster.productid");
                    cmd.Parameters.Add("@d11", GetLowDate(dt_fromdate).AddDays(-1));
                    cmd.Parameters.Add("@d22", GetHighDate(dt_fromdate));
                    cmd.Parameters.Add("@bidd", branchid);
                    DataTable dtinward = vdm.SelectQuery(cmd).Tables[0];

                    cmd = new SqlCommand("SELECT   Sum(possale_subdetails.qty) AS outwardqty, productmaster.productid, Sum(possale_subdetails.totvalue) AS totvalue, Sum(possale_subdetails.ordertax) AS ordertax,CAST(possale_maindetails.doe AS date) FROM possale_maindetails INNER JOIN possale_subdetails on possale_subdetails.refno = possale_maindetails.sno INNER JOIN productmaster ON productmaster.productid = possale_subdetails.productid  WHERE possale_maindetails.doe BETWEEN @d1 AND @d2 AND possale_maindetails.branchid=@bid  GROUP BY  productmaster.productid,CAST(possale_maindetails.doe AS date)");
                    cmd.Parameters.Add("@d1", GetLowDate(closedate));
                    cmd.Parameters.Add("@d2", GetHighDate(closedate));
                    cmd.Parameters.Add("@bid", branchid);
                    DataTable dtouward = vdm.SelectQuery(cmd).Tables[0];

                    cmd = new SqlCommand("select  SSR.productid, Sum(SSR.quantity) as quantity,(CONVERT(NVARCHAR(10), SR.doe, 120)) AS doe   from stores_return AS SR INNER JOIN sub_stores_return AS SSR ON SR.sno=SSR.storesreturn_sno INNER JOIN productmaster ON productmaster.productid = SSR.productid WHERE SR.doe between @d1 and @d2 AND SR.branchid=@branchid GROUP BY SSR.productid,(CONVERT(NVARCHAR(10), SR.doe, 120))");//, inwarddetails.indentno
                    cmd.Parameters.Add("@d1", GetLowDate(dt_fromdate).AddDays(-1));
                    cmd.Parameters.Add("@d2", GetHighDate(dt_fromdate));
                    cmd.Parameters.Add("@branchid", branchid);
                    DataTable dtRetrun = vdm.SelectQuery(cmd).Tables[0];

                    foreach (DataRow dr in dtitem.Rows)
                    {
                        double opqty = 0;
                        double inward = 0;
                        double outward = 0;
                        double closing = 0;
                        double ordertax = 0;
                        double totaloutward = 0;
                        double return_qty = 0;
                        foreach (DataRow drop in dtop.Select("productid='" + dr["productid"].ToString() + "'"))
                        {
                            double.TryParse(drop["closeqty"].ToString(), out opqty);
                        }
                        //string date = "";
                        // DateTime dt = Convert.ToDateTime(dr["doe"].ToString());
                        // string date = dt.AddDays(1).ToString("yyyy-MM-dd");
                        //   double.TryParse(dr["clo_bal"].ToString(), out opqty);
                        foreach (DataRow drin in dtinward.Select("productid='" + dr["productid"].ToString() + "'"))
                        {
                            double.TryParse(drin["inwardqty"].ToString(), out inward);
                        }

                        foreach (DataRow drreturn in dtRetrun.Select("productid='" + dr["productid"].ToString() + "'"))
                        {
                            double.TryParse(drreturn["quantity"].ToString(), out return_qty);
                        }

                        foreach (DataRow drout in dtouward.Select("productid='" + dr["productid"].ToString() + "'"))
                        {
                            double.TryParse(drout["outwardqty"].ToString(), out outward);
                            double.TryParse(drout["ordertax"].ToString(), out ordertax);
                            totaloutward = outward + ordertax;
                            totaloutward = Math.Round(totaloutward, 2);
                        }
                        double total = opqty + inward + return_qty;
                        closing = total - outward;
                        cmd = new SqlCommand("insert into sub_registorclosingdetails(refno, productid, price, clo_bal,op_bal,doe,branchid,inwardqty,saleqty,return_qty) values(@refno, @productid, @price, @clo_bal,@op_bal,@doe,@branchid,@inwardqty,@saleqty,@return_qty)");
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
                        cmd.Parameters.Add("@doe", closedate);
                        cmd.Parameters.Add("@branchid", branchid);
                        cmd.Parameters.Add("@inwardqty", inward);
                        cmd.Parameters.Add("@saleqty", outward);
                        cmd.Parameters.Add("@return_qty", return_qty);
                        vdm.insert(cmd);

                        cmd = new SqlCommand("UPDATE productmoniter set qty=@qty, price=@price WHERE productid=@productid AND branchid=@branchid");
                        cmd.Parameters.Add("@branchid", branchid);
                        cmd.Parameters.Add("@productid", dr["productid"].ToString());
                        cmd.Parameters.Add("@qty", closing);
                        cmd.Parameters.Add("@price", dr["price"].ToString());
                        vdm.Update(cmd);
                    }
                    string Response = GetJson("Register Details are Successfully Closed");
                    context.Response.Write(Response);
                }
            }
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    private void save_parlorerclosingregister(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            var js = new JavaScriptSerializer();
            var title1 = context.Request.Params[1];
            RegcloseDetails obj = js.Deserialize<RegcloseDetails>(title1);
            string cashinhand = obj.cashinhand;
            string cashsale = obj.cashsale;
            string chequesale = obj.chequesale;
            string giftcardsale = obj.giftcardsale;
            string ccsale = obj.ccsale;
            string stripesale = obj.stripesale;
            string othersale = obj.othersale;
            string totalsale = obj.totalsale;
            string expenses = obj.expenses;
            string totalcash = obj.totalcash;
            string submittedcash = obj.submittedcash;
            string submittedslips = obj.submittedslips;
            string submittedchecks = obj.submittedchecks;
            string description = obj.description;
            string btnreg = obj.btnreg;
            string paytm = obj.paytm;
            string phonepay = obj.phonepay;
            string branchid = context.Session["BranchID"].ToString();
            string createdby = context.Session["Employ_Sno"].ToString();
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
            DateTime closedate = ServerDateCurrentdate;
            cmd = new SqlCommand("select * from registorclosingdetails where doe between @d1 and @d2 and parlorid=@branchid");
            cmd.Parameters.Add("@d1", GetLowDate(closedate).AddDays(-1));
            cmd.Parameters.Add("@d2", GetHighDate(closedate).AddDays(-1));
            cmd.Parameters.Add("@branchid", branchid);
            DataTable dtexisting = vdm.SelectQuery(cmd).Tables[0];

            
            if (dtexisting.Rows.Count == 0)
            {
                if (btnreg == "closereg")
                {
                    cmd = new SqlCommand("insert into registorclosingdetails(cashinhand, cashsale, chequesale, giftcardsale, ccsale, stripesale, othersale, totalsale, expenses, totalcash, submittedcash, submittedslips, submittedchecks, description, parlorid, createdon, closedby, doe, paytm, phonepay) values (@cashinhand, @cashsale,  @chequesale,  @giftcardsale, @ccsale, @stripesale, @othersale, @totalsale, @expenses, @totalcash, @submittedcash, @submittedslips, @submittedchecks, @description, @parlorid, @createdon, @closedby, @doe, @paytm, @phonepay)");//,color,@color
                    cmd.Parameters.Add("@cashinhand", cashinhand);
                    cmd.Parameters.Add("@cashsale", cashsale);
                    cmd.Parameters.Add("@chequesale", chequesale);
                    cmd.Parameters.Add("@giftcardsale", giftcardsale);
                    cmd.Parameters.Add("@ccsale", ccsale);
                    cmd.Parameters.Add("@stripesale", stripesale);
                    cmd.Parameters.Add("@othersale", othersale);
                    cmd.Parameters.Add("@totalsale", totalsale);

                    cmd.Parameters.Add("@expenses", expenses);
                    cmd.Parameters.Add("@totalcash", totalcash);//@submittedcash, @submittedslips, @submittedchecks, @description, @parlorid, @createdon, @closedby
                    cmd.Parameters.Add("@submittedcash", submittedcash);
                    cmd.Parameters.Add("@submittedslips", submittedslips);
                    cmd.Parameters.Add("@submittedchecks", submittedchecks);
                    cmd.Parameters.Add("@description", description);
                    cmd.Parameters.Add("@parlorid", branchid);
                    cmd.Parameters.Add("@createdon", ServerDateCurrentdate);
                    cmd.Parameters.Add("@doe", closedate);
                    cmd.Parameters.Add("@closedby", createdby);
                    cmd.Parameters.Add("@paytm", paytm);
                    cmd.Parameters.Add("@phonepay", phonepay);
                    vdm.insert(cmd);
                    cmd = new SqlCommand("select MAX(sno) as refno from registorclosingdetails");
                    DataTable dtoutward = vdm.SelectQuery(cmd).Tables[0];
                    string refno = dtoutward.Rows[0]["refno"].ToString();
                    foreach (SubRegcloseDetails si in obj.closeitems)
                    {
                        if (si.hdnproductsno != "0")
                        {
                            cmd = new SqlCommand("insert into registorclosing_dinaminationdetails(dinaminationid, dinamination, qty, refno) values(@productid, @dinamination, @quantity, @in_refno)");
                            cmd.Parameters.Add("@dinamination", si.dinamination);
                            cmd.Parameters.Add("@productid", si.hdnproductsno);
                            cmd.Parameters.Add("@quantity", si.Quantity);
                            cmd.Parameters.Add("@in_refno", refno);
                            vdm.insert(cmd);


                        }
                    }

                    cmd = new SqlCommand("select * from productmoniter where branchid=@branchid");
                    cmd.Parameters.Add("@branchid", branchid);
                    DataTable dtitem = vdm.SelectQuery(cmd).Tables[0];
                    cmd = new SqlCommand("select op_bal,refno, productid, price, clo_bal,doe,branchid from sub_registorclosingdetails where branchid=@branchid and doe between @d1 and @d2");
                    cmd.Parameters.Add("@d1", GetLowDate(closedate).AddDays(-2));
                    cmd.Parameters.Add("@d2", GetHighDate(closedate).AddDays(-2));
                    cmd.Parameters.Add("@branchid", branchid);
                    DataTable dtop = vdm.SelectQuery(cmd).Tables[0];

                    DateTime dt_fromdate = Convert.ToDateTime(closedate);
                    cmd = new SqlCommand("SELECT SUM(inward_subdetails.qty) AS inwardqty,productmaster.productname, productmaster.productid,(CONVERT(NVARCHAR(10), inward_maindetails.doe, 120)) AS doe  FROM   inward_maindetails INNER JOIN  inward_subdetails ON inward_maindetails.sno = inward_subdetails.refno INNER JOIN productmaster ON productmaster.productid = inward_subdetails.productid  WHERE (inward_maindetails.doe BETWEEN @d11 AND @d22) AND (inward_maindetails.branchid = @bidd) AND (inward_maindetails.status = 'A') group by productmaster.productname, (CONVERT(NVARCHAR(10), inward_maindetails.doe, 120)),productmaster.productid");
                    cmd.Parameters.Add("@d11", GetLowDate(dt_fromdate).AddDays(-1));
                    cmd.Parameters.Add("@d22", GetHighDate(dt_fromdate));
                    cmd.Parameters.Add("@bidd", branchid);
                    DataTable dtinward = vdm.SelectQuery(cmd).Tables[0];

                    cmd = new SqlCommand("SELECT   Sum(possale_subdetails.qty) AS outwardqty, productmaster.productid, Sum(possale_subdetails.totvalue) AS totvalue, Sum(possale_subdetails.ordertax) AS ordertax,CAST(possale_maindetails.doe AS date) FROM possale_maindetails INNER JOIN possale_subdetails on possale_subdetails.refno = possale_maindetails.sno INNER JOIN productmaster ON productmaster.productid = possale_subdetails.productid  WHERE possale_maindetails.doe BETWEEN @d1 AND @d2 AND possale_maindetails.branchid=@bid  GROUP BY  productmaster.productid,CAST(possale_maindetails.doe AS date)");
                    cmd.Parameters.Add("@d1", GetLowDate(closedate));
                    cmd.Parameters.Add("@d2", GetHighDate(closedate));
                    cmd.Parameters.Add("@bid", branchid);
                    DataTable dtouward = vdm.SelectQuery(cmd).Tables[0];

                    cmd = new SqlCommand("select  SSR.productid, Sum(SSR.quantity) as quantity,(CONVERT(NVARCHAR(10), SR.doe, 120)) AS doe   from stores_return AS SR INNER JOIN sub_stores_return AS SSR ON SR.sno=SSR.storesreturn_sno INNER JOIN productmaster ON productmaster.productid = SSR.productid WHERE SR.doe between @d1 and @d2 AND SR.branchid=@branchid GROUP BY SSR.productid,(CONVERT(NVARCHAR(10), SR.doe, 120))");//, inwarddetails.indentno
                    cmd.Parameters.Add("@d1", GetLowDate(dt_fromdate).AddDays(-1));
                    cmd.Parameters.Add("@d2", GetHighDate(dt_fromdate));
                    cmd.Parameters.Add("@branchid", branchid);
                    DataTable dtRetrun = vdm.SelectQuery(cmd).Tables[0];

                    foreach (DataRow dr in dtop.Rows)
                    {
                        double opqty = 0;
                        double inward = 0;
                        double outward = 0;
                        double closing = 0;
                        double ordertax = 0;
                        double totaloutward = 0;
                        double return_qty = 0;
                        //foreach (DataRow drop in dtop.Select("productid='" + dr["productid"].ToString() + "'"))
                        //{
                        //    double.TryParse(drop["qty"].ToString(), out opqty);
                        //}
                        //string date = "";
                        DateTime dt = Convert.ToDateTime(dr["doe"].ToString());
                        string date = dt.AddDays(1).ToString("yyyy-MM-dd");
                        double.TryParse(dr["clo_bal"].ToString(), out opqty);
                        foreach (DataRow drin in dtinward.Select("productid='" + dr["productid"].ToString() + "'AND doe='" + date + "'"))
                        {
                            double.TryParse(drin["inwardqty"].ToString(), out inward);
                        }

                        foreach (DataRow drreturn in dtRetrun.Select("productid='" + dr["productid"].ToString() + "'AND doe='" + date + "'"))
                        {
                            double.TryParse(drreturn["quantity"].ToString(), out return_qty);
                        }
                        foreach (DataRow drout in dtouward.Select("productid='" + dr["productid"].ToString() + "'"))
                        {
                            double.TryParse(drout["outwardqty"].ToString(), out outward);
                            double.TryParse(drout["ordertax"].ToString(), out ordertax);
                            totaloutward = outward; //+ ordertax;
                            totaloutward = Math.Round(totaloutward, 2);
                        }
                        double total = opqty + inward + return_qty;
                        closing = total - outward;
                        cmd = new SqlCommand("insert into sub_registorclosingdetails(refno, productid, price, clo_bal,op_bal,doe,branchid,inwardqty,saleqty,return_qty) values(@refno, @productid, @price, @clo_bal,@op_bal,@doe,@branchid,@inwardqty,@saleqty,@return_qty)");
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
                        cmd.Parameters.Add("@doe", closedate);
                        cmd.Parameters.Add("@branchid", branchid);
                        cmd.Parameters.Add("@inwardqty", inward);
                        cmd.Parameters.Add("@saleqty", outward);
                        cmd.Parameters.Add("@return_qty", return_qty);
                        vdm.insert(cmd);

                        cmd = new SqlCommand("UPDATE productmoniter set qty=@qty, price=@price WHERE productid=@productid AND branchid=@branchid");
                        cmd.Parameters.Add("@branchid", branchid);
                        cmd.Parameters.Add("@productid", dr["productid"].ToString());
                        cmd.Parameters.Add("@qty", closing);
                        cmd.Parameters.Add("@price", dr["price"].ToString());
                        vdm.Update(cmd);

                    }
                    string Response = GetJson("Register Details are Successfully Closed");
                    context.Response.Write(Response);
                }
            }
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    public class saleslistdetails
    {
        public string custmerid { get; set; }
        public string refnote { get; set; }
        public string payingnote { get; set; }
        public string modeofpay { get; set; }
        public string description { get; set; }
        public string balance { get; set; }
        public string totalpaying { get; set; }
        public string totalpayable { get; set; }
        public string totitems { get; set; }
        public string sno { get; set; }
        public string custmorname { get; set; }
        public string discount { get; set; }
        public string doe { get; set; }
        public string saleno { get; set; }
        public string btnvalue { get; set; }

        public string productname { get; set; }
        public string PerUnitRs { get; set; }
        public string Quantity { get; set; }
        public string TotalCost { get; set; }
        public string hdnproductsno { get; set; }
        public string cgst { get; set; }
        public string sgst { get; set; }
        public string ordertax { get; set; }
        public string totvalue { get; set; }
        public string status { get; set; }
    }


    public class itemstockDetails
    {
        public string btnreg { get; set; }
        public List<itemstocksubDetails> itemlist { get; set; }
    }

    public class itemstocksubDetails
    {
        public string productname { get; set; }
        public string price { get; set; }
        public string Quantity { get; set; }
        public string productid { get; set; }
        public string hdnproductsno { get; set; }
    }

    public class getitemstockDetails
    {
        public List<itemstockDetails> RegDetails { get; set; }
        public List<itemstocksubDetails> SubRegclose { get; set; }
    }

    private void update_itemstockdetails(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            var js = new JavaScriptSerializer();
            var title1 = context.Request.Params[1];
            itemstockDetails obj = js.Deserialize<itemstockDetails>(title1);
            string btnreg = "update";
            string branchid = context.Session["BranchID"].ToString();
            string createdby = context.Session["Employ_Sno"].ToString();
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
            DateTime closedate = ServerDateCurrentdate;
            if (btnreg == "update")
            {
                foreach (itemstocksubDetails si in obj.itemlist)
                {
                    if (si.productid != "0")
                    {
                        cmd = new SqlCommand("UPDATE productmoniter set qty=@qty, price=@price WHERE productid=@productid AND branchid=@branchid");
                        cmd.Parameters.Add("@branchid", branchid);
                        cmd.Parameters.Add("@productid", si.productid);
                        cmd.Parameters.Add("@qty", si.Quantity);
                        cmd.Parameters.Add("@price", si.price);
                        vdm.Update(cmd);
                    }
                }
                string Response = GetJson("Item Details are Successfully Updated");
                context.Response.Write(Response);
            }
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    private void get_sale_details(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            string parlorid = context.Session["BranchID"].ToString();
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
            cmd = new SqlCommand("SELECT  posm.sno, posm.discount, posm.status, posm.doe, cust.name, SUM(pssd.totvalue) AS totvalue, SUM(pssd.ordertax) AS ordertax  FROM   possale_maindetails AS posm INNER JOIN  customermaster AS cust ON posm.custmorid = cust.sno INNER JOIN  possale_subdetails AS pssd ON posm.sno = pssd.refno WHERE posm.branchid=@parlorid AND posm.doe between @d1 and @d2 GROUP BY posm.discount, posm.status, posm.doe, cust.name, posm.sno");
            cmd.Parameters.Add("@parlorid", parlorid);
            cmd.Parameters.Add("@d1", GetLowDate(ServerDateCurrentdate).AddDays(-4));
            cmd.Parameters.Add("@d2", GetHighDate(ServerDateCurrentdate));
            DataTable dtsales = vdm.SelectQuery(cmd).Tables[0];
            List<saleslistdetails> saledetailslist = new List<saleslistdetails>();
            if (dtsales.Rows.Count > 0)
            {
                foreach (DataRow dr in dtsales.Rows)
                {
                    saleslistdetails getsectiondetails = new saleslistdetails();
                    getsectiondetails.sno = dr["sno"].ToString();
                    getsectiondetails.discount = dr["discount"].ToString();
                    getsectiondetails.status = dr["status"].ToString();
                    DateTime dt = Convert.ToDateTime(dr["doe"].ToString());
                    string date = dt.ToString("dd/MM/yyyy HH:MM");
                    getsectiondetails.doe = date;
                    getsectiondetails.custmorname = dr["name"].ToString();
                    getsectiondetails.totvalue = dr["totvalue"].ToString();
                    getsectiondetails.ordertax = dr["ordertax"].ToString();
                    saledetailslist.Add(getsectiondetails);
                }

            }
            string response = GetJson(saledetailslist);
            context.Response.Write(response);
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    private void get_paidpossale_details(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
            string branchid = context.Session["BranchID"].ToString();
            string refno = context.Request["sno"].ToString();
            cmd = new SqlCommand("SELECT PM.sno, PM.custmorid, customermaster.name AS custmorname, PM.referencenote, PM.totalitems,  PM.totalpayble, PM.totalpaying, PM.balance, PM.description, PM.modeofpay, PM.payiningnote, PM.discount, PM.status, PM.branchid, PM.doe,  PM.createdby, PM.issueno, PS.refno, PS.productid, PS.productname, PS.qty, PS.price, PS.totvalue, PS.ordertax, productmaster.sgst, productmaster.cgst, productmaster.igst  FROM  possale_maindetails AS PM INNER JOIN  possale_subdetails AS PS ON PM.sno = PS.refno INNER JOIN  customermaster ON PM.custmorid = customermaster.sno INNER JOIN productmaster ON PS.productid = productmaster.productid WHERE  (PM.sno = @SNO)");
            cmd.Parameters.Add("@SNO", refno);
            DataTable routes = vdm.SelectQuery(cmd).Tables[0];
            DataView view = new DataView(routes);
            DataTable dtoutward = view.ToTable(true, "sno", "custmorid", "totalitems", "totalpayble", "totalpaying", "balance", "doe", "issueno", "custmorname", "modeofpay", "discount");
            DataTable dtsuboutward = view.ToTable(true, "productid", "productname", "qty", "price", "totvalue", "sgst", "cgst", "igst", "ordertax");
            List<getOutwardData> getOutwarddetails = new List<getOutwardData>();
            List<OutwardDetails> outwardlist = new List<OutwardDetails>();
            List<SubOutward> suboutwardlist = new List<SubOutward>();
            foreach (DataRow dr in dtoutward.Rows)
            {
                OutwardDetails getoutward = new OutwardDetails();
                getoutward.custmerid = dr["custmorid"].ToString();
                getoutward.doe = ((DateTime)dr["doe"]).ToString("dd-MM-yyyy HH:mm:ss");//dr["inwarddate"].ToString();//((DateTime)dr["inwarddate"]).ToString("yyyy-MM-dd");
                getoutward.custmorname = dr["custmorname"].ToString();
                getoutward.totitems = dr["totalitems"].ToString();
                getoutward.totalpayable = dr["totalpayble"].ToString();
                getoutward.totalpaying = dr["totalpaying"].ToString();
                getoutward.balance = dr["balance"].ToString();
                getoutward.saleno = dr["issueno"].ToString();
                getoutward.modeofpay = dr["modeofpay"].ToString();
                getoutward.discount = dr["discount"].ToString();
                outwardlist.Add(getoutward);
            }
            foreach (DataRow dr in dtsuboutward.Rows)
            {
                SubOutward getsuboutward = new SubOutward();
                getsuboutward.productname = dr["productname"].ToString();
                getsuboutward.Quantity = dr["qty"].ToString();
                getsuboutward.hdnproductsno = dr["productid"].ToString();
                getsuboutward.PerUnitRs = dr["price"].ToString();
                getsuboutward.TotalCost = dr["totvalue"].ToString();
                getsuboutward.sgst = dr["sgst"].ToString();
                getsuboutward.cgst = dr["cgst"].ToString();
                getsuboutward.ordertax = dr["ordertax"].ToString();
                suboutwardlist.Add(getsuboutward);
            }
            getOutwardData getoutwadDatas = new getOutwardData();
            getoutwadDatas.OutwardDetails = outwardlist;
            getoutwadDatas.SubOutward = suboutwardlist;
            getOutwarddetails.Add(getoutwadDatas);
            string response = GetJson(getOutwarddetails);
            context.Response.Write(response);
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    public class subcatsalesdetails
    {
        public string subcategoryname { get; set; }
        public string totvalue { get; set; }
        public string Avgsale { get; set; }
        public string subcategoryid { get; set; }
        public string Avgtax { get; set; }
        public string ordertax { get; set; }
        public string dinaminationtype { get; set; }
        public string parlorid { get; set; }
        public string Salevalue { get; set; }
        public string AvgSalevalue { get; set; }
        public string Billingpricevalue { get; set; }
        public string AvgBillingpricevalue { get; set; }
        public string productname { get; set; }
        public string sno { get; set; }
        public string categoryid { get; set; }
    }

    private void getdatewise_subcategorywisesalevalue(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);

            string logdate = "";
            string eid = context.Request["parlorid"].ToString();
            string[] bs = eid.Split('-');
            logdate = bs[1];
            string branchid = bs[0];

            DateTime dtfromdate = ServerDateCurrentdate;
            DateTime dttodate = ServerDateCurrentdate;
            string amonth = "";
            string ayear = "";
            int totalcount = 0;
            double basictotal = 0;
            DateTime fromdate = ServerDateCurrentdate;
            string frmdate = fromdate.ToString("MM/dd/yyyy");
            string[] str = frmdate.Split('/');
            string years = str[2];
            string[] logstr = logdate.Split('/');
            string date = logstr[0];
            string month = logstr[1];

            string[] mth = month.Split('(');
            string cmnth = mth[0];

            string biologdate = cmnth + "/" + date + "/" + years;
            DateTime dt = Convert.ToDateTime(biologdate);
            context.Session["dt"] = biologdate;
            cmd = new SqlCommand("SELECT  SUM(possale_subdetails.totvalue + possale_subdetails.ordertax) AS totvalue, SUM(possale_subdetails.qty) AS Avgsale, categorymaster.categoryid, categorymaster.category, possale_maindetails.branchid  FROM  productmaster INNER JOIN  possale_subdetails ON productmaster.productid = possale_subdetails.productid INNER JOIN subcategorymaster ON productmaster.subcategoryid = subcategorymaster.subcategoryid INNER JOIN categorymaster ON categorymaster.categoryid=subcategorymaster.categoryid INNER JOIN  possale_maindetails ON possale_subdetails.refno = possale_maindetails.sno  WHERE        (possale_maindetails.doe BETWEEN @D1 AND @D2) AND (possale_maindetails.branchid = @bid) AND (possale_maindetails.status = 'C')  GROUP BY categorymaster.categoryid, categorymaster.category, possale_maindetails.branchid");
            //cmd = new SqlCommand("SELECT  SUM(possale_subdetails.totvalue + possale_subdetails.ordertax) AS totvalue, SUM(possale_subdetails.qty) AS Avgsale, subcategorymaster.subcategoryname, subcategorymaster.subcategoryid, possale_maindetails.branchid  FROM  productmaster INNER JOIN  possale_subdetails ON productmaster.productid = possale_subdetails.productid INNER JOIN subcategorymaster ON productmaster.subcategoryid = subcategorymaster.subcategoryid INNER JOIN  possale_maindetails ON possale_subdetails.refno = possale_maindetails.sno  WHERE        (possale_maindetails.doe BETWEEN @D1 AND @D2) AND (possale_maindetails.branchid = @bid) AND (possale_maindetails.status = 'C')  GROUP BY subcategorymaster.subcategoryname, subcategorymaster.subcategoryid, possale_maindetails.branchid");
            cmd.Parameters.Add("@D1", GetLowDate(dt));
            cmd.Parameters.Add("@D2", GetHighDate(dt));
            cmd.Parameters.Add("@bid", branchid);
            DataTable dtsalevalue = vdm.SelectQuery(cmd).Tables[0];
            List<subcatsalesdetails> subcatsaleslist = new List<subcatsalesdetails>();
            foreach (DataRow dr in dtsalevalue.Rows)
            {
                subcatsalesdetails getdeptdetails = new subcatsalesdetails();
                getdeptdetails.totvalue = dr["totvalue"].ToString();
                getdeptdetails.Avgsale = dr["Avgsale"].ToString();
                getdeptdetails.subcategoryname = dr["category"].ToString();
                getdeptdetails.subcategoryid = dr["categoryid"].ToString();
                getdeptdetails.parlorid = dr["branchid"].ToString();
                subcatsaleslist.Add(getdeptdetails);
            }
            string response = GetJson(subcatsaleslist);
            context.Response.Write(response);
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    private void get_subcatitemwisesalevalue_details(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
            string branchid = context.Request["branchid"].ToString();
            string catid = context.Request["catid"].ToString();
            string biologdate = context.Session["dt"].ToString();
            DateTime dt = Convert.ToDateTime(biologdate);
            // cmd = new SqlCommand("SELECT  SUM(possale_subdetails.totvalue + possale_subdetails.ordertax) AS totvalue, SUM(possale_subdetails.qty) AS Avgsale, categorymaster.categoryid, categorymaster.category, possale_maindetails.branchid  FROM  productmaster INNER JOIN  possale_subdetails ON productmaster.productid = possale_subdetails.productid INNER JOIN subcategorymaster ON productmaster.subcategoryid = subcategorymaster.subcategoryid INNER JOIN categorymaster ON categorymaster.categoryid=subcategorymaster.categoryid INNER JOIN  possale_maindetails ON possale_subdetails.refno = possale_maindetails.sno  WHERE        (possale_maindetails.doe BETWEEN @D1 AND @D2) AND (possale_maindetails.branchid = @bid) AND (possale_maindetails.status = 'C')  GROUP BY categorymaster.categoryid, categorymaster.category, possale_maindetails.branchid");
            cmd = new SqlCommand("SELECT  SUM(possale_subdetails.totvalue + possale_subdetails.ordertax) AS totvalue, SUM(possale_subdetails.qty) AS Avgsale, subcategorymaster.subcategoryname, subcategorymaster.subcategoryid, possale_maindetails.branchid  FROM  productmaster INNER JOIN  possale_subdetails ON productmaster.productid = possale_subdetails.productid INNER JOIN subcategorymaster ON productmaster.subcategoryid = subcategorymaster.subcategoryid INNER JOIN  possale_maindetails ON possale_subdetails.refno = possale_maindetails.sno  WHERE        (possale_maindetails.doe BETWEEN @D1 AND @D2) AND (possale_maindetails.branchid = @bid) AND (possale_maindetails.status = 'C') AND (subcategorymaster.categoryid=@catid)  GROUP BY subcategorymaster.subcategoryname, subcategorymaster.subcategoryid, possale_maindetails.branchid");
            cmd.Parameters.Add("@D1", GetLowDate(dt));
            cmd.Parameters.Add("@D2", GetHighDate(dt));
            cmd.Parameters.Add("@bid", branchid);
            cmd.Parameters.Add("@catid", catid);
            DataTable dtsalevalue = vdm.SelectQuery(cmd).Tables[0];
            List<subcatsalesdetails> subcatsaleslist = new List<subcatsalesdetails>();
            foreach (DataRow dr in dtsalevalue.Rows)
            {
                subcatsalesdetails getdeptdetails = new subcatsalesdetails();
                getdeptdetails.totvalue = dr["totvalue"].ToString();
                getdeptdetails.Avgsale = dr["Avgsale"].ToString();
                getdeptdetails.subcategoryname = dr["subcategoryname"].ToString();
                getdeptdetails.subcategoryid = dr["subcategoryid"].ToString();
                getdeptdetails.parlorid = dr["branchid"].ToString();
                getdeptdetails.categoryid = catid;
                subcatsaleslist.Add(getdeptdetails);
            }
            string response = GetJson(subcatsaleslist);
            context.Response.Write(response);
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    private void getdatewise_WEEKsubcategorywisesalevalue(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);

            string logdate = "";
            string eid = context.Request["parlorid"].ToString();
            string[] bs = eid.Split('-');
            logdate = bs[1];
            string branchid = bs[0];

            DateTime dtfromdate = ServerDateCurrentdate;
            DateTime dttodate = ServerDateCurrentdate;
            string amonth = "";
            string ayear = "";
            int totalcount = 0;
            double basictotal = 0;
            DateTime fromdate = ServerDateCurrentdate;
            string frmdate = fromdate.ToString("MM/dd/yyyy");
            string[] str = frmdate.Split('/');
            string years = str[2];
            string[] logstr = logdate.Split('/');
            string date = logstr[0];
            string month = logstr[1];

            string[] mth = month.Split('(');
            string cmnth = mth[0];
            if (cmnth == "Dec")
            {
                int y = Convert.ToInt32(years) - 1;
                years = y.ToString();
            }
            string biologdate = cmnth + "/" + date + "/" + years;
            DateTime dt = Convert.ToDateTime(biologdate);
            context.Session["dt"] = biologdate;
            cmd = new SqlCommand("SELECT  SUM(possale_subdetails.totvalue + possale_subdetails.ordertax) AS totvalue, SUM(possale_subdetails.qty) AS Avgsale, categorymaster.categoryid, categorymaster.category, possale_maindetails.branchid  FROM  productmaster INNER JOIN  possale_subdetails ON productmaster.productid = possale_subdetails.productid INNER JOIN subcategorymaster ON productmaster.subcategoryid = subcategorymaster.subcategoryid INNER JOIN categorymaster ON categorymaster.categoryid=subcategorymaster.categoryid INNER JOIN  possale_maindetails ON possale_subdetails.refno = possale_maindetails.sno  WHERE        (possale_maindetails.doe BETWEEN @D1 AND @D2) AND (possale_maindetails.branchid = @bid) AND (possale_maindetails.status = 'C')  GROUP BY categorymaster.categoryid, categorymaster.category, possale_maindetails.branchid");

            // cmd = new SqlCommand("SELECT  SUM(possale_subdetails.totvalue + possale_subdetails.ordertax) AS totvalue, SUM(possale_subdetails.qty) AS Avgsale, subcategorymaster.subcategoryname, subcategorymaster.subcategoryid, possale_maindetails.branchid  FROM  productmaster INNER JOIN  possale_subdetails ON productmaster.productid = possale_subdetails.productid INNER JOIN subcategorymaster ON productmaster.subcategoryid = subcategorymaster.subcategoryid INNER JOIN  possale_maindetails ON possale_subdetails.refno = possale_maindetails.sno  WHERE        (possale_maindetails.doe BETWEEN @D1 AND @D2) AND (possale_maindetails.branchid = @bid) AND (possale_maindetails.status = 'C')  GROUP BY subcategorymaster.subcategoryname, subcategorymaster.subcategoryid, possale_maindetails.branchid");
            cmd.Parameters.Add("@D1", GetLowDate(dt));
            cmd.Parameters.Add("@D2", GetHighDate(dt));
            cmd.Parameters.Add("@bid", branchid);
            DataTable dtsalevalue = vdm.SelectQuery(cmd).Tables[0];
            List<subcatsalesdetails> subcatsaleslist = new List<subcatsalesdetails>();
            foreach (DataRow dr in dtsalevalue.Rows)
            {
                subcatsalesdetails getdeptdetails = new subcatsalesdetails();
                getdeptdetails.totvalue = dr["totvalue"].ToString();
                getdeptdetails.Avgsale = dr["Avgsale"].ToString();
                getdeptdetails.subcategoryname = dr["category"].ToString();
                getdeptdetails.subcategoryid = dr["categoryid"].ToString();
                getdeptdetails.parlorid = dr["branchid"].ToString();
                subcatsaleslist.Add(getdeptdetails);
            }
            string response = GetJson(subcatsaleslist);
            context.Response.Write(response);
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    private void get_subcategorywisesalevalue_details(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
            string sno = context.Request["sno"].ToString();
            string branchid = context.Session["BranchID"].ToString();
            string refno = context.Request["Employ_Sno"].ToString();
            if (sno == "0")
            {
                cmd = new SqlCommand("SELECT  SUM(possale_subdetails.totvalue + possale_subdetails.ordertax) AS totvalue, SUM(possale_subdetails.qty) AS Avgsale, subcategorymaster.subcategoryname, subcategorymaster.subcategoryid, possale_maindetails.branchid  FROM  productmaster INNER JOIN  possale_subdetails ON productmaster.productid = possale_subdetails.productid INNER JOIN subcategorymaster ON productmaster.subcategoryid = subcategorymaster.subcategoryid INNER JOIN  possale_maindetails ON possale_subdetails.refno = possale_maindetails.sno  WHERE        (possale_maindetails.doe BETWEEN @D1 AND @D2) AND (possale_maindetails.branchid = @bid) AND (possale_maindetails.status = 'C')  GROUP BY subcategorymaster.subcategoryname, subcategorymaster.subcategoryid, possale_maindetails.branchid");
            }
            else
            {
                branchid = sno;
                cmd = new SqlCommand("SELECT  SUM(possale_subdetails.totvalue + possale_subdetails.ordertax) AS totvalue, SUM(possale_subdetails.qty) AS Avgsale, subcategorymaster.subcategoryname, subcategorymaster.subcategoryid, possale_maindetails.branchid  FROM  productmaster INNER JOIN  possale_subdetails ON productmaster.productid = possale_subdetails.productid INNER JOIN subcategorymaster ON productmaster.subcategoryid = subcategorymaster.subcategoryid INNER JOIN  possale_maindetails ON possale_subdetails.refno = possale_maindetails.sno  WHERE        (possale_maindetails.doe BETWEEN @D1 AND @D2) AND (possale_maindetails.branchid = @bid) AND (possale_maindetails.status = 'C')  GROUP BY subcategorymaster.subcategoryname, subcategorymaster.subcategoryid, possale_maindetails.branchid");
            }
            cmd.Parameters.Add("@D1", GetLowDate(ServerDateCurrentdate));
            cmd.Parameters.Add("@D2", GetHighDate(ServerDateCurrentdate));
            cmd.Parameters.Add("@bid", branchid);
            DataTable dtsalevalue = vdm.SelectQuery(cmd).Tables[0];
            List<subcatsalesdetails> subcatsaleslist = new List<subcatsalesdetails>();
            foreach (DataRow dr in dtsalevalue.Rows)
            {
                subcatsalesdetails getdeptdetails = new subcatsalesdetails();
                getdeptdetails.totvalue = dr["totvalue"].ToString();
                getdeptdetails.Avgsale = dr["Avgsale"].ToString();
                getdeptdetails.subcategoryname = dr["subcategoryname"].ToString();
                getdeptdetails.subcategoryid = dr["subcategoryid"].ToString();
                getdeptdetails.parlorid = dr["branchid"].ToString();
                subcatsaleslist.Add(getdeptdetails);
            }
            string response = GetJson(subcatsaleslist);
            context.Response.Write(response);
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    private void get_saledetails(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
            string branchid = context.Session["BranchID"].ToString();
            string refno = context.Request["Employ_Sno"].ToString();
            cmd = new SqlCommand("SELECT  SUM(possale_subdetails.totvalue + possale_subdetails.ordertax) AS totvalue FROM  productmaster INNER JOIN  possale_subdetails ON productmaster.productid = possale_subdetails.productid INNER JOIN subcategorymaster ON productmaster.subcategoryid = subcategorymaster.subcategoryid INNER JOIN  possale_maindetails ON possale_subdetails.refno = possale_maindetails.sno  WHERE        (possale_maindetails.doe BETWEEN @D1 AND @D2) AND (possale_maindetails.branchid = @bid) AND (possale_maindetails.status = 'C')");
            cmd.Parameters.Add("@D1", GetLowDate(ServerDateCurrentdate));
            cmd.Parameters.Add("@D2", GetHighDate(ServerDateCurrentdate));
            cmd.Parameters.Add("@bid", branchid);
            DataTable dtsalevalue = vdm.SelectQuery(cmd).Tables[0];

            cmd = new SqlCommand("SELECT SUM(inward_subdetails.totvalue) AS purchasevalue  FROM   inward_maindetails INNER JOIN  inward_subdetails ON inward_maindetails.sno = inward_subdetails.refno  WHERE (inward_maindetails.doe BETWEEN @d11 AND @d22) AND (inward_maindetails.branchid = @bidd) AND (inward_maindetails.status = 'A')");
            cmd.Parameters.Add("@d11", GetLowDate(ServerDateCurrentdate));
            cmd.Parameters.Add("@d22", GetHighDate(ServerDateCurrentdate));
            cmd.Parameters.Add("@bidd", branchid);
            DataTable dtpurchase = vdm.SelectQuery(cmd).Tables[0];

            cmd = new SqlCommand("SELECT  SUM(totalvalue) AS expencesvalue FROM  storeexpencess WHERE (doe BETWEEN @D1 AND @D2) AND (branchid = @bid) AND (status = 'A')");
            cmd.Parameters.Add("@D1", GetLowDate(ServerDateCurrentdate));
            cmd.Parameters.Add("@D2", GetHighDate(ServerDateCurrentdate));
            cmd.Parameters.Add("@bid", branchid);
            DataTable dtexpences = vdm.SelectQuery(cmd).Tables[0];


            double salevalue = 0;
            double purchasevalue = 0;
            double expencesvalue = 0;

            List<saledetails> subcatsaleslist = new List<saledetails>();
            foreach (DataRow dr in dtsalevalue.Rows)
            {
                string totvalue = dr["totvalue"].ToString();
                if (totvalue != "")
                {
                    salevalue = Math.Round(Convert.ToDouble(totvalue), 0);
                }
            }
            foreach (DataRow dr in dtpurchase.Rows)
            {
                string purchasetotvalue = dr["purchasevalue"].ToString();
                if (purchasetotvalue != "")
                {
                    purchasevalue = Convert.ToDouble(purchasetotvalue);
                }
            }
            foreach (DataRow dr in dtexpences.Rows)
            {
                string totexpencesvalue = dr["expencesvalue"].ToString();
                if (totexpencesvalue != "")
                {
                    expencesvalue = Convert.ToDouble(totexpencesvalue);
                }
            }
            double pl = salevalue - purchasevalue - expencesvalue;
            saledetails getdeptdetails = new saledetails();
            getdeptdetails.salevalue = salevalue.ToString();
            getdeptdetails.purchasevalue = purchasevalue.ToString();
            getdeptdetails.expencesvalue = expencesvalue.ToString();
            getdeptdetails.profit = pl.ToString();
            subcatsaleslist.Add(getdeptdetails);
            string response = GetJson(subcatsaleslist);
            context.Response.Write(response);
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    private void get_parlorwisesale_details(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
            string branchid = context.Session["BranchID"].ToString();
            string refno = context.Request["Employ_Sno"].ToString();

            cmd = new SqlCommand("SELECT branchid, branchname FROM branchmaster");
            DataTable dtbranchdtls = vdm.SelectQuery(cmd).Tables[0];

            cmd = new SqlCommand("SELECT  SUM(possale_subdetails.totvalue + possale_subdetails.ordertax) AS totvalue, possale_maindetails.branchid  FROM  productmaster INNER JOIN  possale_subdetails ON productmaster.productid = possale_subdetails.productid INNER JOIN subcategorymaster ON productmaster.subcategoryid = subcategorymaster.subcategoryid INNER JOIN  possale_maindetails ON possale_subdetails.refno = possale_maindetails.sno WHERE (possale_maindetails.doe BETWEEN @D1 AND @D2) AND (possale_maindetails.status = 'C') GROUP BY possale_maindetails.branchid");
            cmd.Parameters.Add("@D1", GetLowDate(ServerDateCurrentdate));
            cmd.Parameters.Add("@D2", GetHighDate(ServerDateCurrentdate));
            //cmd.Parameters.Add("@bid", branchid);
            DataTable dtsalevalue = vdm.SelectQuery(cmd).Tables[0];

            cmd = new SqlCommand("SELECT SUM(inward_subdetails.totvalue) AS purchasevalue,inward_maindetails.branchid   FROM   inward_maindetails INNER JOIN  inward_subdetails ON inward_maindetails.sno = inward_subdetails.refno  WHERE (inward_maindetails.doe BETWEEN @d11 AND @d22)  AND (inward_maindetails.status = 'A') GROUP BY inward_maindetails.branchid");
            cmd.Parameters.Add("@d11", GetLowDate(ServerDateCurrentdate));
            cmd.Parameters.Add("@d22", GetHighDate(ServerDateCurrentdate));
            cmd.Parameters.Add("@bidd", branchid);
            DataTable dtpurchase = vdm.SelectQuery(cmd).Tables[0]; //

            cmd = new SqlCommand("SELECT  SUM(totalvalue) AS expencesvalue, branchid FROM  storeexpencess WHERE (doe BETWEEN @D1 AND @D2) AND (branchid = @bid) AND (status = 'A') Group by branchid");
            cmd.Parameters.Add("@D1", GetLowDate(ServerDateCurrentdate));
            cmd.Parameters.Add("@D2", GetHighDate(ServerDateCurrentdate));
            cmd.Parameters.Add("@bid", branchid);
            DataTable dtexpences = vdm.SelectQuery(cmd).Tables[0];
            List<saledetails> subcatsaleslist = new List<saledetails>();
            foreach (DataRow dr in dtbranchdtls.Rows)
            {
                double salevalue = 0;
                double purchasevalue = 0;
                double expencesvalue = 0;
                string parlorid = dr["branchid"].ToString();
                string branchname = dr["branchname"].ToString();
                foreach (DataRow dra in dtsalevalue.Select("branchid='" + dr["branchid"].ToString() + "'"))
                {
                    string saleval = dra["totvalue"].ToString();
                    if (saleval != "")
                    {
                        salevalue = Math.Round(Convert.ToDouble(saleval), 0);
                    }
                }
                foreach (DataRow dra in dtpurchase.Select("branchid='" + dr["branchid"].ToString() + "'"))
                {
                    string purchase = dra["purchasevalue"].ToString();
                    if (purchase != "")
                    {
                        purchasevalue = Math.Round(Convert.ToDouble(purchase), 0);
                    }
                }
                foreach (DataRow dra in dtexpences.Select("branchid='" + dr["branchid"].ToString() + "'"))
                {
                    string expences = dra["expencesvalue"].ToString();
                    if (expences != "")
                    {
                        expencesvalue = Math.Round(Convert.ToDouble(expences), 0);
                    }
                }
                double pl = salevalue - purchasevalue - expencesvalue;
                saledetails getdeptdetails = new saledetails();
                getdeptdetails.parlorid = parlorid;
                getdeptdetails.branchname = branchname;
                getdeptdetails.salevalue = salevalue.ToString();
                getdeptdetails.purchasevalue = purchasevalue.ToString();
                getdeptdetails.expencesvalue = expencesvalue.ToString();
                getdeptdetails.profit = pl.ToString();
                subcatsaleslist.Add(getdeptdetails);
            }
            string response = GetJson(subcatsaleslist);
            context.Response.Write(response);
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    private void get_itemwisesalevalue_details(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
            string refno = context.Request["Employ_Sno"].ToString();
            string subcatid = context.Request["subcatid"].ToString();
            string branchid = context.Request["branchid"].ToString();
            string categoryid = context.Request["categoryid"].ToString();
            string date = context.Session["dt"].ToString();
            DateTime dtdate = Convert.ToDateTime(date);
            ServerDateCurrentdate = dtdate;

            if (branchid == "")
            {
                cmd = new SqlCommand("SELECT SUM(possale_subdetails.totvalue) AS Itemsalevalue, SUM(possale_subdetails.qty) AS Avgsale, SUM(possale_subdetails.ordertax) AS ordertax, AVG(possale_subdetails.ordertax) AS Avgtax, productmaster.productname, possale_subdetails.productid  FROM  productmaster INNER JOIN  possale_subdetails ON productmaster.productid = possale_subdetails.productid INNER JOIN  possale_maindetails ON possale_subdetails.refno = possale_maindetails.sno  WHERE   (possale_maindetails.doe BETWEEN @d1 AND @d2) AND (productmaster.subcategoryid = @subcatid) AND (possale_maindetails.status = 'C')   GROUP BY productmaster.productname, possale_subdetails.productid");

            }
            else
            {
                cmd = new SqlCommand("SELECT SUM(possale_subdetails.totvalue) AS Itemsalevalue, SUM(possale_subdetails.qty) AS Avgsale, SUM(possale_subdetails.ordertax) AS ordertax, AVG(possale_subdetails.ordertax) AS Avgtax, productmaster.productname, possale_subdetails.productid  FROM  productmaster INNER JOIN  possale_subdetails ON productmaster.productid = possale_subdetails.productid INNER JOIN  possale_maindetails ON possale_subdetails.refno = possale_maindetails.sno   WHERE  (possale_maindetails.branchid = @bid) AND (possale_maindetails.doe BETWEEN @d1 AND @d2) AND (productmaster.subcategoryid = @subcatid) AND (productmaster.categoryid=@catid) AND (possale_maindetails.status = 'C')  GROUP BY productmaster.productname, possale_subdetails.productid");
                cmd.Parameters.Add("@bid", branchid);
            }
            cmd.Parameters.Add("@d1", GetLowDate(ServerDateCurrentdate));
            cmd.Parameters.Add("@d2", GetHighDate(ServerDateCurrentdate));
            cmd.Parameters.Add("@subcatid", subcatid);
            cmd.Parameters.Add("@catid", categoryid);
            DataTable dtitemwiesalevalue = vdm.SelectQuery(cmd).Tables[0];
            List<subcatsalesdetails> subcatsaleslist = new List<subcatsalesdetails>();
            if (dtitemwiesalevalue.Rows.Count > 0)
            {
                foreach (DataRow dr in dtitemwiesalevalue.Rows)
                {
                    subcatsalesdetails getdeptdetails = new subcatsalesdetails();
                    getdeptdetails.totvalue = dr["Itemsalevalue"].ToString();
                    getdeptdetails.Avgsale = dr["Avgsale"].ToString();
                    getdeptdetails.subcategoryname = dr["productname"].ToString();
                    getdeptdetails.subcategoryid = dr["productid"].ToString();
                    getdeptdetails.ordertax = dr["ordertax"].ToString();
                    getdeptdetails.Avgtax = dr["Avgtax"].ToString();
                    subcatsaleslist.Add(getdeptdetails);
                }
                string response = GetJson(subcatsaleslist);
                context.Response.Write(response);
            }
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    private void get_denamination_details(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
            string branchid = context.Session["BranchID"].ToString();
            cmd = new SqlCommand("SELECT sno, dinaminationtype FROM dinaminationmaster Where status='A'");
            DataTable dtitemwiesalevalue = vdm.SelectQuery(cmd).Tables[0];
            List<subcatsalesdetails> subcatsaleslist = new List<subcatsalesdetails>();
            if (dtitemwiesalevalue.Rows.Count > 0)
            {
                foreach (DataRow dr in dtitemwiesalevalue.Rows)
                {
                    subcatsalesdetails getdeptdetails = new subcatsalesdetails();
                    getdeptdetails.dinaminationtype = dr["dinaminationtype"].ToString();
                    getdeptdetails.sno = dr["sno"].ToString();
                    subcatsaleslist.Add(getdeptdetails);
                }
                string response = GetJson(subcatsaleslist);
                context.Response.Write(response);
            }
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    private void get_overallitemwisesalevalue(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
            string branchid = context.Session["BranchID"].ToString();
            cmd = new SqlCommand("SELECT SUM(possale_subdetails.totvalue + possale_subdetails.ordertax) AS Salevalue, AVG(possale_subdetails.totvalue + possale_subdetails.ordertax) AS AvgSalevalue, productmaster.productname, SUM(possale_subdetails.qty * productmaster.billingprice) AS Billingpricevalue, AVG(possale_subdetails.qty * productmaster.billingprice) AS AvgBillingpricevalue, productmaster.subcategoryid  FROM  possale_subdetails INNER JOIN productmaster ON possale_subdetails.productid = productmaster.productid INNER JOIN possale_maindetails ON possale_subdetails.refno = possale_maindetails.sno  WHERE (possale_maindetails.doe BETWEEN @D1 AND @D2) AND (possale_maindetails.status='C') AND (possale_maindetails.branchid=@branchid) GROUP BY productmaster.productname, productmaster.subcategoryid  ORDER BY productmaster.subcategoryid");
            cmd.Parameters.Add("@D1", GetLowDate(ServerDateCurrentdate).AddDays(-1));
            cmd.Parameters.Add("@D2", GetHighDate(ServerDateCurrentdate).AddDays(-1));
            cmd.Parameters.Add("@branchid", branchid);
            DataTable dtitemwiesalevalue = vdm.SelectQuery(cmd).Tables[0];
            List<subcatsalesdetails> subcatsaleslist = new List<subcatsalesdetails>();
            if (dtitemwiesalevalue.Rows.Count > 0)
            {
                foreach (DataRow dr in dtitemwiesalevalue.Rows)
                {
                    subcatsalesdetails getdeptdetails = new subcatsalesdetails();
                    getdeptdetails.Salevalue = dr["Salevalue"].ToString();
                    getdeptdetails.AvgSalevalue = dr["AvgSalevalue"].ToString();
                    getdeptdetails.Billingpricevalue = dr["Billingpricevalue"].ToString();
                    getdeptdetails.AvgBillingpricevalue = dr["AvgBillingpricevalue"].ToString();
                    getdeptdetails.productname = dr["productname"].ToString();
                    subcatsaleslist.Add(getdeptdetails);
                }
                string response = GetJson(subcatsaleslist);
                context.Response.Write(response);
            }
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
        //
    }


    public class itemmonitordetails
    {
        public string itemname { get; set; }
        public string quantity { get; set; }
        public string sellingprice { get; set; }
        public string sno { get; set; }
    }
    private void get_itemmonitor_details(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
            string branchid = context.Session["BranchID"].ToString();
            string subcatid = context.Request["subcatid"].ToString();
            if (subcatid == "0")
            {
                cmd = new SqlCommand("select productmaster.productid, productmaster.productname, productmoniter.qty, productmoniter.price from productmaster inner join productmoniter on productmoniter.productid = productmaster.productid WHERE productmoniter.branchid=@bid");
            }
            else
            {
                cmd = new SqlCommand("select productmaster.productid, productmaster.productname, productmoniter.qty, productmoniter.price from productmaster inner join productmoniter on productmoniter.productid = productmaster.productid WHERE productmoniter.branchid=@bid AND productmaster.subcategoryid=@subcatid");
                cmd.Parameters.Add("@subcatid", subcatid);
            }
            cmd.Parameters.Add("@bid", branchid);
            DataTable dtitemwieqty = vdm.SelectQuery(cmd).Tables[0];
            List<itemmonitordetails> subcatsaleslist = new List<itemmonitordetails>();
            if (dtitemwieqty.Rows.Count > 0)
            {
                foreach (DataRow dr in dtitemwieqty.Rows)
                {
                    itemmonitordetails getdeptdetails = new itemmonitordetails();
                    getdeptdetails.itemname = dr["productname"].ToString();
                    getdeptdetails.quantity = dr["qty"].ToString();
                    getdeptdetails.sellingprice = dr["price"].ToString();
                    getdeptdetails.sno = dr["productid"].ToString();
                    subcatsaleslist.Add(getdeptdetails);
                }
                string response = GetJson(subcatsaleslist);
                context.Response.Write(response);
            }
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    private void get_possaledetails_details(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
            string branchid = context.Session["BranchID"].ToString();
            string refno = context.Request["refno"].ToString();
            cmd = new SqlCommand("select possale_maindetails.branchid, possale_subdetails.refno, possale_subdetails.productid, possale_subdetails.productname, possale_subdetails.qty, possale_subdetails.price, possale_subdetails.totvalue, possale_subdetails.ordertax  from possale_subdetails INNER JOIN possale_maindetails ON possale_maindetails.sno = possale_subdetails.refno where possale_maindetails.sno=@refno AND possale_maindetails.branchid=@branchid");
            cmd.Parameters.Add("@refno", refno);
            cmd.Parameters.Add("@branchid", branchid);
            DataTable dtitemwieqty = vdm.SelectQuery(cmd).Tables[0];
            List<saledetails> subcatsaleslist = new List<saledetails>();
            if (dtitemwieqty.Rows.Count > 0)
            {
                foreach (DataRow dr in dtitemwieqty.Rows)
                {
                    saledetails getdeptdetails = new saledetails();
                    getdeptdetails.productname = dr["productname"].ToString();
                    getdeptdetails.Quantity = dr["qty"].ToString();
                    getdeptdetails.PerUnitRs = dr["price"].ToString();
                    getdeptdetails.hdnproductsno = dr["productid"].ToString();
                    getdeptdetails.TotalCost = dr["totvalue"].ToString();
                    getdeptdetails.ordertax = dr["ordertax"].ToString();
                    getdeptdetails.refno = dr["refno"].ToString();
                    subcatsaleslist.Add(getdeptdetails);
                }
                string response = GetJson(subcatsaleslist);
                context.Response.Write(response);
            }
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    private void save_storereturn_details(HttpContext context)
    {
        try
        {
            var js = new JavaScriptSerializer();
            var title1 = context.Request.Params[1];
            inwardDetails obj = js.Deserialize<inwardDetails>(title1);
            string date = obj.date;
            string refnote = obj.refnote;
            string returntype = obj.returntype;
            string description = obj.description;
            string btnval = obj.btnvalue;
            string sno = obj.sno;
            string status = "A";
            string billtotalvalue = obj.totalvalue;
            string vendor = obj.vendor;
            if (vendor == null || vendor == "" || vendor == "Select Branch")
            {
                vendor = "0";
            }
            string branchid = context.Session["BranchID"].ToString();
            string createdby = context.Session["Employ_Sno"].ToString();
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
            vdm = new SalesDBManager();
            if (btnval == "Save")
            {
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
                cmd = new SqlCommand("SELECT { fn IFNULL(MAX(sno), 0) } + 1 AS invoiceno FROM  stores_return WHERE (branchid = @branchid) and (doe between @d1 and @d2)");
                cmd.Parameters.Add("@branchid", branchid);
                cmd.Parameters.Add("@d1", GetLowDate(dtapril));
                cmd.Parameters.Add("@d2", GetHighDate(dtmarch));
                DataTable dtratechart = vdm.SelectQuery(cmd).Tables[0];
                string invoiceno = dtratechart.Rows[0]["invoiceno"].ToString();
                cmd = new SqlCommand("insert into stores_return(returntype, doe, branchid, remarks, refno, billtotalvalue, entryby, createdon, invoiceno, status, vendorid) values (@returntype, @doe, @branchid, @description, @refno, @billtotalvalue, @createdby, @createdon, @invoiceno, @status, @vendor)");
                cmd.Parameters.Add("@branchid", branchid);
                cmd.Parameters.Add("@doe", date);
                cmd.Parameters.Add("@returntype", returntype);
                cmd.Parameters.Add("@refno", refnote);
                cmd.Parameters.Add("@description", description);
                cmd.Parameters.Add("@status", status);
                cmd.Parameters.Add("@createdon", ServerDateCurrentdate);
                cmd.Parameters.Add("@createdby", createdby);
                cmd.Parameters.Add("@invoiceno", invoiceno);
                cmd.Parameters.Add("@billtotalvalue", billtotalvalue);
                cmd.Parameters.Add("@vendor", vendor);
                vdm.insert(cmd);
                cmd = new SqlCommand("select MAX(sno) as stno from stores_return");
                DataTable dtoutward = vdm.SelectQuery(cmd).Tables[0];
                string refno = dtoutward.Rows[0]["stno"].ToString();
                foreach (Subinward si in obj.fillitems)
                {
                    if (si.hdnproductsno != "0")
                    {
                        cmd = new SqlCommand("insert into sub_stores_return(productid, quantity, price,  totalvalue, storesreturn_sno, ordertax) values (@productid,@quantity,@perunit,@totalcost,@in_refno,@ordertax)");
                        cmd.Parameters.Add("@productid", si.hdnproductsno);
                        cmd.Parameters.Add("@quantity", si.Quantity);
                        cmd.Parameters.Add("@perunit", si.PerUnitRs);
                        cmd.Parameters.Add("@totalcost", si.TotalCost);
                        cmd.Parameters.Add("@in_refno", refno);
                        cmd.Parameters.Add("@ordertax", si.ordertax);
                        vdm.insert(cmd);

                        if (returntype == "parlor")
                        {
                            cmd = new SqlCommand("UPDATE productmoniter set qty=qty+@qty, price=@price WHERE productid=@productid AND branchid=@branchid");
                            cmd.Parameters.Add("@branchid", branchid);
                            cmd.Parameters.Add("@productid", si.hdnproductsno);
                            cmd.Parameters.Add("@qty", si.Quantity);
                            cmd.Parameters.Add("@price", si.PerUnitRs);
                            vdm.Update(cmd);
                        }
                        else
                        {
                            cmd = new SqlCommand("UPDATE productmoniter set qty=qty-@qty, price=@price WHERE productid=@productid AND branchid=@branchid");
                            cmd.Parameters.Add("@branchid", branchid);
                            cmd.Parameters.Add("@productid", si.hdnproductsno);
                            cmd.Parameters.Add("@qty", si.Quantity);
                            cmd.Parameters.Add("@price", si.PerUnitRs);
                            vdm.Update(cmd);
                        }


                    }
                }
                string msg = "Store Return Details successfully added";
                string Response = GetJson(msg);
                context.Response.Write(Response);
            }
            else
            {
                cmd = new SqlCommand("UPDATE stores_return SET   billtotalvalue=@billtotalvalue,  modified_by=@modified_by,  modifiedon=@modifiedon WHERE sno=@sno AND branchid=@branchid");
                cmd.Parameters.Add("@sno", sno);
                cmd.Parameters.Add("@branchid", branchid);
                cmd.Parameters.Add("@billtotalvalue", billtotalvalue);
                cmd.Parameters.Add("@modified_by", createdby);
                cmd.Parameters.Add("@modifiedon", ServerDateCurrentdate);
                vdm.Update(cmd);
                foreach (Subinward si in obj.fillitems)
                {
                    if (si.hdnproductsno != "0")
                    {
                        cmd = new SqlCommand("update sub_stores_return set  quantity=@quantity, price=@perunit,totalvalue=@totalcost, ordertax=@ordertax Where storesreturn_sno=@refno and productid=@productid");
                        cmd.Parameters.Add("@productid", si.hdnproductsno);
                        cmd.Parameters.Add("@quantity", si.Quantity);
                        cmd.Parameters.Add("@perunit", si.PerUnitRs);
                        cmd.Parameters.Add("@totalcost", si.TotalCost);
                        cmd.Parameters.Add("@ordertax", si.ordertax);
                        cmd.Parameters.Add("@refno", sno);
                        vdm.Update(cmd);
                        //if (vdm.Update(cmd) == 0)
                        //{
                        //    cmd = new SqlCommand("insert into sub_stores_return(productid, quantity, price,  totalvalue, storesreturn_sno, ordertax) values (@productid,@quantity,@perunit,@totalcost,@in_refno,@ordertax)");
                        //    cmd.Parameters.Add("@productid", si.hdnproductsno);
                        //    cmd.Parameters.Add("@quantity", si.Quantity);
                        //    cmd.Parameters.Add("@perunit", si.PerUnitRs);
                        //    cmd.Parameters.Add("@totalcost", si.TotalCost);
                        //    cmd.Parameters.Add("@in_refno", sno);
                        //    cmd.Parameters.Add("@ordertax", si.ordertax);
                        //    vdm.insert(cmd);
                        //}
                    }
                }
            }
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    private void get_storereturn_details(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            string julydt = "07/01/2017";
            DateTime gst_dt = Convert.ToDateTime(julydt);
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
            string InvoicNo = context.Request["InvoicNo"];
            string branchid = context.Request["ddlBranchName"];
            cmd = new SqlCommand("select productmaster.productname, SR.sno, SR.returntype, SR.doe, SR.branchid, SR.remarks, SR.invoiceno, SR.refno, SR.billtotalvalue, SR.entryby, SR.createdon, SR.status, SSR.productid, SSR.quantity, SSR.price, SSR.storesreturn_sno, SSR.totalvalue, SSR.ordertax  from stores_return AS SR INNER JOIN sub_stores_return AS SSR ON SR.sno=SSR.storesreturn_sno INNER JOIN productmaster ON productmaster.productid = SSR.productid WHERE SR.doe between @d1 and @d2 AND SR.branchid=@branchid AND SR.sno=@sno");//, inwarddetails.indentno
            cmd.Parameters.Add("@d1", GetLowDate(ServerDateCurrentdate).AddDays(-25));
            cmd.Parameters.Add("@d2", GetHighDate(ServerDateCurrentdate));
            cmd.Parameters.Add("@branchid", branchid);
            cmd.Parameters.Add("@sno", InvoicNo);
            DataTable routes = vdm.SelectQuery(cmd).Tables[0];
            DataView view = new DataView(routes);
            DataTable dtinward = view.ToTable(true, "sno", "returntype", "doe", "branchid", "refno", "status", "remarks", "billtotalvalue", "invoiceno");//, "indentno"
            DataTable dtsubinward = view.ToTable(true, "productname", "productid", "quantity", "price", "totalvalue", "storesreturn_sno", "ordertax");
            List<getInwardData> getInwarddetails = new List<getInwardData>();
            List<inwardDetails> inwardlist = new List<inwardDetails>();
            List<Subinward> subinwardlist = new List<Subinward>();
            //foreach (DataRow dr in dtinward.Rows)
            //{
            //    inwardDetails getInward = new inwardDetails();
            //    getInward.date = ((DateTime)dr["doe"]).ToString("dd-MM-yyyy");//dr["inwarddate"].ToString();
            //    getInward.totalvalue = dr["billtotalvalue"].ToString();
            //    getInward.frombranch = dr["returntype"].ToString();
            //    getInward.tobranch = dr["refno"].ToString();
            //    getInward.status = dr["status"].ToString();
            //    getInward.sno = dr["sno"].ToString();
            //    getInward.mrnno = dr["invoiceno"].ToString();
            //    getInward.description = dr["remarks"].ToString();
            //    inwardlist.Add(getInward);
            //}
            foreach (DataRow dr in dtsubinward.Rows)
            {
                Subinward getsubinward = new Subinward();
                getsubinward.hdnproductsno = dr["productid"].ToString();
                getsubinward.productname = dr["productname"].ToString();
                getsubinward.Quantity = dr["quantity"].ToString();
                double quantity = Convert.ToDouble(dr["quantity"].ToString());
                quantity = Math.Round(quantity, 2);
                getsubinward.PerUnitRs = dr["price"].ToString();
                getsubinward.TotalCost = dr["totalvalue"].ToString();
                getsubinward.ordertax = dr["ordertax"].ToString();
                getsubinward.inword_refno = dr["storesreturn_sno"].ToString();
                subinwardlist.Add(getsubinward);
            }
            getInwardData getInwadDatas = new getInwardData();
            //getInwadDatas.InwardDetails = inwardlist;
            getInwadDatas.SubInward = subinwardlist;
            getInwarddetails.Add(getInwadDatas);
            string response = GetJson(subinwardlist);
            context.Response.Write(response);
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    private void get_storereturnpending_details(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            string julydt = "07/01/2017";
            DateTime gst_dt = Convert.ToDateTime(julydt);
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
            string branchid = context.Session["BranchID"].ToString();
            string sno = context.Request["sno"].ToString();
            cmd = new SqlCommand("select productmaster.productname, SR.sno, SR.returntype, SR.doe, SR.branchid, SR.remarks, SR.invoiceno, SR.refno, SR.billtotalvalue, SR.entryby, SR.createdon, SR.status, SSR.productid, SSR.quantity, SSR.price, SSR.storesreturn_sno, SSR.totalvalue, SSR.ordertax  from stores_return AS SR INNER JOIN sub_stores_return AS SSR ON SR.sno=SSR.storesreturn_sno INNER JOIN productmaster ON productmaster.productid = SSR.productid WHERE SR.branchid=@branchid AND SR.sno=@sno AND SR.status=@status");//, inwarddetails.indentno
            cmd.Parameters.Add("@sno", sno);
            cmd.Parameters.Add("@branchid", branchid);
            cmd.Parameters.Add("@status", "P");
            DataTable routes = vdm.SelectQuery(cmd).Tables[0];
            DataView view = new DataView(routes);
            DataTable dtinward = view.ToTable(true, "sno", "returntype", "doe", "branchid", "refno", "status", "remarks", "billtotalvalue", "invoiceno");//, "indentno"
            DataTable dtsubinward = view.ToTable(true, "productname", "productid", "quantity", "price", "totalvalue", "storesreturn_sno", "ordertax");
            List<getInwardData> getInwarddetails = new List<getInwardData>();
            List<inwardDetails> inwardlist = new List<inwardDetails>();
            List<Subinward> subinwardlist = new List<Subinward>();
            foreach (DataRow dr in dtinward.Rows)
            {
                inwardDetails getInward = new inwardDetails();
                getInward.date = ((DateTime)dr["doe"]).ToString("dd-MM-yyyy");//dr["inwarddate"].ToString();
                getInward.totalvalue = dr["billtotalvalue"].ToString();
                getInward.frombranch = dr["returntype"].ToString();
                getInward.tobranch = dr["refno"].ToString();
                getInward.status = dr["status"].ToString();
                getInward.sno = dr["sno"].ToString();
                getInward.mrnno = dr["invoiceno"].ToString();
                getInward.description = dr["remarks"].ToString();
                inwardlist.Add(getInward);
            }
            foreach (DataRow dr in dtsubinward.Rows)
            {
                Subinward getsubinward = new Subinward();
                getsubinward.hdnproductsno = dr["productid"].ToString();
                getsubinward.productname = dr["productname"].ToString();
                getsubinward.Quantity = dr["quantity"].ToString();
                double quantity = Convert.ToDouble(dr["quantity"].ToString());
                quantity = Math.Round(quantity, 2);
                getsubinward.PerUnitRs = dr["price"].ToString();
                getsubinward.TotalCost = dr["totalvalue"].ToString();
                getsubinward.ordertax = dr["ordertax"].ToString();
                getsubinward.inword_refno = dr["storesreturn_sno"].ToString();
                subinwardlist.Add(getsubinward);
            }
            getInwardData getInwadDatas = new getInwardData();
            getInwadDatas.InwardDetails = inwardlist;
            getInwadDatas.SubInward = subinwardlist;
            getInwarddetails.Add(getInwadDatas);
            string response = GetJson(getInwarddetails);
            context.Response.Write(response);
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    private void storereturn_approveclick(HttpContext context)
    {

        try
        {
            vdm = new SalesDBManager();
            string julydt = "07/01/2017";
            DateTime gst_dt = Convert.ToDateTime(julydt);
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
            string branchid = context.Session["BranchID"].ToString();
            string sno = context.Request["sno"].ToString();
            cmd = new SqlCommand("UPDATE stores_return SET status='A' WHERE sno=@sno");
            cmd.Parameters.Add("@sno", sno);
            vdm.Update(cmd);

            cmd = new SqlCommand("select sub_stores_return.productid, sub_stores_return.quantity, stores_return.returntype  from sub_stores_return INNER JOIN stores_return ON stores_return.sno = sub_stores_return.storesreturn_sno where storesreturn_sno=@psno");
            cmd.Parameters.Add("@psno", sno);
            DataTable dtsubreturn = vdm.SelectQuery(cmd).Tables[0];
            if (dtsubreturn.Rows.Count > 0)
            {
                foreach (DataRow dr in dtsubreturn.Rows)
                {
                    string productid = dr["productid"].ToString();
                    string quantity = dr["quantity"].ToString();
                    string returntype = dr["returntype"].ToString();
                    if (returntype == "parlor")
                    {
                        cmd = new SqlCommand("Update productmoniter set qty=qty+@quantity where productid=@productid AND branchid=@branchid");
                        cmd.Parameters.Add("@productid", productid);
                        cmd.Parameters.Add("@branchid", branchid);
                        cmd.Parameters.Add("@quantity", quantity);
                        vdm.Update(cmd);
                    }
                    else
                    {
                        cmd = new SqlCommand("Update productmoniter set qty=qty-@quantity where productid=@productid AND branchid=@branchid");
                        cmd.Parameters.Add("@productid", productid);
                        cmd.Parameters.Add("@branchid", branchid);
                        cmd.Parameters.Add("@quantity", quantity);
                        vdm.Update(cmd);
                    }
                }
            }
            string Response = GetJson("Item Details are Successfully Aproved");
            context.Response.Write(Response);
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }






    private void get_employewise_parlor_details(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
            string empid = context.Session["Employ_Sno"].ToString();
            cmd = new SqlCommand("select branchmaster.branchname, branchmaster.phone, branchmaster.gstin, empbranchmapping.branchid from empbranchmapping INNER JOIN branchmaster ON branchmaster.branchid= empbranchmapping.branchid WHERE empbranchmapping.empid=@empid");
            cmd.Parameters.Add("@empid", empid);
            DataTable routes = vdm.SelectQuery(cmd).Tables[0];
            List<parlordetails> SectionMaster = new List<parlordetails>();
            foreach (DataRow dr in routes.Rows)
            {
                parlordetails getsectiondetails = new parlordetails();
                getsectiondetails.parlorid = dr["branchid"].ToString();
                getsectiondetails.parlorname = dr["branchname"].ToString();
                getsectiondetails.phone = dr["phone"].ToString();
                getsectiondetails.gstin = dr["gstin"].ToString();
                getsectiondetails.sno = dr["branchid"].ToString();
                SectionMaster.Add(getsectiondetails);
            }
            string response = GetJson(SectionMaster);
            context.Response.Write(response);
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
        //
    }

    private void get_branchassigntoemp_details(HttpContext context)
    {
        context.Session["BranchID"] = "";
        string branchid = context.Request["branchid"].ToString();
        context.Session["BranchID"] = branchid;
        string Response = GetJson("ok");
        context.Response.Write(Response);
    }

    private void get_stocktransferpending_details(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            string julydt = "07/01/2017";
            DateTime gst_dt = Convert.ToDateTime(julydt);
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
            string branchid = context.Session["BranchID"].ToString();
            string sno = context.Request["sno"].ToString();
            cmd = new SqlCommand("SELECT STD.sno, STD.billtotalvalue, STD.frombranch, STD.tobranch, STD.doe, STD.branchid, STD.status, STD.invoiceno, STD.invoicedate, STD.remarks, STSD.productid, STSD.quantity, STSD.price, STSD.totvalue, SUP.branchname as fromname, SUP1.branchname as toname, PM.productname, STSD.stock_refno FROM stocktransferdetails AS STD INNER JOIN stocktransfersubdetails AS STSD ON STD.sno=STSD.stock_refno INNER JOIN branchmaster AS SUP ON SUP.branchid = STD.frombranch INNER JOIN branchmaster AS SUP1 ON SUP1.branchid = STD.tobranch INNER JOIN productmaster AS PM on PM.productid = STSD.productid WHERE  STD.branchid=@branchid AND STD.status=@status AND STD.sno=@sno");//, inwarddetails.indentno
            cmd.Parameters.Add("@sno", sno);
            cmd.Parameters.Add("@branchid", branchid);
            cmd.Parameters.Add("@status", "P");
            DataTable routes = vdm.SelectQuery(cmd).Tables[0];
            DataView view = new DataView(routes);
            DataTable dtinward = view.ToTable(true, "sno", "frombranch", "tobranch", "doe", "branchid", "invoiceno", "status", "invoicedate", "remarks", "fromname", "toname", "billtotalvalue");//, "indentno"
            DataTable dtsubinward = view.ToTable(true, "productid", "quantity", "price", "totvalue", "stock_refno", "productname");
            List<getInwardData> getInwarddetails = new List<getInwardData>();
            List<inwardDetails> inwardlist = new List<inwardDetails>();
            List<Subinward> subinwardlist = new List<Subinward>();
            foreach (DataRow dr in dtinward.Rows)
            {
                inwardDetails getInward = new inwardDetails();
                getInward.date = ((DateTime)dr["doe"]).ToString("dd-MM-yyyy");//dr["inwarddate"].ToString();
                getInward.totalvalue = dr["billtotalvalue"].ToString();
                getInward.frombranch = dr["frombranch"].ToString();
                getInward.tobranch = dr["tobranch"].ToString();
                getInward.fromname = dr["fromname"].ToString();
                getInward.toname = dr["toname"].ToString();
                getInward.status = dr["status"].ToString();
                getInward.sno = dr["sno"].ToString();
                getInward.mrnno = dr["invoiceno"].ToString();
                getInward.description = dr["remarks"].ToString();
                inwardlist.Add(getInward);

            }
            foreach (DataRow dr in dtsubinward.Rows)
            {
                Subinward getsubinward = new Subinward();
                getsubinward.hdnproductsno = dr["productid"].ToString();
                getsubinward.productname = dr["productname"].ToString();
                getsubinward.Quantity = dr["quantity"].ToString();
                double quantity = Convert.ToDouble(dr["quantity"].ToString());
                quantity = Math.Round(quantity, 2);
                getsubinward.PerUnitRs = dr["price"].ToString();
                getsubinward.TotalCost = dr["totvalue"].ToString();
                getsubinward.ordertax = "0";
                getsubinward.inword_refno = dr["stock_refno"].ToString();
                subinwardlist.Add(getsubinward);
            }
            getInwardData getInwadDatas = new getInwardData();
            getInwadDatas.InwardDetails = inwardlist;
            getInwadDatas.SubInward = subinwardlist;
            getInwarddetails.Add(getInwadDatas);
            string response = GetJson(getInwarddetails);
            context.Response.Write(response);
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    private void stocktranfer_approveclick(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            string julydt = "07/01/2017";
            DateTime gst_dt = Convert.ToDateTime(julydt);
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
            string branchid = context.Session["BranchID"].ToString();
            string sno = context.Request["sno"].ToString();
            cmd = new SqlCommand("UPDATE stocktransferdetails SET status='A' WHERE sno=@sno");
            cmd.Parameters.Add("@sno", sno);
            vdm.Update(cmd);

            cmd = new SqlCommand("select stocktransfersubdetails.productid, stocktransfersubdetails.quantity, stocktransferdetails.frombranch, stocktransferdetails.tobranch  from stocktransfersubdetails INNER JOIN stocktransferdetails ON stocktransferdetails.sno = stocktransfersubdetails.stock_refno where stocktransferdetails.sno=@psno");
            cmd.Parameters.Add("@psno", sno);
            DataTable dtsubreturn = vdm.SelectQuery(cmd).Tables[0];
            if (dtsubreturn.Rows.Count > 0)
            {
                foreach (DataRow dr in dtsubreturn.Rows)
                {
                    string productid = dr["productid"].ToString();
                    string quantity = dr["quantity"].ToString();
                    string frombranch = dr["frombranch"].ToString();
                    string tobranch = dr["tobranch"].ToString();
                    if (frombranch != "")
                    {
                        cmd = new SqlCommand("Update productmoniter set qty=qty-@quantity where productid=@productid AND branchid=@branchid");
                        cmd.Parameters.Add("@productid", productid);
                        cmd.Parameters.Add("@branchid", frombranch);
                        cmd.Parameters.Add("@quantity", quantity);
                        vdm.Update(cmd);
                    }
                }
            }
            string Response = GetJson("Item Details are Successfully Aproved");
            context.Response.Write(Response);
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    private void get_stock_details(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
            string branchid = context.Session["BranchID"].ToString();
            cmd = new SqlCommand("Select productmoniter.productid, productmoniter.qty, productmoniter.price, productmaster.productname from productmoniter INNER JOIN productmaster ON productmaster.productid= productmoniter.productid WHERE productmoniter.branchid=@branchid ORDER BY productmaster.subcategoryid ");
            cmd.Parameters.Add("@branchid", branchid);
            DataTable dtitemwieqty = vdm.SelectQuery(cmd).Tables[0];
            List<itemmonitordetails> subcatsaleslist = new List<itemmonitordetails>();
            if (dtitemwieqty.Rows.Count > 0)
            {
                foreach (DataRow dr in dtitemwieqty.Rows)
                {
                    itemmonitordetails getdeptdetails = new itemmonitordetails();
                    getdeptdetails.itemname = dr["productname"].ToString();
                    getdeptdetails.quantity = dr["qty"].ToString();
                    getdeptdetails.sellingprice = dr["price"].ToString();
                    getdeptdetails.sno = dr["productid"].ToString();
                    subcatsaleslist.Add(getdeptdetails);
                }
                string response = GetJson(subcatsaleslist);
                context.Response.Write(response);
            }
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    private void get_cashclosingdetails_details(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
            string branchid = context.Session["BranchID"].ToString();
            cmd = new SqlCommand("SELECT sno, cashinhand, cashsale, chequesale, giftcardsale, ccsale, stripesale, othersale, totalsale, expenses, totalcash, submittedcash, submittedslips, submittedchecks, description, parlorid, doe, closedby from registorclosingdetails Where doe between @d1 and @d2 AND parlorid=@pid");
            cmd.Parameters.Add("@d1", GetLowDate(ServerDateCurrentdate).AddDays(-20));
            cmd.Parameters.Add("@d2", GetHighDate(ServerDateCurrentdate));
            cmd.Parameters.Add("@pid", branchid);
            DataTable dtitemwieqty = vdm.SelectQuery(cmd).Tables[0];
            List<RegcloseDetails> subcatsaleslist = new List<RegcloseDetails>();
            if (dtitemwieqty.Rows.Count > 0)
            {
                foreach (DataRow dr in dtitemwieqty.Rows)
                {

                    RegcloseDetails getdeptdetails = new RegcloseDetails();
                    getdeptdetails.cashinhand = dr["cashinhand"].ToString();
                    getdeptdetails.cashsale = dr["cashsale"].ToString();
                    getdeptdetails.chequesale = dr["chequesale"].ToString();
                    getdeptdetails.giftcardsale = dr["giftcardsale"].ToString();
                    getdeptdetails.ccsale = dr["ccsale"].ToString();
                    getdeptdetails.stripesale = dr["stripesale"].ToString();
                    getdeptdetails.othersale = dr["othersale"].ToString();
                    getdeptdetails.totalsale = dr["totalsale"].ToString();
                    getdeptdetails.expenses = dr["expenses"].ToString();
                    getdeptdetails.totalcash = dr["totalcash"].ToString();
                    getdeptdetails.submittedcash = dr["submittedcash"].ToString();
                    getdeptdetails.doe = ((DateTime)dr["doe"]).ToString("dd-MM-yyyy");
                    getdeptdetails.sno = dr["sno"].ToString();
                    subcatsaleslist.Add(getdeptdetails);
                }
                string response = GetJson(subcatsaleslist);
                context.Response.Write(response);
            }
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }
    public class paymentdetails
    {
        public string sno { get; set; }
        public string accounttype { get; set; }
        public string status { get; set; }
        public string name { get; set; }
        public string accountno { get; set; }
        public string accountid { get; set; }
        public string totalamount { get; set; }
        public string Remarks { get; set; }
        public string UserName { get; set; }
        public string doe { get; set; }
        public string approvedby { get; set; }
        public string btnval { get; set; }
        public string debitname { get; set; }
        public string headofaccount { get; set; }
        public string headid { get; set; }
        public string refno { get; set; }
        public string paymentdate { get; set; }
        public string branchname { get; set; }
        public string branchid { get; set; }
        public string jvdate { get; set; }
        public List<paymentsubdetails> paymententry { get; set; }
        public List<paymentsubdetails> subpaymententry { get; set; }

        public string sapimport { get; set; }

        public string subbranch { get; set; }

        public string subheadofaccount { get; set; }

        public string totalamountsub { get; set; }

        public string branch { get; set; }

        public string subbranchid { get; set; }

        public string totalsubamount { get; set; }
    }

    public class paymentsubdetails
    {

        public string Account { get; set; }
        public string amount { get; set; }
        public string SNo { get; set; }

    }
    private void save_jounel_voucher_click(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            var js = new JavaScriptSerializer();
            var title1 = context.Request.Params[1];
            paymentdetails obj = js.Deserialize<paymentdetails>(title1);
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
            string UserName = context.Session["UserSno"].ToString();
            string branchid = obj.branchid;
            string sno = obj.sno;
            string totalamount = obj.totalamount;
            if (totalamount == null)
            {
                totalamount = "0";
            }
            string Remarks = obj.Remarks;
            string btn_save = obj.btnval;
            string strdate = obj.jvdate;
            DateTime jvdate = Convert.ToDateTime(strdate);
            //string debitname = obj.debitname;
            if (btn_save == "Save")
            {
                cmd = new SqlCommand("insert into journel_entry (branchid,amount,remarks,doe,createdby,status,jvdate) values (@branchid,@amount,@remarks,@doe,@createdby,'P',@jvdate)");
                cmd.Parameters.Add("@branchid", branchid);
                cmd.Parameters.Add("@amount", totalamount);
                cmd.Parameters.Add("@remarks", Remarks);
                cmd.Parameters.Add("@doe", ServerDateCurrentdate);
                cmd.Parameters.Add("@createdby", UserName);
                cmd.Parameters.Add("@jvdate", jvdate);
                vdm.insert(cmd);
                cmd = new SqlCommand("select MAX(sno) AS sno from journel_entry ");
                DataTable routes = vdm.SelectQuery(cmd).Tables[0];
                string paymentrefno = routes.Rows[0]["sno"].ToString();
                foreach (paymentsubdetails si in obj.paymententry)
                {
                    string headofaccount = si.SNo;
                    string amount = si.amount;
                    cmd = new SqlCommand("insert into subjournel_entry (refno, headofaccount, amount) values (@refno, @headofaccount, @amount)");
                    cmd.Parameters.Add("@refno", paymentrefno);
                    cmd.Parameters.Add("@headofaccount", headofaccount);
                    cmd.Parameters.Add("@amount", amount);
                    vdm.insert(cmd);
                }
                foreach (paymentsubdetails si in obj.subpaymententry)
                {
                    string headofaccount = si.SNo;
                    string amount = si.amount;
                    cmd = new SqlCommand("insert into subjournel_credit_entry (refno, headofaccount, amount) values (@refno, @headofaccount, @amount)");
                    cmd.Parameters.Add("@refno", paymentrefno);
                    cmd.Parameters.Add("@headofaccount", headofaccount);
                    cmd.Parameters.Add("@amount", amount);
                    vdm.insert(cmd);
                }
                string msg = "successfully Inserted";
                string Response = GetJson(msg);
                context.Response.Write(Response);
            }
            else
            {
                cmd = new SqlCommand("UPDATE journel_entry SET branchid=@branchid,amount=@amount,remarks=@remarks, status=@status,jvdate=@jvdate WHERE sno=@sno");
                cmd.Parameters.Add("@branchid", branchid);
                cmd.Parameters.Add("@amount", totalamount);
                cmd.Parameters.Add("@remarks", Remarks);
                cmd.Parameters.Add("@sno", sno);
                cmd.Parameters.Add("@status", 'P');
                cmd.Parameters.Add("@jvdate", jvdate);
                vdm.Update(cmd);
                cmd = new SqlCommand("delete from subjournel_entry where refno=@Refno");
                cmd.Parameters.Add("@Refno", sno);
                vdm.Delete(cmd);
                cmd = new SqlCommand("delete from subjournel_credit_entry where refno=@Refno");
                cmd.Parameters.Add("@Refno", sno);
                vdm.Delete(cmd);
                foreach (paymentsubdetails si in obj.paymententry)
                {
                    string headofaccount = si.SNo;
                    string amount = si.amount;
                    cmd = new SqlCommand("insert into subjournel_entry (refno, headofaccount, amount) values (@refno, @headofaccount, @amount)");
                    cmd.Parameters.Add("@refno", sno);
                    cmd.Parameters.Add("@headofaccount", headofaccount);
                    cmd.Parameters.Add("@amount", amount);
                    vdm.insert(cmd);
                }
                foreach (paymentsubdetails si in obj.subpaymententry)
                {
                    string headofaccount = si.SNo;
                    string amount = si.amount;
                    cmd = new SqlCommand("insert into subjournel_credit_entry (refno, headofaccount, amount) values (@refno, @headofaccount, @amount)");
                    cmd.Parameters.Add("@refno", sno);
                    cmd.Parameters.Add("@headofaccount", headofaccount);
                    cmd.Parameters.Add("@amount", amount);
                    vdm.insert(cmd);
                }
                string msg = "updated successfully";
                string Response = GetJson(msg);
                context.Response.Write(Response);
            }
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    public class subcathoursalevalue
    {
        public string subcategoryname { get; set; }
        public string Hour { get; set; }
        public string qty { get; set; }
        public string totvalue { get; set; }
        public string sno { get; set; }
        public string value1 { get; set; }
        public string value2 { get; set; }
        public string value3 { get; set; }
        public string value4 { get; set; }
        public string value5 { get; set; }
        public string value6 { get; set; }
        public string value7 { get; set; }
        public string value8 { get; set; }
        public string value9 { get; set; }
        public string value10 { get; set; }
        public string value11 { get; set; }
        public string value12 { get; set; }
        public string value13 { get; set; }
        public string value14 { get; set; }
        public string value15 { get; set; }
        public string value16 { get; set; }
        public string value17 { get; set; }
        public string value18 { get; set; }
        public string subcat1 { get; set; }
        public string subcat2 { get; set; }
        public string subcat3 { get; set; }
        public string subcat4 { get; set; }
        public string subcat5 { get; set; }
        public string subcat6 { get; set; }
        public string subcat7 { get; set; }
        public string subcat8 { get; set; }
        public string subcat9 { get; set; }
        public string subcat10 { get; set; }
        public string subcat11 { get; set; }
        public string subcat12 { get; set; }
        public string subcat13 { get; set; }
        public string subcat14 { get; set; }
        public string subcat15 { get; set; }
        public string subcat16 { get; set; }
        public string subcat17 { get; set; }
    }
    private void subcategorywise_hoursalevalue(HttpContext context)
    {
        //
        try
        {
            vdm = new SalesDBManager();
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
            string branchid = context.Session["BranchID"].ToString();
            cmd = new SqlCommand("SELECT subcategorymaster.subcategoryname, Datepart(hour, possale_maindetails.doe) Hour, SUM(possale_subdetails.qty) AS QTY, Sum(possale_subdetails.totvalue) as totvalue, sum(possale_subdetails.ordertax) AS ordertax from possale_maindetails  INNER JOIN possale_subdetails ON possale_subdetails.refno = possale_maindetails.sno INNER JOIN productmaster ON productmaster.productid = possale_subdetails.productid INNER JOIN subcategorymaster ON subcategorymaster.subcategoryid=productmaster.subcategoryid WHERE possale_maindetails.branchid=@bid AND  possale_maindetails.doe BETWEEN @d1 AND @d2 GROUP BY subcategorymaster.subcategoryname,  Datepart(hour, possale_maindetails.doe) ORDER BY Datepart(hour, possale_maindetails.doe)");
            cmd.Parameters.Add("@d1", GetLowDate(ServerDateCurrentdate).AddDays(-1));
            cmd.Parameters.Add("@d2", GetHighDate(ServerDateCurrentdate).AddDays(-1));
            cmd.Parameters.Add("@bid", branchid);
            DataTable dtitemwieqty = vdm.SelectQuery(cmd).Tables[0];
            DataView view = new DataView(dtitemwieqty);
            DataTable dtlist = view.ToTable(true, "Hour");//, "indentno"
            List<subcathoursalevalue> subcatsaleslist = new List<subcathoursalevalue>();
            if (dtlist.Rows.Count > 0)
            {
                string value1 = "";
                string value2 = "";
                string value3 = "";
                string value4 = "";
                string value5 = "";
                string value6 = "";
                string value7 = "";
                string value8 = "";
                string value9 = "";
                string value10 = "";
                string value11 = "";
                string value12 = "";
                string value13 = "";
                string value14 = "";
                string value15 = "";
                string value16 = "";
                string value17 = "";
                string value18 = "";
                string subcat1 = "";
                string subcat2 = "";
                string subcat3 = "";
                string subcat4 = "";
                string subcat5 = "";
                string subcat6 = "";
                string subcat7 = "";
                string subcat8 = "";
                string subcat9 = "";
                string subcat10 = "";
                string subcat11 = "";
                string subcat12 = "";
                string subcat13 = "";
                string subcat14 = "";
                string subcat15 = "";
                string subcat16 = "";
                string subcat17 = "";
                DataTable Report = new DataTable();
                Report.Columns.Add("Hour");
                Report.Columns.Add("subcat1");
                Report.Columns.Add("subcat2");
                Report.Columns.Add("subcat3");
                Report.Columns.Add("subcat4");
                Report.Columns.Add("subcat5");
                Report.Columns.Add("subcat6");
                Report.Columns.Add("subcat7");
                Report.Columns.Add("subcat8");
                Report.Columns.Add("subcat9");
                Report.Columns.Add("subcat10");
                Report.Columns.Add("subcat11");
                Report.Columns.Add("subcat12");
                Report.Columns.Add("subcat13");
                Report.Columns.Add("subcat14");
                Report.Columns.Add("subcat15");
                Report.Columns.Add("subcat16");
                Report.Columns.Add("subcat17");
                Report.Columns.Add("subcat18");
                Report.Columns.Add("value1");
                Report.Columns.Add("value2");
                Report.Columns.Add("value3");
                Report.Columns.Add("value4");
                Report.Columns.Add("value5");
                Report.Columns.Add("value6");
                Report.Columns.Add("value7");
                Report.Columns.Add("value8");
                Report.Columns.Add("value9");
                Report.Columns.Add("value10");
                Report.Columns.Add("value11");
                Report.Columns.Add("value12");
                Report.Columns.Add("value13");
                Report.Columns.Add("value14");
                Report.Columns.Add("value15");
                Report.Columns.Add("value16");
                Report.Columns.Add("value17");
                Report.Columns.Add("value18");
                foreach (DataRow dr in dtlist.Rows)
                {
                    string hour = dr["Hour"].ToString();

                    DataRow newrow = Report.NewRow();
                    newrow["Hour"] = hour.ToString();
                    int i = 0;
                    foreach (DataRow dra in dtitemwieqty.Select("Hour='" + hour + "'"))
                    {


                        double totvalue = 0;
                        double.TryParse(dra["totvalue"].ToString(), out totvalue);
                        double ordertax = 0;
                        double.TryParse(dra["ordertax"].ToString(), out ordertax);
                        double tot = Math.Round(totvalue + ordertax, 2);

                        i++;
                        if (i == 1)
                        {
                            newrow["subcat1"] = dra["subcategoryname"].ToString();
                            newrow["value1"] = tot.ToString();
                        }
                        if (i == 2)
                        {
                            newrow["subcat2"] = dra["subcategoryname"].ToString();
                            newrow["value2"] = tot.ToString();
                        }
                        if (i == 3)
                        {
                            newrow["subcat3"] = dra["subcategoryname"].ToString();
                            newrow["value3"] = tot.ToString();
                        }
                        if (i == 4)
                        {
                            newrow["subcat4"] = dra["subcategoryname"].ToString();
                            newrow["value4"] = tot.ToString();
                        }
                        if (i == 5)
                        {
                            newrow["subcat5"] = dra["subcategoryname"].ToString();
                            newrow["value5"] = tot.ToString();
                        }
                        if (i == 6)
                        {
                            newrow["subcat6"] = dra["subcategoryname"].ToString();
                            newrow["value6"] = tot.ToString();
                        }
                        if (i == 7)
                        {
                            newrow["subcat7"] = dra["subcategoryname"].ToString();
                            newrow["value7"] = tot.ToString();
                        }
                        if (i == 8)
                        {
                            newrow["subcat8"] = dra["subcategoryname"].ToString();
                            newrow["value8"] = tot.ToString();
                        }
                        if (i == 9)
                        {
                            newrow["subcat9"] = dra["subcategoryname"].ToString();
                            newrow["value9"] = tot.ToString();

                        }
                        if (i == 10)
                        {
                            newrow["subcat10"] = dra["subcategoryname"].ToString();
                            newrow["value10"] = tot.ToString();
                        }
                        if (i == 11)
                        {
                            newrow["subcat11"] = dra["subcategoryname"].ToString();
                            newrow["value11"] = tot.ToString();
                        }
                        if (i == 12)
                        {
                            newrow["subcat12"] = dra["subcategoryname"].ToString();
                            newrow["value12"] = tot.ToString();
                        }
                        if (i == 13)
                        {
                            newrow["subcat13"] = dra["subcategoryname"].ToString();
                            newrow["value13"] = tot.ToString();
                        }
                        if (i == 14)
                        {
                            newrow["subcat14"] = dra["subcategoryname"].ToString();
                            newrow["value14"] = tot.ToString();
                        }
                        if (i == 15)
                        {
                            newrow["subcat15"] = dra["subcategoryname"].ToString();
                            newrow["value15"] = tot.ToString();
                        }
                        if (i == 16)
                        {
                            newrow["subcat16"] = dra["subcategoryname"].ToString();
                            newrow["value16"] = tot.ToString();
                        }
                        if (i == 17)
                        {
                            newrow["subcat17"] = dra["subcategoryname"].ToString();
                            newrow["value17"] = tot.ToString();
                        }
                        if (i == 18)
                        {
                            newrow["subcat18"] = dra["subcategoryname"].ToString();
                            newrow["value18"] = tot.ToString();
                        }

                    }
                    Report.Rows.Add(newrow);

                }
                if (Report.Rows.Count > 0)
                {
                    foreach (DataRow drrpt in Report.Rows)
                    {

                        subcathoursalevalue getdeptdetails = new subcathoursalevalue();
                        getdeptdetails.Hour = drrpt["Hour"].ToString();
                        getdeptdetails.subcat1 = drrpt["subcat1"].ToString();
                        getdeptdetails.subcat2 = drrpt["subcat2"].ToString();
                        getdeptdetails.subcat3 = drrpt["subcat3"].ToString();
                        getdeptdetails.subcat4 = drrpt["subcat4"].ToString();
                        getdeptdetails.subcat5 = drrpt["subcat5"].ToString();
                        getdeptdetails.subcat6 = drrpt["subcat6"].ToString();
                        getdeptdetails.subcat7 = drrpt["subcat7"].ToString();
                        getdeptdetails.subcat8 = drrpt["subcat8"].ToString();
                        getdeptdetails.subcat9 = drrpt["subcat9"].ToString();
                        getdeptdetails.subcat10 = drrpt["subcat10"].ToString();
                        getdeptdetails.subcat11 = drrpt["subcat11"].ToString();
                        getdeptdetails.subcat12 = drrpt["subcat12"].ToString();
                        getdeptdetails.subcat13 = drrpt["subcat13"].ToString();
                        getdeptdetails.subcat14 = drrpt["subcat14"].ToString();
                        getdeptdetails.subcat15 = drrpt["subcat15"].ToString();
                        getdeptdetails.subcat16 = drrpt["subcat16"].ToString();
                        getdeptdetails.subcat17 = drrpt["subcat17"].ToString();

                        getdeptdetails.value1 = drrpt["value1"].ToString();
                        getdeptdetails.value2 = drrpt["value2"].ToString();
                        getdeptdetails.value3 = drrpt["value3"].ToString();
                        getdeptdetails.value4 = drrpt["value4"].ToString();
                        getdeptdetails.value5 = drrpt["value5"].ToString();
                        getdeptdetails.value6 = drrpt["value6"].ToString();
                        getdeptdetails.value7 = drrpt["value7"].ToString();
                        getdeptdetails.value8 = drrpt["value8"].ToString();
                        getdeptdetails.value9 = drrpt["value9"].ToString();
                        getdeptdetails.value10 = drrpt["value10"].ToString();
                        getdeptdetails.value11 = drrpt["value11"].ToString();
                        getdeptdetails.value12 = drrpt["value12"].ToString();
                        getdeptdetails.value13 = drrpt["value13"].ToString();
                        getdeptdetails.value14 = drrpt["value14"].ToString();
                        getdeptdetails.value15 = drrpt["value15"].ToString();
                        getdeptdetails.value16 = drrpt["value16"].ToString();
                        getdeptdetails.value17 = drrpt["value17"].ToString();
                        subcatsaleslist.Add(getdeptdetails);
                    }
                }
                string response = GetJson(subcatsaleslist);
                context.Response.Write(response);
            }
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }

    }
    public class datewisesalevaluedashboard
    {
        public string parlorid { get; set; }
        public string parlorname { get; set; }
        public string cmpid { get; set; }
        public string LogDate { get; set; }
        public string salevalue { get; set; }
        public string week1 { get; set; }
        public string week2 { get; set; }
        public string week3 { get; set; }
        public string week4 { get; set; }
        public string week5 { get; set; }

        public string linkval1 { get; set; }
        public string linkval2 { get; set; }
        public string linkval3 { get; set; }
        public string linkval4 { get; set; }

        public string linkval5 { get; set; }


        public string doe { get; set; }
        public string Time_diff { get; set; }
    }
    public class Allbiomertcdates
    {
        public string Betweendates { get; set; }
        public string Empid { get; set; }
        public string Employeename { get; set; }
        public string designation { get; set; }
        public string branchname { get; set; }
    }
    public class Employeebiomtericattendencedates //Employeemonthlyattendencedates
    {
        public List<Allbiomertcdates> Allbiomertcdates { get; set; }
        public List<datewisesalevaluedashboard> salevalue { get; set; }

    }

    private void get_possalevalue_details(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
            string branchid = "";

            //DateTime lastMonday = DateTime.Now.AddDays(-6);
            //while (lastMonday.DayOfWeek != DayOfWeek.Monday)
            //    lastMonday = lastMonday.AddDays(-1);


            DateTime fromdate = GetLowDate(ServerDateCurrentdate).AddDays(-6);
            DateTime todate = GetLowDate(ServerDateCurrentdate);
            TimeSpan dateSpan = todate.Subtract(fromdate);
            int NoOfdays = dateSpan.Days;
            NoOfdays = NoOfdays + 2;
            DateTime monday = DateTime.Today.AddDays(-(int)DateTime.Today.DayOfWeek + (int)DayOfWeek.Monday);

            cmd = new SqlCommand("SELECT branchid,branchname,cmpid FROM branchmaster");
            DataTable dtbranchinfo = vdm.SelectQuery(cmd).Tables[0];
            // cmd = new SqlCommand("SELECT  SUM(possale_subdetails.totvalue + possale_subdetails.ordertax) AS totvalue, CONVERT(VARCHAR(10), possale_maindetails.doe, 101) AS doe, possale_maindetails.branchid FROM  productmaster INNER JOIN  possale_subdetails ON productmaster.productid = possale_subdetails.productid INNER JOIN subcategorymaster ON productmaster.subcategoryid = subcategorymaster.subcategoryid INNER JOIN  possale_maindetails ON possale_subdetails.refno = possale_maindetails.sno  WHERE        (possale_maindetails.doe BETWEEN  DATEADD(wk,DATEDIFF(wk,7,GETDATE()),0) AND DATEADD(wk,DATEDIFF(wk,7,GETDATE()),7))  AND (possale_maindetails.status = 'C') GROUP BY CONVERT(VARCHAR(10), possale_maindetails.doe, 101), possale_maindetails.branchid ");
            cmd = new SqlCommand("SELECT  SUM(possale_subdetails.totvalue + possale_subdetails.ordertax) AS totvalue, CONVERT(VARCHAR(10), possale_maindetails.doe, 101) AS doe, possale_maindetails.branchid FROM  productmaster INNER JOIN  possale_subdetails ON productmaster.productid = possale_subdetails.productid INNER JOIN subcategorymaster ON productmaster.subcategoryid = subcategorymaster.subcategoryid INNER JOIN  possale_maindetails ON possale_subdetails.refno = possale_maindetails.sno  WHERE        (possale_maindetails.doe BETWEEN @D1 AND @D2)  AND (possale_maindetails.status = 'C') GROUP BY CONVERT(VARCHAR(10), possale_maindetails.doe, 101), possale_maindetails.branchid");
            cmd.Parameters.Add("@D1", GetLowDate(fromdate));
            cmd.Parameters.Add("@D2", GetHighDate(todate));
            DataTable dtsalevalue = vdm.SelectQuery(cmd).Tables[0];
            List<datewisesalevaluedashboard> salevaluelist = new List<datewisesalevaluedashboard>();
            List<Allbiomertcdates> Alldateslists = new List<Allbiomertcdates>();
            List<Employeebiomtericattendencedates> Employeebiomtericattendencedateslists = new List<Employeebiomtericattendencedates>();

            DataTable Report = new DataTable();
            Report.Columns.Add("Sno");
            Report.Columns.Add("Parlorid");
            Report.Columns.Add("Parlor Name");
            int count = 0;
            DateTime dtFrm = new DateTime();
            for (int j = 1; j < NoOfdays; j++)
            {
                if (j == 1)
                {
                    dtFrm = fromdate;
                }
                else
                {
                    dtFrm = dtFrm.AddDays(1);
                }
                DayOfWeek dow = dtFrm.DayOfWeek; //enum
                string str = dow.ToString();
                string strdate = dtFrm.ToString("dd/MMM");
                string columndate = strdate + "(" + str + ")";
                Report.Columns.Add(columndate);
                Allbiomertcdates obj1 = new Allbiomertcdates();
                obj1.Betweendates = columndate;
                Alldateslists.Add(obj1);
                count++;
            }

            if (dtbranchinfo.Rows.Count > 0)
            {
                int i = 1;
                foreach (DataRow dr in dtbranchinfo.Rows)
                {
                    DataRow newrow = Report.NewRow();
                    newrow["Sno"] = i++.ToString();
                    newrow["Parlor Name"] = dr["branchname"].ToString();
                    string parlorname = dr["branchname"].ToString();
                    string cmpid = dr["cmpid"].ToString();
                    branchid = dr["branchid"].ToString();
                    foreach (DataRow drDriver in dtsalevalue.Rows)
                    {
                        datewisesalevaluedashboard getattendance = new datewisesalevaluedashboard();
                        if (branchid == drDriver["branchid"].ToString())
                        {
                            string logdate = "";
                            string totsalevalue = "";
                            string attendance_date = drDriver["doe"].ToString();
                            if (attendance_date != "")
                            {
                                DateTime dtDoe = Convert.ToDateTime(attendance_date);
                                string strdate = dtDoe.ToString("dd/MMM");

                                DayOfWeek dow = dtDoe.DayOfWeek; //enum
                                string str = dow.ToString();
                                string columndate = strdate + "(" + str + ")";
                                logdate = columndate;
                                string salevalue = drDriver["totvalue"].ToString();
                                if (salevalue != "")
                                {
                                    double tsval = Convert.ToDouble(salevalue);
                                    tsval = Math.Round(tsval, 0);
                                    newrow[columndate] = tsval;
                                    totsalevalue = tsval.ToString();
                                }
                                else
                                {
                                    newrow[columndate] = "0";
                                }
                            }
                            else
                            {
                            }
                            string bid = drDriver["branchid"].ToString();
                            newrow["Parlorid"] = drDriver["branchid"].ToString();
                            getattendance.cmpid = cmpid;
                            getattendance.parlorname = parlorname;
                            getattendance.LogDate = logdate;
                            getattendance.salevalue = totsalevalue;
                            getattendance.parlorid = bid;
                            salevaluelist.Add(getattendance);
                        }
                    }
                    Report.Rows.Add(newrow);
                }
                if (Report.Rows.Count > 0)
                {

                }
                Employeebiomtericattendencedates obj2 = new Employeebiomtericattendencedates();
                obj2.Allbiomertcdates = Alldateslists;
                obj2.salevalue = salevaluelist;
                Employeebiomtericattendencedateslists.Add(obj2);
                string response = GetJson(Employeebiomtericattendencedateslists);
                context.Response.Write(response);
            }
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    private void get_lastweekpossalevalue_details(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
            string branchid = "";

            DateTime lastMonday = DateTime.Now.AddDays(-6);
            while (lastMonday.DayOfWeek != DayOfWeek.Monday)
                lastMonday = lastMonday.AddDays(-1);


            DateTime fromdate = GetLowDate(lastMonday);
            DateTime todate = GetLowDate(lastMonday).AddDays(6);
            TimeSpan dateSpan = todate.Subtract(fromdate);
            int NoOfdays = dateSpan.Days;
            NoOfdays = NoOfdays + 2;
            DateTime monday = DateTime.Today.AddDays(-(int)DateTime.Today.DayOfWeek + (int)DayOfWeek.Monday);

            cmd = new SqlCommand("SELECT branchid,branchname,cmpid FROM branchmaster");
            DataTable dtbranchinfo = vdm.SelectQuery(cmd).Tables[0];
            // cmd = new SqlCommand("SELECT  SUM(possale_subdetails.totvalue + possale_subdetails.ordertax) AS totvalue, CONVERT(VARCHAR(10), possale_maindetails.doe, 101) AS doe, possale_maindetails.branchid FROM  productmaster INNER JOIN  possale_subdetails ON productmaster.productid = possale_subdetails.productid INNER JOIN subcategorymaster ON productmaster.subcategoryid = subcategorymaster.subcategoryid INNER JOIN  possale_maindetails ON possale_subdetails.refno = possale_maindetails.sno  WHERE        (possale_maindetails.doe BETWEEN  DATEADD(wk,DATEDIFF(wk,7,GETDATE()),0) AND DATEADD(wk,DATEDIFF(wk,7,GETDATE()),7))  AND (possale_maindetails.status = 'C') GROUP BY CONVERT(VARCHAR(10), possale_maindetails.doe, 101), possale_maindetails.branchid ");
            cmd = new SqlCommand("SELECT  SUM(possale_subdetails.totvalue + possale_subdetails.ordertax) AS totvalue, CONVERT(VARCHAR(10), possale_maindetails.doe, 101) AS doe, possale_maindetails.branchid FROM  productmaster INNER JOIN  possale_subdetails ON productmaster.productid = possale_subdetails.productid INNER JOIN subcategorymaster ON productmaster.subcategoryid = subcategorymaster.subcategoryid INNER JOIN  possale_maindetails ON possale_subdetails.refno = possale_maindetails.sno  WHERE        (possale_maindetails.doe BETWEEN @D1 AND @D2)  AND (possale_maindetails.status = 'C') GROUP BY CONVERT(VARCHAR(10), possale_maindetails.doe, 101), possale_maindetails.branchid");
            cmd.Parameters.Add("@D1", GetLowDate(fromdate));
            cmd.Parameters.Add("@D2", GetHighDate(todate));
            DataTable dtsalevalue = vdm.SelectQuery(cmd).Tables[0];
            List<datewisesalevaluedashboard> salevaluelist = new List<datewisesalevaluedashboard>();
            List<Allbiomertcdates> Alldateslists = new List<Allbiomertcdates>();
            List<Employeebiomtericattendencedates> Employeebiomtericattendencedateslists = new List<Employeebiomtericattendencedates>();

            DataTable Report = new DataTable();
            Report.Columns.Add("Sno");
            Report.Columns.Add("Parlorid");
            Report.Columns.Add("Parlor Name");
            int count = 0;
            DateTime dtFrm = new DateTime();
            for (int j = 1; j < NoOfdays; j++)
            {
                if (j == 1)
                {
                    dtFrm = fromdate;
                }
                else
                {
                    dtFrm = dtFrm.AddDays(1);
                }
                DayOfWeek dow = dtFrm.DayOfWeek; //enum
                string str = dow.ToString();
                string strdate = dtFrm.ToString("dd/MMM");
                string columndate = strdate + "(" + str + ")";
                Report.Columns.Add(columndate);
                Allbiomertcdates obj1 = new Allbiomertcdates();
                obj1.Betweendates = columndate;
                Alldateslists.Add(obj1);
                count++;
            }

            if (dtbranchinfo.Rows.Count > 0)
            {
                int i = 1;
                foreach (DataRow dr in dtbranchinfo.Rows)
                {
                    DataRow newrow = Report.NewRow();
                    newrow["Sno"] = i++.ToString();
                    newrow["Parlor Name"] = dr["branchname"].ToString();
                    string parlorname = dr["branchname"].ToString();
                    string cmpid = dr["cmpid"].ToString();
                    branchid = dr["branchid"].ToString();
                    foreach (DataRow drDriver in dtsalevalue.Rows)
                    {
                        datewisesalevaluedashboard getattendance = new datewisesalevaluedashboard();
                        if (branchid == drDriver["branchid"].ToString())
                        {
                            string logdate = "";
                            string totsalevalue = "";
                            string attendance_date = drDriver["doe"].ToString();
                            if (attendance_date != "")
                            {
                                DateTime dtDoe = Convert.ToDateTime(attendance_date);
                                string strdate = dtDoe.ToString("dd/MMM");

                                DayOfWeek dow = dtDoe.DayOfWeek; //enum
                                string str = dow.ToString();
                                string columndate = strdate + "(" + str + ")";
                                logdate = columndate;
                                string salevalue = drDriver["totvalue"].ToString();
                                if (salevalue != "")
                                {
                                    double tsval = Convert.ToDouble(salevalue);
                                    tsval = Math.Round(tsval, 0);
                                    newrow[columndate] = tsval;
                                    totsalevalue = tsval.ToString();
                                }
                                else
                                {
                                    newrow[columndate] = "0";
                                }
                            }
                            else
                            {
                            }
                            string bid = drDriver["branchid"].ToString();
                            newrow["Parlorid"] = drDriver["branchid"].ToString();
                            getattendance.cmpid = cmpid;
                            getattendance.parlorname = parlorname;
                            getattendance.LogDate = logdate;
                            getattendance.salevalue = totsalevalue;
                            getattendance.parlorid = bid;
                            salevaluelist.Add(getattendance);
                        }
                    }
                    Report.Rows.Add(newrow);
                }
                if (Report.Rows.Count > 0)
                {

                }
                Employeebiomtericattendencedates obj2 = new Employeebiomtericattendencedates();
                obj2.Allbiomertcdates = Alldateslists;
                obj2.salevalue = salevaluelist;
                Employeebiomtericattendencedateslists.Add(obj2);
                string response = GetJson(Employeebiomtericattendencedateslists);
                context.Response.Write(response);
            }
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    private void get_currentweekpossalevalue_details(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
            string branchid = "";

            DateTime monday = DateTime.Today.AddDays(-(int)DateTime.Today.DayOfWeek + (int)DayOfWeek.Monday);
            DateTime sunday = DateTime.Today.AddDays(-(int)DateTime.Today.DayOfWeek + (int)DayOfWeek.Sunday);
            DateTime fromdate = GetLowDate(monday);
            DateTime todate = GetLowDate(monday).AddDays(6);
            TimeSpan dateSpan = todate.Subtract(fromdate);
            int NoOfdays = dateSpan.Days;
            NoOfdays = NoOfdays + 2;


            cmd = new SqlCommand("SELECT branchid,branchname,cmpid FROM branchmaster");
            DataTable dtbranchinfo = vdm.SelectQuery(cmd).Tables[0];
            //cmd = new SqlCommand("SELECT  SUM(possale_subdetails.totvalue + possale_subdetails.ordertax) AS totvalue, CONVERT(VARCHAR(10), possale_maindetails.doe, 101) AS doe, possale_maindetails.branchid FROM  productmaster INNER JOIN  possale_subdetails ON productmaster.productid = possale_subdetails.productid INNER JOIN subcategorymaster ON productmaster.subcategoryid = subcategorymaster.subcategoryid INNER JOIN  possale_maindetails ON possale_subdetails.refno = possale_maindetails.sno  WHERE        (possale_maindetails.doe BETWEEN  DATEADD(week, DATEDIFF(day, 0, getdate())/7, 0) AND DATEADD(week, DATEDIFF(day, 0, getdate())/7, 5))  AND (possale_maindetails.status = 'C') GROUP BY CONVERT(VARCHAR(10), possale_maindetails.doe, 101), possale_maindetails.branchid");
            //cmd = new SqlCommand("SELECT  SUM(possale_subdetails.totvalue + possale_subdetails.ordertax) AS totvalue, CONVERT(VARCHAR(10), possale_maindetails.doe, 101) AS doe, possale_maindetails.branchid FROM  productmaster INNER JOIN  possale_subdetails ON productmaster.productid = possale_subdetails.productid INNER JOIN subcategorymaster ON productmaster.subcategoryid = subcategorymaster.subcategoryid INNER JOIN  possale_maindetails ON possale_subdetails.refno = possale_maindetails.sno  WHERE        (possale_maindetails.doe BETWEEN @D1 AND @D2)  AND (possale_maindetails.status = 'C') GROUP BY CONVERT(VARCHAR(10), possale_maindetails.doe, 101), possale_maindetails.branchid");
            cmd = new SqlCommand("SELECT  SUM(possale_subdetails.totvalue + possale_subdetails.ordertax) AS totvalue, CONVERT(VARCHAR(10), possale_maindetails.doe, 101) AS doe, possale_maindetails.branchid FROM  productmaster INNER JOIN  possale_subdetails ON productmaster.productid = possale_subdetails.productid INNER JOIN subcategorymaster ON productmaster.subcategoryid = subcategorymaster.subcategoryid INNER JOIN  possale_maindetails ON possale_subdetails.refno = possale_maindetails.sno  WHERE        (possale_maindetails.doe BETWEEN @D1 AND @D2)  AND (possale_maindetails.status = 'C') GROUP BY CONVERT(VARCHAR(10), possale_maindetails.doe, 101), possale_maindetails.branchid");
            cmd.Parameters.Add("@D1", GetLowDate(fromdate));
            cmd.Parameters.Add("@D2", GetHighDate(todate));
            DataTable dtsalevalue = vdm.SelectQuery(cmd).Tables[0];
            List<datewisesalevaluedashboard> salevaluelist = new List<datewisesalevaluedashboard>();
            List<Allbiomertcdates> Alldateslists = new List<Allbiomertcdates>();
            List<Employeebiomtericattendencedates> Employeebiomtericattendencedateslists = new List<Employeebiomtericattendencedates>();

            DataTable Report = new DataTable();
            Report.Columns.Add("Sno");
            Report.Columns.Add("Parlorid");
            Report.Columns.Add("Parlor Name");
            Report.Columns.Add("Total");
            int count = 0;
            DateTime dtFrm = new DateTime();
            for (int j = 1; j < NoOfdays; j++)
            {
                if (j == 1)
                {
                    dtFrm = fromdate;
                }
                else
                {
                    dtFrm = dtFrm.AddDays(1);
                }
                DayOfWeek dow = dtFrm.DayOfWeek; //enum
                string str = dow.ToString();
                string strdate = dtFrm.ToString("dd/MMM");
                string columndate = strdate + "(" + str + ")";
                Report.Columns.Add(columndate);
                Allbiomertcdates obj1 = new Allbiomertcdates();
                obj1.Betweendates = columndate;
                Alldateslists.Add(obj1);
                count++;
            }

            if (dtbranchinfo.Rows.Count > 0)
            {
                int i = 1;
                foreach (DataRow dr in dtbranchinfo.Rows)
                {
                    DataRow newrow = Report.NewRow();
                    newrow["Sno"] = i++.ToString();
                    newrow["Parlor Name"] = dr["branchname"].ToString();
                    string parlorname = dr["branchname"].ToString();
                    string cmpid = dr["cmpid"].ToString();
                    branchid = dr["branchid"].ToString();
                    double branchwisetotvalue = 0;
                    foreach (DataRow drDriver in dtsalevalue.Rows)
                    {
                        datewisesalevaluedashboard getattendance = new datewisesalevaluedashboard();
                        if (branchid == drDriver["branchid"].ToString())
                        {
                            string logdate = "";
                            string totsalevalue = "";
                            string attendance_date = drDriver["doe"].ToString();
                            if (attendance_date != "")
                            {
                                DateTime dtDoe = Convert.ToDateTime(attendance_date);
                                string strdate = dtDoe.ToString("dd/MMM");

                                DayOfWeek dow = dtDoe.DayOfWeek; //enum
                                string str = dow.ToString();
                                string columndate = strdate + "(" + str + ")";
                                logdate = columndate;
                                string salevalue = drDriver["totvalue"].ToString();
                                if (salevalue != "")
                                {
                                    double tsval = Convert.ToDouble(salevalue);
                                    tsval = Math.Round(tsval, 0);
                                    newrow[columndate] = tsval;
                                    branchwisetotvalue += tsval;
                                    totsalevalue = tsval.ToString();
                                }
                                else
                                {
                                    newrow[columndate] = "0";
                                }
                            }
                            else
                            {
                            }
                            string bid = drDriver["branchid"].ToString();
                            newrow["Parlorid"] = drDriver["branchid"].ToString();
                            getattendance.cmpid = cmpid;
                            getattendance.parlorname = parlorname;
                            getattendance.LogDate = logdate;
                            getattendance.salevalue = totsalevalue;
                            getattendance.parlorid = bid;
                            salevaluelist.Add(getattendance);
                        }
                        else
                        {
                            getattendance.cmpid = cmpid;
                            getattendance.parlorname = parlorname;

                            getattendance.salevalue = "0";
                            getattendance.parlorid = branchid;
                            salevaluelist.Add(getattendance);
                        }
                    }
                    newrow["Total"] = branchwisetotvalue;
                    Report.Rows.Add(newrow);
                }
                if (Report.Rows.Count > 0)
                {

                }
                Employeebiomtericattendencedates obj2 = new Employeebiomtericattendencedates();
                obj2.Allbiomertcdates = Alldateslists;
                obj2.salevalue = salevaluelist;
                Employeebiomtericattendencedateslists.Add(obj2);
                string response = GetJson(Employeebiomtericattendencedateslists);
                context.Response.Write(response);
            }
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    private void get_weekpossalevalue_details(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);

            string eid = context.Request["parlorid"].ToString();
            string[] bs = eid.Split('_');
            string frmlogdate = bs[1];
            string tologdate = bs[2];
            string branchid = bs[3];

            DateTime dtfromdate = ServerDateCurrentdate;
            DateTime dttodate = ServerDateCurrentdate;
            string amonth = "";
            string ayear = "";
            int totalcount = 0;
            double basictotal = 0;
            DateTime fromdate = ServerDateCurrentdate;
            string frmdate = fromdate.ToString("MM/dd/yyyy");
            string[] str = frmdate.Split('/');
            string years = str[2];
            string[] frmlogstr = frmlogdate.Split('/');
            string date = frmlogstr[0];
            string month = frmlogstr[1];

            string[] mth = month.Split('(');
            string cmnth = mth[0];

            string biologdate = cmnth + "/" + date + "/" + years;

            if (month == "Dec")
            {
                int my = (Convert.ToInt32(years) - 1);
                string myye = my.ToString();
                biologdate = cmnth + "/" + date + "/" + myye;
            }

            DateTime dtfrom = Convert.ToDateTime(biologdate);

            string[] tologstr = tologdate.Split('/');
            string todate = tologstr[0];
            string tomonth = tologstr[1];

            string[] tomth = tomonth.Split('(');
            string tocmnth = tomth[0];
            string tobiologdate = tocmnth + "/" + todate + "/" + years;
            if (tocmnth == "Dec")
            {
                int myy = (Convert.ToInt32(years) - 1);
                string myyee = myy.ToString();
                tobiologdate = tocmnth + "/" + todate + "/" + myyee;
            }

            DateTime dtto = Convert.ToDateTime(tobiologdate);




            DateTime dfromdate = GetLowDate(dtfrom);
            DateTime dtodate = GetLowDate(dtto);
            TimeSpan dateSpan = dtodate.Subtract(dfromdate);
            int NoOfdays = dateSpan.Days;
            NoOfdays = NoOfdays + 2;

            cmd = new SqlCommand("SELECT branchid,branchname FROM branchmaster WHERE branchid=@BBID");
            cmd.Parameters.Add("@BBID", branchid);
            DataTable dtbranchinfo = vdm.SelectQuery(cmd).Tables[0];
            cmd = new SqlCommand("SELECT  SUM(possale_subdetails.totvalue + possale_subdetails.ordertax) AS totvalue, CONVERT(VARCHAR(10), possale_maindetails.doe, 101) AS doe, possale_maindetails.branchid FROM  productmaster INNER JOIN  possale_subdetails ON productmaster.productid = possale_subdetails.productid INNER JOIN subcategorymaster ON productmaster.subcategoryid = subcategorymaster.subcategoryid INNER JOIN  possale_maindetails ON possale_subdetails.refno = possale_maindetails.sno  WHERE        (possale_maindetails.doe BETWEEN @D1 AND @D2)  AND (possale_maindetails.status = 'C') GROUP BY CONVERT(VARCHAR(10), possale_maindetails.doe, 101), possale_maindetails.branchid");
            cmd.Parameters.Add("@D1", GetLowDate(dtfrom));
            cmd.Parameters.Add("@D2", GetHighDate(dtto));
            DataTable dtsalevalue = vdm.SelectQuery(cmd).Tables[0];
            List<datewisesalevaluedashboard> salevaluelist = new List<datewisesalevaluedashboard>();
            List<Allbiomertcdates> Alldateslists = new List<Allbiomertcdates>();
            List<Employeebiomtericattendencedates> Employeebiomtericattendencedateslists = new List<Employeebiomtericattendencedates>();

            DataTable Report = new DataTable();
            Report.Columns.Add("Sno");
            Report.Columns.Add("Parlorid");
            Report.Columns.Add("Parlor Name");
            int count = 0;
            DateTime dtFrm = new DateTime();
            for (int j = 1; j < NoOfdays; j++)
            {
                if (j == 1)
                {
                    dtFrm = dfromdate;
                }
                else
                {
                    dtFrm = dtFrm.AddDays(1);
                }
                DayOfWeek dow = dtFrm.DayOfWeek; //enum
                string strr = dow.ToString();
                string strdate = dtFrm.ToString("dd/MMM");
                string columndate = strdate + "(" + strr + ")";
                Report.Columns.Add(columndate);
                Allbiomertcdates obj1 = new Allbiomertcdates();
                obj1.Betweendates = columndate;
                Alldateslists.Add(obj1);
                count++;
            }

            if (dtbranchinfo.Rows.Count > 0)
            {
                int i = 1;
                foreach (DataRow dr in dtbranchinfo.Rows)
                {
                    DataRow newrow = Report.NewRow();
                    newrow["Sno"] = i++.ToString();
                    newrow["Parlor Name"] = dr["branchname"].ToString();
                    string parlorname = dr["branchname"].ToString();
                    branchid = dr["branchid"].ToString();
                    foreach (DataRow drDriver in dtsalevalue.Rows)
                    {
                        datewisesalevaluedashboard getattendance = new datewisesalevaluedashboard();
                        if (branchid == drDriver["branchid"].ToString())
                        {
                            string logdate = "";
                            string totsalevalue = "";
                            string attendance_date = drDriver["doe"].ToString();
                            if (attendance_date != "")
                            {
                                DateTime dtDoe = Convert.ToDateTime(attendance_date);
                                string strdate = dtDoe.ToString("dd/MMM");

                                DayOfWeek dow = dtDoe.DayOfWeek; //enum
                                string strf = dow.ToString();
                                string columndate = strdate + "(" + strf + ")";
                                logdate = columndate;
                                string salevalue = drDriver["totvalue"].ToString();
                                if (salevalue != "")
                                {
                                    double tsval = Convert.ToDouble(salevalue);
                                    tsval = Math.Round(tsval, 0);
                                    newrow[columndate] = tsval;
                                    totsalevalue = tsval.ToString();
                                }
                                else
                                {
                                    newrow[columndate] = "0";
                                }
                            }
                            else
                            {
                            }
                            string bid = drDriver["branchid"].ToString();
                            newrow["Parlorid"] = drDriver["branchid"].ToString();
                            getattendance.parlorname = parlorname;
                            getattendance.LogDate = logdate;
                            getattendance.salevalue = totsalevalue;
                            getattendance.parlorid = bid;
                            salevaluelist.Add(getattendance);
                        }
                    }
                    Report.Rows.Add(newrow);
                }
                if (Report.Rows.Count > 0)
                {

                }
                Employeebiomtericattendencedates obj2 = new Employeebiomtericattendencedates();
                obj2.Allbiomertcdates = Alldateslists;
                obj2.salevalue = salevaluelist;
                Employeebiomtericattendencedateslists.Add(obj2);
                string response = GetJson(Employeebiomtericattendencedateslists);
                context.Response.Write(response);
            }
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }
    private void get_weekwisepossale_details(HttpContext context)
    {
        vdm = new SalesDBManager();
        DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
        DateTime Enddate = new DateTime(ServerDateCurrentdate.Year, ServerDateCurrentdate.Month + 1, 1).AddDays(-1);
        string mymonth = context.Request["month"].ToString();
        string myyear = context.Request["year"].ToString();
        if (mymonth == "")
        {
        }
        else
        {
            if (mymonth == "12")
            {
                string dta = mymonth + "/" + "01" + "/" + myyear;
                ServerDateCurrentdate = Convert.ToDateTime(dta);
                Enddate = new DateTime(ServerDateCurrentdate.Year, ServerDateCurrentdate.Month, 1).AddDays(30);
            }
            else
            {
                string dta = mymonth + "/" + "01" + "/" + myyear;
                ServerDateCurrentdate = Convert.ToDateTime(dta);
                Enddate = new DateTime(ServerDateCurrentdate.Year, ServerDateCurrentdate.Month, 1).AddDays(30);
            }
        }



        DateTime firstMonthDay = new DateTime(ServerDateCurrentdate.Year, ServerDateCurrentdate.Month, 1);
        DateTime firstMonthMonday = firstMonthDay.AddDays((DayOfWeek.Monday + 7 - firstMonthDay.DayOfWeek) % 7);
        if (firstMonthMonday > ServerDateCurrentdate)
        {
            firstMonthDay = firstMonthDay.AddMonths(-1);
            firstMonthMonday = firstMonthDay.AddDays((DayOfWeek.Monday + 7 - firstMonthDay.DayOfWeek) % 7);
        }
        int count = (ServerDateCurrentdate - firstMonthMonday).Days / 7 + 1;

        DateTime From_Date = new DateTime(ServerDateCurrentdate.Year, ServerDateCurrentdate.Month, 1);

        List<datewisesalevaluedashboard> salevaluelist = new List<datewisesalevaluedashboard>();
        List<Allbiomertcdates> Alldateslists = new List<Allbiomertcdates>();
        List<Employeebiomtericattendencedates> Employeebiomtericattendencedateslists = new List<Employeebiomtericattendencedates>();

        //weeks
        string strfromdate = From_Date.ToString();
        DateTime fromDate = DateTime.Parse(strfromdate.Trim());
        var d_fromdate = fromDate;
        CultureInfo cul_from = CultureInfo.CurrentCulture;
        int from_weekNum = cul_from.Calendar.GetWeekOfYear(
            d_fromdate,
            CalendarWeekRule.FirstDay,
            DayOfWeek.Monday);

        string strtodate = Enddate.ToString();
        DateTime toDate = DateTime.Parse(strtodate.Trim());
        var d_toDate = toDate;
        CultureInfo cul_to = CultureInfo.CurrentCulture;
        int to_weekNum = cul_to.Calendar.GetWeekOfYear(
            d_toDate,
            CalendarWeekRule.FirstDay,
            DayOfWeek.Monday);
        int diffweeks = to_weekNum - from_weekNum;
        DateTime firstmonth = new DateTime();
        DateTime lastmonth = new DateTime();
        Enddate = Enddate.AddMonths(1);
        TimeSpan dateSpan = Enddate.Subtract(From_Date);
        int years = (dateSpan.Days / 365);
        int months = ((dateSpan.Days % 365) / 31) + (years * 12);
        int N = 0;
        int i = 1;
        if (months != 0)
        {
            ArrayList al = new ArrayList();
            DataTable Report = new DataTable();
            DataTable Sorttable = new DataTable();
            Report.Columns.Add("Sno");
            Report.Columns.Add("Parlorid");
            Report.Columns.Add("Parlor Name");

            Sorttable.Columns.Add("Sno");
            Sorttable.Columns.Add("Parlorid");
            Sorttable.Columns.Add("Parlor Name");
            int newweek = from_weekNum;
            for (int j = 0; j < diffweeks; j++)
            {
                firstmonth = GetLowDate(From_Date);
                lastmonth = GetHighDate(firstmonth.AddDays(7));
                DateTime dtF = firstmonth.AddDays(-1);
                TimeSpan dateSpan2 = lastmonth.Subtract(dtF);
                int NoOfdays = dateSpan2.Days;
                string ChangedTime1 = firstmonth.ToString("dd/MMM");
                string ChangedTime2 = lastmonth.ToString("dd/MMM");
                string week = "W" + newweek + "_" + ChangedTime1 + "_" + ChangedTime2 + "";
                al.Add(week);
                Report.Columns.Add(week);
                Sorttable.Columns.Add(week);
                Allbiomertcdates obj1 = new Allbiomertcdates();
                obj1.Betweendates = week;
                Alldateslists.Add(obj1);
                newweek = newweek + 1;
                From_Date = From_Date.AddDays(7);
            }
            cmd = new SqlCommand("SELECT branchid,branchname FROM branchmaster");
            DataTable dtbranchinfo = vdm.SelectQuery(cmd).Tables[0];
            for (int m = 0; m < al.Count; m++)
            {
                string weekvalue = al[m].ToString();
                DateTime fromdate = ServerDateCurrentdate;
                string frmdate = fromdate.ToString("MM/dd/yyyy");
                string[] str = frmdate.Split('/');
                string year = str[2];
                string[] logstr = weekvalue.Split('_');
                string date = logstr[0];
                string month = logstr[1];
                string cmnth = logstr[2];
                string fdate = month + "/" + year;
                string todate = cmnth + "/" + year;
                DateTime dtfrom = Convert.ToDateTime(fdate);
                DateTime dtto = Convert.ToDateTime(todate);
                string branchid = "";

                cmd = new SqlCommand("SELECT  SUM(possale_subdetails.totvalue + possale_subdetails.ordertax) AS totvalue,  possale_maindetails.branchid FROM  productmaster INNER JOIN  possale_subdetails ON productmaster.productid = possale_subdetails.productid INNER JOIN subcategorymaster ON productmaster.subcategoryid = subcategorymaster.subcategoryid INNER JOIN  possale_maindetails ON possale_subdetails.refno = possale_maindetails.sno  WHERE        (possale_maindetails.doe BETWEEN @D1 AND @D2)  AND (possale_maindetails.status = 'C') GROUP BY  possale_maindetails.branchid");
                cmd.Parameters.Add("@D1", GetLowDate(dtfrom));
                cmd.Parameters.Add("@D2", GetHighDate(dtto));
                DataTable dtsalevalue = vdm.SelectQuery(cmd).Tables[0];
                if (dtbranchinfo.Rows.Count > 0)
                {
                    int k = 1;
                    foreach (DataRow dr in dtbranchinfo.Rows)
                    {
                        DataRow newrow = Report.NewRow();
                        newrow["Sno"] = k++.ToString();
                        newrow["Parlor Name"] = dr["branchname"].ToString();
                        string parlorname = dr["branchname"].ToString();
                        branchid = dr["branchid"].ToString();
                        foreach (DataRow drDriver in dtsalevalue.Rows)
                        {

                            if (branchid == drDriver["branchid"].ToString())
                            {
                                string logdate = "";
                                string totsalevalue = "";
                                string salevalue = drDriver["totvalue"].ToString();
                                if (salevalue != "")
                                {
                                    double tsval = Convert.ToDouble(salevalue);
                                    tsval = Math.Round(tsval, 0);
                                    newrow[weekvalue] = tsval;
                                    totsalevalue = tsval.ToString();
                                }
                                else
                                {
                                    newrow[weekvalue] = "0";
                                }
                                string bid = drDriver["branchid"].ToString();
                                newrow["Parlorid"] = drDriver["branchid"].ToString();
                                Report.Rows.Add(newrow);
                            }

                        }

                    }
                }
                newweek = newweek + 1;
                From_Date = From_Date.AddDays(7);
            }
            string week1 = "";
            string week2 = "";
            string week3 = "";
            string week4 = "";
            string week5 = "";
            if (Report.Rows.Count > 0)
            {

                int a = 1;
                foreach (DataRow drb in dtbranchinfo.Rows)
                {
                    string branchid = drb["branchid"].ToString();
                    DataRow newrow = Sorttable.NewRow();

                    string parlorname = drb["branchname"].ToString();
                    string columnname3 = "";
                    string columnname4 = "";
                    string columnname5 = "";
                    string columnname6 = "";
                    string columnname7 = "";
                    string columnname8 = "";
                    string columnname9 = "";
                    string columnname10 = "";
                    int columncount = Report.Columns.Count;
                    if (columncount > 7)
                    {
                        columnname4 = Report.Columns[3].ToString();
                        columnname5 = Report.Columns[4].ToString();
                        columnname6 = Report.Columns[5].ToString();
                        columnname7 = Report.Columns[6].ToString();
                        columnname8 = Report.Columns[7].ToString();
                        week1 = columnname4;
                        week2 = columnname5;
                        week3 = columnname6;
                        week4 = columnname7;
                        week5 = columnname8;
                    }
                    else
                    {
                        columnname4 = Report.Columns[3].ToString();
                        columnname5 = Report.Columns[4].ToString();
                        columnname6 = Report.Columns[5].ToString();
                        columnname7 = Report.Columns[6].ToString();
                        week1 = columnname4;
                        week2 = columnname5;
                        week3 = columnname6;
                        week4 = columnname7;

                    }
                    newrow["Sno"] = a++.ToString();
                    newrow["Parlor Name"] = drb["branchname"].ToString();
                    string prname = drb["branchname"].ToString();
                    string colum4value = "";
                    string colum5value = "";
                    string colum6value = "";
                    string colum7value = "";
                    string colum8value = "";


                    foreach (DataRow dra in Report.Select("Parlorid='" + branchid + "'"))
                    {

                        string parlorid = dra["Parlorid"].ToString();
                        string wee = dra["Parlorid"].ToString();
                        if (branchid == parlorid)
                        {
                            newrow["Parlorid"] = parlorid;

                            if (columncount > 7)
                            {
                                if (colum4value != "")
                                {
                                    newrow[columnname4] = colum4value;
                                }
                                else
                                {
                                    colum4value = dra[columnname4].ToString();
                                    if (colum4value != "")
                                    {
                                        newrow[columnname4] = colum4value;
                                    }
                                }

                                if (colum5value != "")
                                {
                                    newrow[columnname5] = colum5value;
                                }
                                else
                                {
                                    colum5value = dra[columnname5].ToString();
                                    if (colum5value != "")
                                    {
                                        newrow[columnname5] = dra[columnname5].ToString();
                                    }
                                }

                                if (colum6value != "")
                                {
                                    newrow[columnname6] = colum6value;

                                }
                                else
                                {
                                    colum6value = dra[columnname6].ToString();
                                    if (colum6value != "")
                                    {
                                        newrow[columnname6] = dra[columnname6].ToString();

                                    }
                                }

                                if (colum7value != "")
                                {
                                    newrow[columnname7] = colum7value;

                                }
                                else
                                {
                                    colum7value = dra[columnname7].ToString();
                                    if (colum7value != "")
                                    {
                                        newrow[columnname7] = dra[columnname7].ToString();

                                    }
                                }

                                if (colum8value != "")
                                {
                                    newrow[columnname8] = colum8value;

                                }
                                else
                                {
                                    colum8value = dra[columnname8].ToString();
                                    if (colum8value != "")
                                    {
                                        newrow[columnname8] = dra[columnname8].ToString();

                                    }
                                }
                            }
                            else
                            {
                                if (colum4value != "")
                                {
                                    newrow[columnname4] = colum4value;
                                }
                                else
                                {
                                    colum4value = dra[columnname4].ToString();
                                    if (colum4value != "")
                                    {
                                        newrow[columnname4] = colum4value;
                                    }
                                }

                                if (colum5value != "")
                                {
                                    newrow[columnname5] = colum5value;
                                }
                                else
                                {
                                    colum5value = dra[columnname5].ToString();
                                    if (colum5value != "")
                                    {
                                        newrow[columnname5] = dra[columnname5].ToString();
                                    }
                                }

                                if (colum6value != "")
                                {
                                    newrow[columnname6] = colum6value;

                                }
                                else
                                {
                                    colum6value = dra[columnname6].ToString();
                                    if (colum6value != "")
                                    {
                                        newrow[columnname6] = dra[columnname6].ToString();

                                    }
                                }

                                if (colum7value != "")
                                {
                                    newrow[columnname7] = colum7value;

                                }
                                else
                                {
                                    colum7value = dra[columnname7].ToString();
                                    if (colum7value != "")
                                    {
                                        newrow[columnname7] = dra[columnname7].ToString();

                                    }
                                }
                            }
                        }
                    }

                    Sorttable.Rows.Add(newrow);

                }
            }
            if (Sorttable.Rows.Count > 0)
            {
                foreach (DataRow drs in Sorttable.Rows)
                {
                    datewisesalevaluedashboard getattendance = new datewisesalevaluedashboard();
                    string parlorid = drs["Parlorid"].ToString();

                    getattendance.parlorid = drs["Parlorid"].ToString();
                    getattendance.parlorname = drs["Parlor Name"].ToString();
                    string week1tval = week1;
                    string week1value = drs["Parlorid"].ToString();
                    string linkval1 = week1tval + "_" + week1value;

                    string week2tval = week2;
                    string week2value = drs["Parlorid"].ToString();
                    string linkval2 = week2tval + "_" + week2value;

                    string week3tval = week3;
                    string week3value = drs["Parlorid"].ToString();
                    string linkval3 = week3tval + "_" + week3value;

                    string week4tval = week4;
                    string week4value = drs["Parlorid"].ToString();
                    string linkval4 = week4tval + "_" + week4value;

                    string week5tval = week5;
                    string week5value = drs["Parlorid"].ToString();
                    string linkval5 = week5tval + "_" + week5value;

                    getattendance.week1 = drs[week1].ToString();
                    getattendance.week2 = drs[week2].ToString();
                    getattendance.week3 = drs[week3].ToString();
                    getattendance.week4 = drs[week4].ToString();
                    if (week5 != "")
                    {
                        getattendance.week5 = drs[week5].ToString();
                    }

                    getattendance.linkval1 = linkval1;
                    getattendance.linkval2 = linkval2;
                    getattendance.linkval3 = linkval3;
                    getattendance.linkval4 = linkval4;
                    getattendance.linkval5 = linkval5;
                    salevaluelist.Add(getattendance);
                }
            }
            Employeebiomtericattendencedates obj2 = new Employeebiomtericattendencedates();
            obj2.Allbiomertcdates = Alldateslists;
            obj2.salevalue = salevaluelist;
            Employeebiomtericattendencedateslists.Add(obj2);
            string response = GetJson(Employeebiomtericattendencedateslists);
            context.Response.Write(response);

        }
    }

    private void get_mnthweekwisepossale_details(HttpContext context)
    {
        vdm = new SalesDBManager();
        string dat = context.Request["parlorid"].ToString();
        string[] dtstr = dat.Split('_');
        string mnth = dtstr[0];
        string mparlorid = dtstr[1];
        string da = "01";

        string[] dtmy = mnth.Split('/');
        string mynth = dtmy[0];
        string myyr = dtmy[1];

        string mtobiologdate = mynth + "/" + da + "/" + myyr;
        DateTime dtmto = Convert.ToDateTime(mtobiologdate);
        DateTime Enddate = DateTime.Now;
        DateTime ServerDateCurrentdate = dtmto;
        if (ServerDateCurrentdate.Month > 11)
        {
            Enddate = new DateTime(ServerDateCurrentdate.Year, ServerDateCurrentdate.Month, 1).AddDays(30);
        }
        else
        {
            Enddate = new DateTime(ServerDateCurrentdate.Year, ServerDateCurrentdate.Month + 1, 1).AddDays(-1);
        }
        DateTime firstMonthDay = new DateTime(ServerDateCurrentdate.Year, ServerDateCurrentdate.Month, 1);
        DateTime firstMonthMonday = firstMonthDay.AddDays((DayOfWeek.Monday + 7 - firstMonthDay.DayOfWeek) % 7);
        if (firstMonthMonday > ServerDateCurrentdate)
        {
            firstMonthDay = firstMonthDay.AddMonths(-1);
            firstMonthMonday = firstMonthDay.AddDays((DayOfWeek.Monday + 7 - firstMonthDay.DayOfWeek) % 7);
        }
        int count = (ServerDateCurrentdate - firstMonthMonday).Days / 7 + 1;
        DateTime From_Date = new DateTime(ServerDateCurrentdate.Year, ServerDateCurrentdate.Month, 1);

        List<datewisesalevaluedashboard> salevaluelist = new List<datewisesalevaluedashboard>();
        List<Allbiomertcdates> Alldateslists = new List<Allbiomertcdates>();
        List<Employeebiomtericattendencedates> Employeebiomtericattendencedateslists = new List<Employeebiomtericattendencedates>();

        //weeks
        string strfromdate = From_Date.ToString();
        DateTime fromDate = DateTime.Parse(strfromdate.Trim());
        var d_fromdate = fromDate;
        CultureInfo cul_from = CultureInfo.CurrentCulture;
        int from_weekNum = cul_from.Calendar.GetWeekOfYear(
            d_fromdate,
            CalendarWeekRule.FirstDay,
            DayOfWeek.Monday);

        string strtodate = Enddate.ToString();
        DateTime toDate = DateTime.Parse(strtodate.Trim());
        var d_toDate = toDate;
        CultureInfo cul_to = CultureInfo.CurrentCulture;
        int to_weekNum = cul_to.Calendar.GetWeekOfYear(
            d_toDate,
            CalendarWeekRule.FirstDay,
            DayOfWeek.Monday);
        int diffweeks = to_weekNum - from_weekNum;
        DateTime firstmonth = new DateTime();
        DateTime lastmonth = new DateTime();
        Enddate = Enddate.AddMonths(1);
        TimeSpan dateSpan = Enddate.Subtract(From_Date);
        int years = (dateSpan.Days / 365);
        int months = ((dateSpan.Days % 365) / 31) + (years * 12);
        int N = 0;
        int i = 1;
        if (months != 0)
        {
            ArrayList al = new ArrayList();
            DataTable Report = new DataTable();
            DataTable Sorttable = new DataTable();
            Report.Columns.Add("Sno");
            Report.Columns.Add("Parlorid");
            Report.Columns.Add("Parlor Name");

            Sorttable.Columns.Add("Sno");
            Sorttable.Columns.Add("Parlorid");
            Sorttable.Columns.Add("Parlor Name");
            int newweek = from_weekNum;
            for (int j = 0; j < diffweeks; j++)
            {
                firstmonth = GetLowDate(From_Date);
                lastmonth = GetHighDate(firstmonth.AddDays(7));
                DateTime dtF = firstmonth.AddDays(-1);
                TimeSpan dateSpan2 = lastmonth.Subtract(dtF);
                int NoOfdays = dateSpan2.Days;
                string ChangedTime1 = firstmonth.ToString("dd/MMM");
                string ChangedTime2 = lastmonth.ToString("dd/MMM");
                string week = "W" + newweek + "_" + ChangedTime1 + "_" + ChangedTime2 + "";
                al.Add(week);
                Report.Columns.Add(week);
                Sorttable.Columns.Add(week);
                Allbiomertcdates obj1 = new Allbiomertcdates();
                obj1.Betweendates = week;
                Alldateslists.Add(obj1);
                newweek = newweek + 1;
                From_Date = From_Date.AddDays(7);
            }
            cmd = new SqlCommand("SELECT branchid,branchname FROM branchmaster where branchid=@bid");
            cmd.Parameters.Add("@bid", mparlorid);
            DataTable dtbranchinfo = vdm.SelectQuery(cmd).Tables[0];
            for (int m = 0; m < al.Count; m++)
            {
                string weekvalue = al[m].ToString();
                DateTime fromdate = ServerDateCurrentdate;
                string frmdate = fromdate.ToString("MM/dd/yyyy");
                string[] str = frmdate.Split('/');
                string year = str[2];
                string[] logstr = weekvalue.Split('_');
                string date = logstr[0];
                string month = logstr[1];
                string cmnth = logstr[2];



                string fdate = month + "/" + year;
                if (month == "29/Dec")
                {
                    int myye = Convert.ToInt32(year) + 1;
                    year = myye.ToString();
                }
                else
                {

                }
                string todate = cmnth + "/" + year;

                DateTime dtfrom = Convert.ToDateTime(fdate);
                DateTime dtto = Convert.ToDateTime(todate);



                string branchid = "";
                cmd = new SqlCommand("SELECT  SUM(possale_subdetails.totvalue + possale_subdetails.ordertax) AS totvalue,  possale_maindetails.branchid FROM  productmaster INNER JOIN  possale_subdetails ON productmaster.productid = possale_subdetails.productid INNER JOIN subcategorymaster ON productmaster.subcategoryid = subcategorymaster.subcategoryid INNER JOIN  possale_maindetails ON possale_subdetails.refno = possale_maindetails.sno  WHERE        (possale_maindetails.doe BETWEEN @D1 AND @D2)  AND (possale_maindetails.status = 'C') GROUP BY  possale_maindetails.branchid");
                cmd.Parameters.Add("@D1", GetLowDate(dtfrom));
                cmd.Parameters.Add("@D2", GetHighDate(dtto));
                DataTable dtsalevalue = vdm.SelectQuery(cmd).Tables[0];
                if (dtbranchinfo.Rows.Count > 0)
                {
                    int k = 1;
                    foreach (DataRow dr in dtbranchinfo.Rows)
                    {
                        DataRow newrow = Report.NewRow();
                        newrow["Sno"] = k++.ToString();
                        newrow["Parlor Name"] = dr["branchname"].ToString();
                        string parlorname = dr["branchname"].ToString();
                        branchid = dr["branchid"].ToString();
                        foreach (DataRow drDriver in dtsalevalue.Rows)
                        {

                            if (branchid == drDriver["branchid"].ToString())
                            {
                                string logdate = "";
                                string totsalevalue = "";
                                string salevalue = drDriver["totvalue"].ToString();
                                if (salevalue != "")
                                {
                                    double tsval = Convert.ToDouble(salevalue);
                                    tsval = Math.Round(tsval, 0);
                                    newrow[weekvalue] = tsval;
                                    totsalevalue = tsval.ToString();
                                }
                                else
                                {
                                    newrow[weekvalue] = "0";
                                }
                                string bid = drDriver["branchid"].ToString();
                                newrow["Parlorid"] = drDriver["branchid"].ToString();
                                Report.Rows.Add(newrow);
                            }

                        }

                    }

                }


                newweek = newweek + 1;
                From_Date = From_Date.AddDays(7);
            }
            string week1 = "";
            string week2 = "";
            string week3 = "";
            string week4 = "";
            string week5 = "";
            if (Report.Rows.Count > 0)
            {

                int a = 1;
                foreach (DataRow drb in dtbranchinfo.Rows)
                {
                    string branchid = drb["branchid"].ToString();
                    DataRow newrow = Sorttable.NewRow();

                    string parlorname = drb["branchname"].ToString();
                    string columnname3 = "";
                    string columnname4 = "";
                    string columnname5 = "";
                    string columnname6 = "";
                    string columnname7 = "";
                    string columnname8 = "";
                    string columnname9 = "";
                    string columnname10 = "";
                    int columncount = Report.Columns.Count;
                    if (columncount > 7)
                    {
                        columnname4 = Report.Columns[3].ToString();
                        columnname5 = Report.Columns[4].ToString();
                        columnname6 = Report.Columns[5].ToString();
                        columnname7 = Report.Columns[6].ToString();
                        columnname8 = Report.Columns[7].ToString();
                        week1 = columnname4;
                        week2 = columnname5;
                        week3 = columnname6;
                        week4 = columnname7;
                        week5 = columnname8;
                    }
                    else
                    {
                        columnname4 = Report.Columns[3].ToString();
                        columnname5 = Report.Columns[4].ToString();
                        columnname6 = Report.Columns[5].ToString();
                        columnname7 = Report.Columns[6].ToString();
                        week1 = columnname4;
                        week2 = columnname5;
                        week3 = columnname6;
                        week4 = columnname7;

                    }
                    newrow["Sno"] = a++.ToString();
                    newrow["Parlor Name"] = drb["branchname"].ToString();
                    string prname = drb["branchname"].ToString();
                    string colum4value = "";
                    string colum5value = "";
                    string colum6value = "";
                    string colum7value = "";
                    string colum8value = "";


                    foreach (DataRow dra in Report.Select("Parlorid='" + branchid + "'"))
                    {

                        string parlorid = dra["Parlorid"].ToString();
                        string wee = dra["Parlorid"].ToString();
                        if (branchid == parlorid)
                        {
                            newrow["Parlorid"] = parlorid;

                            if (columncount > 7)
                            {
                                if (colum4value != "")
                                {
                                    newrow[columnname4] = colum4value;
                                }
                                else
                                {
                                    colum4value = dra[columnname4].ToString();
                                    if (colum4value != "")
                                    {
                                        newrow[columnname4] = colum4value;
                                    }
                                }

                                if (colum5value != "")
                                {
                                    newrow[columnname5] = colum5value;
                                }
                                else
                                {
                                    colum5value = dra[columnname5].ToString();
                                    if (colum5value != "")
                                    {
                                        newrow[columnname5] = dra[columnname5].ToString();
                                    }
                                }

                                if (colum6value != "")
                                {
                                    newrow[columnname6] = colum6value;

                                }
                                else
                                {
                                    colum6value = dra[columnname6].ToString();
                                    if (colum6value != "")
                                    {
                                        newrow[columnname6] = dra[columnname6].ToString();

                                    }
                                }

                                if (colum7value != "")
                                {
                                    newrow[columnname7] = colum7value;

                                }
                                else
                                {
                                    colum7value = dra[columnname7].ToString();
                                    if (colum7value != "")
                                    {
                                        newrow[columnname7] = dra[columnname7].ToString();

                                    }
                                }

                                if (colum8value != "")
                                {
                                    newrow[columnname8] = colum8value;

                                }
                                else
                                {
                                    colum8value = dra[columnname8].ToString();
                                    if (colum8value != "")
                                    {
                                        newrow[columnname8] = dra[columnname8].ToString();

                                    }
                                }
                            }
                            else
                            {
                                if (colum4value != "")
                                {
                                    newrow[columnname4] = colum4value;
                                }
                                else
                                {
                                    colum4value = dra[columnname4].ToString();
                                    if (colum4value != "")
                                    {
                                        newrow[columnname4] = colum4value;
                                    }
                                }

                                if (colum5value != "")
                                {
                                    newrow[columnname5] = colum5value;
                                }
                                else
                                {
                                    colum5value = dra[columnname5].ToString();
                                    if (colum5value != "")
                                    {
                                        newrow[columnname5] = dra[columnname5].ToString();
                                    }
                                }

                                if (colum6value != "")
                                {
                                    newrow[columnname6] = colum6value;

                                }
                                else
                                {
                                    colum6value = dra[columnname6].ToString();
                                    if (colum6value != "")
                                    {
                                        newrow[columnname6] = dra[columnname6].ToString();

                                    }
                                }

                                if (colum7value != "")
                                {
                                    newrow[columnname7] = colum7value;

                                }
                                else
                                {
                                    colum7value = dra[columnname7].ToString();
                                    if (colum7value != "")
                                    {
                                        newrow[columnname7] = dra[columnname7].ToString();

                                    }
                                }
                            }
                        }
                    }

                    Sorttable.Rows.Add(newrow);

                }
            }
            if (Sorttable.Rows.Count > 0)
            {
                foreach (DataRow drs in Sorttable.Rows)
                {
                    datewisesalevaluedashboard getattendance = new datewisesalevaluedashboard();
                    getattendance.parlorid = drs["Parlorid"].ToString();
                    getattendance.parlorname = drs["Parlor Name"].ToString();
                    string week1tval = week1;
                    string week1value = drs["Parlorid"].ToString();
                    string linkval1 = week1tval + "_" + week1value;

                    string week2tval = week2;
                    string week2value = drs["Parlorid"].ToString();
                    string linkval2 = week2tval + "_" + week2value;

                    string week3tval = week3;
                    string week3value = drs["Parlorid"].ToString();
                    string linkval3 = week3tval + "_" + week3value;

                    string week4tval = week4;
                    string week4value = drs["Parlorid"].ToString();
                    string linkval4 = week4tval + "_" + week4value;

                    string week5tval = week5;
                    string week5value = drs["Parlorid"].ToString();
                    string linkval5 = week5tval + "_" + week5value;

                    getattendance.week1 = drs[week1].ToString();
                    getattendance.week2 = drs[week2].ToString();
                    getattendance.week3 = drs[week3].ToString();
                    getattendance.week4 = drs[week4].ToString();
                    if (week5 != "")
                    {
                        getattendance.week5 = drs[week5].ToString();
                    }

                    getattendance.linkval1 = linkval1;
                    getattendance.linkval2 = linkval2;
                    getattendance.linkval3 = linkval3;
                    getattendance.linkval4 = linkval4;
                    getattendance.linkval5 = linkval5;
                    salevaluelist.Add(getattendance);
                }
            }
            Employeebiomtericattendencedates obj2 = new Employeebiomtericattendencedates();
            obj2.Allbiomertcdates = Alldateslists;
            obj2.salevalue = salevaluelist;
            Employeebiomtericattendencedateslists.Add(obj2);
            string response = GetJson(Employeebiomtericattendencedateslists);
            context.Response.Write(response);
            //string response = GetJson(salevaluelist);
            //context.Response.Write(response);
        }
    }


    private DateTime GetLowMonthRetrive(DateTime dt)
    {
        double Day, Hour, Min, Sec;
        DateTime DT = dt;
        DT = dt;
        Day = -dt.Day + 1;
        Hour = -dt.Hour;
        Min = -dt.Minute;
        Sec = -dt.Second;
        DT = DT.AddDays(Day);
        DT = DT.AddHours(Hour);
        DT = DT.AddMinutes(Min);
        DT = DT.AddSeconds(Sec);
        return DT;

    }
    private DateTime GetHighMonth(DateTime dt)
    {
        double Day, Hour, Min, Sec;
        DateTime DT = DateTime.Now;
        Day = 31 - dt.Day;
        Hour = 23 - dt.Hour;
        Min = 59 - dt.Minute;
        Sec = 59 - dt.Second;
        DT = dt;
        DT = DT.AddDays(Day);
        DT = DT.AddHours(Hour);
        DT = DT.AddMinutes(Min);
        DT = DT.AddSeconds(Sec);
        if (DT.Day == 3)
        {
            DT = DT.AddDays(-3);
        }
        else if (DT.Day == 2)
        {
            DT = DT.AddDays(-2);
        }
        else if (DT.Day == 1)
        {
            DT = DT.AddDays(-1);
        }
        return DT;
    }

    private void get_monthwisepossale_details(HttpContext context)
    {
        vdm = new SalesDBManager();
        DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
        DateTime Enddate = new DateTime(ServerDateCurrentdate.Year, ServerDateCurrentdate.Month + 1, 1).AddDays(-1);

        DateTime From_Date = new DateTime(ServerDateCurrentdate.Year, ServerDateCurrentdate.Month, 1);

        List<datewisesalevaluedashboard> salevaluelist = new List<datewisesalevaluedashboard>();
        List<Allbiomertcdates> Alldateslists = new List<Allbiomertcdates>();
        List<Employeebiomtericattendencedates> Employeebiomtericattendencedateslists = new List<Employeebiomtericattendencedates>();

        //MONTH
        DateTime firstmonth = new DateTime();
        DateTime lastmonth = new DateTime();
        string fdt = context.Request["frmdate"].ToString();
        string tdt = context.Request["todate"].ToString();
        if (fdt != "")
        {
            From_Date = Convert.ToDateTime(fdt);
        }
        if (tdt != "")
        {
            Enddate = Convert.ToDateTime(tdt);
        }
        Enddate = Enddate.AddMonths(1);
        TimeSpan dateSpan = Enddate.Subtract(From_Date);
        int years = (dateSpan.Days / 365);
        int months = ((dateSpan.Days % 365) / 31) + (years * 12);
        int N = 0;
        int i = 1;
        if (months != 0)
        {
            DataTable Report = new DataTable();
            DataTable Sorttable = new DataTable();
            Report.Columns.Add("Sno");
            Report.Columns.Add("Parlorid");
            Report.Columns.Add("Parlor Name");

            Sorttable.Columns.Add("Sno");
            Sorttable.Columns.Add("Parlorid");
            Sorttable.Columns.Add("Parlor Name");
            cmd = new SqlCommand("SELECT branchid,branchname FROM branchmaster");
            DataTable dtbranchinfo = vdm.SelectQuery(cmd).Tables[0];
            for (int j = 0; j < months; j++)
            {
                double totalqty = 0; double totalsalevalue = 0;
                firstmonth = GetLowMonthRetrive(From_Date.AddMonths(j));
                lastmonth = GetHighMonth(firstmonth);
                string mnth = firstmonth.ToString("MM");
                int NoOfdays = 0;

                DateTime dtF = firstmonth.AddDays(-1);
                DataTable dtsale_value = vdm.SelectQuery(cmd).Tables[0];
                TimeSpan dateSpan2 = lastmonth.Subtract(dtF);
                NoOfdays = dateSpan2.Days;
                string ChangedTime1 = firstmonth.ToString("MMM/yyyy");
                string Changedt = firstmonth.ToString("MMM");
                Report.Columns.Add(ChangedTime1);
                Sorttable.Columns.Add(ChangedTime1);
                Allbiomertcdates obj1 = new Allbiomertcdates();
                obj1.Betweendates = ChangedTime1;
                Alldateslists.Add(obj1);




                // cmd = new SqlCommand("SELECT  SUM(possale_subdetails.totvalue + possale_subdetails.ordertax) AS totvalue, month(possale_maindetails.doe) AS Month, year(possale_maindetails.doe) as year, possale_maindetails.branchid FROM  productmaster INNER JOIN  possale_subdetails ON productmaster.productid = possale_subdetails.productid INNER JOIN subcategorymaster ON productmaster.subcategoryid = subcategorymaster.subcategoryid INNER JOIN  possale_maindetails ON possale_subdetails.refno = possale_maindetails.sno  WHERE        (possale_maindetails.doe BETWEEN @d1 AND @d2)  AND (possale_maindetails.status = 'C') GROUP BY month(possale_maindetails.doe), year(possale_maindetails.doe), possale_maindetails.branchid order by possale_maindetails.branchid");
                cmd = new SqlCommand("SELECT  SUM(possale_subdetails.totvalue + possale_subdetails.ordertax) AS totvalue,  possale_maindetails.branchid FROM  productmaster INNER JOIN  possale_subdetails ON productmaster.productid = possale_subdetails.productid INNER JOIN subcategorymaster ON productmaster.subcategoryid = subcategorymaster.subcategoryid INNER JOIN  possale_maindetails ON possale_subdetails.refno = possale_maindetails.sno  WHERE        (possale_maindetails.doe BETWEEN @D1 AND @D2)  AND (possale_maindetails.status = 'C') GROUP BY  possale_maindetails.branchid");
                cmd.Parameters.Add("@D1", GetLowDate(dtF));
                cmd.Parameters.Add("@D2", GetHighDate(lastmonth));
                DataTable dtsalevalue = vdm.SelectQuery(cmd).Tables[0];
                if (dtbranchinfo.Rows.Count > 0)
                {
                    foreach (DataRow dr in dtbranchinfo.Rows)
                    {
                        DataRow newrow = Report.NewRow();
                        string branchid = dr["branchid"].ToString();
                        string parlorname = dr["branchname"].ToString();
                        foreach (DataRow drr in dtsalevalue.Rows)
                        {
                            if (branchid == drr["branchid"].ToString())
                            {
                                string logdate = "";
                                string totsalevalue = "";
                                string salevalue = drr["totvalue"].ToString();
                                if (salevalue != "")
                                {
                                    double tsval = Convert.ToDouble(salevalue);
                                    tsval = Math.Round(tsval, 0);
                                    newrow[ChangedTime1] = tsval;
                                    totsalevalue = tsval.ToString();
                                }
                                else
                                {
                                    newrow[ChangedTime1] = "0";
                                }
                                string bid = drr["branchid"].ToString();
                                newrow["Parlorid"] = drr["branchid"].ToString();
                                newrow["Parlor Name"] = parlorname;
                                Report.Rows.Add(newrow);
                                string mntval = ChangedTime1 + "_" + bid;

                            }
                        }
                    }
                }
            }

            string mnth1 = "";
            string mnth2 = "";
            string mnth3 = "";
            string mnth4 = "";
            if (Report.Rows.Count > 0)
            {
                int a = 1;
                foreach (DataRow drb in dtbranchinfo.Rows)
                {
                    string branchid = drb["branchid"].ToString();
                    DataRow newrow = Sorttable.NewRow();
                    string parlorname = drb["branchname"].ToString();
                    string columnname3 = "";
                    string columnname4 = "";
                    string columnname5 = "";
                    string columnname6 = "";
                    string columnname7 = "";
                    string columnname8 = "";
                    string columnname9 = "";
                    string columnname10 = "";
                    int columncount = Report.Columns.Count;
                    if (columncount > 7)
                    {
                        columnname4 = Report.Columns[3].ToString();
                        columnname5 = Report.Columns[4].ToString();
                        columnname6 = Report.Columns[5].ToString();
                        columnname7 = Report.Columns[6].ToString();
                        columnname8 = Report.Columns[7].ToString();
                        columnname9 = Report.Columns[8].ToString();
                        columnname10 = Report.Columns[9].ToString();

                    }
                    else
                    {
                        if (columncount > 5)
                        {
                            columnname4 = Report.Columns[3].ToString();
                            columnname5 = Report.Columns[4].ToString();
                            columnname6 = Report.Columns[5].ToString();
                            columnname7 = Report.Columns[6].ToString();
                            mnth1 = columnname4;
                            mnth2 = columnname5;
                            mnth3 = columnname6;
                            mnth4 = columnname7;
                        }
                        else
                        {
                            if (columncount == 4)
                            {
                                columnname4 = Report.Columns[3].ToString();
                                mnth1 = columnname4;
                            }
                            else
                            {
                                columnname4 = Report.Columns[3].ToString();
                                columnname5 = Report.Columns[4].ToString();
                                mnth1 = columnname4;
                                mnth2 = columnname5;
                            }
                        }
                    }
                    newrow["Sno"] = a++.ToString();
                    newrow["Parlor Name"] = drb["branchname"].ToString();
                    string prname = drb["branchname"].ToString();
                    string colum4value = "";
                    string colum5value = "";
                    string colum6value = "";
                    string colum7value = "";
                    string colum8value = "";


                    foreach (DataRow dra in Report.Select("Parlorid='" + branchid + "'"))
                    {

                        string parlorid = dra["Parlorid"].ToString();
                        string wee = dra["Parlorid"].ToString();
                        if (branchid == parlorid)
                        {
                            newrow["Parlorid"] = parlorid;
                            if (columncount == 4)
                            {
                                if (colum4value != "")
                                {
                                    newrow[columnname4] = colum4value;
                                }
                                else
                                {
                                    colum4value = dra[columnname4].ToString();
                                    if (colum4value != "")
                                    {
                                        newrow[columnname4] = colum4value;
                                    }
                                }
                            }
                            else
                            {
                                if (colum4value != "")
                                {
                                    newrow[columnname4] = colum4value;
                                }
                                else
                                {
                                    colum4value = dra[columnname4].ToString();
                                    if (colum4value != "")
                                    {
                                        newrow[columnname4] = colum4value;
                                    }
                                }
                                if (colum5value != "")
                                {
                                    newrow[columnname5] = colum5value;
                                }
                                else
                                {
                                    colum5value = dra[columnname5].ToString();
                                    if (colum5value != "")
                                    {
                                        newrow[columnname5] = dra[columnname5].ToString();
                                    }
                                }
                            }
                        }
                    }

                    Sorttable.Rows.Add(newrow);

                }
            }
            if (Sorttable.Rows.Count > 0)
            {
                foreach (DataRow drs in Sorttable.Rows)
                {
                    datewisesalevaluedashboard getattendance = new datewisesalevaluedashboard();
                    getattendance.parlorid = drs["Parlorid"].ToString();
                    getattendance.parlorname = drs["Parlor Name"].ToString();
                    string week1tval = mnth1;
                    string week1value = drs["Parlorid"].ToString();
                    string linkval1 = week1tval + "_" + week1value;

                    string week2tval = mnth2;
                    string week2value = drs["Parlorid"].ToString();
                    string linkval2 = week2tval + "_" + week2value;

                    string week3tval = mnth3;
                    string week3value = drs["Parlorid"].ToString();
                    string linkval3 = week3tval + "_" + week3value;

                    string week4tval = mnth4;
                    string week4value = drs["Parlorid"].ToString();
                    string linkval4 = week4tval + "_" + week4value;
                    if (mnth1 != "")
                    {
                        getattendance.week1 = drs[mnth1].ToString();
                        getattendance.linkval1 = linkval1;
                    }
                    if (mnth2 != "")
                    {
                        getattendance.week2 = drs[mnth2].ToString();
                        getattendance.linkval2 = linkval2;
                    }
                    if (mnth3 != "")
                    {
                        getattendance.week3 = drs[mnth3].ToString();
                        getattendance.linkval3 = linkval3;
                    }
                    if (mnth4 != "")
                    {
                        getattendance.week4 = drs[mnth4].ToString();
                        getattendance.linkval4 = linkval4;
                    }
                    salevaluelist.Add(getattendance);
                }
            }
            Employeebiomtericattendencedates obj2 = new Employeebiomtericattendencedates();
            obj2.Allbiomertcdates = Alldateslists;
            obj2.salevalue = salevaluelist;
            Employeebiomtericattendencedateslists.Add(obj2);
            string response = GetJson(Employeebiomtericattendencedateslists);
            context.Response.Write(response);
        }
    }



    //sales 
    public class initializedataclasss
    {
        public string sno { get; set; }
        public string subcategorynam { get; set; }
        public string subcategorynames { get; set; }
        public string SubCat_sno { get; set; }
        public string ProductName { get; set; }
        public string productname { get; set; }
        public string Qty { get; set; }
        public string salestype { get; set; }
        public string categoryname { get; set; }
        public string Units { get; set; }
        public string UnitPrice { get; set; }
        public string unitprice { get; set; }
        public string branchname { get; set; }
        public string branchtype { get; set; }
        public string RegionName { get; set; }
        public string SubregionName { get; set; }
        public string RouteName { get; set; }
        public string Distributorname { get; set; }
        public string InvName { get; set; }
        public string Departmentname { get; set; }
        public string empname { get; set; }
        public string price { get; set; }
        public string igst { get; set; }
        public string cgst { get; set; }
        public string sgst { get; set; }
        public string productid { get; set; }
    }

    private void get_salescategory_details(HttpContext context)
    {
        try
        {
            VehicleDBMgr vdbmngr = new VehicleDBMgr();
            List<initializedataclasss> initializedatalist = new List<initializedataclasss>();
            mycmd = new MySqlCommand("select sno,Categoryname from products_category where flag=@flag and userdata_sno=@username");
            mycmd.Parameters.Add("@username", "1");
            mycmd.Parameters.Add("@flag", "1");
            foreach (DataRow dr in vdbmngr.SelectQuery(mycmd).Tables[0].Rows)
            {
                initializedataclasss initializedata = new initializedataclasss();
                initializedata.sno = dr["sno"].ToString();
                initializedata.categoryname = dr["Categoryname"].ToString();
                initializedatalist.Add(initializedata);
            }
            mycmd = new MySqlCommand("SELECT products_category.Categoryname, products_subcategory.SubCatName,products_subcategory.category_sno,products_subcategory.sno, productsdata.*  FROM productsdata RIGHT OUTER JOIN products_subcategory ON productsdata.SubCat_sno = products_subcategory.sno RIGHT OUTER JOIN products_category ON products_subcategory.category_sno = products_category.sno WHERE (products_category.flag<>0) AND (products_subcategory.Flag<>0) AND products_category.userdata_sno=@username");
            mycmd.Parameters.Add("@username", "1");
            DataTable dt = vdbmngr.SelectQuery(mycmd).Tables[0];
            context.Session["getcategorynames"] = dt;

            //mycmd = new MySqlCommand("SELECT productsdata.sno, productsdata.SubCat_sno, productsdata.ProductName, productsdata.Qty, productsdata.Units, productsdata.UnitPrice, productsdata.Flag, productsdata.UserData_sno, products_subcategory.SubCatName FROM products_subcategory RIGHT OUTER JOIN productsdata ON products_subcategory.sno = productsdata.SubCat_sno WHERE (products_subcategory.Flag <> 0) AND productsdata.UserData_sno=@username");
            //mycmd.Parameters.Add("@username", "1");
            //DataTable dt1 = vdbmngr.SelectQuery(mycmd).Tables[0];
            //context.Session["getproductsnames"] = dt1;

            mycmd = new MySqlCommand("SELECT branchproducts.Rank,productsdata.ProductName, productsdata.SubCat_sno, productsdata.sno, products_category.Categoryname, productsdata.Units, productsdata.Qty, branchproducts.unitprice FROM branchproducts INNER JOIN productsdata ON branchproducts.product_sno = productsdata.sno INNER JOIN products_subcategory ON productsdata.SubCat_sno = products_subcategory.sno INNER JOIN products_category ON products_subcategory.category_sno = products_category.sno WHERE (branchproducts.branch_sno = @BranchID) ORDER BY branchproducts.Rank");
            mycmd.Parameters.Add("@BranchID", "158");
            DataTable dttable = vdbmngr.SelectQuery(mycmd).Tables[0];
            context.Session["getproductsnames"] = dttable;

            if (initializedatalist != null)
            {
                string response = GetJson(initializedatalist);
                context.Response.Write(response);
            }
        }
        catch (Exception ex)
        {
            string msg = ex.Message;
            string response = GetJson(msg);
            context.Response.Write(response);
        }
    }




    private void get_parloritemdata_details(HttpContext context)
    {
        try
        {
            VehicleDBMgr vdbmngr = new VehicleDBMgr();
            List<initializedataclasss> initializedatalist = new List<initializedataclasss>();
            string subcatname = context.Request["subcatid"];
            DataTable subcategorys = (DataTable)context.Session["getproductsnames"];
            DataTable productnames = subcategorys.DefaultView.ToTable(true, "SubCat_sno", "ProductName", "sno", "Units", "unitprice");
            DataRow[] products = productnames.Select("SubCat_sno=" + subcatname + "");
            foreach (DataRow dr in products)
            {
                initializedataclasss initializedata = new initializedataclasss();
                initializedata.ProductName = dr["ProductName"].ToString();
                initializedata.sno = dr["sno"].ToString();
                initializedata.Units = dr["Units"].ToString();
                initializedata.UnitPrice = dr["unitprice"].ToString();
                initializedatalist.Add(initializedata);
            }
            if (initializedatalist != null)
            {
                string response = GetJson(initializedatalist);
                context.Response.Write(response);
            }
        }
        catch (Exception ex)
        {
            string msg = ex.Message;
            string response = GetJson(msg);
            context.Response.Write(response);
        }
    }

    public class indentitemDetails
    {
        public string btnreg { get; set; }
        public string distibuter { get; set; }
        public List<indentitemsubDetails> itemlist { get; set; }
    }

    public class indentitemsubDetails
    {
        public string productname { get; set; }
        public string price { get; set; }
        public string Quantity { get; set; }
        public string productid { get; set; }
        public string hdnproductsno { get; set; }
    }

    public class getitemindentDetails
    {
        public List<indentitemDetails> RegDetails { get; set; }
        public List<indentitemsubDetails> SubRegclose { get; set; }
    }

    private void indent_save_click(HttpContext context)
    {
        try
        {
            VehicleDBMgr vdbmngr = new VehicleDBMgr();
            var js = new JavaScriptSerializer();
            var title1 = context.Request.Params[1];
            indentitemDetails obj = js.Deserialize<indentitemDetails>(title1);
            string btnreg = "Save";
            DateTime ServerDateCurrentdate = VehicleDBMgr.GetTime(vdbmngr.conn);
            DateTime closedate = ServerDateCurrentdate;
            if (btnreg == "Save")
            {
                mycmd = new MySqlCommand("insert into indents (Branch_id,I_date,UserData_sno,Status,PaymentStatus,I_createdby,IndentType)values(@Branch_id,@I_date,@UserData_sno,@Status,@PaymentStatus,@I_createdby,@IndentType)");
                mycmd.Parameters.Add("@Branch_id", "6258");
                mycmd.Parameters.Add("@I_date", ServerDateCurrentdate);
                mycmd.Parameters.Add("@UserData_sno", "1");
                mycmd.Parameters.Add("@Status", "O");
                mycmd.Parameters.Add("@PaymentStatus", 'A');
                mycmd.Parameters.Add("@IndentType", "indent1");
                mycmd.Parameters.Add("@I_createdby", "6258");
                vdbmngr.insert(mycmd);
                mycmd = new MySqlCommand("SELECT max(IndentNo) as IndentNo FROM indents");
                DataTable dttable = vdbmngr.SelectQuery(mycmd).Tables[0];
                if (dttable.Rows.Count > 0)
                {
                    string IndNo = dttable.Rows[0]["IndentNo"].ToString();
                    foreach (indentitemsubDetails si in obj.itemlist)
                    {
                        if (si.productid != "0")
                        {
                            mycmd = new MySqlCommand("insert into indents_subtable (IndentNo,Product_sno,Status,unitQty,UnitCost,OTripId)values(@IndentNo,@Product_sno,@Status,@unitQty,@UnitCost,@OTripId)");
                            mycmd.Parameters.Add("@IndentNo", IndNo);
                            mycmd.Parameters.Add("@Product_sno", si.productid);
                            double UtCost = 0;
                            double.TryParse(si.price, out UtCost);
                            UtCost = Math.Round(UtCost, 2);
                            mycmd.Parameters.Add("@UnitCost", UtCost);
                            double unitQty = 0;
                            double.TryParse(si.Quantity, out unitQty);
                            mycmd.Parameters.Add("@unitQty", unitQty);
                            mycmd.Parameters.Add("@Status", "Ordered");
                            mycmd.Parameters.Add("@OTripId", "0");
                            vdbmngr.insert(mycmd);
                        }
                    }
                }
                string Response = GetJson("Indent Details are Successfully Saved");
                context.Response.Write(Response);
            }
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    private void subdistibuterrate_save(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            var js = new JavaScriptSerializer();
            var title1 = context.Request.Params[1];
            indentitemDetails obj = js.Deserialize<indentitemDetails>(title1);
            string btnreg = "Save";
            string distibutor = obj.distibuter;
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
            DateTime closedate = ServerDateCurrentdate;
            string createdby = context.Session["Employ_Sno"].ToString();
            if (btnreg == "Save")
            {
                string distibutorid = distibutor;
                foreach (indentitemsubDetails si in obj.itemlist)
                {
                    if (si.productid != "0")
                    {
                        cmd = new SqlCommand("UPDATE distibutorratemoniter SET price=@price, doe=@doe WHERE productid=@productid AND distibutorid=@distibutorid");
                        cmd.Parameters.Add("@price", si.price);
                        cmd.Parameters.Add("@productid", si.productid);
                        cmd.Parameters.Add("@distibutorid", distibutorid);
                        cmd.Parameters.Add("@doe", ServerDateCurrentdate);
                        if (vdm.Update(cmd) == 0)
                        {
                            cmd = new SqlCommand("insert into distibutorratemoniter (distibutorid, productid, price, I_createdby, doe)values(@distibutorid,@productid,@price,@I_createdby,@doe)");
                            cmd.Parameters.Add("@distibutorid", distibutorid);
                            cmd.Parameters.Add("@productid", si.productid);
                            cmd.Parameters.Add("@price", si.price);
                            cmd.Parameters.Add("@I_createdby", createdby);
                            cmd.Parameters.Add("@doe", ServerDateCurrentdate);
                            vdm.insert(cmd);
                        }
                        cmd = new SqlCommand("insert into distibutorratemoniterlogs (distibutorid, productid, price, I_createdby, doe)values(@distibutorid,@productid,@price,@I_createdby,@doe)");
                        cmd.Parameters.Add("@distibutorid", distibutorid);
                        cmd.Parameters.Add("@productid", si.productid);
                        cmd.Parameters.Add("@price", si.price);
                        cmd.Parameters.Add("@I_createdby", createdby);
                        cmd.Parameters.Add("@doe", ServerDateCurrentdate);
                        vdm.insert(cmd);
                    }
                }
                string Response = GetJson("Rate Details are Successfully Saved");
                context.Response.Write(Response);
            }
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    private void get_salesproduct_details(HttpContext context)
    {
        try
        {
            VehicleDBMgr vdbmngr = new VehicleDBMgr();
            List<initializedataclasss> initializedatalist = new List<initializedataclasss>();
            string distibutorid = context.Request["distibutorid"].ToString();
            string branchid = context.Session["BranchID"].ToString();
            cmd = new SqlCommand("select price, productid from distibutorratemoniter where distibutorid=@did");
            cmd.Parameters.Add("@did", distibutorid);
            DataTable dtdistibutortable = vdm.SelectQuery(cmd).Tables[0];
            cmd = new SqlCommand("SELECT productmaster.productid, productmaster.categoryid, productmaster.imagepath, productmaster.subcategoryid, productmaster.uim AS Puim,  productmaster.productname, productmaster.billingprice,   productmaster.productcode, productmaster.hsncode, productmaster.sub_cat_code, productmaster.sku, productmaster.description, productmaster.igst, productmaster.cgst, productmaster.sgst, productmaster.gsttaxcategory, productmaster.status, productmaster.createdby, productmaster.createdon, uimmaster.uim, productmoniter.qty, productmoniter.price, categorymaster.category, subcategorymaster.subcategoryname, productmaster.supplierid  FROM productmaster INNER JOIN productmoniter ON productmaster.productid=productmoniter.productid INNER JOIN categorymaster ON productmaster.categoryid = categorymaster.categoryid INNER JOIN subcategorymaster ON productmaster.subcategoryid = subcategorymaster.subcategoryid LEFT OUTER JOIN uimmaster ON uimmaster.sno=productmaster.uim  WHERE (productmoniter.branchid = @branchid)");
            cmd.Parameters.Add("@branchid", branchid);
            DataTable dttable = vdm.SelectQuery(cmd).Tables[0];
            //mycmd = new MySqlCommand("SELECT branchproducts.Rank,productsdata.ProductName, productsdata.SubCat_sno, productsdata.sno, products_category.Categoryname, productsdata.Units, productsdata.Qty, branchproducts.unitprice, productsdata.igst, productsdata.sgst, productsdata.cgst FROM branchproducts INNER JOIN productsdata ON branchproducts.product_sno = productsdata.sno INNER JOIN products_subcategory ON productsdata.SubCat_sno = products_subcategory.sno INNER JOIN products_category ON products_subcategory.category_sno = products_category.sno WHERE (branchproducts.branch_sno = @BranchID) ORDER BY branchproducts.Rank");
            //mycmd.Parameters.Add("@BranchID", "158");
            //DataTable dttable = vdbmngr.SelectQuery(mycmd).Tables[0];
            if (dtdistibutortable.Rows.Count > 0)
            {
                foreach (DataRow dr in dtdistibutortable.Rows)
                {
                    string productid = dr["productid"].ToString();
                    string price = dr["price"].ToString();
                    foreach (DataRow drv in dttable.Select("productid=" + productid + ""))
                    {
                        initializedataclasss initializedata = new initializedataclasss();
                        initializedata.productname = drv["ProductName"].ToString();
                        initializedata.productid = drv["productid"].ToString();
                        initializedata.Units = drv["uim"].ToString();
                        initializedata.price = price;
                        initializedata.igst = drv["igst"].ToString(); ;
                        initializedata.cgst = drv["cgst"].ToString(); ;
                        initializedata.sgst = drv["sgst"].ToString(); ;
                        initializedatalist.Add(initializedata);
                    }
                }
            }
            if (initializedatalist != null)
            {
                string response = GetJson(initializedatalist);
                context.Response.Write(response);
            }
        }
        catch (Exception ex)
        {
            string msg = ex.Message;
            string response = GetJson(msg);
            context.Response.Write(response);
        }
    }

    private void save_distibutorsale_details(HttpContext context)
    {
        try
        {
            var js = new JavaScriptSerializer();
            var title1 = context.Request.Params[1];
            inwardDetails obj = js.Deserialize<inwardDetails>(title1);
            string date = obj.date;
            string refnote = obj.refnote;
            string frombranch = obj.frombranch;
            string description = obj.description;
            string btnval = obj.btnvalue;
            string sno = obj.sno;
            string status = "A";
            string billtotalvalue = obj.totalvalue;
            string branchid = context.Session["BranchID"].ToString();
            string createdby = context.Session["Employ_Sno"].ToString();
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
            vdm = new SalesDBManager();
            if (btnval == "Save")
            {
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
                cmd = new SqlCommand("SELECT { fn IFNULL(MAX(invoiceno), 0) } + 1 AS invoiceno FROM  distibutorsalemaindetails WHERE (branchid = @branchid) and (doe between @d1 and @d2)");
                cmd.Parameters.Add("@branchid", branchid);
                cmd.Parameters.Add("@d1", GetLowDate(dtapril));
                cmd.Parameters.Add("@d2", GetHighDate(dtmarch));
                DataTable dtratechart = vdm.SelectQuery(cmd).Tables[0];
                string invoiceno = dtratechart.Rows[0]["invoiceno"].ToString();
                cmd = new SqlCommand("insert into distibutorsalemaindetails(distibutorid, doe, branchid, status, invoiceno, invoicedate, remarks, billtotalvalue, refnote, createdby, createdon) values (@frombranch,  @doe, @branchid, @status, @invoiceno, @invoicedate, @description, @billtotalvalue, @refno, @createdby, @createdon)");
                cmd.Parameters.Add("@branchid", branchid);
                cmd.Parameters.Add("@doe", date);
                cmd.Parameters.Add("@frombranch", frombranch);
                cmd.Parameters.Add("@refno", refnote);
                cmd.Parameters.Add("@description", description);
                cmd.Parameters.Add("@status", status);
                cmd.Parameters.Add("@invoicedate", ServerDateCurrentdate);
                cmd.Parameters.Add("@createdon", ServerDateCurrentdate);
                cmd.Parameters.Add("@createdby", createdby);
                cmd.Parameters.Add("@invoiceno", invoiceno);
                cmd.Parameters.Add("@billtotalvalue", billtotalvalue);
                vdm.insert(cmd);
                cmd = new SqlCommand("select MAX(sno) as stno from distibutorsalemaindetails");
                DataTable dtoutward = vdm.SelectQuery(cmd).Tables[0];
                string refno = dtoutward.Rows[0]["stno"].ToString();
                foreach (Subinward si in obj.fillitems)
                {
                    if (si.hdnproductsno != "0")
                    {
                        cmd = new SqlCommand("insert into distibutorsalesubdetails(productid, quantity, price, totvalue, stock_refno, igst, cgst, sgst) values (@productid,@quantity,@perunit,@totalcost,@in_refno, @igst, @cgst, @sgst)");
                        cmd.Parameters.Add("@productid", si.hdnproductsno);
                        cmd.Parameters.Add("@quantity", si.Quantity);
                        cmd.Parameters.Add("@perunit", si.PerUnitRs);
                        cmd.Parameters.Add("@totalcost", si.TotalCost);
                        cmd.Parameters.Add("@igst", si.igst);
                        cmd.Parameters.Add("@cgst", si.cgst);
                        cmd.Parameters.Add("@sgst", si.sgst);
                        cmd.Parameters.Add("@in_refno", refno);
                        vdm.insert(cmd);
                    }
                }

                cmd = new SqlCommand("UPDATE distibutorduemonitor SET amount=amount+@amt WHERE distibutorid=@distibutorid AND branchid=@BID");
                cmd.Parameters.Add("@amt", billtotalvalue);
                cmd.Parameters.Add("@distibutorid", frombranch);
                cmd.Parameters.Add("@BID", branchid);
                if (vdm.Update(cmd) == 0)
                {
                    cmd = new SqlCommand("insert into distibutorduemonitor(distibutorid, amount, branchid) values (@distid,@amount,@bbid)");
                    cmd.Parameters.Add("@distid", frombranch);
                    cmd.Parameters.Add("@amount", billtotalvalue);
                    cmd.Parameters.Add("@bbid", branchid);
                    vdm.insert(cmd);
                }
                string msg = "Sale Details successfully added";
                string Response = GetJson(msg);
                context.Response.Write(Response);
            }
            else
            {
                cmd = new SqlCommand("UPDATE distibutorsalemaindetails SET distibutorid=@frombranch, refnote=@refnote, doe=@doe, billtotalvalue=@billtotalvalue, remarks=@description WHERE sno=@sno AND branchid=@branchid");
                cmd.Parameters.Add("@sno", sno);
                cmd.Parameters.Add("@branchid", branchid);
                cmd.Parameters.Add("@doe", date);
                cmd.Parameters.Add("@frombranch", frombranch);
                cmd.Parameters.Add("@refno", refnote);
                cmd.Parameters.Add("@description", description);
                cmd.Parameters.Add("@billtotalvalue", billtotalvalue);
                vdm.Update(cmd);
                foreach (Subinward si in obj.fillitems)
                {
                    if (si.hdnproductsno != "0")
                    {
                        cmd = new SqlCommand("update distibutorsalesubdetails set  quantity=@quantity, price=@perunit,totvalue=@totalcost Where stock_refno=@refno and productid=@productid");
                        cmd.Parameters.Add("@productid", si.hdnproductsno);
                        cmd.Parameters.Add("@quantity", si.Quantity);
                        cmd.Parameters.Add("@perunit", si.PerUnitRs);
                        cmd.Parameters.Add("@totalcost", si.TotalCost);
                        cmd.Parameters.Add("@refno", sno);
                        if (vdm.Update(cmd) == 0)
                        {
                            cmd = new SqlCommand("insert into distibutorsalesubdetails(productid, quantity, price, totvalue, stock_refno, igst, cgst, sgst) values (@productid,@quantity,@perunit,@totalcost,@in_refno, @igst, @cgst, @sgst)");
                            cmd.Parameters.Add("@productid", si.hdnproductsno);
                            cmd.Parameters.Add("@quantity", si.Quantity);
                            cmd.Parameters.Add("@perunit", si.PerUnitRs);
                            cmd.Parameters.Add("@totalcost", si.TotalCost);
                            cmd.Parameters.Add("@igst", si.igst);
                            cmd.Parameters.Add("@cgst", si.cgst);
                            cmd.Parameters.Add("@sgst", si.sgst);
                            cmd.Parameters.Add("@in_refno", sno);
                            vdm.insert(cmd);
                        }
                    }
                }
            }
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }


    public class distibutorsaleDetails
    {
        public string date { get; set; }
        public string refnote { get; set; }
        public string distibutorname { get; set; }
        public string distibutorid { get; set; }
        public string description { get; set; }
        public string sno { get; set; }
        public string btnvalue { get; set; }
        public string totalvalue { get; set; }
        public string invoiceno { get; set; }
        public string status { get; set; }
        public string stateid { get; set; }
        public string address { get; set; }
        public string phoneno { get; set; }
        public string emailid { get; set; }
        public string gstno { get; set; }
        public string cstno { get; set; }
        public string tinno { get; set; }
        public string branchtype { get; set; }
        public string branchid { get; set; }
        public string frombrancname { get; set; }
        public string fromaddress { get; set; }
        public string fromphonenno { get; set; }
        public string fromgstin { get; set; }
        public string fromemailid { get; set; }
        public string fromstateid { get; set; }
        public string fromstatecode { get; set; }
        public string fromstatename { get; set; }
        public string modeoftransport { get; set; }
        public string vehicleno { get; set; }

        public List<distibutorsalesubDetails> fillitems { get; set; }
    }

    public class distibutorsalesubDetails
    {
        public string productname { get; set; }
        public string hsncode { get; set; }
        public string itemcode { get; set; }
        public string uim { get; set; }
        public string PerUnitRs { get; set; }
        public string Quantity { get; set; }
        public string TotalCost { get; set; }
        public string hdnproductsno { get; set; }
        public string cgst { get; set; }
        public string sgst { get; set; }
        public string igst { get; set; }
        public string ordertax { get; set; }
        public string inword_refno { get; set; }
        public string subcategoryname { get; set; }
        public string sno { get; set; }
    }
    public class getdistibutorsale  //new
    {
        public List<distibutorsaleDetails> distibutorsaleDetails { get; set; }
        public List<distibutorsalesubDetails> Subdistibutorsale { get; set; }
    }
    private void get_distibutorsale_details_click(HttpContext context)
    {
        try
        {
            VehicleDBMgr vdbmngr = new VehicleDBMgr();
            List<initializedataclass> initializedatalist = new List<initializedataclass>();
            string distibutorid = context.Request["distibutorid"].ToString();
            string fromdate = context.Request["fromdate"].ToString();
            string todate = context.Request["todate"].ToString();

            DateTime dtfrom = Convert.ToDateTime(fromdate);
            DateTime dtto = Convert.ToDateTime(todate);
            string branchid = context.Session["BranchID"].ToString();
            cmd = new SqlCommand("select subdistibutor.distibutorname, subdistibutor.stateid, distibutorsalemaindetails.invoicedate, distibutorsalemaindetails.invoiceno, distibutorsalemaindetails.billtotalvalue, distibutorsalemaindetails.status, distibutorsalemaindetails.sno from distibutorsalemaindetails INNER JOIN subdistibutor on subdistibutor.sno=distibutorsalemaindetails.distibutorid WHERE distibutorsalemaindetails.distibutorid=@did AND invoicedate between @d1 and @d2 AND distibutorsalemaindetails.branchid=@branchid");
            cmd.Parameters.Add("@d1", GetLowDate(dtfrom));
            cmd.Parameters.Add("@d2", GetHighDate(dtto));
            cmd.Parameters.Add("@branchid", branchid);
            cmd.Parameters.Add("@did", distibutorid);
            DataTable dtstock = vdm.SelectQuery(cmd).Tables[0];
            List<distibutorsaleDetails> stock_lst = new List<distibutorsaleDetails>();
            foreach (DataRow dr in dtstock.Rows)
            {
                distibutorsaleDetails getstockdetails = new distibutorsaleDetails();
                getstockdetails.distibutorname = dr["distibutorname"].ToString();
                getstockdetails.stateid = dr["stateid"].ToString();
                getstockdetails.totalvalue = dr["billtotalvalue"].ToString();
                getstockdetails.status = dr["status"].ToString();
                getstockdetails.date = ((DateTime)dr["invoicedate"]).ToString("dd-MM-yyyy"); //dr["invoicedate"].ToString();
                getstockdetails.sno = dr["sno"].ToString();
                getstockdetails.invoiceno = dr["invoiceno"].ToString();
                stock_lst.Add(getstockdetails);
            }
            string response = GetJson(stock_lst);
            context.Response.Write(response);
        }
        catch
        {

        }
    }

    private void get_distibutorsales_Sub_details_click(HttpContext context)
    {
        try
        {
            VehicleDBMgr vdbmngr = new VehicleDBMgr();
            List<initializedataclass> initializedatalist = new List<initializedataclass>();
            string refno = context.Request["refdcno"].ToString();
            string branchid = context.Session["BranchID"].ToString();

            //mycmd = new MySqlCommand("SELECT branchproducts.Rank,productsdata.ProductName,productsdata.Itemcode, productsdata.hsncode, productsdata.SubCat_sno, productsdata.sno, products_category.Categoryname, productsdata.Units, productsdata.Qty, branchproducts.unitprice, productsdata.igst, productsdata.sgst, productsdata.cgst FROM branchproducts INNER JOIN productsdata ON branchproducts.product_sno = productsdata.sno INNER JOIN products_subcategory ON productsdata.SubCat_sno = products_subcategory.sno INNER JOIN products_category ON products_subcategory.category_sno = products_category.sno WHERE (branchproducts.branch_sno = @BranchID) ORDER BY branchproducts.Rank");
            //mycmd.Parameters.Add("@BranchID", "158");
            //DataTable dttable = vdbmngr.SelectQuery(mycmd).Tables[0];

            cmd = new SqlCommand("SELECT productmaster.productid, productmaster.categoryid, productmaster.imagepath, productmaster.subcategoryid, productmaster.uim AS Puim,  productmaster.productname, productmaster.billingprice,   productmaster.productcode, productmaster.hsncode, productmaster.sub_cat_code, productmaster.sku, productmaster.description, productmaster.igst, productmaster.cgst, productmaster.sgst, productmaster.gsttaxcategory, productmaster.status, productmaster.createdby, productmaster.createdon, uimmaster.uim, productmoniter.qty, productmoniter.price, categorymaster.category, subcategorymaster.subcategoryname, productmaster.supplierid  FROM productmaster INNER JOIN productmoniter ON productmaster.productid=productmoniter.productid INNER JOIN categorymaster ON productmaster.categoryid = categorymaster.categoryid INNER JOIN subcategorymaster ON productmaster.subcategoryid = subcategorymaster.subcategoryid LEFT OUTER JOIN uimmaster ON uimmaster.sno=productmaster.uim  WHERE (productmoniter.branchid = @branchid)");
            cmd.Parameters.Add("@branchid", branchid);
            DataTable dttable = vdm.SelectQuery(cmd).Tables[0];

            cmd = new SqlCommand("SELECT branchmaster.branchid, branchmaster.branchname, branchmaster.address, branchmaster.phone, branchmaster.gstin, branchmaster.emailid, branchmaster.stateid, statemastar.statename, statemastar.statecode  FROM branchmaster INNER JOIN statemastar ON statemastar.sno= branchmaster.stateid WHERE branchid=@branchid");
            cmd.Parameters.Add("@branchid", branchid);
            DataTable dtfrombranch = vdm.SelectQuery(cmd).Tables[0];

            cmd = new SqlCommand("SELECT subdistibutor.distibutorname, subdistibutor.address, subdistibutor.stateid, subdistibutor.phone, subdistibutor.tino, subdistibutor.stno, subdistibutor.cstno, subdistibutor.emailid, subdistibutor.gstin,subdistibutor.branchtype, distibutorsalemaindetails.invoiceno,  distibutorsalemaindetails.billtotalvalue,   distibutorsalemaindetails.invoicedate, distibutorsalemaindetails.distibutorid, distibutorsalemaindetails.branchid, distibutorsalesubdetails.productid, distibutorsalesubdetails.quantity, distibutorsalesubdetails.price,    distibutorsalesubdetails.totvalue, distibutorsalesubdetails.igst, distibutorsalesubdetails.cgst, distibutorsalesubdetails.sgst, distibutorsalemaindetails.sno  FROM            distibutorsalemaindetails INNER JOIN  distibutorsalesubdetails ON distibutorsalemaindetails.sno = distibutorsalesubdetails.stock_refno INNER JOIN subdistibutor ON distibutorsalemaindetails.distibutorid = subdistibutor.sno WHERE distibutorsalemaindetails.sno=@sno");
            cmd.Parameters.Add("@sno", refno);
            DataTable dtstock = vdm.SelectQuery(cmd).Tables[0];

            DataView view = new DataView(dtstock);
            DataTable dtdistibutorsale = view.ToTable(true, "sno", "distibutorid", "distibutorname", "stateid", "address", "phone", "tino", "stno", "cstno", "emailid", "gstin", "invoiceno", "invoicedate", "branchid", "billtotalvalue", "branchtype");//, "indentno"
            DataTable dtsubdistibutorsale = view.ToTable(true, "productid", "quantity", "price", "totvalue", "igst", "cgst", "sgst", "sno");
            List<getdistibutorsale> getdistibutorsaledetails = new List<getdistibutorsale>();
            List<distibutorsaleDetails> distbutorlist = new List<distibutorsaleDetails>();
            List<distibutorsalesubDetails> distbutorlistsublist = new List<distibutorsalesubDetails>();
            string frombrancname = "";
            string fromaddress = "";
            string fromphonenno = "";
            string fromgstin = "";
            string fromemailid = "";
            string fromstateid = "";
            string tostateid = "";
            string fromstatecode = "";
            string fromstatename = "";
            if (dtfrombranch.Rows.Count > 0)
            {
                foreach (DataRow drbranch in dtfrombranch.Rows)
                {
                    frombrancname = drbranch["branchname"].ToString();
                    fromaddress = drbranch["address"].ToString();
                    fromphonenno = drbranch["phone"].ToString();
                    fromgstin = drbranch["gstin"].ToString();
                    fromemailid = drbranch["emailid"].ToString();
                    fromstateid = drbranch["stateid"].ToString();
                    fromstatecode = drbranch["statecode"].ToString();
                    fromstatename = drbranch["statename"].ToString();
                }
            }
            foreach (DataRow dr in dtdistibutorsale.Rows)
            {
                distibutorsaleDetails getInward = new distibutorsaleDetails();
                getInward.date = ((DateTime)dr["invoicedate"]).ToString("dd-MM-yyyy");//dr["inwarddate"].ToString();
                getInward.totalvalue = dr["billtotalvalue"].ToString();
                getInward.distibutorname = dr["distibutorname"].ToString();
                getInward.address = dr["address"].ToString();
                getInward.phoneno = dr["phone"].ToString();
                getInward.branchtype = dr["branchtype"].ToString();
                getInward.tinno = dr["tino"].ToString();
                tostateid = dr["stateid"].ToString();
                getInward.stateid = dr["stateid"].ToString();
                getInward.gstno = dr["gstin"].ToString();
                getInward.cstno = dr["cstno"].ToString();
                getInward.emailid = dr["emailid"].ToString();
                getInward.sno = dr["sno"].ToString();
                getInward.branchid = dr["branchid"].ToString();
                getInward.invoiceno = dr["invoiceno"].ToString();
                getInward.modeoftransport = "Vehicle";
                getInward.vehicleno = "TS16T1234";
                getInward.frombrancname = frombrancname;
                getInward.fromaddress = fromaddress;
                getInward.fromphonenno = fromphonenno;
                getInward.fromgstin = fromgstin;
                getInward.fromemailid = fromemailid;
                getInward.fromstateid = fromstateid;
                getInward.fromstatecode = fromstatecode;
                getInward.fromstatename = fromstatename;
                distbutorlist.Add(getInward);

            }
            foreach (DataRow dr in dtsubdistibutorsale.Rows)
            {
                distibutorsalesubDetails getsubinward = new distibutorsalesubDetails();
                string productid = dr["productid"].ToString();
                getsubinward.hdnproductsno = dr["productid"].ToString();
                foreach (DataRow drv in dttable.Select("productid=" + productid + ""))
                {
                    getsubinward.productname = drv["ProductName"].ToString();
                    getsubinward.hsncode = drv["hsncode"].ToString();
                    getsubinward.itemcode = drv["productcode"].ToString();
                    getsubinward.uim = drv["uim"].ToString();
                }
                getsubinward.Quantity = dr["quantity"].ToString();
                double quantity = Convert.ToDouble(dr["quantity"].ToString());
                quantity = Math.Round(quantity, 2);
                getsubinward.PerUnitRs = dr["price"].ToString();
                getsubinward.TotalCost = dr["totvalue"].ToString();
                if (fromstateid == tostateid)
                {
                    getsubinward.igst = "0";
                    getsubinward.cgst = dr["cgst"].ToString();
                    getsubinward.sgst = dr["sgst"].ToString();
                }
                else
                {
                    getsubinward.igst = dr["igst"].ToString();
                    getsubinward.cgst = "0";
                    getsubinward.sgst = "0";
                }
                getsubinward.inword_refno = dr["sno"].ToString();
                distbutorlistsublist.Add(getsubinward);
            }
            getdistibutorsale getInwadDatas = new getdistibutorsale();
            getInwadDatas.distibutorsaleDetails = distbutorlist;
            getInwadDatas.Subdistibutorsale = distbutorlistsublist;
            getdistibutorsaledetails.Add(getInwadDatas);
            string response = GetJson(getdistibutorsaledetails);
            context.Response.Write(response);
        }
        catch
        {
        }
    }

    public class initializedataclass
    {
        public string sno { get; set; }
        public string subcategorynam { get; set; }
        public string subcategorynames { get; set; }
        public string SubCat_sno { get; set; }
        public string ProductName { get; set; }
        public string productname { get; set; }
        public string Qty { get; set; }
        public string salestype { get; set; }
        public string categoryname { get; set; }
        public string Units { get; set; }
        public string UnitPrice { get; set; }
        public string unitprice { get; set; }
        public string branchname { get; set; }
        public string branchtype { get; set; }
        public string RegionName { get; set; }
        public string SubregionName { get; set; }
        public string RouteName { get; set; }
        public string Distributorname { get; set; }
        public string InvName { get; set; }
        public string Departmentname { get; set; }
        public string empname { get; set; }
    }



    private void intialize_productsmanagement_products(HttpContext context)
    {

        try
        {
            MySqlCommand cmd = new MySqlCommand();
            DBManagerSales vdbmngr = new DBManagerSales();
            List<initializedataclass> initializedatalist = new List<initializedataclass>();
            string FormType = context.Request["FormType"];
            if (FormType == "NewProductMaster")
            {
                cmd = new MySqlCommand("select tempcatsno AS sno,description AS Categoryname from products_category where flag=@flag and userdata_sno=@username AND tempcatsno IS NOT NULL");
                cmd.Parameters.Add("@username", "1");
                cmd.Parameters.Add("@flag", "1");
            }
            else
            {
                cmd = new MySqlCommand("select sno,Categoryname from products_category where flag=@flag and userdata_sno=@username");
                cmd.Parameters.Add("@username", "1");
                cmd.Parameters.Add("@flag", "1");
            }
            foreach (DataRow dr in vdbmngr.SelectQuery(cmd).Tables[0].Rows)
            {
                initializedataclass initializedata = new initializedataclass();
                initializedata.sno = dr["sno"].ToString();
                initializedata.categoryname = dr["Categoryname"].ToString();
                initializedatalist.Add(initializedata);
            }
            if (FormType == "NewProductMaster")
            {
                cmd = new MySqlCommand("SELECT   productsdata.ifdflag, productsdata.description, productsdata.invqty, productsdata.pieces, productsdata.specification, productsdata.materialtype, productsdata.PerUnitPrice, products_subcategory.SubCatName,products_subcategory.sno AS SubCatsno, productsdata.images, productsdata.hsncode, productsdata.igst, productsdata.sgst, productsdata.cgst, productsdata.gsttaxcategory, products_category.Categoryname,products_category.sno AS categorysno, productsdata.tproduct, productsdata.Itemcode, productsdata.ProductName, productsdata.sno, productsdata.Qty, productsdata.Units, productsdata.UnitPrice, productsdata.Flag, products_subcategory.category_sno, productsdata.SubCat_sno, productsdata.VatPercent, invmaster.InvName, productsdata.tempsubcatsno, products_category.tempcatsno,products_subcategory.tempsub_catsno, products_category.description AS Expr1, products_subcategory.description AS Expr2 FROM  products_category INNER JOIN products_subcategory ON products_category.tempcatsno = products_subcategory.tempcatsno INNER JOIN productsdata ON products_subcategory.tempsub_catsno = productsdata.tempsubcatsno INNER JOIN invmaster ON productsdata.Inventorysno = invmaster.sno");
                cmd.Parameters.Add("@username", "1");
            }
            else
            {
                cmd = new MySqlCommand("SELECT products_category.Categoryname, products_subcategory.SubCatName,products_subcategory.category_sno,products_subcategory.sno, productsdata.*  FROM productsdata RIGHT OUTER JOIN products_subcategory ON productsdata.SubCat_sno = products_subcategory.sno RIGHT OUTER JOIN products_category ON products_subcategory.category_sno = products_category.sno WHERE (products_category.flag<>0) AND (products_subcategory.Flag<>0) AND products_category.userdata_sno=@username");
                cmd.Parameters.Add("@username", "1");
            }
            DataTable dt = vdbmngr.SelectQuery(cmd).Tables[0];
            context.Session["getcategorynames"] = dt;
            if (initializedatalist != null)
            {
                string response = GetJson(initializedatalist);
                context.Response.Write(response);
            }
        }
        catch (Exception ex)
        {
            string msg = ex.Message;
            string response = GetJson(msg);
            context.Response.Write(response);
        }
    }

    private void get_subcategory_data(HttpContext context)
    {
        try
        {
            DBManagerSales vdbmngr = new DBManagerSales();
            List<initializedataclass> initializedatalist = new List<initializedataclass>();
            string catgryname = context.Request["cmbcatgryname"];
            string FormType = "NewProductMaster";

            DataTable productdata = (DataTable)context.Session["getcategorynames"];
            DataTable categorys = new DataTable();
            if (FormType == "NewProductMaster")
            {
                // productsdata.tempsubcatsno, products_category.tempcatsno,products_subcategory.tempsub_catsno, products_category.description AS Expr1, products_subcategory.description AS Expr2
                categorys = productdata.DefaultView.ToTable(true, "tempcatsno", "Expr2", "tempsub_catsno");
                DataRow[] subcatgry = categorys.Select("tempcatsno=" + catgryname + "");
                foreach (DataRow dr in subcatgry)
                {
                    initializedataclass initializedata = new initializedataclass();
                    initializedata.subcategorynames = dr["Expr2"].ToString();
                    initializedata.sno = dr["tempsub_catsno"].ToString();
                    initializedatalist.Add(initializedata);
                }
            }
            else
            {
                categorys = productdata.DefaultView.ToTable(true, "category_sno", "SubCatName", "sno");
                DataRow[] subcatgry = categorys.Select("category_sno=" + catgryname + "");
                foreach (DataRow dr in subcatgry)
                {
                    initializedataclass initializedata = new initializedataclass();
                    initializedata.subcategorynames = dr["SubCatName"].ToString();
                    initializedata.sno = dr["sno"].ToString();
                    initializedatalist.Add(initializedata);
                }
            }
            if (initializedatalist != null)
            {
                string response = GetJson(initializedatalist);
                context.Response.Write(response);
            }
        }
        catch (Exception ex)
        {
            string msg = ex.Message;
            string response = GetJson(msg);
            context.Response.Write(response);
        }
    }


    private void get_salesitemdata_details(HttpContext context)
    {
        DBManagerSales vdbmngr = new DBManagerSales();
        string parlorid = context.Session["BranchID"].ToString();
        string subcatid = context.Request["subcatid"].ToString();
        MySqlCommand cmd;
        cmd = new MySqlCommand("SELECT    branchproducts.branch_sno,products_subcategory.tempsub_catsno AS SubCatSno, products_category.description AS Categoryname, branchproducts.product_sno, productsdata.ProductName,productsdata.Units, branchproducts.unitprice, branchproducts.Rank,products_subcategory.description AS SubCategoryName FROM  products_category INNER JOIN products_subcategory ON products_category.tempcatsno = products_subcategory.tempcatsno INNER JOIN productsdata ON products_subcategory.tempsub_catsno = productsdata.tempsubcatsno INNER JOIN branchproducts ON productsdata.sno = branchproducts.product_sno WHERE (branchproducts.branch_sno = @BranchId) AND (productsdata.tempsubcatsno = @sub) ORDER BY products_subcategory.tempsub_catsno, branchproducts.Rank");
        cmd.Parameters.Add("@BranchID", "158");
        cmd.Parameters.Add("@sub", subcatid);
        DataTable dtiteminfo = vdbmngr.SelectQuery(cmd).Tables[0];
        if (dtiteminfo.Rows.Count > 0)
        {
            List<ProductDetails> ProductDetails = new List<ProductDetails>();
            foreach (DataRow dr in dtiteminfo.Rows)
            {
                ProductDetails getproductdetails = new ProductDetails();
                getproductdetails.productname = dr["ProductName"].ToString();
                getproductdetails.productid = dr["product_sno"].ToString();
                getproductdetails.uim = dr["Units"].ToString();
                getproductdetails.price = dr["unitprice"].ToString();
                ProductDetails.Add(getproductdetails);
            }
            string response = GetJson(ProductDetails);
            context.Response.Write(response);
        }
    }
    class orderdetail
    {
        public string SNo { set; get; }
        public string Product { set; get; }
        public string Productsno { set; get; }
        public string Qty { set; get; }
        public string Rate { set; get; }
        public string Total { set; get; }
        public string ReturnQty { set; get; }
        public string ExtraQty { set; get; }
        public string Status { set; get; }
        public string Unitsqty { set; get; }
        public string UnitCost { set; get; }
        public string IndentNo { set; get; }
        public string hdnSno { set; get; }
        public string orderunitRate { set; get; }
        public string HdnIndentSno { set; get; }
        public string LeakQty { set; get; }
        public string RtnQty { set; get; }
        public string RemainQty { set; get; }
        public string ShortQty { set; get; }
        public string FreeMilk { set; get; }
        public string productname { set; get; }
        public string agentid { set; get; }
        public string uim { get; set; }
    }
    class Inventorydetail
    {
        public string SNo { set; get; }
        public string InvSno { set; get; }
        public string GivenQty { set; get; }
        public string ReceivedQty { set; get; }
        public string BalanceQty { set; get; }
        public string TransQty { set; get; }
    }
    class InvDatails
    {
        public string SNo { set; get; }
        public string Qty { set; get; }
        public string TripID { set; get; }
    }
    class Leakagedetail
    {
        public string SNo { set; get; }
        public string ProductID { set; get; }
        public string LeakageQty { set; get; }
        public string DeductionAmount { set; get; }
    }
    class RouteLeakdetails
    {
        public string SNo { set; get; }
        public string ProductID { set; get; }
        public string LeaksQty { set; get; }
        public string ReturnsQty { set; get; }
        public string TripID { set; get; }
    }
    class Orders
    {
        public string op { set; get; }
        public string BranchID { set; get; }
        public List<orderdetail> data { set; get; }
        public List<orderdetail> offerdata { set; get; }
        public List<Inventorydetail> Inventorydetails { set; get; }
        public List<Leakagedetail> Leakagedetails { set; get; }
        public List<RouteLeakdetails> RouteLeakdetails { set; get; }
        public List<InvDatails> InvDatails { set; get; }
        public string totqty { set; get; }
        public string totrate { set; get; }
        public string totTotal { set; get; }
        public string Status { set; get; }
        public string IndentNo { set; get; }
        public string TotalPrice { set; get; }
        public string BalanceAmount { set; get; }
        public string PaidAmount { set; get; }
        public string TotalCost { set; get; }
        public string Remarks { set; get; }
        public string PaymentType { set; get; }
        public string Denominations { set; get; }
        public string ColAmount { set; get; }
        public string SubAmount { set; get; }
        public string IndentType { set; get; }
        public string EmpName { set; get; }
        public string RouteId { set; get; }
        public string SaveType { set; get; }
        public string DispDate { set; get; }
        public string Mode { set; get; }
        public string DispSno { set; get; }
    }

    private void ValidateLogin(HttpContext context)
    {
        string msg = "Success";
        string status = "0";
        try
        {
            DBManagerSales vdm = new DBManagerSales();
            MySqlCommand cmd;
            DataTable dt = new DataTable();
            String UserName = "Indent_kmm";// txtUserName.Text, 
            String PassWord = "123"; //txtPassword.Text;
            string dispatchpassword = "0";
            cmd = new MySqlCommand("select * from empmanage where UserName=@UN and Password=@Pwd and flag=@flag");
            cmd.Parameters.Add("@UN", UserName);
            cmd.Parameters.Add("@Pwd", PassWord);
            cmd.Parameters.Add("@flag", "1");
            DataTable dtemp = vdm.SelectQuery(cmd).Tables[0];
            if (dtemp.Rows.Count > 0)
            {
                context.Session["logingname"] = UserName;
                context.Session["PWD"] = PassWord;
                string LevelType = dtemp.Rows[0]["LevelType"].ToString();
                cmd = new MySqlCommand("SELECT Sno, EmpId, AssignDate, Status, DispatcherID,Password FROM tripdata WHERE (DispatcherID = @EmpId) AND (Status = 'A')");
                cmd.Parameters.Add("@EmpId", dtemp.Rows[0]["Sno"].ToString());
                DataTable dtdispAssign = vdm.SelectQuery(cmd).Tables[0];
                if (dtdispAssign.Rows.Count > 0)
                {
                    LevelType = "SODispatcher";
                    status = "1";
                    dispatchpassword = dtdispAssign.Rows[0]["Password"].ToString();
                }
                if (PassWord != dispatchpassword)
                {
                    if (LevelType == "Dispatcher" || LevelType == "SODispatcher")
                    {
                        if (status == "1")
                        {
                            cmd = new MySqlCommand("SELECT branchroutes.BranchID, tripdata.Sno,tripdata.I_Date,triproutes.RouteID,dispatch_sub.IndentType,dispatch.Disptype FROM  tripdata INNER JOIN triproutes ON tripdata.Sno = triproutes.Tripdata_sno INNER JOIN dispatch ON triproutes.RouteID = dispatch.sno INNER JOIN dispatch_sub ON dispatch.sno = dispatch_sub.dispatch_sno INNER JOIN branchroutes ON dispatch_sub.Route_id = branchroutes.Sno WHERE (tripdata.Status = 'A') AND (tripdata.DispatcherID = @EmpId)GROUP BY dispatch.DispName");
                            cmd.Parameters.Add("@EmpId", dtemp.Rows[0]["Sno"].ToString());
                            dt = vdm.SelectQuery(cmd).Tables[0];
                        }
                        if (status == "0")
                        {
                            cmd = new MySqlCommand("SELECT  T1.Sno, T1.I_Date, T1.dispsno, t2.BranchID, t2.IndentType, T1.DispType,T1.RouteID FROM (SELECT tripdata.Sno, tripdata.I_Date, triproutes.RouteID,dispatch.sno AS dispsno, dispatch.DispType FROM tripdata INNER JOIN triproutes ON tripdata.Sno = triproutes.Tripdata_sno INNER JOIN dispatch ON triproutes.RouteID = dispatch.sno WHERE (tripdata.EmpId = @empid) AND (tripdata.Status = 'A') GROUP BY dispatch.DispName) T1 INNER JOIN (SELECT  dispatch_sub.dispatch_sno, branchroutes.BranchID, dispatch_sub.IndentType FROM dispatch_sub INNER JOIN branchroutes ON dispatch_sub.Route_id = branchroutes.Sno) t2 ON t2.dispatch_sno = T1.dispsno GROUP BY T1.dispsno");
                            //cmd = new MySqlCommand("SELECT branchroutes.BranchID, tripdata.Sno, tripdata.I_Date, triproutes.RouteID, dispatch_sub.IndentType, dispatch.DispType FROM tripdata INNER JOIN triproutes ON tripdata.Sno = triproutes.Tripdata_sno INNER JOIN dispatch ON triproutes.RouteID = dispatch.sno INNER JOIN dispatch_sub ON dispatch.sno = dispatch_sub.dispatch_sno INNER JOIN branchroutes ON dispatch_sub.Route_id = branchroutes.Sno WHERE (tripdata.Status = 'A') AND (tripdata.EmpId = @EmpId) GROUP BY dispatch.DispName");
                            cmd.Parameters.Add("@EmpId", dtemp.Rows[0]["Sno"].ToString());
                            dt = vdm.SelectQuery(cmd).Tables[0];
                        }
                        if (dt.Rows.Count > 0)
                        {
                            context.Session["UserName"] = "";
                            context.Session["userdata_sno"] = dtemp.Rows[0]["UserData_sno"].ToString();
                            context.Session["UserSno"] = dtemp.Rows[0]["Sno"].ToString(); ;
                            context.Session["count"] = "";
                            context.Session["routearray"] = "";
                            context.Session["RouteId"] = dt.Rows[0]["RouteID"].ToString();
                            context.Session["TripdataSno"] = dt.Rows[0]["Sno"].ToString();
                            context.Session["TripID"] = dt.Rows[0]["Sno"].ToString();
                            context.Session["Permissions"] = "";
                            context.Session["Salestype"] = "Plant";
                            context.Session["BranchSno"] = "";
                            if (status == "0")
                            {
                                context.Session["LevelType"] = dtemp.Rows[0]["LevelType"].ToString();
                                context.Session["Permissions"] = dtemp.Rows[0]["LevelType"].ToString();
                            }
                            if (status == "1")
                            {
                                context.Session["LevelType"] = "SODispatcher";
                                context.Session["Permissions"] = "SODispatcher";
                            }
                            context.Session["PlantEmpId"] = dtemp.Rows[0]["Sno"].ToString();
                            context.Session["PlantDispSno"] = dt.Rows[0]["Sno"].ToString();
                            context.Session["DispDate"] = dt.Rows[0]["I_Date"].ToString();
                            context.Session["I_Date"] = dt.Rows[0]["I_Date"].ToString();
                            context.Session["userdata_sno"] = dtemp.Rows[0]["UserData_sno"].ToString();
                            context.Session["UserName"] = dtemp.Rows[0]["UserName"].ToString();
                            context.Session["CsoNo"] = dtemp.Rows[0]["Branch"].ToString();
                            context.Session["IndentType"] = dt.Rows[0]["IndentType"].ToString();
                            context.Session["DispType"] = dt.Rows[0]["Disptype"].ToString();
                        }
                        else
                        {
                            msg = "Trip Not Assigned on this UserName";
                        }
                    }
                    else
                    {
                        //  cmd = new MySqlCommand("SELECT  tripdata.Status, tripdata.AssignDate, tripdata.ATripid, tripdata.I_Date, tripdata.Sno, tripdata.Permissions, tripdata.EmpId, empmanage.Sno AS EmpSno, dispatch.DispType, empmanage.UserName,branchdata.sno AS BranchSno, empmanage.Userdata_sno, empmanage.LevelType, empmanage.Branch, salestypemanagement.salestype, triproutes.RouteID FROM tripdata INNER JOIN triproutes ON tripdata.Sno = triproutes.Tripdata_sno INNER JOIN empmanage ON tripdata.EmpId = empmanage.Sno INNER JOIN branchdata ON empmanage.Branch = branchdata.sno INNER JOIN salestypemanagement ON branchdata.SalesType = salestypemanagement.sno INNER JOIN dispatch ON triproutes.RouteID = dispatch.sno WHERE (tripdata.Status = 'A') AND (empmanage.UserName = @UN) AND (empmanage.Password = @Pwd)");
                        cmd = new MySqlCommand("SELECT tripdata.Status, tripdata.AssignDate,tripdata.ATripId, tripdata.I_Date, tripdata.Sno,  tripdata.Permissions, tripdata.EmpId, empmanage.Sno AS EmpSno,dispatch.DispType, empmanage.UserName, branchdata.sno AS BranchSno, empmanage.Userdata_sno, empmanage.LevelType, empmanage.Branch, salestypemanagement.salestype, triproutes.RouteID, dispatch_sub.IndentType FROM  tripdata INNER JOIN triproutes ON tripdata.Sno = triproutes.Tripdata_sno INNER JOIN empmanage ON tripdata.EmpId = empmanage.Sno INNER JOIN branchdata ON empmanage.Branch = branchdata.sno INNER JOIN salestypemanagement ON branchdata.SalesType = salestypemanagement.sno INNER JOIN dispatch ON triproutes.RouteID = dispatch.sno INNER JOIN dispatch_sub ON dispatch.sno = dispatch_sub.dispatch_sno WHERE (tripdata.Status = 'A') AND (empmanage.UserName = @UN) AND (empmanage.Password = @Pwd)");
                        cmd.Parameters.Add("@UN", UserName);
                        cmd.Parameters.Add("@Pwd", PassWord);
                        dt = vdm.SelectQuery(cmd).Tables[0];
                        if (dt.Rows.Count > 0)
                        {
                            string Permissions = dt.Rows[0]["Permissions"].ToString();
                            if (Permissions == "D;C")
                            {
                                msg = "Sorry,Please Login Offline Application C.vyshnavi.net";
                            }
                            else
                            {
                                context.Session["UserName"] = dt.Rows[0]["UserName"].ToString();
                                context.Session["userdata_sno"] = dt.Rows[0]["UserData_sno"].ToString();
                                context.Session["UserSno"] = dt.Rows[0]["EmpSno"].ToString();
                                context.Session["LevelType"] = dt.Rows[0]["LevelType"].ToString();
                                context.Session["AssignDate"] = dt.Rows[0]["AssignDate"].ToString();
                                context.Session["I_Date"] = dt.Rows[0]["I_Date"].ToString();
                                int count = 0;
                                string Routes = "";
                                string[] routearray = new String[0] { };
                                foreach (DataRow dr in dt.Rows)
                                {
                                    if (dt.Rows.Count > 1)
                                    {
                                        string RouteId = dr["RouteId"].ToString();
                                        if (RouteId != "")
                                        {
                                            Routes += dr["RouteId"].ToString() + "@";
                                            count++;
                                        }
                                    }
                                }
                                routearray = Routes.Split('@');
                                context.Session["count"] = count;
                                context.Session["routearray"] = routearray;
                                context.Session["RouteId"] = dt.Rows[0]["RouteId"].ToString();
                                context.Session["TripdataSno"] = dt.Rows[0]["Sno"].ToString();
                                context.Session["TripID"] = dt.Rows[0]["Sno"].ToString();
                                context.Session["Permissions"] = dt.Rows[0]["Permissions"].ToString();
                                context.Session["Salestype"] = dt.Rows[0]["salestype"].ToString();
                                context.Session["BranchSno"] = dt.Rows[0]["BranchSno"].ToString();
                                context.Session["CsoNo"] = dt.Rows[0]["BranchSno"].ToString();
                                //context.Session["IndentType"] = "Indent1"; //dt.Rows[0]["IndentType"].ToString();
                                context.Session["IndentType"] = dt.Rows[0]["IndentType"].ToString(); ; //dt.Rows[0]["IndentType"].ToString();

                                context.Session["DispType"] = dt.Rows[0]["DispType"].ToString();
                                context.Session["ATripId"] = dt.Rows[0]["ATripId"].ToString();
                            }
                        }
                        else
                        {
                            msg = "Trip Not Assigned on this UserName";
                        }
                    }
                }
                if (PassWord == dispatchpassword)
                {
                    msg = "Change Password";
                }
            }
            else
            {
                msg = "Invalid UserName and Password";
            }
        }
        catch (Exception ex)
        {
            msg = ex.Message;
        }
        string errresponse = GetJson(msg);
        context.Response.Write(errresponse);
    }

    private void btnOrderSaveClick(HttpContext context)
    {
        try
        {
            DBManagerSales vdbmngr = new DBManagerSales();
            MySqlCommand cmd;
            var js = new JavaScriptSerializer();
            List<string> MsgList = new List<string>();
            if (context.Session["Employ_Sno"] == null)
            {
                string errmsg = "Session Expired";
                string errresponse = GetJson(errmsg);
                context.Response.Write(errresponse);
            }
            else
            {
                string Username = context.Session["userdata_sno"].ToString();
                DateTime ServerDateCurrentdate = DBManagerSales.GetTime(vdbmngr.conn);
                ServerDateCurrentdate = ServerDateCurrentdate.AddDays(10);
                var title1 = context.Request.Params[1];
                Orders obj = js.Deserialize<Orders>(title1);
                string b_bid = obj.BranchID;
                string IndentType = "khammam3";
                if (IndentType == "")
                {
                    IndentType = context.Session["IndentType"].ToString();
                }
                if (IndentType == "")
                {
                    IndentType = "Indent1";
                }
                if (IndentType == null)
                {
                    IndentType = "Indent1";
                }
                cmd = new MySqlCommand("select BranchName,phonenumber,sno from BranchData where Sno=@sno");
                cmd.Parameters.Add("@sno", b_bid);
                DataTable dtBranchName = vdbmngr.SelectQuery(cmd).Tables[0];
                string BranchName = dtBranchName.Rows[0]["BranchName"].ToString();
                string phonenumber = dtBranchName.Rows[0]["phonenumber"].ToString();

                int BranchID = 0;
                int.TryParse(b_bid, out BranchID);
                float Qty = 0;
                float.TryParse(obj.totqty, out Qty);
                float Price = 0;
                float.TryParse(obj.totTotal, out Price);
                float TotalPrice = 0;
                float.TryParse(obj.TotalPrice, out TotalPrice);
                DataTable dtorders = new DataTable();
                if (context.Session["Orders"] == null)
                {
                    cmd = new MySqlCommand("SELECT productsdata.ProductName,indents_subtable.unitQty,indents_subtable.unitCost, productsdata.sno, indents_subtable.unitQty * indents_subtable.UnitCost AS Total, indents.IndentNo, productsdata.Qty AS RawQty , productsdata.Units FROM indents INNER JOIN indents_subtable ON indents.IndentNo = indents_subtable.IndentNo INNER JOIN productsdata ON indents_subtable.Product_sno = productsdata.sno WHERE (indents.Branch_id = @bsno)  and (indents.IndentType = @IndentType) AND (indents.UserData_sno = @UserName) AND (indents.I_date between @d1 AND  @d2)");
                    cmd.Parameters.Add("@d1", GetLowDate(ServerDateCurrentdate));
                    cmd.Parameters.Add("@d2", GetHighDate(ServerDateCurrentdate));
                    cmd.Parameters.Add("@UserName", Username);
                    cmd.Parameters.Add("@IndentType", IndentType);
                    cmd.Parameters.Add("@bsno", b_bid);
                    dtorders = vdbmngr.SelectQuery(cmd).Tables[0];
                    context.Session["Orders"] = dtorders;
                }
                else
                {
                    dtorders = (DataTable)context.Session["Orders"];
                }
                DataRow[] drOrders;
                string hdnIndentNo = obj.IndentNo;

                cmd = new MySqlCommand("select IndentNo from Indents where Branch_id=@Branch_id AND (indents.I_date between @d1 AND  @d2) and (indents.IndentType = @IndentType)");
                cmd.Parameters.Add("@Branch_id", BranchID);
                cmd.Parameters.Add("@IndentType", IndentType);
                cmd.Parameters.Add("@d1", GetLowDate(ServerDateCurrentdate));
                cmd.Parameters.Add("@d2", GetHighDate(ServerDateCurrentdate));
                DataTable dtIndent = vdbmngr.SelectQuery(cmd).Tables[0];

                cmd = new MySqlCommand("SELECT idoffer_indents, idoffers_assignment, salesoffice_id, route_id, agent_id, indent_date, indents_id, IndentType FROM offer_indents WHERE (agent_id = @Branch_id) AND (IndentType = @IndentType) AND (indent_date BETWEEN @d1 AND @d2)");
                cmd.Parameters.Add("@Branch_id", BranchID);
                cmd.Parameters.Add("@IndentType", IndentType);
                cmd.Parameters.Add("@d1", GetLowDate(ServerDateCurrentdate));
                cmd.Parameters.Add("@d2", GetHighDate(ServerDateCurrentdate));
                DataTable dt_offerIndent = vdbmngr.SelectQuery(cmd).Tables[0];

                string ProductName = "";
                string OfferProductName = "OFFER PRODUCTS\r\n";
                double TotalQty = 0;
                double OfferTotalQty = 0;
                foreach (orderdetail o in obj.data)
                {
                    if (o.Unitsqty != "0")
                    {
                        float UnitQty = 0;
                        float.TryParse(o.Unitsqty, out UnitQty);
                        ProductName += o.Product + "=" + Math.Round(UnitQty, 2) + ";\r\n";
                        TotalQty += Math.Round(UnitQty, 2);
                    }
                }
                foreach (orderdetail o in obj.offerdata)
                {
                    if (o.Unitsqty != "0")
                    {
                        float UnitQty = 0;
                        float.TryParse(o.Unitsqty, out UnitQty);
                        OfferProductName += o.Product + "=" + Math.Round(UnitQty, 2) + ";\r\n";
                        OfferTotalQty += Math.Round(UnitQty, 2);
                    }
                }
                if (dtIndent.Rows.Count > 0)
                {
                    string BranchIndentNo = dtIndent.Rows[0]["IndentNo"].ToString();

                    if (BranchIndentNo != "")
                    {
                        cmd = new MySqlCommand("Update indents set I_date=@I_date, UserData_sno=@UserData_sno, Status=@Status,I_modifiedby=@I_modifiedby where Branch_id=@Branch_id and IndentNo=@IndentNo");
                        cmd.Parameters.Add("@Branch_id", BranchID);
                        cmd.Parameters.Add("@I_date", ServerDateCurrentdate);
                        cmd.Parameters.Add("@UserData_sno", Username);
                        cmd.Parameters.Add("@Status", "O");
                        cmd.Parameters.Add("@I_modifiedby", context.Session["UserSno"].ToString());
                        cmd.Parameters.Add("@IndentNo", BranchIndentNo);
                        vdbmngr.Update(cmd);
                        foreach (orderdetail o in obj.data)
                        {
                            cmd = new MySqlCommand("Update indents_subtable set unitQty=@unitQty,OTripId=@OTripId,UnitCost=@UnitCost,Status=@Status where IndentNo=@IndentNo and Product_sno=@Product_sno");
                            cmd.Parameters.Add("@IndentNo", BranchIndentNo);
                            cmd.Parameters.Add("@Product_sno", o.Productsno);
                            double UnitCost = 0;
                            double.TryParse(o.UnitCost, out UnitCost);
                            UnitCost = Math.Round(UnitCost, 2);
                            cmd.Parameters.Add("@UnitCost", UnitCost);
                            double unitQty = 0;
                            double.TryParse(o.Unitsqty, out unitQty);
                            unitQty = Math.Round(unitQty, 2);
                            cmd.Parameters.Add("@unitQty", unitQty);
                            cmd.Parameters.Add("@Status", "Ordered");
                            cmd.Parameters.Add("@OTripId", context.Session["TripdataSno"].ToString());
                            if (vdbmngr.Update(cmd) == 0)
                            {
                                cmd = new MySqlCommand("insert into indents_subtable (IndentNo,Product_sno,Status,unitQty,UnitCost,OTripId)values(@IndentNo,@Product_sno,@Status,@unitQty,@UnitCost,@OTripId)");
                                cmd.Parameters.Add("@IndentNo", BranchIndentNo);
                                cmd.Parameters.Add("@Product_sno", o.Productsno);
                                cmd.Parameters.Add("@UnitCost", UnitCost);
                                cmd.Parameters.Add("@unitQty", unitQty);
                                cmd.Parameters.Add("@Status", "Ordered");
                                cmd.Parameters.Add("@OTripId", context.Session["TripdataSno"].ToString());
                                if (unitQty != 0.0)
                                {
                                    vdbmngr.insert(cmd);
                                }
                            }
                            foreach (DataRow dr in dtorders.Rows)
                            {
                                string Prodsno = dr["sno"].ToString();
                                string Psno = o.Productsno;
                                if (Prodsno == Psno)
                                {
                                    cmd = new MySqlCommand("Update  EditedIndents set Prodsno=@Prodsno,EntryTime=@EntryTime,ActualQty=@ActualQty,EditQty=@EditQty where BranchID=@BranchID and IndentNo=@IndentNo");
                                    cmd.Parameters.Add("@IndentNo", BranchIndentNo);
                                    cmd.Parameters.Add("@Prodsno", o.Productsno);
                                    cmd.Parameters.Add("@BranchID", b_bid);
                                    cmd.Parameters.Add("@EntryTime", ServerDateCurrentdate);
                                    double Aqty = 0;
                                    double.TryParse(dr["unitQty"].ToString(), out Aqty);
                                    Aqty = Math.Round(Aqty, 2);
                                    cmd.Parameters.Add("@ActualQty", Aqty);
                                    double Eqty = 0;
                                    double.TryParse(o.ReturnQty, out Eqty);
                                    Eqty = Math.Round(Eqty, 2);
                                    cmd.Parameters.Add("@EditQty", Eqty);
                                    if (vdbmngr.Update(cmd) == 0)
                                    {
                                        cmd = new MySqlCommand("insert into EditedIndents (IndentNo,Prodsno,BranchID,EntryTime,ActualQty,EditQty)values(@IndentNo,@Prodsno,@BranchID,@EntryTime,@ActualQty,@EditQty)");
                                        cmd.Parameters.Add("@IndentNo", BranchIndentNo);
                                        cmd.Parameters.Add("@Prodsno", o.Productsno);
                                        cmd.Parameters.Add("@BranchID", b_bid);
                                        cmd.Parameters.Add("@EntryTime", ServerDateCurrentdate);
                                        cmd.Parameters.Add("@ActualQty", Aqty);
                                        cmd.Parameters.Add("@EditQty", Eqty);
                                        vdbmngr.insert(cmd);
                                    }
                                }
                            }
                        }
                        if (dt_offerIndent.Rows.Count > 0)
                        {
                            string offerIndentNo = dt_offerIndent.Rows[0]["idoffer_indents"].ToString();
                            if (offerIndentNo != "")
                            {
                                cmd = new MySqlCommand("UPDATE offer_indents SET indent_date = @indent_date, indents_id = @indents_id, I_modified_by = @I_modified_by WHERE (idoffer_indents = @idoffer_indents) AND (agent_id=@Branch_id)");
                                cmd.Parameters.Add("@indent_date", ServerDateCurrentdate);
                                cmd.Parameters.Add("@Branch_id", BranchID);

                                cmd.Parameters.Add("@indents_id", BranchIndentNo);
                                cmd.Parameters.Add("@I_modified_by", context.Session["UserSno"].ToString());
                                cmd.Parameters.Add("@idoffer_indents", offerIndentNo);
                                vdbmngr.Update(cmd);
                                foreach (orderdetail o in obj.offerdata)
                                {
                                    if (o.Productsno != null)
                                    {
                                        double unitQty = 0;
                                        double.TryParse(o.Unitsqty, out unitQty);
                                        unitQty = Math.Round(unitQty, 2);
                                        cmd = new MySqlCommand("UPDATE offer_indents_sub SET offer_indent_qty = @offer_indent_qty WHERE (idoffer_indents = @idoffer_indents) AND (product_id = @product_id)");
                                        cmd.Parameters.Add("@offer_indent_qty", unitQty);
                                        cmd.Parameters.Add("@idoffer_indents", offerIndentNo);
                                        cmd.Parameters.Add("@product_id", o.Productsno);
                                        if (vdbmngr.Update(cmd) == 0)
                                        {
                                            double UnitCost = 0;
                                            double.TryParse(o.UnitCost, out UnitCost);
                                            UnitCost = Math.Round(UnitCost, 2);

                                            cmd = new MySqlCommand("INSERT INTO offer_indents_sub (idoffer_indents, product_id, unit_price, offer_indent_qty, offer_delivered_qty) VALUES (@idoffer_indents, @product_id, @unit_price, @offer_indent_qty, @offer_delivered_qty)");
                                            cmd.Parameters.Add("idoffer_indents", offerIndentNo);
                                            cmd.Parameters.Add("product_id", o.Productsno);
                                            //cmd.Parameters.Add("unit_price", UnitCost);
                                            cmd.Parameters.Add("unit_price", UnitCost);
                                            cmd.Parameters.Add("offer_indent_qty", unitQty);
                                            cmd.Parameters.Add("offer_delivered_qty", "0");
                                            if (unitQty != 0.0)
                                            {
                                                vdbmngr.insert(cmd);
                                            }
                                        }
                                    }
                                }
                            }

                        }
                        else
                        {
                            cmd = new MySqlCommand("SELECT offers_assignment.idoffers_assignment, offers_assignment.offers_assignment_name, offers_assignment.offer_type, offers_assignment.offer_from, offers_assignment.offer_to, offers_assignment.created_date, offers_assignment.created_by, offers_assignment.status, offers_assignment_sub.id_offers, offers_sub.product_id, offers_sub.offer_product_id, offers_sub.qty_if_above, offers_sub.offer_qty, offers_sub.present_price FROM offers_assignment INNER JOIN offers_assignment_sub ON offers_assignment.idoffers_assignment = offers_assignment_sub.idoffers_assignment INNER JOIN offers_sub ON offers_assignment_sub.id_offers = offers_sub.idoffers WHERE (offers_assignment.status = 1) AND (offers_assignment.offer_from = @d1) AND (offers_assignment.salesoffice_id = @soid) OR (offers_assignment.status = 1) AND (offers_assignment.offer_to >= @d1) AND (offers_assignment.salesoffice_id = @soid)");
                            cmd.Parameters.Add("@d1", GetLowDate(ServerDateCurrentdate));
                            cmd.Parameters.Add("@soid", context.Session["CsoNo"].ToString());
                            DataTable dtoffers = vdbmngr.SelectQuery(cmd).Tables[0];
                            DataView view = new DataView(dtoffers);
                            DataTable distincttable = view.ToTable(true, "idoffers_assignment", "offers_assignment_name");
                            string idoffers_assignment = "0";
                            long offer_indent_no = 0;
                            if (dtoffers.Rows.Count > 0)
                            {

                                idoffers_assignment = distincttable.Rows[0]["idoffers_assignment"].ToString();

                                cmd = new MySqlCommand("INSERT INTO offer_indents (idoffers_assignment, salesoffice_id, agent_id, indent_date, indents_id,IndentType) VALUES (@idoffers_assignment, @salesoffice_id, @agent_id, @indent_date, @indents_id,@IndentType)");
                                cmd.Parameters.Add("@idoffers_assignment", idoffers_assignment);
                                cmd.Parameters.Add("@salesoffice_id", context.Session["CsoNo"].ToString());
                                cmd.Parameters.Add("@agent_id", BranchID);
                                cmd.Parameters.Add("@indent_date", ServerDateCurrentdate);
                                cmd.Parameters.Add("@IndentType", IndentType);

                                cmd.Parameters.Add("@indents_id", BranchIndentNo);
                                long offerindentno = vdbmngr.insertScalar(cmd);
                                offer_indent_no = offerindentno;

                                #region offer_indent
                                foreach (orderdetail o in obj.offerdata)
                                {
                                    if (o.Productsno != null)
                                    {
                                        double unitQty = 0;
                                        double.TryParse(o.Unitsqty, out unitQty);
                                        unitQty = Math.Round(unitQty, 2);
                                        //cmd = new MySqlCommand("UPDATE offer_indents_sub SET offer_indent_qty = offer_indent_qty + @offer_indent_qty WHERE (idoffer_indents = @idoffer_indents) AND (product_id = @product_id)");
                                        //cmd.Parameters.Add("@offer_indent_qty", unitQty);
                                        //cmd.Parameters.Add("@idoffer_indents", offer_indent_no);
                                        //cmd.Parameters.Add("@product_id", o.Productsno);
                                        //if (vdm.Update(cmd) == 0)
                                        //{
                                        double UnitCost = 0;
                                        double.TryParse(o.UnitCost, out UnitCost);
                                        UnitCost = Math.Round(UnitCost, 2);

                                        cmd = new MySqlCommand("INSERT INTO offer_indents_sub (idoffer_indents, product_id, unit_price, offer_indent_qty, offer_delivered_qty) VALUES (@idoffer_indents, @product_id, @unit_price, @offer_indent_qty, @offer_delivered_qty)");
                                        cmd.Parameters.Add("idoffer_indents", offer_indent_no);
                                        cmd.Parameters.Add("product_id", o.Productsno);
                                        //cmd.Parameters.Add("unit_price", UnitCost);
                                        cmd.Parameters.Add("unit_price", UnitCost);
                                        cmd.Parameters.Add("offer_indent_qty", unitQty);
                                        cmd.Parameters.Add("offer_delivered_qty", "0");
                                        if (unitQty != 0.0)
                                        {
                                            vdbmngr.insert(cmd);
                                        }
                                        //}
                                    }
                                }

                                #endregion

                            }

                        }
                        cmd = new MySqlCommand("Update Indents set PaymentStatus=@PamentStatus where IndentNo=@IndentNo");
                        cmd.Parameters.Add("@PamentStatus", 'A');
                        cmd.Parameters.Add("@IndentNo", hdnIndentNo);
                        vdbmngr.Update(cmd);


                    }
                    else
                    {
                        cmd = new MySqlCommand("insert into indents (Branch_id,TotalQty,TotalPrice,I_date,UserData_sno,Status,PaymentStatus,I_createdby,IndentType)values(@Branch_id,@TotalQty,@TotalPrice,@I_date,@UserData_sno,@Status,@PaymentStatus,@I_createdby,@IndentType)");
                        cmd.Parameters.Add("@Branch_id", BranchID);
                        cmd.Parameters.Add("@TotalQty", Qty);
                        cmd.Parameters.Add("@TotalPrice", Price);
                        cmd.Parameters.Add("@I_date", ServerDateCurrentdate);
                        cmd.Parameters.Add("@UserData_sno", Username);
                        cmd.Parameters.Add("@Status", "O");
                        cmd.Parameters.Add("@PaymentStatus", 'A');
                        cmd.Parameters.Add("@IndentType", IndentType);
                        long IndentNo = vdbmngr.insertScalar(cmd);

                        //cmd = new MySqlCommand("SELECT offers_assignment.idoffers_assignment, offers_assignment.offers_assignment_name, offers_assignment.offer_type, offers_assignment.offer_from,offers_assignment.offer_to, offers_assignment.created_date, offers_assignment.created_by, offers_assignment.status, offers_assignment_sub.id_offers, offers_sub.product_id, offers_sub.offer_product_id, offers_sub.qty_if_above, offers_sub.offer_qty, offers_sub.present_price FROM offers_assignment INNER JOIN offers_assignment_sub ON offers_assignment.idoffers_assignment = offers_assignment_sub.idoffers_assignment INNER JOIN offers_sub ON offers_assignment_sub.id_offers = offers_sub.idoffers WHERE (offers_assignment.status = 1) AND (offers_assignment.offer_from >= @d1) OR (offers_assignment.status = 1) AND (offers_assignment.offer_to <= @d1)");
                        //cmd.Parameters.Add("@d1", DateConverter.GetLowDate(ServerDateCurrentdate));
                        //DataTable dtoffers = vdm.SelectQuery(cmd).Tables[0];

                        cmd = new MySqlCommand("SELECT offers_assignment.idoffers_assignment, offers_assignment.offers_assignment_name, offers_assignment.offer_type, offers_assignment.offer_from, offers_assignment.offer_to, offers_assignment.created_date, offers_assignment.created_by, offers_assignment.status, offers_assignment_sub.id_offers, offers_sub.product_id, offers_sub.offer_product_id, offers_sub.qty_if_above, offers_sub.offer_qty, offers_sub.present_price FROM offers_assignment INNER JOIN offers_assignment_sub ON offers_assignment.idoffers_assignment = offers_assignment_sub.idoffers_assignment INNER JOIN offers_sub ON offers_assignment_sub.id_offers = offers_sub.idoffers WHERE (offers_assignment.status = 1) AND (offers_assignment.salesoffice_id=@bsno) AND (offers_assignment.offer_from <= @d1) AND (offers_assignment.offer_to >= @d1) GROUP BY offers_sub.offer_product_id");
                        cmd.Parameters.Add("@d1", GetLowDate(ServerDateCurrentdate));
                        cmd.Parameters.Add("@bsno", context.Session["CsoNo"].ToString());
                        DataTable dtoffers = vdbmngr.SelectQuery(cmd).Tables[0];
                        DataView view = new DataView(dtoffers);
                        DataTable distincttable = view.ToTable(true, "idoffers_assignment", "offers_assignment_name");
                        DataTable distincttable1 = view.ToTable(true, "id_offers", "product_id", "offer_product_id", "qty_if_above", "offer_qty");
                        //DataTable distincttable2 = view.ToTable(true, "idoffers_assignment", "offers_assignment_name");
                        string idoffers_assignment = "0";
                        long offer_indent_no = 0;
                        if (dtoffers.Rows.Count > 0)
                        {

                            idoffers_assignment = distincttable.Rows[0]["idoffers_assignment"].ToString();

                            cmd = new MySqlCommand("INSERT INTO offer_indents (idoffers_assignment, salesoffice_id, agent_id, indent_date, indents_id,IndentType) VALUES (@idoffers_assignment, @salesoffice_id, @agent_id, @indent_date, @indents_id,@IndentType)");
                            cmd.Parameters.Add("@idoffers_assignment", idoffers_assignment);
                            cmd.Parameters.Add("@salesoffice_id", context.Session["CsoNo"].ToString());
                            cmd.Parameters.Add("@agent_id", BranchID);
                            cmd.Parameters.Add("@indent_date", ServerDateCurrentdate);
                            cmd.Parameters.Add("@indents_id", IndentNo);
                            cmd.Parameters.Add("@IndentType", IndentType);
                            long offerindentno = vdbmngr.insertScalar(cmd);
                            offer_indent_no = offerindentno;
                        }




                        foreach (orderdetail o in obj.data)
                        {
                            if (o.Productsno != null)
                            {
                                cmd = new MySqlCommand("insert into indents_subtable (IndentNo,Product_sno,Status,unitQty,UnitCost,OTripId)values(@IndentNo,@Product_sno,@Status,@unitQty,@UnitCost,@OTripId)");
                                cmd.Parameters.Add("@IndentNo", IndentNo);
                                cmd.Parameters.Add("@Product_sno", o.Productsno);
                                double UnitCost = 0;
                                double.TryParse(o.UnitCost, out UnitCost);
                                UnitCost = Math.Round(UnitCost, 2);
                                cmd.Parameters.Add("@UnitCost", UnitCost);
                                double unitQty = 0;
                                double.TryParse(o.Unitsqty, out unitQty);
                                unitQty = Math.Round(unitQty, 2);
                                cmd.Parameters.Add("@unitQty", unitQty);
                                cmd.Parameters.Add("@Status", "Ordered");
                                cmd.Parameters.Add("@OTripId", context.Session["TripdataSno"].ToString());
                                if (unitQty != 0.0)
                                {
                                    vdbmngr.insert(cmd);
                                }


                            }
                        }
                        #region offer_indent
                        foreach (orderdetail o in obj.offerdata)
                        {
                            if (o.Productsno != null)
                            {
                                double unitQty = 0;
                                double.TryParse(o.Unitsqty, out unitQty);
                                unitQty = Math.Round(unitQty, 2);
                                //cmd = new MySqlCommand("UPDATE offer_indents_sub SET offer_indent_qty = offer_indent_qty + @offer_indent_qty WHERE (idoffer_indents = @idoffer_indents) AND (product_id = @product_id)");
                                //cmd.Parameters.Add("@offer_indent_qty", unitQty);
                                //cmd.Parameters.Add("@idoffer_indents", offer_indent_no);
                                //cmd.Parameters.Add("@product_id", o.Productsno);
                                //if (vdm.Update(cmd) == 0)
                                //{
                                double UnitCost = 0;
                                double.TryParse(o.UnitCost, out UnitCost);
                                UnitCost = Math.Round(UnitCost, 2);

                                cmd = new MySqlCommand("INSERT INTO offer_indents_sub (idoffer_indents, product_id, unit_price, offer_indent_qty, offer_delivered_qty) VALUES (@idoffer_indents, @product_id, @unit_price, @offer_indent_qty, @offer_delivered_qty)");
                                cmd.Parameters.Add("idoffer_indents", offer_indent_no);
                                cmd.Parameters.Add("product_id", o.Productsno);
                                //cmd.Parameters.Add("unit_price", UnitCost);
                                cmd.Parameters.Add("unit_price", UnitCost);
                                cmd.Parameters.Add("offer_indent_qty", unitQty);
                                cmd.Parameters.Add("offer_delivered_qty", "0");
                                if (unitQty != 0.0)
                                {
                                    vdbmngr.insert(cmd);
                                }
                                //}
                            }
                        }

                        #endregion
                    }
                }
                else
                {
                    cmd = new MySqlCommand("insert into indents (Branch_id,TotalQty,TotalPrice,I_date,UserData_sno,Status,PaymentStatus,IndentType)values(@Branch_id,@TotalQty,@TotalPrice,@I_date,@UserData_sno,@Status,@PaymentStatus,@IndentType)");
                    cmd.Parameters.Add("@Branch_id", BranchID);
                    cmd.Parameters.Add("@TotalQty", Qty);
                    cmd.Parameters.Add("@TotalPrice", Price);
                    cmd.Parameters.Add("@I_date", ServerDateCurrentdate);
                    cmd.Parameters.Add("@UserData_sno", Username);
                    cmd.Parameters.Add("@Status", "O");
                    cmd.Parameters.Add("@IndentType", IndentType);
                    cmd.Parameters.Add("@PaymentStatus", 'A');
                    long IndentNo = vdbmngr.insertScalar(cmd);

                    cmd = new MySqlCommand("SELECT offers_assignment.idoffers_assignment, offers_assignment.offers_assignment_name, offers_assignment.offer_type, offers_assignment.offer_from, offers_assignment.offer_to, offers_assignment.created_date, offers_assignment.created_by, offers_assignment.status, offers_assignment_sub.id_offers, offers_sub.product_id, offers_sub.offer_product_id, offers_sub.qty_if_above, offers_sub.offer_qty, offers_sub.present_price FROM offers_assignment INNER JOIN offers_assignment_sub ON offers_assignment.idoffers_assignment = offers_assignment_sub.idoffers_assignment INNER JOIN offers_sub ON offers_assignment_sub.id_offers = offers_sub.idoffers WHERE (offers_assignment.status = 1) AND (offers_assignment.offer_from = @d1) AND (offers_assignment.salesoffice_id = @soid) OR (offers_assignment.status = 1) AND (offers_assignment.offer_to >= @d1) AND (offers_assignment.salesoffice_id = @soid)");
                    cmd.Parameters.Add("@d1", GetLowDate(ServerDateCurrentdate));
                    cmd.Parameters.Add("@soid", context.Session["CsoNo"].ToString());
                    DataTable dtoffers = vdbmngr.SelectQuery(cmd).Tables[0];
                    DataView view = new DataView(dtoffers);
                    DataTable distincttable = view.ToTable(true, "idoffers_assignment", "offers_assignment_name");
                    DataTable distincttable1 = view.ToTable(true, "id_offers", "product_id", "offer_product_id", "qty_if_above", "offer_qty");
                    //DataTable distincttable2 = view.ToTable(true, "product_id", "offer_product_id");
                    string idoffers_assignment = "0";
                    long offer_indent_no = 0;
                    if (dtoffers.Rows.Count > 0)
                    {

                        idoffers_assignment = distincttable.Rows[0]["idoffers_assignment"].ToString();

                        cmd = new MySqlCommand("INSERT INTO offer_indents (idoffers_assignment, salesoffice_id, agent_id, indent_date, indents_id,IndentType) VALUES (@idoffers_assignment, @salesoffice_id, @agent_id, @indent_date, @indents_id,@IndentType)");
                        cmd.Parameters.Add("@idoffers_assignment", idoffers_assignment);
                        cmd.Parameters.Add("@salesoffice_id", context.Session["CsoNo"].ToString());
                        cmd.Parameters.Add("@agent_id", BranchID);
                        cmd.Parameters.Add("@indent_date", ServerDateCurrentdate);
                        cmd.Parameters.Add("@IndentType", IndentType);

                        cmd.Parameters.Add("@indents_id", IndentNo);
                        long offerindentno = vdbmngr.insertScalar(cmd);
                        offer_indent_no = offerindentno;

                    }



                    foreach (orderdetail o in obj.data)
                    {
                        if (o.Productsno != null)
                        {
                            cmd = new MySqlCommand("insert into indents_subtable (IndentNo,Product_sno,Status,unitQty,UnitCost,OTripId)values(@IndentNo,@Product_sno,@Status,@unitQty,@UnitCost,@OTripId)");
                            cmd.Parameters.Add("@IndentNo", IndentNo);
                            cmd.Parameters.Add("@Product_sno", o.Productsno);
                            double UnitCost = 0;
                            double.TryParse(o.UnitCost, out UnitCost);
                            UnitCost = Math.Round(UnitCost, 2);
                            cmd.Parameters.Add("@UnitCost", UnitCost);
                            double unitQty = 0;
                            double.TryParse(o.Unitsqty, out unitQty);
                            unitQty = Math.Round(unitQty, 2);
                            cmd.Parameters.Add("@unitQty", unitQty);
                            cmd.Parameters.Add("@Status", "Ordered");
                            cmd.Parameters.Add("@OTripId", context.Session["TripdataSno"].ToString());
                            if (unitQty != 0.0)
                            {
                                vdbmngr.insert(cmd);
                            }
                        }
                    }

                    #region offer_indent
                    foreach (orderdetail o in obj.offerdata)
                    {
                        if (o.Productsno != null)
                        {
                            double unitQty = 0;
                            double.TryParse(o.Unitsqty, out unitQty);
                            unitQty = Math.Round(unitQty, 2);
                            //cmd = new MySqlCommand("UPDATE offer_indents_sub SET offer_indent_qty = offer_indent_qty + @offer_indent_qty WHERE (idoffer_indents = @idoffer_indents) AND (product_id = @product_id)");
                            //cmd.Parameters.Add("@offer_indent_qty", unitQty);
                            //cmd.Parameters.Add("@idoffer_indents", offer_indent_no);
                            //cmd.Parameters.Add("@product_id", o.Productsno);
                            //if (vdm.Update(cmd) == 0)
                            //{
                            double UnitCost = 0;
                            double.TryParse(o.UnitCost, out UnitCost);
                            UnitCost = Math.Round(UnitCost, 2);

                            cmd = new MySqlCommand("INSERT INTO offer_indents_sub (idoffer_indents, product_id, unit_price, offer_indent_qty, offer_delivered_qty) VALUES (@idoffer_indents, @product_id, @unit_price, @offer_indent_qty, @offer_delivered_qty)");
                            cmd.Parameters.Add("idoffer_indents", offer_indent_no);
                            cmd.Parameters.Add("product_id", o.Productsno);
                            //cmd.Parameters.Add("unit_price", UnitCost);
                            cmd.Parameters.Add("unit_price", UnitCost);
                            cmd.Parameters.Add("offer_indent_qty", unitQty);
                            cmd.Parameters.Add("offer_delivered_qty", "0");
                            if (unitQty != 0.0)
                            {
                                vdbmngr.insert(cmd);
                            }
                            //}
                        }
                    }

                    #endregion
                }
                foreach (orderdetail o in obj.data)
                {
                    if (o.Productsno != null)
                    {
                        cmd = new MySqlCommand("Update branchproducts set flag=@flag  where branch_sno=@branch_sno and product_sno=@product_sno");
                        float UnitCost = 0;
                        cmd.Parameters.Add("@flag", true);
                        cmd.Parameters.Add("@branch_sno", BranchID);
                        cmd.Parameters.Add("@product_sno", o.Productsno);
                        if (vdbmngr.Update(cmd) == 0)
                        {
                            cmd = new MySqlCommand("Insert Into branchproducts(branch_sno,product_sno,flag,userdata_sno,Unitprice) values(@branch_sno,@product_sno,@flag,@userdata_sno,@Unitprice)");
                            cmd.Parameters.Add("@branch_sno", BranchID);
                            cmd.Parameters.Add("@product_sno", o.Productsno);
                            cmd.Parameters.Add("@flag", false);
                            cmd.Parameters.Add("@userdata_sno", Username);
                            cmd.Parameters.Add("@Unitprice", UnitCost);
                            vdbmngr.insert(cmd);
                        }
                    }
                }
                if (phonenumber.Length == 10)
                {
                    string Date = DateTime.Now.AddDays(1).ToString("dd/MM/yyyy");
                    WebClient client = new WebClient();
                    string companyname = "\r\nPowered By Vyshnavi";
                    string BranchSno = context.Session["CsoNo"].ToString();
                    if (BranchSno == "4609" || BranchSno == "3625" || BranchSno == "2948" || BranchSno == "172" || BranchSno == "282" || BranchSno == "271" || BranchSno == "174" || BranchSno == "3928" || BranchSno == "285" || BranchSno == "527" || BranchSno == "4607" || BranchSno == "306" || BranchSno == "538" || BranchSno == "2749" || BranchSno == "1801")
                    {
                        //string baseurl = "http://www.smsstriker.com/API/sms.php?username=vaishnavidairy&password=vyshnavi@123&from=VYSNVI&to=" + MobNo + "&message=%20" + msg + "&response=Y";

                        string baseurl = "http://www.smsstriker.com/API/sms.php?username=vaishnavidairy&password=vyshnavi@123&from=VSALES&to=" + phonenumber + "&msg=Dear%20" + BranchName + "%20Your%20indent%20for%20Date%20" + Date + "%20,%20" + ProductName + "Total%20Ltrs =" + TotalQty + "&type=1";
                        Stream data = client.OpenRead(baseurl);
                        StreamReader reader = new StreamReader(data);
                        string ResponseID = reader.ReadToEnd();
                        data.Close();
                        reader.Close();
                    }
                    else
                    {
                        string baseurl = "http://www.smsstriker.com/API/sms.php?username=vaishnavidairy&password=vyshnavi@123&from=VFWYRA&to=" + phonenumber + "&msg=Dear%20" + BranchName + "%20Your%20indent%20for%20Date%20" + Date + "%20,%20" + ProductName + "Total%20Ltrs =" + TotalQty + "&type=1";
                        Stream data = client.OpenRead(baseurl);
                        StreamReader reader = new StreamReader(data);
                        string ResponseID = reader.ReadToEnd();
                        data.Close();
                        reader.Close();
                    }

                    string message = " Dear " + BranchName + " Your indent for Date " + Date + " , " + ProductName + "Total Ltrs =" + TotalQty + " ";

                    // string text = message.Replace("\n", "\n" + System.Environment.NewLine);
                    cmd = new MySqlCommand("insert into smsinfo (agentid,branchid, msg,mobileno,msgtype,branchname,doe) values (@agentid,@branchid,@msg,@mobileno,@msgtype,@branchname,@doe)");
                    cmd.Parameters.Add("@agentid", BranchID);
                    cmd.Parameters.Add("@branchid", context.Session["CsoNo"].ToString());
                    //cmd.Parameters.Add("@mainbranch", Session["SuperBranch"].ToString());
                    cmd.Parameters.Add("@msg", message);
                    cmd.Parameters.Add("@mobileno", phonenumber);
                    cmd.Parameters.Add("@msgtype", "Indent");
                    cmd.Parameters.Add("@branchname", BranchName);
                    cmd.Parameters.Add("@doe", ServerDateCurrentdate);
                    vdbmngr.insert(cmd);
                }
                var jsonSerializer = new JavaScriptSerializer();
                var jsonString = String.Empty;
                context.Request.InputStream.Position = 0;
                using (var inputStream = new StreamReader(context.Request.InputStream))
                {
                    jsonString = inputStream.ReadToEnd();
                }
                string msg = "Data Successfully Saved";
                MsgList.Add(msg);
                string responses = GetJson(MsgList);
                context.Response.Write(responses);
            }
        }
        catch (Exception ex)
        {
            List<string> MsgList = new List<string>();
            if (ex.Message == "Unable to connect to the remote server")
            {
                string msg = "Data Saved but Message Not Sent";
                MsgList.Add(msg);
            }
            else
            {
                string msg = ex.ToString();
                MsgList.Add(msg);
            }

            string response = GetJson(MsgList);
            context.Response.Write(response);
        }
    }

    private void get_agentindent_details(HttpContext context)
    {
        DBManagerSales vdbmngr = new DBManagerSales();
        MySqlCommand cmd;
        DateTime ServerDateCurrentdate = DBManagerSales.GetTime(vdbmngr.conn);
        string Username = context.Session["userdata_sno"].ToString();
        string b_bid = context.Request["agentid"];
        string date = context.Request["date"];
        ServerDateCurrentdate = Convert.ToDateTime(date);
        string IndentType = "khammam3";
        cmd = new MySqlCommand("SELECT productsdata.ProductName,indents_subtable.unitQty,indents_subtable.unitCost, productsdata.sno, indents_subtable.unitQty * indents_subtable.UnitCost AS Total, indents.IndentNo, productsdata.Qty AS RawQty , productsdata.Units FROM indents INNER JOIN indents_subtable ON indents.IndentNo = indents_subtable.IndentNo INNER JOIN productsdata ON indents_subtable.Product_sno = productsdata.sno WHERE (indents.Branch_id = @bsno)  and (indents.IndentType = @IndentType) AND (indents.UserData_sno = @UserName) AND (indents.I_date between @d1 AND  @d2)");
        cmd.Parameters.Add("@d1", GetLowDate(ServerDateCurrentdate));
        cmd.Parameters.Add("@d2", GetHighDate(ServerDateCurrentdate));
        cmd.Parameters.Add("@UserName", Username);
        cmd.Parameters.Add("@IndentType", IndentType);
        cmd.Parameters.Add("@bsno", b_bid);
        DataTable dtorders = vdbmngr.SelectQuery(cmd).Tables[0];
        if (dtorders.Rows.Count > 0)
        {
            List<orderdetail> ProductDetails = new List<orderdetail>();
            foreach (DataRow dr in dtorders.Rows)
            {
                orderdetail getproductdetails = new orderdetail();
                getproductdetails.productname = dr["ProductName"].ToString();
                getproductdetails.Productsno = dr["sno"].ToString();
                getproductdetails.Unitsqty = dr["unitQty"].ToString();
                getproductdetails.UnitCost = dr["unitCost"].ToString();
                getproductdetails.uim = dr["Units"].ToString();
                getproductdetails.IndentNo = dr["IndentNo"].ToString();
                ProductDetails.Add(getproductdetails);
            }
            string response = GetJson(ProductDetails);
            context.Response.Write(response);
        }
    }

    private void btnOrdereditClick(HttpContext context)
    {
        try
        {
            DBManagerSales vdbmngr = new DBManagerSales();
            MySqlCommand cmd;
            var js = new JavaScriptSerializer();
            List<string> MsgList = new List<string>();
            if (context.Session["Employ_Sno"] == null)
            {
                string errmsg = "Session Expired";
                string errresponse = GetJson(errmsg);
                context.Response.Write(errresponse);
            }
            else
            {
                string Username = context.Session["userdata_sno"].ToString();
                DateTime ServerDateCurrentdate = DBManagerSales.GetTime(vdbmngr.conn);

                var title1 = context.Request.Params[1];
                Orders obj = js.Deserialize<Orders>(title1);
                string b_bid = obj.BranchID;
                string IndentType = "khammam3";
                foreach (orderdetail o in obj.data)
                {
                    cmd = new MySqlCommand("Update indents_subtable set unitQty=@unitQty,Status=@Status where IndentNo=@IndentNo and Product_sno=@Product_sno");
                    cmd.Parameters.Add("@IndentNo", o.IndentNo);
                    cmd.Parameters.Add("@Product_sno", o.Productsno);
                    double UnitCost = 0;
                    double.TryParse(o.UnitCost, out UnitCost);
                    UnitCost = Math.Round(UnitCost, 2);
                    double unitQty = 0;
                    double.TryParse(o.Unitsqty, out unitQty);
                    unitQty = Math.Round(unitQty, 2);
                    cmd.Parameters.Add("@unitQty", unitQty);
                    cmd.Parameters.Add("@Status", "Ordered");
                    vdbmngr.Update(cmd);
                }
            }
        }
        catch (Exception ex)
        {
            List<string> MsgList = new List<string>();
            if (ex.Message == "Unable to connect to the remote server")
            {
                string msg = "Data Saved but Message Not Sent";
                MsgList.Add(msg);
            }
            else
            {
                string msg = ex.ToString();
                MsgList.Add(msg);
            }

            string response = GetJson(MsgList);
            context.Response.Write(response);
        }
    }

    private void get_distibutorsale_details(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            string julydt = "07/01/2017";
            DateTime gst_dt = Convert.ToDateTime(julydt);
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
            string branchid = context.Session["BranchID"].ToString();
            //SELECT  distibutorsalemaindetails.sno, distibutorsalemaindetails.distibutorid, distibutorsalemaindetails.branchid, distibutorsalemaindetails.invoiceno, distibutorsalemaindetails.invoicedate,  distibutorsalemaindetails.status, distibutorsalemaindetails.doe, distibutorsalemaindetails.remarks, distibutorsalemaindetails.billtotalvalue, distibutorsalemaindetails.refnote, distibutorsalemaindetails.createdby,  distibutorsalemaindetails.createdon, distibutorsalesubdetails.sno AS Expr1, distibutorsalesubdetails.productid, distibutorsalesubdetails.quantity, distibutorsalesubdetails.price, distibutorsalesubdetails.totvalue,  distibutorsalesubdetails.stock_refno, distibutorsalesubdetails.igst, distibutorsalesubdetails.cgst, distibutorsalesubdetails.sgst FROM            distibutorsalemaindetails INNER JOIN distibutorsalesubdetails ON distibutorsalemaindetails.sno = distibutorsalesubdetails.stock_refno WHERE        (distibutorsalemaindetails.branchid = @bid) AND (distibutorsalemaindetails.invoicedate BETWEEN @D1 AND @D2)
            cmd = new SqlCommand("SELECT distibutorsalemaindetails.sno, distibutorsalemaindetails.distibutorid, distibutorsalemaindetails.branchid, distibutorsalemaindetails.invoiceno, distibutorsalemaindetails.invoicedate, distibutorsalemaindetails.status, distibutorsalemaindetails.doe, distibutorsalemaindetails.remarks, distibutorsalemaindetails.billtotalvalue, distibutorsalemaindetails.refnote, distibutorsalemaindetails.createdby,  distibutorsalemaindetails.createdon, distibutorsalesubdetails.productid, distibutorsalesubdetails.quantity, distibutorsalesubdetails.price, distibutorsalesubdetails.totvalue,      distibutorsalesubdetails.stock_refno, distibutorsalesubdetails.igst, distibutorsalesubdetails.cgst, distibutorsalesubdetails.sgst, productmaster.productname, subdistibutor.distibutorname FROM distibutorsalemaindetails INNER JOIN  distibutorsalesubdetails ON distibutorsalemaindetails.sno = distibutorsalesubdetails.stock_refno INNER JOIN  productmaster ON distibutorsalesubdetails.productid = productmaster.productid  INNER JOIN  subdistibutor ON distibutorsalemaindetails.distibutorid = subdistibutor.sno WHERE (distibutorsalemaindetails.branchid = @bid) AND (distibutorsalemaindetails.invoicedate BETWEEN @D1 AND @D2) AND distibutorsalemaindetails.status=@status");//, inwarddetails.indentno
            cmd.Parameters.Add("@d1", GetLowDate(ServerDateCurrentdate).AddDays(-25));
            cmd.Parameters.Add("@d2", GetHighDate(ServerDateCurrentdate));
            cmd.Parameters.Add("@bid", branchid);
            cmd.Parameters.Add("@status", "P");
            DataTable routes = vdm.SelectQuery(cmd).Tables[0];

            DataView view = new DataView(routes);
            DataTable dtinward = view.ToTable(true, "sno", "distibutorid", "branchid", "invoiceno", "invoicedate", "doe", "status", "remarks", "distibutorname", "billtotalvalue");//, "indentno"
            DataTable dtsubinward = view.ToTable(true, "productid", "quantity", "price", "totvalue", "stock_refno", "productname", "igst", "cgst", "sgst");
            List<getInwardData> getInwarddetails = new List<getInwardData>();
            List<inwardDetails> inwardlist = new List<inwardDetails>();
            List<Subinward> subinwardlist = new List<Subinward>();
            foreach (DataRow dr in dtinward.Rows)
            {
                inwardDetails getInward = new inwardDetails();
                getInward.date = ((DateTime)dr["invoicedate"]).ToString("dd-MM-yyyy");//dr["inwarddate"].ToString();
                getInward.invoicedate = dr["invoicedate"].ToString();
                getInward.totalvalue = dr["billtotalvalue"].ToString();
                getInward.frombranch = dr["branchid"].ToString();
                getInward.tobranch = dr["distibutorid"].ToString();
                getInward.fromname = dr["distibutorname"].ToString();
                getInward.status = dr["status"].ToString();
                getInward.sno = dr["sno"].ToString();
                getInward.mrnno = dr["invoiceno"].ToString();
                getInward.description = dr["remarks"].ToString();
                inwardlist.Add(getInward);

            }
            foreach (DataRow dr in dtsubinward.Rows)
            {
                Subinward getsubinward = new Subinward();
                getsubinward.hdnproductsno = dr["productid"].ToString();
                getsubinward.productname = dr["productname"].ToString();
                getsubinward.Quantity = dr["quantity"].ToString();
                double quantity = Convert.ToDouble(dr["quantity"].ToString());
                quantity = Math.Round(quantity, 2);
                getsubinward.PerUnitRs = dr["price"].ToString();
                getsubinward.TotalCost = dr["totvalue"].ToString();
                getsubinward.inword_refno = dr["stock_refno"].ToString();
                getsubinward.igst = dr["igst"].ToString();
                getsubinward.cgst = dr["cgst"].ToString();
                getsubinward.sgst = dr["sgst"].ToString();
                subinwardlist.Add(getsubinward);
            }
            getInwardData getInwadDatas = new getInwardData();
            getInwadDatas.InwardDetails = inwardlist;
            getInwadDatas.SubInward = subinwardlist;
            getInwarddetails.Add(getInwadDatas);
            string response = GetJson(getInwarddetails);
            context.Response.Write(response);
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }
    //  

    private void get_Sales_details(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            string julydt = "07/01/2017";
            DateTime gst_dt = Convert.ToDateTime(julydt);
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
            string InvoicNo = context.Request["InvoicNo"];
            string refno = context.Request["refno"];
            string branchid = context.Session["BranchID"].ToString();
            string Branch = context.Request["ddlBranchName"].ToString();
            
            //SELECT  distibutorsalemaindetails.sno, distibutorsalemaindetails.distibutorid, distibutorsalemaindetails.branchid, distibutorsalemaindetails.invoiceno, distibutorsalemaindetails.invoicedate,  distibutorsalemaindetails.status, distibutorsalemaindetails.doe, distibutorsalemaindetails.remarks, distibutorsalemaindetails.billtotalvalue, distibutorsalemaindetails.refnote, distibutorsalemaindetails.createdby,  distibutorsalemaindetails.createdon, distibutorsalesubdetails.sno AS Expr1, distibutorsalesubdetails.productid, distibutorsalesubdetails.quantity, distibutorsalesubdetails.price, distibutorsalesubdetails.totvalue,  distibutorsalesubdetails.stock_refno, distibutorsalesubdetails.igst, distibutorsalesubdetails.cgst, distibutorsalesubdetails.sgst FROM            distibutorsalemaindetails INNER JOIN distibutorsalesubdetails ON distibutorsalemaindetails.sno = distibutorsalesubdetails.stock_refno WHERE        (distibutorsalemaindetails.branchid = @bid) AND (distibutorsalemaindetails.invoicedate BETWEEN @D1 AND @D2)
            cmd = new SqlCommand("SELECT branchmaster.address, branchmaster.phone, branchmaster.gstin, PM.sno, PM.custmorid, customermaster.name AS custmorname, PM.referencenote, PM.totalitems,  PM.totalpayble, PM.totalpaying, PM.balance, PM.description, PM.modeofpay, PM.payiningnote, PM.discount, PM.status, PM.branchid, PM.doe,  PM.createdby, PM.issueno, PS.refno, PS.productid, PS.productname, PS.qty, PS.totvalue, PS.ordertax, productmaster.sgst, productmaster.cgst, productmaster.igst, productmoniter.price  FROM  possale_maindetails AS PM INNER JOIN  possale_subdetails AS PS ON PM.sno = PS.refno INNER JOIN  customermaster ON PM.custmorid = customermaster.sno INNER JOIN productmaster ON PS.productid = productmaster.productid INNER JOIN branchmaster ON branchmaster.branchid=PM.branchid INNER JOIN productmoniter ON productmoniter.productid=PS.productid WHERE (PM.sno = @SNO) AND productmoniter.branchid=@BID");
            cmd.Parameters.Add("@SNO", InvoicNo);
            cmd.Parameters.Add("@BID", Branch);
            DataTable routes = vdm.SelectQuery(cmd).Tables[0];
            DataView view = new DataView(routes);
            DataTable dtoutward = view.ToTable(true, "sno", "custmorid", "totalitems", "totalpayble", "totalpaying", "balance", "doe", "issueno", "custmorname", "modeofpay", "discount", "address", "phone", "gstin");
            DataTable dtsuboutward = view.ToTable(true, "productid", "productname", "qty", "price", "totvalue", "sgst", "cgst", "igst", "ordertax");
            List<SubOutward> suboutwardlist = new List<SubOutward>();
            foreach (DataRow dr in dtsuboutward.Rows)
            {
                SubOutward getsuboutward = new SubOutward();
                getsuboutward.productname = dr["productname"].ToString();
                getsuboutward.Quantity = dr["qty"].ToString();
                getsuboutward.hdnproductsno = dr["productid"].ToString();
                getsuboutward.PerUnitRs = dr["price"].ToString();
                getsuboutward.TotalCost = dr["totvalue"].ToString();
                getsuboutward.igst = dr["igst"].ToString();
                getsuboutward.sgst = dr["sgst"].ToString();
                getsuboutward.cgst = dr["cgst"].ToString();
                getsuboutward.ordertax = dr["ordertax"].ToString();
                getsuboutward.InvoiceNo = InvoicNo;
                suboutwardlist.Add(getsuboutward);
            }
            string response = GetJson(suboutwardlist);
            context.Response.Write(response);
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    private void Update_possale(HttpContext context)
    {
        try
        {
            var js = new JavaScriptSerializer();
            var title1 = context.Request.Params[1];

            OutwardDetails obj = js.Deserialize<OutwardDetails>(title1);
            string totalpaying = obj.totalpaying;
            string totalpayable = obj.totalpayable;
            string billtotalvalue = obj.billtotalvalue;
            string InvoiceNo = obj.sno;
            string balance = obj.balance;
            string btnval = obj.btnvalue;
            string status = "";
            if (btnval == "Save")
            {
                status = "C";
            }
            else
            {
                status = "H";
            }
            // string btnval = "Save";
            string branchid = context.Session["BranchID"].ToString();
            string createdby = context.Session["Employ_Sno"].ToString();
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
            vdm = new SalesDBManager();

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

            cmd = new SqlCommand("update possale_maindetails set totalpaying=totalpaying where sno=@sno");
            cmd.Parameters.Add("@totalpaying", totalpaying);
            cmd.Parameters.Add("@sno", InvoiceNo);
            vdm.Update(cmd);
            string refno = "";
            foreach (SubOutward si in obj.fillitems)
            {
                if (si.hdnproductsno != "0")
                {
                    cmd = new SqlCommand("update possale_subdetails set productid=@productid, qty=@qty, price=@price, totvalue=@totvalue,ordertax=@ordertax where productid=@productid and refno=@refno");
                    cmd.Parameters.Add("@productname", si.productname);
                    cmd.Parameters.Add("@productid", si.hdnproductsno);
                    cmd.Parameters.Add("@qty", si.Quantity);
                    cmd.Parameters.Add("@price", si.PerUnitRs);
                    cmd.Parameters.Add("@totvalue", si.TotalCost);
                    cmd.Parameters.Add("@ordertax", si.ordertax);
                    cmd.Parameters.Add("@refno", InvoiceNo);
                    vdm.Update(cmd);
                }
            }
            string msg = "Sale successfully Updated";
            string Response = GetJson(msg);
            context.Response.Write(Response);
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }

    class Item_Bal_Trans
    {
        public string productid { set; get; }
        public string productname { set; get; }
        public string opp_balance { set; get; }
        public string salesdate { set; get; }
        public string inwardqty { set; get; }
        public string saleqty { set; get; }
        public string returnqty { set; get; }
        public string clo_balance { set; get; }
        public string sno { set; get; }
        public string doe { set; get; }
    }
    class Item_Bal_Trans_Model
    {
        public List<Item_Bal_Trans> filldetails { set; get; }
    }
    private void get_Bal_Trans(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            string branchid = context.Request["branchid"];
            string category = context.Request["category"];
            string subcategory = context.Request["subcategory"];
            string productid = context.Request["itemname"];
            string fromdate = context.Request["fromdate"];
            string todate = context.Request["todate"];
            DateTime dt_fromdate = Convert.ToDateTime(fromdate);
            DateTime dt_todate = Convert.ToDateTime(todate);
            cmd = new SqlCommand("Select aa.return_qty,aa.inwardqty,aa.saleqty,aa.op_bal,aa.refno, aa.productid,aa.sno, aa.price, aa.clo_bal,aa.doe,aa.branchid,bb.productname from sub_registorclosingdetails as aa INNER JOIN productmaster bb ON aa.productid=bb.productid WHERE  aa.branchid  = @Branchid  and (aa.productid = @productid) AND (aa.doe BETWEEN @d1 AND @d2) order by aa.doe");
            cmd.Parameters.AddWithValue("@productid", productid);
            cmd.Parameters.AddWithValue("@Branchid", branchid);
            cmd.Parameters.AddWithValue("@d1", GetLowDate(dt_fromdate));
            cmd.Parameters.AddWithValue("@d2", GetHighDate(dt_todate));
            DataTable dtitem = vdm.SelectQuery(cmd).Tables[0];


            //cmd = new SqlCommand("SELECT SUM(inward_subdetails.qty) AS inwardqty,productmaster.productname,productmaster.productid,CAST(inward_maindetails.doe  AS date)  FROM   inward_maindetails INNER JOIN  inward_subdetails ON inward_maindetails.sno = inward_subdetails.refno INNER JOIN productmaster ON productmaster.productid = inward_subdetails.productid  WHERE (inward_maindetails.doe BETWEEN @d11 AND @d22) AND (inward_maindetails.branchid = @bidd) AND (inward_subdetails.productid = @productid) AND (inward_maindetails.status = 'A') GROUP BY  productmaster.productname,CAST(inward_maindetails.doe  AS date),productmaster.productid");
            //cmd.Parameters.Add("@d11", GetLowDate(dt_fromdate));
            //cmd.Parameters.Add("@d22", GetHighDate(dt_todate));
            //cmd.Parameters.Add("@bidd", branchid);
            //cmd.Parameters.AddWithValue("@productid", productid);
            //DataTable dtinward = vdm.SelectQuery(cmd).Tables[0];

            //cmd = new SqlCommand("SELECT   Sum(possale_subdetails.qty) AS outwardqty,Sum(possale_subdetails.ordertax) AS ordertax, productmaster.productid,productmaster.productname, possale_subdetails.price, Sum(possale_subdetails.totvalue) AS totvalue, Sum(possale_subdetails.ordertax) AS ordertax,CAST(possale_maindetails.doe AS date) FROM possale_maindetails INNER JOIN possale_subdetails on possale_subdetails.refno = possale_maindetails.sno INNER JOIN productmaster ON productmaster.productid = possale_subdetails.productid  WHERE (possale_maindetails.doe BETWEEN @d1 AND @d2) AND (possale_maindetails.branchid=@bid) AND (possale_subdetails.productid=@productid)  GROUP BY  productmaster.productname, possale_subdetails.price,productmaster.productid,CAST(possale_maindetails.doe AS date)");
            //cmd.Parameters.Add("@d1", GetLowDate(dt_fromdate));
            //cmd.Parameters.Add("@d2", GetHighDate(dt_fromdate));
            //cmd.Parameters.Add("@bid", branchid);
            //cmd.Parameters.AddWithValue("@productid", productid);
            //DataTable dtouward = vdm.SelectQuery(cmd).Tables[0];
            List<Item_Bal_Trans> ItemBalList = new List<Item_Bal_Trans>();


            foreach (DataRow dr in dtitem.Rows)


            {
                Item_Bal_Trans getBalanceItem = new Item_Bal_Trans();

                double opqty = 0;
                double inward = 0;
                double outward = 0;
                double return_qty = 0;
                double cloqty = 0;
                double totaloutward = 0;

                double.TryParse(dr["return_qty"].ToString(), out return_qty);
                double.TryParse(dr["op_bal"].ToString(), out opqty);
                double.TryParse(dr["clo_bal"].ToString(), out cloqty);
                double.TryParse(dr["inwardqty"].ToString(), out inward);
                double.TryParse(dr["saleqty"].ToString(), out outward);

                //foreach (DataRow drin in dtinward.Select("productid='" + dr["productid"].ToString() + "'"))
                //{
                //    double.TryParse(drin["inwardqty"].ToString(), out inward);
                //    double.TryParse(drin["inwardqty"].ToString(), out inward);
                //}
                //foreach (DataRow drout in dtouward.Select("productid='" + dr["productid"].ToString() + "'"))
                //{
                //    double.TryParse(drout["outwardqty"].ToString(), out outward);
                //    double.TryParse(drout["ordertax"].ToString(), out ordertax);
                //    totaloutward = outward + ordertax;
                //    totaloutward = Math.Round(totaloutward, 2);
                //}
                getBalanceItem.sno = dr["sno"].ToString();
                getBalanceItem.productid = dr["productid"].ToString();
                getBalanceItem.productname = dr["productname"].ToString();
                getBalanceItem.opp_balance = opqty.ToString();
                DateTime dtDOE = Convert.ToDateTime(dr["doe"].ToString());
                getBalanceItem.salesdate = dtDOE.ToString("dd/MMM/yyyy");
                getBalanceItem.clo_balance = cloqty.ToString();
                getBalanceItem.inwardqty = inward.ToString();
                getBalanceItem.saleqty = outward.ToString();
                getBalanceItem.returnqty = return_qty.ToString();
                ItemBalList.Add(getBalanceItem);
            }
            string response = GetJson(ItemBalList);
            context.Response.Write(response);
        }
        catch (Exception ex)
        {
        }
    }
    private void Edit_Item_Bal_Trans(HttpContext context)
    {
        try
        {
            vdm = new SalesDBManager();
            var js = new JavaScriptSerializer();
            //string empid = context.Session["empid"].ToString();
            DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
            var title1 = context.Request.Params[1];
            Item_Bal_Trans_Model obj = js.Deserialize<Item_Bal_Trans_Model>(title1);
            foreach (Item_Bal_Trans o in obj.filldetails)
            {
                DateTime dtIndent = Convert.ToDateTime(o.doe);
                cmd = new SqlCommand("UPDATE sub_registorclosingdetails set op_bal=@opp_balance,return_qty=@return_qty,inwardqty=@inwardqty,saleqty=@saleqty,clo_bal=@clo_balance  where sno=@sno and productid=@productid AND doe between @d1 and @d2");
                cmd.Parameters.AddWithValue("@d1", GetLowDate(dtIndent));
                cmd.Parameters.AddWithValue("@d2", GetHighDate(dtIndent));
                cmd.Parameters.AddWithValue("@opp_balance", o.opp_balance);
                cmd.Parameters.AddWithValue("@inwardqty", o.inwardqty);
                cmd.Parameters.AddWithValue("@saleqty", o.saleqty);
                cmd.Parameters.AddWithValue("@return_qty", o.returnqty);
                cmd.Parameters.AddWithValue("@clo_balance", o.clo_balance);
                cmd.Parameters.AddWithValue("@productid", o.productid);
                cmd.Parameters.AddWithValue("@sno", o.sno);
               // cmd.Parameters.AddWithValue("@doe", dtIndent);
                vdm.Update(cmd);
            }
            string msg = "Balances Successfully Updated";
            string Response = GetJson(msg);
            context.Response.Write(Response);
        }
        catch (Exception ex)
        {
            string Response = GetJson(ex.Message);
            context.Response.Write(Response);
        }
    }
}







    





                

   