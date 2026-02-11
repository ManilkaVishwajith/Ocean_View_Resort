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

        /* පසුබිම (Background Animation) - Index Page එකේ වගේමයි */
        .bg-image {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('../img/double.jpg') no-repeat center center;
            background-size: cover;
            filter: blur(4px); /* පොඩි Blur එකක් දැම්මා ෆෝම් එක කැපිලා පේන්න */
            z-index: -1;
            transform: scale(1.1);
        }

        .overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, rgba(0, 24, 56, 0.8), rgba(0, 0, 0, 0.6));
            z-index: 0;
        }

        /* Glassmorphism Login Card */
        .login-card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 20px;
            padding: 40px;
            width: 100%;
            max-width: 400px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.5);
            color: white;
            z-index: 2;
            animation: slideDown 1s ease;
        }

        .login-header {
            text-align: center;
            margin-bottom: 30px;
        }

        .login-header h3 {
            font-weight: 600;
            letter-spacing: 1px;
        }

        .login-header i {
            font-size: 3rem;
            margin-bottom: 10px;
            color: #ffd700; /* Gold Color Icon */
            text-shadow: 0 0 10px rgba(255, 215, 0, 0.5);
        }

        /* Input Fields Styling */
        .form-control {
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.3);
            color: white;
            border-radius: 30px;
            padding: 12px 20px;
            padding-left: 45px; /* Icon එකට ඉඩ */
        }

        .form-control:focus {
            background: rgba(255, 255, 255, 0.2);
            box-shadow: none;
            border-color: #ffd700;
            color: white;
        }

        .form-control::placeholder {
            color: rgba(255, 255, 255, 0.6);
        }

        .input-group-text {
            background: transparent;
            border: none;
            color: #ffd700;
            position: absolute;
            left: 15px;
            top: 10px;
            z-index: 10;
        }

        .input-wrapper {
            position: relative;
            margin-bottom: 20px;
        }

        /* Buttons */
        .btn-login {
            background: linear-gradient(45deg, #d4af37, #c5a028);
            border: none;
            border-radius: 30px;
            padding: 12px;
            font-weight: 600;
            width: 100%;
            transition: 0.3s;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: white;
        }

        .btn-login:hover {
            transform: scale(1.02);
            box-shadow: 0 5px 15px rgba(212, 175, 55, 0.4);
            color: white;
        }

        .btn-reset {
            background: transparent;
            border: 1px solid rgba(255, 255, 255, 0.5);
            border-radius: 30px;
            padding: 10px;
            width: 100%;
            color: white;
            transition: 0.3s;
            margin-top: 10px;
        }

        .btn-reset:hover {
            background: rgba(255, 255, 255, 0.1);
            border-color: white;
        }

        /* Error Message Alert */
        .alert-glass {
            background: rgba(220, 53, 69, 0.2);
            border: 1px solid rgba(220, 53, 69, 0.5);
            color: #ffcccc;
            border-radius: 15px;
            font-size: 0.9rem;
        }

        /* Links */
        .bottom-links a {
            color: rgba(255, 255, 255, 0.7);
            text-decoration: none;
            font-size: 0.9rem;
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
                <div class="alert alert-glass text-center fade show" role="alert">
                    <i class="fas fa-exclamation-circle me-1"></i> <%= error %>
                </div>
                <% session.removeAttribute("failedMsg"); %>
            <% } %>

            <form action="../login" method="post" novalidate>
                
                <div class="input-wrapper">
                    <span class="input-group-text"><i class="fas fa-user"></i></span>
                    <input type="text" name="username" class="form-control" placeholder="Username" required>
                </div>

                <div class="input-wrapper">
                    <span class="input-group-text"><i class="fas fa-lock"></i></span>
                    <input type="password" name="password" class="form-control" placeholder="Password" required>
                </div>

                <button type="submit" class="btn btn-login shadow">Login <i class="fas fa-sign-in-alt ms-1"></i></button>
                <button type="reset" class="btn btn-reset">Reset Fields</button>

            </form>

            <div class="text-center mt-4 bottom-links">
                <p class="mb-2">Don't have an account? <a href="signup.jsp" class="fw-bold text-warning">Sign Up</a></p>
                <a href="../home/index.jsp"><i class="fas fa-arrow-left me-1"></i> Back to Home</a>
            </div>

        </div>
    </div>

    <script>
        // Form එක Submit වෙද්දී Empty නම් Alert එකක් පෙන්වන්න (Browser Default වලට වඩා ලස්සනට)
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
                e.preventDefault(); // නවත්වන්න
                // alert("Please fill in all fields!"); // ඕන නම් දාන්න පුළුවන්
            }
        });
    </script>
</body>
</html>