<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | Ocean View Resort</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        body, html {
            height: 100%;
            margin: 0;
            font-family: 'Poppins', sans-serif;
            overflow: hidden;
        }

        /* 🔹 Background Image */
        .bg-image {
            position: fixed;
            top: 0; left: 0; width: 100%; height: 100%;
            /* Path එක නිවැරදි කළා */
            background: url('${pageContext.request.contextPath}/img/double.jpg') no-repeat center center;
            background-size: cover;
            filter: blur(4px);
            z-index: -1;
            transform: scale(1.02);
        }

        .overlay {
            position: fixed;
            top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0, 0, 0, 0.5); /* අඳුරු පැහැය */
            z-index: -1;
        }

        /* 🔹 Glassmorphism Card */
        .login-card {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 20px;
            padding: 40px;
            width: 100%;
            max-width: 400px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.5);
            color: white;
            animation: slideDown 0.8s ease;
        }

        .login-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .login-header i {
            font-size: 3rem;
            margin-bottom: 10px;
            color: #ffd700; /* Gold Color */
            text-shadow: 0 0 10px rgba(255, 215, 0, 0.5);
        }

        /* 🔹 Input Fields */
        .form-control {
            background: rgba(255, 255, 255, 0.1) !important;
            border: 1px solid rgba(255, 255, 255, 0.3);
            color: white !important;
            border-radius: 30px;
            padding: 12px 20px 12px 45px;
            height: 50px;
        }

        .form-control:focus {
            background: rgba(255, 255, 255, 0.2) !important;
            box-shadow: none;
            border-color: #ffd700;
        }

        .form-control::placeholder {
            color: rgba(255, 255, 255, 0.7);
        }

        .input-group-text {
            background: transparent;
            border: none;
            color: #ffd700;
            position: absolute;
            left: 15px;
            top: 12px;
            z-index: 10;
        }

        .input-wrapper {
            position: relative;
            margin-bottom: 20px;
        }

        /* 🔹 Buttons */
        .btn-login {
            background: linear-gradient(45deg, #d4af37, #c5a028);
            border: none;
            border-radius: 30px;
            padding: 12px;
            font-weight: 600;
            width: 100%;
            transition: 0.3s;
            color: white;
            margin-top: 10px;
        }

        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(212, 175, 55, 0.4);
            color: white;
        }

        /* Links */
        .bottom-links a {
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            transition: 0.3s;
        }

        .bottom-links a:hover {
            color: #ffd700;
        }

        @keyframes slideDown {
            from { transform: translateY(-50px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }
    </style>
</head>
<body>

    <div class="bg-image"></div>
    <div class="overlay"></div>

    <div class="d-flex justify-content-center align-items-center h-100 w-100">
        <div class="login-card">
            
            <div class="login-header">
                <i class="fas fa-user-circle"></i>
                <h3>Welcome Back</h3>
                <p class="text-white-50">Please login to your account</p>
            </div>

            <% 
            String error = (String) session.getAttribute("failedMsg");
            if(error != null) { 
            %>
                <div class="alert alert-danger bg-transparent text-danger border-danger text-center fade show">
                    <i class="fas fa-exclamation-circle me-1"></i> <%= error %>
                </div>
                <% session.removeAttribute("failedMsg"); %>
            <% } %>

            <% 
            String success = (String) session.getAttribute("succMsg");
            if(success != null) { 
            %>
                <div class="alert alert-success bg-transparent text-success border-success text-center fade show">
                    <i class="fas fa-check-circle me-1"></i> <%= success %>
                </div>
                <% session.removeAttribute("succMsg"); %>
            <% } %>

            <form action="${pageContext.request.contextPath}/login" method="post" novalidate>
                
                <div class="input-wrapper">
                    <span class="input-group-text"><i class="fas fa-user"></i></span>
                    <input type="text" name="username" class="form-control" placeholder="Username" required>
                </div>

                <div class="input-wrapper">
                    <span class="input-group-text"><i class="fas fa-lock"></i></span>
                    <input type="password" name="password" class="form-control" placeholder="Password" required>
                </div>

                <button type="submit" class="btn btn-login shadow">Login <i class="fas fa-sign-in-alt ms-1"></i></button>

            </form>

            <div class="text-center mt-4 bottom-links">
                <p class="mb-2">Don't have an account? <a href="signup.jsp" class="fw-bold text-warning">Sign Up</a></p>
                <a href="${pageContext.request.contextPath}/home/index.jsp">
    <i class="fas fa-arrow-left me-1"></i> Back to Home
</a>
            </div>

        </div>
    </div>

    <script>
        // Validation Script
        document.querySelector('form').addEventListener('submit', function(e) {
            const inputs = this.querySelectorAll('input');
            let valid = true;
            inputs.forEach(input => {
                if(!input.value) {
                    valid = false;
                    input.style.borderColor = '#ff6b6b';
                    input.style.boxShadow = '0 0 5px rgba(255, 107, 107, 0.5)';
                } else {
                    input.style.borderColor = 'rgba(255, 255, 255, 0.3)';
                    input.style.boxShadow = 'none';
                }
            });
            
            if(!valid) {
                e.preventDefault(); 
            }
        });
    </script>
</body>
</html>