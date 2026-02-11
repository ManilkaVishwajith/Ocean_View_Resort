<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.oceanview.model.Reservation" %>
<%
    // Servlet එකෙන් එවපු Object එක මෙතනින් ගන්නවා
    Reservation r = (Reservation) request.getAttribute("reservation");
    Long days = (Long) request.getAttribute("days");
    Double total = (Double) request.getAttribute("total");

    // දත්ත නැත්නම් ආපහු යවන්න
    if (r == null) {
        response.sendRedirect("../reservations/viewAll.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Invoice #<%= r.getId() %> | Ocean View</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    
    <style>
        body { font-family: 'Poppins', sans-serif; background-color: #f8f9fa; }
        
        /* Glass Card Style */
        .invoice-container {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 50px;
            margin-top: 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            border: 1px solid #eee;
        }

        .invoice-header { border-bottom: 2px solid #007bff; padding-bottom: 20px; margin-bottom: 30px; }
        .resort-name { font-weight: 700; color: #007bff; letter-spacing: 1px; }
        .table thead { background-color: #007bff; color: white; }
        
        /* Print කරනකොට බටන් හංගන්න */
        @media print {
            .no-print { display: none; }
            body { background: white; }
            .invoice-container { box-shadow: none; border: none; margin-top: 0; padding: 0; }
        }
    </style>
</head>
<body>

<div class="container d-flex justify-content-center">
    <div class="invoice-container col-lg-9">
        
        <div class="invoice-header d-flex justify-content-between align-items-center">
            <div>
                <h1 class="resort-name mb-0">OCEAN VIEW RESORT 🌊</h1>
                <p class="text-muted mb-0">Luxury redefined at the shore</p>
            </div>
            <div class="text-end">
                <h3 class="fw-bold">INVOICE</h3>
                <span class="badge bg-primary">#INV-00<%= r.getId() %></span>
            </div>
        </div>

        <div class="row mb-5">
            <div class="col-md-6">
                <h6 class="text-uppercase text-muted border-bottom pb-2">Guest Details</h6>
                <p class="mb-0 fw-bold"><%= r.getCustomerName() %></p>
                <p class="text-muted"><%= r.getEmail() %></p>
            </div>
            <div class="col-md-6 text-md-end">
                <h6 class="text-uppercase text-muted border-bottom pb-2">Stay Information</h6>
                <p class="mb-0"><strong>Check-In:</strong> <%= r.getCheckIn() %></p>
                <p class="mb-0"><strong>Check-Out:</strong> <%= r.getCheckOut() %></p>
                <p class="mb-0"><strong>Total Nights:</strong> <%= days %></p>
            </div>
        </div>

        <div class="table-responsive">
            <table class="table table-hover border">
                <thead>
                    <tr>
                        <th>Description</th>
                        <th class="text-center">Rate</th>
                        <th class="text-center">Nights</th>
                        <th class="text-end">Subtotal</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            <span class="fw-bold"><%= r.getRoomType() %> Room Booking</span><br>
                            <small class="text-muted">Standard resort charges and amenities</small>
                        </td>
                        <td class="text-center">LKR <%= r.getRoomPrice() %></td>
                        <td class="text-center"><%= days %></td>
                        <td class="text-end fw-bold">
                            <% 
                                double rate = Double.parseDouble(r.getRoomPrice());
                                out.print("LKR " + String.format("%.2f", rate * days));
                            %>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>

        <div class="row mt-4">
            <div class="col-md-7">
                <div class="p-3 bg-light rounded">
                    <small class="text-muted">Important: This is a computer-generated invoice. Payment is due at the time of check-out.</small>
                </div>
            </div>
            <div class="col-md-5">
                <table class="table table-borderless">
                    <tr>
                        <td class="text-end">Subtotal:</td>
                        <td class="text-end fw-bold">LKR <%= String.format("%.2f", rate * days) %></td>
                    </tr>
                    <tr>
                        <td class="text-end text-muted">Service Tax (10%):</td>
                        <td class="text-end text-muted">LKR <%= String.format("%.2f", (rate * days) * 0.10) %></td>
                    </tr>
                    <tr class="border-top border-dark fs-5">
                        <td class="text-end fw-bold">TOTAL:</td>
                        <td class="text-end fw-bold text-primary">LKR <%= String.format("%.2f", total) %></td>
                    </tr>
                </table>
            </div>
        </div>

        <div class="text-center mt-5 no-print">
            <hr>
            <button onclick="window.print()" class="btn btn-primary px-4 rounded-pill me-2">
                <i class="fas fa-print me-2"></i> Print Invoice
            </button>
            <a href="../reservations/viewAll.jsp" class="btn btn-outline-secondary px-4 rounded-pill">
                Back to List
            </a>
        </div>

    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>