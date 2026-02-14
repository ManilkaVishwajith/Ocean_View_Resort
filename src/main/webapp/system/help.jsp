<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Help & Support | Ocean View</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: url('${pageContext.request.contextPath}/img/double.jpg') no-repeat center center fixed;
            background-size: cover;
            min-height: 100vh;
            color: white;
            padding: 40px 0;
        }

        .overlay {
            position: fixed; top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0, 0, 0, 0.6); z-index: -1;
        }

        .glass-container {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 30px;
            padding: 40px;
            box-shadow: 0 25px 50px rgba(0,0,0,0.4);
            max-width: 900px;
            margin: auto;
        }

        /* Accordion Styles */
        .accordion-item {
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            margin-bottom: 15px;
            border-radius: 15px !important;
            overflow: hidden;
        }

        .accordion-button {
            background: rgba(255, 255, 255, 0.05);
            color: #ffd700;
            font-weight: 600;
            box-shadow: none;
        }

        .accordion-button:not(.collapsed) {
            background: rgba(255, 215, 0, 0.2);
            color: white;
            box-shadow: none;
        }

        .accordion-button::after {
            filter: invert(1); /* Make arrow white */
        }

        .accordion-body {
            color: rgba(255, 255, 255, 0.9);
            font-size: 0.95rem;
            line-height: 1.6;
        }

        .step-icon {
            color: #ffd700;
            margin-right: 10px;
        }

        .btn-back {
            background: rgba(255, 255, 255, 0.15);
            color: white;
            border: 1px solid rgba(255, 255, 255, 0.3);
            padding: 10px 30px;
            border-radius: 30px;
            transition: 0.3s;
            text-decoration: none;
        }

        .btn-back:hover {
            background: #ffd700;
            color: black;
        }
    </style>
</head>
<body>

    <div class="overlay"></div>

    <div class="container">
        <div class="glass-container">
            <div class="text-center mb-5">
                <i class="fas fa-life-ring fa-3x text-warning mb-3"></i>
                <h2 class="fw-bold">User Guide & Support</h2>
                <p class="text-white-50">Everything you need to know about managing reservations</p>
            </div>

            <div class="accordion" id="helpAccordion">
                
                <div class="accordion-item">
                    <h2 class="accordion-header">
                        <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne">
                            <i class="fas fa-desktop step-icon"></i> System Overview
                        </button>
                    </h2>
                    <div id="collapseOne" class="accordion-collapse collapse show" data-bs-parent="#helpAccordion">
                        <div class="accordion-body">
                            Welcome to the <strong>Ocean View Resort Management System</strong>. This platform allows Staff and Admins to manage bookings efficiently.
                            <ul>
                                <li><strong>Dashboard:</strong> Your central hub for quick actions.</li>
                                <li><strong>My Bookings:</strong> View, Edit, or Delete existing reservations.</li>
                                <li><strong>Search:</strong> Quickly find customers by ID, Name, or Date.</li>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="accordion-item">
                    <h2 class="accordion-header">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo">
                            <i class="fas fa-plus-circle step-icon"></i> How to Add a Reservation?
                        </button>
                    </h2>
                    <div id="collapseTwo" class="accordion-collapse collapse" data-bs-parent="#helpAccordion">
                        <div class="accordion-body">
                            <ol>
                                <li>Navigate to the <strong>"New Reservation"</strong> page.</li>
                                <li>Fill in the <strong>Customer Name, NIC, Contact Number</strong>.</li>
                                <li>Select the desired <strong>Room Type</strong> (Price will auto-update).</li>
                                <li>Choose <strong>Check-in</strong> and <strong>Check-out</strong> dates.</li>
                                <li>Click <strong>"Save Reservation"</strong> to confirm.</li>
                            </ol>
                        </div>
                    </div>
                </div>

                <div class="accordion-item">
                    <h2 class="accordion-header">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree">
                            <i class="fas fa-file-invoice-dollar step-icon"></i> How Billing Works?
                        </button>
                    </h2>
                    <div id="collapseThree" class="accordion-collapse collapse" data-bs-parent="#helpAccordion">
                        <div class="accordion-body">
                            The system automatically calculates the bill based on your stay duration.
                            <br><br>
                            <code>Total = (Price Per Night) x (Number of Days)</code>
                            <br><br>
                            Navigate to <strong>My Bookings</strong> and click the <i class="fas fa-file-invoice"></i> <strong>Invoice</strong> button to generate a printable bill.
                        </div>
                    </div>
                </div>

            </div>

            <div class="text-center mt-5">
                <a href="${pageContext.request.contextPath}/system/admindashboard.jsp" class="btn-back">
                    <i class="fas fa-arrow-left me-2"></i> Back to Dashboard
                </a>
            </div>

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>