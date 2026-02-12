using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Net.Mail;
using System.Web;
using PSAUStay.Helpers;

namespace PSAUStay
{
    public partial class BookingSuccess : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["PSAUStayConnection"].ConnectionString;
        string onlineAccountInfo = "GCash/Paymaya: 09123456789 (PSAU Stay)";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // 1. Retrieve Data from QueryString
                string bookingRef = Request.QueryString["ref"];
                string email = Request.QueryString["email"];
                string amountStr = Request.QueryString["amount"];
                string paymentOption = Request.QueryString["payment"] ?? "downpayment"; // Default to downpayment

                // 2. Retrieve Extra Info from Session (Passed from ConfirmReservation)
                litGuestName.Text = Session["FullName"]?.ToString() ?? "Guest";
                string checkIn = Session["CheckIn"]?.ToString();
                string checkOut = Session["CheckOut"]?.ToString();
                litDates.Text = $"{checkIn} to {checkOut}";
                litPaymentInfo.Text = onlineAccountInfo;

                // Get contact information from database using booking reference
                if (!string.IsNullOrEmpty(bookingRef))
                {
                    using (SqlConnection con = new SqlConnection(connStr))
                    {
                        string query = @"SELECT gl.Contact 
                                       FROM GuestList gl 
                                       INNER JOIN Reservation r ON gl.GuestID = r.UserID 
                                       WHERE r.ReservationID = @ReservationID";
                        
                        using (SqlCommand cmd = new SqlCommand(query, con))
                        {
                            cmd.Parameters.AddWithValue("@ReservationID", bookingRef);
                            con.Open();
                            object contactResult = cmd.ExecuteScalar();
                            litContact.Text = contactResult?.ToString() ?? "N/A";
                        }
                    }
                }
                else
                {
                    litContact.Text = "N/A";
                }

                decimal totalPrice = 0;
                decimal requiredPayment = 0;
                string paymentType = "";

                if (decimal.TryParse(amountStr, out totalPrice))
                {
                    if (paymentOption == "full")
                    {
                        requiredPayment = totalPrice;
                        paymentType = "Full Payment";
                    }
                    else
                    {
                        requiredPayment = totalPrice * 0.50m; // Calculate 50%
                        paymentType = "Downpayment (50%)";
                    }
                    litTotalPrice.Text = totalPrice.ToString("N2");
                    litDownpayment.Text = requiredPayment.ToString("N2");
                }

                litRefNumber.Text = bookingRef;

                // 3. Trigger Email and DB Token logic
                if (!string.IsNullOrEmpty(bookingRef) && !string.IsNullOrEmpty(email))
                {
                    ProcessPaymentRequest(bookingRef, email, requiredPayment, paymentType);
                }
            }
        }

        private void ProcessPaymentRequest(string bookingRef, string email, decimal requiredPayment, string paymentType)
        {
            string token = Guid.NewGuid().ToString("N");
            DateTime expiry = DateTime.Now.AddHours(24);

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string sql = @"INSERT INTO RoomPaymentUploads (BookingRef, Email, Token, ExpirationDate, Status)
                               VALUES (@BookingRef, @Email, @Token, @Expiry, 'Pending')";

                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@BookingRef", bookingRef);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Token", token);
                    cmd.Parameters.AddWithValue("@Expiry", expiry);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            // PUBLIC URL FOR UPLOAD PORTAL (Replace localhost with your actual domain when live)
            string link = $"http://localhost:24721/UploadPayment.aspx?token={token}";

            string body = $@"
                <div style='font-family: Arial, sans-serif; color: #333;'>
                    <h2 style='color: #198754;'>Booking Received!</h2>
                    <p>Dear {litGuestName.Text},</p>
                    <p>Your booking request <strong>#{bookingRef}</strong> for <strong>{litDates.Text}</strong> is pending payment.</p>
                    
                    <div style='background: #f8f9fa; padding: 15px; border-radius: 5px;'>
                        <p><strong>Total Price:</strong> ₱{litTotalPrice.Text}</p>
                        <p><strong>{paymentType} Required:</strong> <span style='color: #198754; font-size: 1.2em;'>₱{requiredPayment:N2}</span></p>
                    </div>

                    <p>Please send payment to: <br><strong>{onlineAccountInfo}</strong></p>

                    <p>Click the link below to upload your proof of payment (expires in 24 hours):</p>
                    <p><a href='{link}' style='display:inline-block; padding: 10px 20px; background-color: #198754; color: white; text-decoration: none; border-radius: 5px;'>Upload Proof of Payment</a></p>
                    
                    <p>Thank you,<br><strong>PSAU Stay Team</strong></p>
                </div>";

            try
            {
                EmailHelper.Send(email, $"Action Required: Payment for Booking #{bookingRef}", body, true);
            }
            catch (Exception ex)
            {
                lblEmailStatus.Text = "⚠ Booking saved, but we couldn't send the email. Please save your reference number.";
                lblEmailStatus.CssClass = "alert alert-danger d-block small mb-4";
                System.Diagnostics.Debug.WriteLine("Email Error: " + ex.Message);
            }
        }
    }
}