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
using System.Security.Cryptography;
using System.Net.Sockets;
using System.Text.RegularExpressions;
using MySql.Data.MySqlClient;

public partial class login : System.Web.UI.Page
{
    SalesDBManager vdm = new SalesDBManager();
    AccessControldbmanger Accescontrol_db = new AccessControldbmanger();
    SqlCommand cmd;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                btnLogin_Click();
                lblMsg.Visible = false;
            }
        }
        catch (Exception ex)
        {
            //lblMsg.Text = ex.Message;
        }
    }
    protected void login_click(object sender, EventArgs e)
    {
        try
        {
            vdm = new SalesDBManager();
            string userid = txtusername.Text, password = txtpassword.Text;
            cmd = new SqlCommand("SELECT sno, employename, userid, password, emailid, phone, branchtype, leveltype, departmentid, branchid  FROM employe_details where userid=@username AND password=@pwd");
            cmd.Parameters.Add("@pwd", password);
            cmd.Parameters.Add("@username", userid);
            DataTable dt = vdm.SelectQuery(cmd).Tables[0];
            if (dt.Rows.Count > 0)
            {
                string sno = dt.Rows[0]["sno"].ToString();
                Session["Employ_Sno"] = dt.Rows[0]["sno"].ToString();
                Session["BranchID"] = dt.Rows[0]["branchid"].ToString();
                Session["branch"] = dt.Rows[0]["branchid"].ToString();
                Session["SuperBranch"] = "10";
                Session["UserName"] = dt.Rows[0]["employename"].ToString();
                Session["posleveltype"] = dt.Rows[0]["leveltype"].ToString();
                Session["LevelType"] = dt.Rows[0]["leveltype"].ToString();
                Session["UserSno"] = dt.Rows[0]["sno"].ToString();
                string leveltype = dt.Rows[0]["leveltype"].ToString();
                Response.Cookies["UserName"].Value = HttpUtility.UrlEncode("true");
                Response.Cookies["UserName"].Path = "/";
                Response.Cookies["UserName"].Expires = DateTime.Now.AddDays(1);
                Response.Cookies["Employ_Sno"].Value = HttpUtility.UrlEncode("true");
                Response.Cookies["Employ_Sno"].Path = "/";
                Response.Cookies["Employ_Sno"].Expires = DateTime.Now.AddDays(1);
                Session["TitleName"] = "SRI VYSHNAVI DAIRY";
                string ipaddress;
                ipaddress = Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
                if (ipaddress == "" || ipaddress == null)
                {
                    ipaddress = Request.ServerVariables["REMOTE_ADDR"];
                }
                DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
                HttpBrowserCapabilities browser = Request.Browser;
                string devicetype = "";
                string userAgent = Request.ServerVariables["HTTP_USER_AGENT"];
                Regex OS = new Regex(@"(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino", RegexOptions.IgnoreCase | RegexOptions.Multiline);
                Regex device = new Regex(@"1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-", RegexOptions.IgnoreCase | RegexOptions.Multiline);
                string device_info = string.Empty;
                if (OS.IsMatch(userAgent))
                {
                    device_info = OS.Match(userAgent).Groups[0].Value;
                }
                if (device.IsMatch(userAgent.Substring(0, 4)))
                {
                    device_info += device.Match(userAgent).Groups[0].Value;
                }
                if (!string.IsNullOrEmpty(device_info))
                {
                    devicetype = device_info;
                    string[] words = devicetype.Split(')');
                    devicetype = words[0].ToString();
                }
                else
                {
                    devicetype = "Desktop";
                }
                cmd = new SqlCommand("Select * from empbranchmapping Where empid=@sno");
                cmd.Parameters.Add("@sno", sno);
                DataTable dtemp = vdm.SelectQuery(cmd).Tables[0];
                if (dtemp.Rows.Count > 1)
                {
                    Response.Redirect("Switchaccounts.aspx", false);
                }
                else
                {
                    if (leveltype == "Admin     ")
                    {
                        Response.Redirect("Default.aspx", false);
                    }
                    if (leveltype == "SuperAdmin")
                    {
                        Response.Redirect("Default.aspx", false);
                    }
                    if (leveltype == "User      ")
                    {
                        Response.Redirect("vpos.aspx", false);
                    }
                    if (leveltype == "Manager   ")
                    {
                        Response.Redirect("Default.aspx", false);
                    }
                    if (leveltype == "Accounts  ")
                    {
                        Response.Redirect("Default.aspx", false);
                    }
                    if (leveltype == "Distibutor")
                    {
                        Response.Redirect("Distibuterindent.aspx", false);
                    }
                    if (leveltype == "Indent    ")
                    {
                        ValidateLogin();
                        Response.Redirect("Distibuterindent.aspx", false);
                    }
                    if (leveltype == "AccountsOfficer")
                    {
                        ValidateLogin();
                        Response.Redirect("vocherform.aspx", false);
                    }
                    
                }
            }
            else
            {
                lblMsg.Visible = true;
                lblMsg.Text = "Invalid userId and Password";
            }
        }
        catch (Exception ex)
        {
            lblMsg.Text = ex.Message;
        }
    }
    private void ValidateLogin()
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
                Session["logingname"] = UserName;
                Session["PWD"] = PassWord;
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
                            Session["UserName"] = "";
                            Session["userdata_sno"] = dtemp.Rows[0]["UserData_sno"].ToString();
                            Session["UserSno"] = dtemp.Rows[0]["Sno"].ToString(); ;
                            Session["count"] = "";
                            Session["routearray"] = "";
                            Session["RouteId"] = dt.Rows[0]["RouteID"].ToString();
                            Session["TripdataSno"] = dt.Rows[0]["Sno"].ToString();
                            Session["TripID"] = dt.Rows[0]["Sno"].ToString();
                            Session["Permissions"] = "";
                            Session["Salestype"] = "Plant";
                            Session["BranchSno"] = "";
                            if (status == "0")
                            {
                                Session["LevelType"] = dtemp.Rows[0]["LevelType"].ToString();
                                Session["Permissions"] = dtemp.Rows[0]["LevelType"].ToString();
                            }
                            if (status == "1")
                            {
                                Session["LevelType"] = "SODispatcher";
                                Session["Permissions"] = "SODispatcher";
                            }
                            Session["PlantEmpId"] = dtemp.Rows[0]["Sno"].ToString();
                            Session["PlantDispSno"] = dt.Rows[0]["Sno"].ToString();
                            Session["DispDate"] = dt.Rows[0]["I_Date"].ToString();
                            Session["I_Date"] = dt.Rows[0]["I_Date"].ToString();
                            Session["userdata_sno"] = dtemp.Rows[0]["UserData_sno"].ToString();
                            Session["UserName"] = dtemp.Rows[0]["UserName"].ToString();
                            Session["CsoNo"] = dtemp.Rows[0]["Branch"].ToString();
                            Session["IndentType"] = dt.Rows[0]["IndentType"].ToString();
                            Session["DispType"] = dt.Rows[0]["Disptype"].ToString();
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
                                Session["UserName"] = dt.Rows[0]["UserName"].ToString();
                                Session["userdata_sno"] = dt.Rows[0]["UserData_sno"].ToString();
                                Session["UserSno"] = dt.Rows[0]["EmpSno"].ToString();
                                Session["LevelType"] = dt.Rows[0]["LevelType"].ToString();
                                Session["AssignDate"] = dt.Rows[0]["AssignDate"].ToString();
                                Session["I_Date"] = dt.Rows[0]["I_Date"].ToString();
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
                                Session["count"] = count;
                                Session["routearray"] = routearray;
                                Session["RouteId"] = dt.Rows[0]["RouteId"].ToString();
                                Session["TripdataSno"] = dt.Rows[0]["Sno"].ToString();
                                Session["TripID"] = dt.Rows[0]["Sno"].ToString();
                                Session["Permissions"] = dt.Rows[0]["Permissions"].ToString();
                                Session["Salestype"] = dt.Rows[0]["salestype"].ToString();
                                Session["BranchSno"] = dt.Rows[0]["BranchSno"].ToString();
                                Session["CsoNo"] = dt.Rows[0]["BranchSno"].ToString();
                                //Session["IndentType"] = "Indent1"; //dt.Rows[0]["IndentType"].ToString();
                                Session["IndentType"] = dt.Rows[0]["IndentType"].ToString(); ; //dt.Rows[0]["IndentType"].ToString();

                                Session["DispType"] = dt.Rows[0]["DispType"].ToString();
                                Session["ATripId"] = dt.Rows[0]["ATripId"].ToString();
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
    }
    private void btnLogin_Click()
    {
        try
        {
            vdm = new SalesDBManager();
            string firstname = Request.QueryString["username"];
            string lastname = Request.QueryString["pwd"];
            txtusername.Text = firstname;
            txtpassword.Text = lastname;
            if (txtusername.Text.Trim() == "" || txtpassword.Text.Trim() == "")
            {
                lblMsg.Visible = true;
                lblMsg.Text = "Required userName and password";
                return;
            }
            string userid = txtusername.Text, password = txtpassword.Text;
            cmd = new SqlCommand("SELECT sno, employename, userid, password, emailid, phone, branchtype, leveltype, departmentid, branchid  FROM employe_details where userid=@username AND password=@pwd");
            cmd.Parameters.Add("@pwd", password);
            cmd.Parameters.Add("@username", userid);
            DataTable dt = vdm.SelectQuery(cmd).Tables[0];
            if (dt.Rows.Count > 0)
            {
                string sno = dt.Rows[0]["sno"].ToString();
                Session["Employ_Sno"] = dt.Rows[0]["sno"].ToString();
                Session["BranchID"] = dt.Rows[0]["branchid"].ToString();
                Session["UserName"] = dt.Rows[0]["employename"].ToString();
                Session["posleveltype"] = dt.Rows[0]["leveltype"].ToString();
                string leveltype = dt.Rows[0]["leveltype"].ToString();
                Response.Cookies["UserName"].Value = HttpUtility.UrlEncode("true");
                Response.Cookies["UserName"].Path = "/";
                Response.Cookies["UserName"].Expires = DateTime.Now.AddDays(1);
                Response.Cookies["Employ_Sno"].Value = HttpUtility.UrlEncode("true");
                Response.Cookies["Employ_Sno"].Path = "/";
                Response.Cookies["Employ_Sno"].Expires = DateTime.Now.AddDays(1);
                string ipaddress;
                ipaddress = Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
                if (ipaddress == "" || ipaddress == null)
                {
                    ipaddress = Request.ServerVariables["REMOTE_ADDR"];
                }
                DateTime ServerDateCurrentdate = SalesDBManager.GetTime(vdm.conn);
                HttpBrowserCapabilities browser = Request.Browser;
                string devicetype = "";
                string userAgent = Request.ServerVariables["HTTP_USER_AGENT"];
                Regex OS = new Regex(@"(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|mobile.+firefox|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows ce|xda|xiino", RegexOptions.IgnoreCase | RegexOptions.Multiline);
                Regex device = new Regex(@"1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-", RegexOptions.IgnoreCase | RegexOptions.Multiline);
                string device_info = string.Empty;
                if (OS.IsMatch(userAgent))
                {
                    device_info = OS.Match(userAgent).Groups[0].Value;
                }
                if (device.IsMatch(userAgent.Substring(0, 4)))
                {
                    device_info += device.Match(userAgent).Groups[0].Value;
                }
                if (!string.IsNullOrEmpty(device_info))
                {
                    devicetype = device_info;
                    string[] words = devicetype.Split(')');
                    devicetype = words[0].ToString();
                }
                else
                {
                    devicetype = "Desktop";
                }
                //cmd = new SqlCommand("INSERT INTO logininfo(userid, username, logintime, ipaddress, devicetype) values (@userid, @UserName, @logintime, @ipaddress, @device)");
                //cmd.Parameters.Add("@userid", dt.Rows[0]["sno"].ToString());
                //cmd.Parameters.Add("@UserName", Session["UserName"]);
                //cmd.Parameters.Add("@logintime", ServerDateCurrentdate);
                //cmd.Parameters.Add("@ipaddress", ipaddress);
                //cmd.Parameters.Add("@device", devicetype);
                //vdm.insert(cmd);
                if (leveltype == "Admin     ")
                {
                    Response.Redirect("Default.aspx", false);
                }
                if (leveltype == "SuperAdmin")
                {
                    Response.Redirect("Default.aspx", false);
                }
                if (leveltype == "User      ")
                {
                    Response.Redirect("vpos.aspx", false);
                }
                if (leveltype == "Manager   ")
                {
                    Response.Redirect("Default.aspx", false);
                }
                if (leveltype == "Accounts  ")
                {
                    Response.Redirect("Default.aspx", false);
                }
                if (leveltype == "Distibutor")
                {
                    Response.Redirect("Distibuterindent.aspx", false);
                }
            }
            else
            {
                lblMsg.Visible = true;
                lblMsg.Text = "Invalid userId and Password";
            }
        }
        catch (Exception ex)
        {
            lblMsg.Text = ex.Message;
        }
    }
}