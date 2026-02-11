<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Make Reservation | Ocean View Resort</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            overflow-x: hidden;
            color: white;
        }

        /* 🔹 පසුබිම (Dashboard Theme) */
        .bg-image {
            position: fixed;
            top: 0; left: 0; width: 100%; height: 100%;
            background: url('../img/double.jpg') no-repeat center center;
            background-size: cover;
            z-index: -1;
            filter: blur(8px);
            transform: scale(1.1);
        }

        .overlay {
            position: fixed;
            top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0, 0, 0, 0.7); /* අඳුරු ආවරණය */
            z-index: -1;
        }

        /* 🔹 Glass Card Effect */
        .glass-card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 25px;
            padding: 40px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.5);
            animation: slideUp 0.8s ease-in-out;
        }

        /* 🔹 Inputs & Labels */
        .form-label {
            font-weight: 500;
            color: #ffd700; /* Gold Color */
            margin-bottom: 8px;
            font-size: 0.95rem;
        }

        .form-control, .form-select {
            background: rgba(255, 255, 255, 0.1) !important;
            border: 1px solid rgba(255, 255, 255, 0.3);
            color: white !important;
            border-radius: 12px;
            padding: 12px;
            transition: 0.3s;
        }

        .form-control:focus, .form-select:focus {
            background: rgba(255, 255, 255, 0.2) !important;
            border-color: #ffd700;
            box-shadow: 0 0 10px rgba(255, 215, 0, 0.3);
        }

        /* Input Placeholder Color */
        .form-control::placeholder {
            color: rgba(255, 255, 255, 0.5);
        }

        /* Dropdown Options (Browser Default Fix) */
        option {
            background: #333;
            color: white;
        }

        /* 🔹 Submit Button */
        .btn-confirm {
            background: linear-gradient(45deg, #d4af37, #c5a028);
            border: none;
            color: white;
            padding: 15px;
            border-radius: 15px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: 0.3s;
            margin-top: 20px;
        }

        .btn-confirm:hover {
            transform: scale(1.02);
            box-shadow: 0 5px 20px rgba(212, 175, 55, 0.4);
            color: white;
        }

        /* 🔹 Back Link */
        .btn-back {
            color: rgba(255, 255, 255, 0.7);
            text-decoration: none;
            font-size: 0.9rem;
            transition: 0.3s;
        }

        .btn-back:hover {
            color: #ffd700;
        }

        @keyframes slideUp {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>

    <div class="bg-image"></div>
    <div class="overlay"></div>

    <div class="container mb-5">
        <div class="row justify-content-center" style="margin-top: 60px;">
            <div class="col-lg-6 col-md-8">
                
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <a href="viewAll.jsp" class="btn-back">
                        <i class="fas fa-arrow-left me-2"></i> Back to List
                    </a>
                    <a href="../system/dashboard.jsp" class="btn-back">
                        <i class="fas fa-home me-2"></i> Dashboard
                    </a>
                </div>

                <div class="glass-card">
                    <div class="text-center mb-4">
                        <i class="fas fa-concierge-bell fa-3x text-warning mb-3"></i>
                        <h2 class="fw-bold">Book Your Stay 🏨</h2>
                        <p class="text-white-50">Enter guest details to create a new reservation.</p>
                    </div>

                    <form action="../reservation/add" method="post">
                        
                        <div class="mb-3">
                            <label class="form-label"><i class="fas fa-user me-2"></i>Customer Name</label>
                            <input type="text" name="customerName" class="form-control" placeholder="Enter guest full name" required>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label"><i class="fas fa-envelope me-2"></i>Email Address</label>
                            <input type="email" name="email" class="form-control" placeholder="guest@example.com" required>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label"><i class="fas fa-bed me-2"></i>Room Type</label>
                                <select name="roomType" class="form-select" id="roomSelect" onchange="updatePrice()">
                                    <option value="Luxury" data-price="25000">Luxury</option>
                                    <option value="Deluxe" data-price="15000">Deluxe</option>
                                    <option value="Standard" data-price="8000">Standard</option>
                                </select>
                            </div>
                            
                            <div class="col-md-6 mb-3">
                                <label class="form-label"><i class="fas fa-tag me-2"></i>Price (LKR)</label>
                                <input type="number" name="roomPrice" id="priceInput" class="form-control" value="25000" readonly>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label"><i class="fas fa-calendar-alt me-2"></i>Check-In</label>
                                <input type="date" name="checkIn" class="form-control" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label"><i class="fas fa-calendar-check me-2"></i>Check-Out</label>
                                <input type="date" name="checkOut" class="form-control" required>
                            </div>
                        </div>

                        <button type="submit" class="btn btn-confirm w-100">
                            <i class="fas fa-check-circle me-2"></i> Confirm Booking
                        </button>
                    </form>
                </div>
                
                <div class="text-center mt-4">
                    <small class="text-white-50">&copy; 2026 Ocean View Resort System</small>
                </div>

            </div>
        </div>
    </div>

    <script>
        function updatePrice() {
            var select = document.getElementById("roomSelect");
            var priceInput = document.getElementById("priceInput");
            
            // තෝරාගත් Option එකේ 'data-price' අගය ගන්න
            var selectedOption = select.options[select.selectedIndex];
            var price = selectedOption.getAttribute("data-price");
            
            // Price Input එකට එම අගය දාන්න
            priceInput.value = price;
        }
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>