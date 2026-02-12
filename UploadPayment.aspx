<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UploadPayment.aspx.cs" Inherits="PSAUStay.UploadPayment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container" style="max-width: 600px; margin-top: 50px;">
        <h2 class="text-center mb-4">Upload Payment Proof</h2>
        <asp:Label ID="lblMessage" runat="server" CssClass="text-danger mb-3 d-block"></asp:Label>

        <asp:Panel ID="pnlUpload" runat="server" Visible="false">
            <asp:FileUpload ID="fuPaymentProof" runat="server" CssClass="form-control mb-3" 
                            onchange="previewFile(this)" />
            
            <!-- Image preview -->
            <div class="mb-3">
                <img id="imgPreview" src="#" style="display:none; max-width:100%; height:auto; border:1px solid #ccc; padding:5px;" />
            </div>

            <asp:Button ID="Button1" runat="server" Text="Upload Payment Proof" CssClass="btn btn-primary" OnClick="btnUpload_Click" />
        </asp:Panel>

        <asp:Panel ID="pnlExpired" runat="server" Visible="false">
            <p class="text-center text-danger">
                This upload link has expired or is invalid. Please contact support.
            </p>
        </asp:Panel>
    </div>

    <script type="text/javascript">
        function previewFile(input) {
            var file = input.files[0];
            if (file) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    var img = document.getElementById('imgPreview');
                    img.src = e.target.result;
                    img.style.display = 'block';
                };
                reader.readAsDataURL(file);
            }
        }
    </script>
</asp:Content>
