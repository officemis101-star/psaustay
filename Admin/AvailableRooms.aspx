<%@ Page Title="Available Rooms" Language="C#" MasterPageFile="~/AdminControl.master" AutoEventWireup="true" CodeBehind="AvailableRooms.aspx.cs" Inherits="PSAUStay.Admin.AvailableRooms" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AdminMainContent" runat="server">
    <%-- Green Header --%>
    <div class="card shadow-sm border-0 mb-4" style="background: linear-gradient(135deg, var(--psau-green) 0%, var(--psau-green-dark) 100%);">
        <div class="card-body p-4">
            <div class="row align-items-center">
                <div class="col">
                    <h2 class="mb-1 fw-bold text-white">
                        <i class="bi bi-door-open-fill me-2" style="color: var(--psau-gold);"></i>
                        Real-Time Room Availability
                    </h2>
                    <p class="mb-0 text-white-50">View and manage currently available rooms for booking</p>
                </div>
                <div class="col-auto">
                    <a href="<%= ResolveUrl("~/Admin/Dashboard.aspx") %>" class="btn btn-light shadow-sm fw-bold">
                        <i class="bi bi-arrow-left me-2"></i>Back to Dashboard
                    </a>
                </div>
            </div>
        </div>
    </div>

    <div class="card border-0 shadow-sm">
        <div class="card-body">
            <p class="text-muted">Available rooms functionality will be implemented here.</p>
        </div>
    </div>
</asp:Content>
