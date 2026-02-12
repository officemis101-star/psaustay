<%@ Page Title="" Language="C#" MasterPageFile="~/AdminControl.master" AutoEventWireup="true" CodeBehind="ManageUsers.aspx.cs" Inherits="PSAUStay.Account.ManageUsers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="AdminMainContent" runat="server">
    <%-- Green Header --%>
    <div class="card shadow-sm border-0 mb-4" style="background: linear-gradient(135deg, var(--psau-green) 0%, var(--psau-green-dark) 100%);">
        <div class="card-body p-4">
            <div class="row align-items-center">
                <div class="col">
                    <h2 class="mb-1 fw-bold text-white">
                        <i class="bi bi-people-fill me-2" style="color: var(--psau-gold);"></i>
                        Manage Users
                    </h2>
                    <p class="mb-0 text-white-50">Create and manage user accounts and permissions</p>
                </div>
                <div class="col-auto">
                    <a href="<%= ResolveUrl("~/Admin/Dashboard.aspx") %>" class="btn btn-light shadow-sm fw-bold me-2">
                        <i class="bi bi-arrow-left me-2"></i>Back to Dashboard
                    </a>
                    <asp:Button ID="btnAddUser" runat="server" Text="➕ Add User" CssClass="btn btn-light shadow-sm fw-bold"
                        OnClick="btnAddUser_Click" />
                </div>
            </div>
        </div>
    </div>

    <!-- Users Grid -->
    <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered"
        OnRowCommand="gvUsers_RowCommand">
        <Columns>

            <asp:BoundField DataField="UserId" HeaderText="ID" />

            <asp:BoundField DataField="FullName" HeaderText="Full Name" />

            <asp:BoundField DataField="Email" HeaderText="Email" />

            <asp:BoundField DataField="AccessLevelName" HeaderText="Role" />

            <asp:TemplateField HeaderText="Actions">
                <ItemTemplate>
                    <asp:Button ID="btnEdit" runat="server" Text="Edit"
                        CommandName="EditUser" CommandArgument='<%# Eval("UserId") %>'
                        CssClass="btn btn-primary btn-sm" />

                    <asp:Button ID="btnDelete" runat="server" Text="Delete"
                        CommandName="DeleteUser" CommandArgument='<%# Eval("UserId") %>'
                        CssClass="btn btn-danger btn-sm" />
                </ItemTemplate>
            </asp:TemplateField>

        </Columns>
    </asp:GridView>

    <!-- Modal Panel for Add/Edit -->
    <asp:Panel ID="pnlModal" runat="server" CssClass="card p-4" Visible="False">

        <h4><asp:Label ID="lblModalTitle" runat="server" Text="Add User"></asp:Label></h4>

        <div class="mb-2">
            <label>Full Name</label>
            <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control"></asp:TextBox>
        </div>

        <div class="mb-2">
            <label>Email</label>
            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>
        </div>

        <div class="mb-2">
            <label>Password</label>
            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
        </div>

        <div class="mb-2">
            <label>Role</label>
            <asp:DropDownList ID="ddlRole" runat="server" CssClass="form-control"></asp:DropDownList>
        </div>

        <asp:Button ID="btnSave" runat="server" Text="Save" CssClass="btn btn-success"
            OnClick="btnSave_Click" />

        <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-secondary"
            OnClick="btnCancel_Click" />

    </asp:Panel>
</asp:Content>
