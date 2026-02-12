<%@ Page Title="Reset Counts" Language="C#" MasterPageFile="~/AdminControl.master" AutoEventWireup="true" CodeBehind="ResetCounts.aspx.cs" Inherits="PSAUStay.Admin.ResetCounts" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AdminMainContent" runat="server">
    <%-- Green Header --%>
    <div class="card shadow-sm border-0 mb-4" style="background: linear-gradient(135deg, var(--psau-green) 0%, var(--psau-green-dark) 100%);">
        <div class="card-body p-4">
            <div class="row align-items-center">
                <div class="col">
                    <h2 class="mb-1 fw-bold text-white">
                        <i class="bi bi-arrow-clockwise me-2" style="color: var(--psau-gold);"></i>
                        Reset Dashboard Counts
                    </h2>
                    <p class="mb-0 text-white-50">Reset all booking status counts and statistics</p>
                </div>
            </div>
        </div>
    </div>

    <div class="container mt-4">
        <div class="alert alert-warning">
            <strong>Warning:</strong> This will reset all booking status counts. This action cannot be undone.
        </div>

        <div class="card border-0 shadow-sm">
            <div class="card-body">
                <h5>Current Status Distribution</h5>
                <asp:Literal ID="litCurrentCounts" runat="server"></asp:Literal>
                
                <hr />
                
                <div class="d-flex gap-2">
                    <asp:Button ID="btnResetToPending" runat="server" Text="Reset All to Pending" 
                        CssClass="btn btn-warning" OnClick="btnResetToPending_Click" />
                    <asp:Button ID="btnClearAll" runat="server" Text="Clear All Data" 
                        CssClass="btn btn-danger" OnClick="btnClearAll_Click" />
                    <asp:Button ID="btnRefresh" runat="server" Text="Refresh Counts" 
                        CssClass="btn btn-secondary" OnClick="btnRefresh_Click" />
                </div>
            </div>
        </div>

        <div class="mt-3">
            <asp:Label ID="lblMessage" runat="server" CssClass="alert alert-success d-block" style="display:none;"></asp:Label>
        </div>
    </div>
</asp:Content>
