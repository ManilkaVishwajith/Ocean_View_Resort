<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up | Ocean View Resort</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

    <style>
        body {
            font-family: 'Poppins', sans-serif;
            overflow: hidden; /* Scrollbar අයින් කිරීමට */
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        /* 🔹 පසුබිම (Background) */
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
            background: rgba(0, 0, 0, 0.6);
            z-index: -1;
        }

        /* 🔹 Glass Card Design */
        .signup-card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 20px;
            padding: 40px;
            width: 100%;
            max-width: 450px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.5);
            animation: zoomIn 0.8s ease;
            color: white;
        }

        /* 🔹 Inputs Styling */
        .form-label {
            font-weight: 500;
            color: #ffd700; /* Gold */
            font-size: 0.9rem;
            margin-bottom: 5px;
        }

        .input-group-text {
            background: rgba(255, 255, 255, 0.2);
            border: 1px solid rgba(255, 255, 255, 0.3);
            border-right: none;
            color: #ffd700;
        }

        .form-control {
            background: rgba(255, 255, 255, 0.1) !important;
            border: 1px solid rgba(255, 255, 255, 0.3);
            border-left: none;
            color: white !important;
            height: 45px;
        }

        .form-control:focus {
            background: rgba(255, 255, 255, 0.2) !important;
            border-color: #ffd700;
            box-shadow: none;
        }

        .form-control::placeholder {
            color: rgba(255, 255, 255, 0.6);
            font-size: 0.9rem;
        }

        /* 🔹 Buttons */
        .btn-signup {
            background: linear-gradient(45deg, #d4af37, #c5a028);
            border: none;
            color: white;
            padding: 12px;
            border-radius: 30px;
            font-weight: 600;
            letter-spacing: 1px;
            transition: 0.3s;
            margin-top: 10px;
        }

        .btn-signup:hover {
            transform: scale(1.05);
            box-shadow: 0 0 15px rgba(212, 175, 55, 0.5);
            color: white;
        }

        .link-text {
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            transition: 0.3s;
            font-size: 0.9rem;
        }

        .link-text:hover {
            color: #ffd700;
        }

        /* 🔹 Home Button */
        .btn-home {
            position: absolute;
            top: 20px;
            left: 20px;
            color: white;
            text-decoration: none;
            font-weight: 500;
            background: rgba(255, 255, 255, 0.1);
            padding: 10px 20px;
            border-radius: 30px;
            backdrop-filter: blur(5px);
            transition: 0.3s;
        }
        .btn-home:hover { background: rgba(255, 255, 255, 0.2); color: #ffd700; }

        @keyframes zoomIn {
            from { opacity: 0; transform: scale(0.9); }
            to { opacity: 1; transform: scale(1); }
        }
    </style>
</head>
<body>

    <div class="bg-image"></div>
    <div class="overlay"></div>

    <a href="../home/index.jsp" class="btn-home"><i class="fas fa-arrow-left me-2"></i>Home</a>

    <div class="signup-card">
        <div class="text-center mb-4">
            <i class="fas fa-user-plus fa-3x text-warning mb-3"></i>
            <h3 class="fw-bold">Join Ocean View 🌊</h3>
            <p class="text-white-50">Create your account to start booking</p>
        </div>

        <% 
            String error = (String) session.getAttribute("regError");
            String success = (String) session.getAttribute("regSuccess");
            
            if(error != null) { %>
                <div class="alert alert-danger bg-transparent text-danger border-danger text-center p-2"><i class="fas fa-exclamation-circle me-2"></i><%= error %></div>
        <%  session.removeAttribute("regError"); } 
            
            if(success != null) { %>
                <div class="alert alert-success bg-transparent text-success border-success text-center p-2"><i class="fas fa-check-circle me-2"></i><%= success %></div>
        <%  session.removeAttribute("regSuccess"); } %>

        <form action="../register" method="post">
            
            <div class="mb-3">
                <label class="form-label">Username</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-user"></i></span>
                    <input type="text" name="username" class="form-control" placeholder="Choose a username" required>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label">Email Address</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                    <input type="email" name="email" class="form-control" placeholder="Enter your email" required>
                </div>
            </div>

            <div class="mb-4">
                <label class="form-label">Password</label>
                <div class="input-group">
                    <span class="input-group-text"><i class="fas fa-lock"></i></span>
                    <input type="password" name="password" class="form-control" placeholder="Create a password" required>
                </div>
            </div>
            
            <input type="hidden" name="role" value="customer">
            
            <button type="submit" class="btn btn-signup w-100">
                Create Account <i class="fas fa-arrow-right ms-2"></i>
            </button>
            
            <div class="text-center mt-4">
                <p class="mb-0 text-white-50">Already have an account?</p>
                <a href="login.jsp" class="link-text fw-bold">Login Here</a>
            </div>
        </form>
    </div>

</body>
</html>