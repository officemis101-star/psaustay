<%@ Page Title="Booking Success" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BookingSuccess.aspx.cs" Inherits="PSAUStay.BookingSuccess" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-7">
                <div class="card border-0 shadow-lg" style="border-radius: 20px; overflow: hidden;">
                    <div class="bg-success py-5 text-white text-center">
                        <i class="bi bi-check-circle-fill" style="font-size: 4.5rem;"></i>
                        <h2 class="fw-bold mt-2">Booking Submitted!</h2>
                        <p class="opacity-75 mb-0">Reference Number: <span class="fw-bold">#<asp:Literal ID="litRefNumber" runat="server" /></span></p>
                    </div>

                    <div class="card-body p-4 p-md-5">
                        <asp:Label ID="lblEmailStatus" runat="server" CssClass="alert alert-info d-block small mb-4" Visible="false"></asp:Label>

                        <h5 class="fw-bold mb-4 text-dark border-bottom pb-2">Reservation Details</h5>
                        
                        <div class="row g-3 mb-4">
                            <div class="col-sm-6">
                                <label class="text-muted small text-uppercase fw-bold d-block">Guest Name</label>
                                <p class="fw-bold"><asp:Literal ID="litGuestName" runat="server" /></p>
                            </div>
                            <div class="col-sm-6">
                                <label class="text-muted small text-uppercase fw-bold d-block">Contact Number</label>
                                <p class="fw-bold"><asp:Literal ID="litContact" runat="server" /></p>
                            </div>
                            <div class="col-sm-12">
                                <label class="text-muted small text-uppercase fw-bold d-block">Stay Dates</label>
                                <p class="fw-bold"><asp:Literal ID="litDates" runat="server" /></p>
                            </div>
                        </div>

                        <div class="bg-light p-4 rounded-3 mb-4">
                            <div class="d-flex justify-content-between mb-2">
                                <span class="text-muted">Total Room Price:</span>
                                <span class="fw-bold">₱<asp:Literal ID="litTotalPrice" runat="server" /></span>
                            </div>
                            <div class="d-flex justify-content-between align-items-center pt-2 border-top border-2">
                                <span class="text-dark fw-bold">Required Payment:</span>
                                <span class="h4 mb-0 fw-bold text-success">₱<asp:Literal ID="litDownpayment" runat="server" /></span>
                            </div>
                        </div>

                        <div class="p-3 rounded-3 mb-4" style="background-color: #fff9e6; border-left: 5px solid #ffc107;">
                            <h6 class="fw-bold"><i class="bi bi-info-circle me-2"></i>Action Required</h6>
                            <p class="small mb-0">
                                Please settle the downpayment to <strong><asp:Literal ID="litPaymentInfo" runat="server" /></strong>. 
                                Send payment receipt to (<strong>mmarcusivanmiranda@gmail.com</strong>) for your proof of payment.
                            </p>
                        </div>

                        <div class="d-grid gap-2 d-md-flex justify-content-md-center">
                            <a href="OnlineBooking.aspx" class="btn btn-success btn-lg px-5 rounded-pill shadow-sm fw-bold">Return to Home</a>
                            <button type="button" onclick="window.print();" class="btn btn-outline-secondary px-4 rounded-pill">
                                <i class="bi bi-printer me-1"></i> Print Receipt
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>