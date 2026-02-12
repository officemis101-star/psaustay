<%@ Page Title="Change Password" Language="C#" MasterPageFile="~/AdminControl.master" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="PSAUStay.Account.ChangePassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AdminMainContent" runat="server">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3 class="mb-0">
            <i class="bi bi-shield-lock-fill me-2" style="color: var(--psau-gold);"></i>
            Change Password
        </h3>
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb mb-0">
                <li class="breadcrumb-item">
                    <a href="<%= ResolveUrl("~/Admin/Dashboard.aspx") %>" style="color: var(--psau-green); text-decoration: none;">Dashboard</a>
                </li>
                <li class="breadcrumb-item">
                    <a href="#" style="color: var(--psau-green); text-decoration: none;">Security</a>
                </li>
                <li class="breadcrumb-item active" aria-current="page">Change Password</li>
            </ol>
        </nav>
    </div>

    <div class="row">
        <div class="col-lg-6 col-md-8">
            <div class="card shadow-sm border-0">
                <div class="card-header bg-gradient" style="background: linear-gradient(135deg, var(--psau-green) 0%, var(--psau-green-dark) 100%);">
                    <h5 class="mb-0 text-white">
                        <i class="bi bi-key-fill me-2"></i>Update Your Password
                    </h5>
                </div>
                <div class="card-body p-4">
                    <asp:Label ID="lblMsg" runat="server" CssClass="alert d-block" style="display: none;"></asp:Label>
                    
                    <div class="mb-4">
                        <div class="form-group mb-3">
                            <label for="txtOldPassword" class="form-label fw-semibold">
                                <i class="bi bi-lock-fill me-1 text-muted"></i>
                                Current Password
                            </label>
                            <asp:TextBox ID="txtOldPassword" CssClass="form-control form-control-lg" 
                                runat="server" TextMode="Password" placeholder="Enter your current password"></asp:TextBox>
                        </div>

                        <div class="form-group mb-3">
                            <label for="txtNewPassword" class="form-label fw-semibold">
                                <i class="bi bi-shield-check me-1 text-muted"></i>
                                New Password
                            </label>
                            <asp:TextBox ID="txtNewPassword" CssClass="form-control form-control-lg" 
                                runat="server" TextMode="Password" placeholder="Enter your new password"></asp:TextBox>
                            <div class="form-text text-muted">
                                <small>Password should be at least 8 characters long</small>
                            </div>
                        </div>

                        <div class="form-group mb-4">
                            <label for="txtConfirmPassword" class="form-label fw-semibold">
                                <i class="bi bi-shield-lock me-1 text-muted"></i>
                                Confirm New Password
                            </label>
                            <asp:TextBox ID="txtConfirmPassword" CssClass="form-control form-control-lg" 
                                runat="server" TextMode="Password" placeholder="Confirm your new password"></asp:TextBox>
                        </div>

                        <div class="d-grid gap-2">
                            <asp:Button ID="btnUpdate" runat="server" Text="Update Password" 
                                CssClass="btn btn-lg btn-success" OnClick="btnUpdate_Click" 
                                style="background-color: var(--psau-green); border-color: var(--psau-green);" />
                            <a href="<%= ResolveUrl("~/Admin/Dashboard.aspx") %>" class="btn btn-outline-secondary btn-lg">
                                <i class="bi bi-arrow-left me-2"></i>Back to Dashboard
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Security Tips Card -->
            <div class="card shadow-sm border-0 mt-4">
                <div class="card-header bg-light">
                    <h6 class="mb-0">
                        <i class="bi bi-info-circle-fill me-2 text-info"></i>
                        Security Tips
                    </h6>
                </div>
                <div class="card-body">
                    <ul class="mb-0">
                        <li class="mb-2">Use a strong password with letters, numbers, and special characters</li>
                        <li class="mb-2">Don't reuse passwords from other accounts</li>
                        <li class="mb-0">Change your password regularly for better security</li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="col-lg-6 col-md-4">
            <div class="card shadow-sm border-0">
                <div class="card-body text-center p-5">
                    <div class="mb-4">
                        <i class="bi bi-shield-check" style="font-size: 5rem; color: var(--psau-green);"></i>
                    </div>
                    <h5 class="card-title mb-3">Password Security</h5>
                    <p class="card-text text-muted">
                        Keeping your password secure helps protect your account and sensitive data. 
                        Regular password updates are an important part of maintaining good security practices.
                    </p>
                    <div class="mt-4">
                        <span class="badge bg-success me-2">
                            <i class="bi bi-check-circle me-1"></i>Encrypted
                        </span>
                        <span class="badge bg-success me-2">
                            <i class="bi bi-shield-lock me-1"></i>Secure Storage
                        </span>
                        <span class="badge bg-info">
                            <i class="bi bi-clock-history me-1"></i>Regular Updates
                        </span>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <style>
        .card {
            border-radius: 12px;
            transition: transform 0.2s ease-in-out;
        }
        
        .card:hover {
            transform: translateY(-2px);
        }
        
        .form-control:focus {
            border-color: var(--psau-green);
            box-shadow: 0 0 0 0.2rem rgba(11, 102, 35, 0.25);
        }
        
        .btn-success:hover {
            background-color: var(--psau-green-dark) !important;
            border-color: var(--psau-green-dark) !important;
        }
        
        .breadcrumb-item + .breadcrumb-item::before {
            content: "›";
            color: var(--psau-green);
        }
        
        .alert {
            border-radius: 8px;
            border: none;
        }
        
        .alert-success {
            background-color: #d4edda;
            color: #155724;
        }
        
        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
        }
    </style>
</asp:Content>
