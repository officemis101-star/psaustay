using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Security.Cryptography;
using System.Text;

namespace PSAUStay.Account
{
    public partial class ChangePassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Require login
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/Account/Login.aspx");
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            string userId = Session["UserID"]?.ToString();
            string oldPassword = txtOldPassword.Text.Trim();
            string newPassword = txtNewPassword.Text.Trim();
            string confirmPassword = txtConfirmPassword.Text.Trim();

            if (string.IsNullOrEmpty(oldPassword) || string.IsNullOrEmpty(newPassword))
            {
                ShowMessage("⚠️ Please fill in all fields.", "danger");
                return;
            }

            if (newPassword != confirmPassword)
            {
                ShowMessage("❌ New passwords do not match.", "danger");
                return;
            }

            string connStr = ConfigurationManager.ConnectionStrings["PSAUStayConnection"].ConnectionString;

            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    con.Open();
                    // 1️⃣ Get current password hash and salt
                    string selectQuery = "SELECT PasswordHash, Salt FROM Users WHERE UserID=@UserID";
                    string storedHash = "", storedSalt = "";

                    using (SqlCommand cmd = new SqlCommand(selectQuery, con))
                    {
                        cmd.Parameters.AddWithValue("@UserID", userId);
                        SqlDataReader reader = cmd.ExecuteReader();
                        if (reader.Read())
                        {
                            storedHash = reader["PasswordHash"].ToString();
                            storedSalt = reader["Salt"].ToString();
                        }
                        reader.Close();
                    }

                    if (string.IsNullOrEmpty(storedHash) || string.IsNullOrEmpty(storedSalt))
                    {
                        ShowMessage("⚠️ Account password not found. Contact admin.", "danger");
                        return;
                    }

                    // 2️⃣ Verify old password
                    if (!VerifyPassword(oldPassword, storedSalt, storedHash))
                    {
                        ShowMessage("❌ Current password is incorrect.", "danger");
                        return;
                    }

                    // 3️⃣ Generate new salt + hash
                    string newSalt = GenerateSalt();
                    string newHash = HashPassword(newPassword, newSalt);

                    // 4️⃣ Update database
                    string updateQuery = "UPDATE Users SET PasswordHash=@Hash, Salt=@Salt WHERE UserID=@UserID";
                    using (SqlCommand updateCmd = new SqlCommand(updateQuery, con))
                    {
                        updateCmd.Parameters.AddWithValue("@Hash", newHash);
                        updateCmd.Parameters.AddWithValue("@Salt", newSalt);
                        updateCmd.Parameters.AddWithValue("@UserID", userId);
                        updateCmd.ExecuteNonQuery();
                    }

                    ShowMessage("✅ Password updated successfully!", "success");
                    // Clear form fields
                    txtOldPassword.Text = "";
                    txtNewPassword.Text = "";
                    txtConfirmPassword.Text = "";
                }
            }
            catch (Exception ex)
            {
                ShowMessage("⚠️ Error: " + ex.Message, "danger");
            }
        }

        private void ShowMessage(string message, string alertType)
        {
            lblMsg.Text = message;
            lblMsg.CssClass = $"alert alert-{alertType} d-block";
            lblMsg.Style.Remove("display");
        }

        // 🔐 Helper Methods
        public static string GenerateSalt()
        {
            byte[] saltBytes = new byte[16];
            using (var rng = new RNGCryptoServiceProvider())
            {
                rng.GetBytes(saltBytes);
            }
            return Convert.ToBase64String(saltBytes);
        }

        public static string HashPassword(string password, string salt)
        {
            var saltBytes = Convert.FromBase64String(salt);
            using (var deriveBytes = new Rfc2898DeriveBytes(password, saltBytes, 10000))
            {
                byte[] hashBytes = deriveBytes.GetBytes(32);
                return Convert.ToBase64String(hashBytes);
            }
        }

        public static bool VerifyPassword(string password, string salt, string storedHash)
        {
            string computedHash = HashPassword(password, salt);
            return SlowEquals(Convert.FromBase64String(storedHash), Convert.FromBase64String(computedHash));
        }

        private static bool SlowEquals(byte[] a, byte[] b)
        {
            uint diff = (uint)a.Length ^ (uint)b.Length;
            for (int i = 0; i < a.Length && i < b.Length; i++)
                diff |= (uint)(a[i] ^ b[i]);
            return diff == 0;
        }
    }
}
