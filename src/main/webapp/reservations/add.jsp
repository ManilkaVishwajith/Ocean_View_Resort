<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>New Reservation | Ocean View</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background: url('${pageContext.request.contextPath}/img/double.jpg') no-repeat center center fixed;
            background-size: cover;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 0;
        }

        .overlay {
            position: fixed; top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0, 0, 0, 0.5); z-index: -1;
        }

        /* 🔹 Advanced Glass Card */
        .glass-card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 30px;
            padding: 40px;
            width: 100%;
            max-width: 700px;
            box-shadow: 0 25px 50px rgba(0,0,0,0.4);
            color: white;
            animation: slideIn 0.8s ease;
        }

        /* 🔹 Form Inputs Styling */
        .form-label { color: #ffd700; font-weight: 500; font-size: 0.9rem; margin-bottom: 8px; }
        
        .input-group-text {
            background: rgba(255, 255, 255, 0.2);
            border: 1px solid rgba(255, 255, 255, 0.3);
            color: #ffd700;
            border-right: none;
        }

        .form-control, .form-select {
            background: rgba(255, 255, 255, 0.1) !important;
            border: 1px solid rgba(255, 255, 255, 0.3);
            border-left: none;
            color: white !important;
            height: 48px;
        }

        .form-control:focus, .form-select:focus {
            background: rgba(255, 255, 255, 0.2) !important;
            border-color: #ffd700;
            box-shadow: none;
        }

        /* Dropdown options color */
        .form-select option { background: #1a1a1a; color: white; }

        /* 🔹 Buttons Styling */
        .btn-save {
            background: linear-gradient(45deg, #28a745, #218838);
            border: none; color: white; padding: 12px 30px;
            border-radius: 30px; font-weight: 600; transition: 0.3s;
        }
        .btn-save:hover { transform: scale(1.05); box-shadow: 0 0 15px rgba(40, 167, 69, 0.5); }

        .btn-back {
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.3);
            color: white; padding: 12px 30px;
            border-radius: 30px; text-decoration: none; transition: 0.3s;
        }
        .btn-back:hover { background: rgba(255, 255, 255, 0.2); color: #ffd700; }

        @keyframes slideIn {
            from { opacity: 0; transform: translateY(30px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>

    <div class="overlay"></div>

    <div class="glass-card">
        <div class="text-center mb-4">
            <i class="fas fa-calendar-plus fa-3x text-warning mb-3"></i>
            <h2 class="fw-bold">Book Your Paradise 🌊</h2>
            <p class="text-white-50">Fill the details to confirm your stay</p>
        </div>

        <form action="${pageContext.request.contextPath}/ReservationServlet" method="post">
            
            <div class="row">
                <div class="col-md-12 mb-3">
                    <label class="form-label">Customer Full Name</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-user"></i></span>
                        <input type="text" name="customerName" class="form-control" placeholder="Enter name" required>
                    </div>
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label">NIC Number</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-id-card"></i></span>
                        <input type="text" name="nic" class="form-control" placeholder="NIC / Passport" required>
                    </div>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Contact Number</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-phone"></i></span>
                        <input type="text" name="contactNo" class="form-control" placeholder="Phone number" required>
                    </div>
                </div>

                <div class="col-md-6 mb-3">
                    <label class="form-label">Room Type</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-bed"></i></span>
                        <select name="roomType" class="form-select" required>
                            <option value="" disabled selected>Select Room</option>
                            <option value="Single">Single Room (LKR 5000)</option>
                            <option value="Double">Double Room (LKR 8500)</option>
                            <option value="Luxury Suite">Luxury Suite (LKR 15000)</option>
                        </select>
                    </div>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Number of Guests</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-users"></i></span>
                        <input type="number" name="noOfGuests" class="form-control" min="1" max="10" required>
                    </div>
                </div>

                <div class="col-md-6 mb-4">
                    <label class="form-label">Check-in Date</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-calendar-alt"></i></span>
                        <input type="date" name="checkIn" class="form-control" required>
                    </div>
                </div>
                <div class="col-md-6 mb-4">
                    <label class="form-label">Check-out Date</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-calendar-check"></i></span>
                        <input type="date" name="checkOut" class="form-control" required>
                    </div>
                </div>
            </div>

            <div class="d-flex justify-content-between align-items-center mt-3">
                <a href="${pageContext.request.contextPath}/home/index.jsp" class="btn-back">
                    <i class="fas fa-arrow-left me-2"></i>Back
                </a>
                <div>
                    <button type="reset" class="btn btn-outline-danger rounded-pill px-4 me-2">Cancel</button>
                    <button type="submit" class="btn-save shadow">
                        <i class="fas fa-save me-2"></i>Save Reservation
                    </button>
                </div>
            </div>
        </form>
    </div>

</body>
</html>