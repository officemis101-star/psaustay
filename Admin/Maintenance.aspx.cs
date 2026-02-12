using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PSAUStay.Admin
{
    public partial class Maintenance : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["PSAUStayConnection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                LoadMaintenanceRequests();
        }

        void LoadMaintenanceRequests()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"SELECT m.MaintenanceID, r.RoomName, m.IssueDescription, 
                                m.RequestorName, m.Status, m.AssignedTo, m.DateRequested
                         FROM MaintenanceRequests m
                         INNER JOIN Rooms r ON m.RoomID = r.RoomID
                         ORDER BY m.DateRequested DESC";
                SqlDataAdapter da = new SqlDataAdapter(query, con);
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvMaintenance.DataSource = dt;
                gvMaintenance.DataBind();
            }
        }

        protected string GetStatusBadgeClass(string status)
        {
            switch (status?.ToLower())
            {
                case "pending":
                    return "bg-warning";
                case "in progress":
                case "inprogress":
                    return "bg-primary";
                case "completed":
                    return "bg-success";
                case "cancelled":
                    return "bg-danger";
                default:
                    return "bg-secondary";
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            // TODO: Add logic to insert a new maintenance request
            // Example: redirect to a form or open a modal
            Response.Redirect("AddMaintenanceRequest.aspx");
        }
    }
}