<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ocean View Resort | Paradise Awaits</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        /* 1. Base Styles */
        body, html {
            height: 100%;
            margin: 0;
            font-family: 'Poppins', sans-serif;
            overflow-x: hidden;
        }

        /* 2. Animated Background */
        .hero-section {
            position: relative;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }

        .hero-bg-img {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            /* ඔයාගේ පින්තූරය මෙතනට ලින්ක් වෙලා තියෙන්නේ */
            background: url('../img/double.jpg') no-repeat center center;
            background-size: cover;
            z-index: -1;
            /* Zoom Animation */
            animation: zoomEffect 20s infinite alternate;
        }

        /* අඳුරු Overlay එකක් (Blue/Black Gradient) */
        .overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, rgba(0, 24, 56, 0.7), rgba(0, 0, 0, 0.5));
            z-index: 0;
        }

        @keyframes zoomEffect {
            0% { transform: scale(1); }
            100% { transform: scale(1.15); }
        }

        /* 3. Glassmorphism Card (වීදුරු පෙට්ටිය) */
        .glass-card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 20px;
            padding: 3rem;
            text-align: center;
            color: white;
            box-shadow: 0 8px 32px 0 rgba(0, 0, 0, 0.37);
            max-width: 800px;
            width: 90%;
            z-index: 2;
            animation: fadeInUp 1.5s ease-out;
        }

        /* 4. Typography */
        .resort-title {
            font-family: 'Playfair Display', serif;
            font-size: 4rem;
            font-weight: 700;
            margin-bottom: 1rem;
            text-shadow: 2px 2px 10px rgba(0,0,0,0.5);
            background: linear-gradient(to right, #ffffff, #ffd700);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }

        .welcome-text {
            font-size: 1.2rem;
            font-weight: 300;
            margin-bottom: 2.5rem;
            color: #f0f0f0;
            letter-spacing: 1px;
        }

        /* 5. Advanced Buttons */
        .btn-luxury {
            background: linear-gradient(45deg, #d4af37, #c5a028);
            border: none;
            color: white;
            padding: 12px 35px;
            font-size: 1.1rem;
            border-radius: 50px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(212, 175, 55, 0.4);
            margin: 10px;
            text-decoration: none;
            display: inline-block;
        }

        .btn-luxury:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(212, 175, 55, 0.6);
            color: white;
        }

        .btn-outline-glass {
            background: transparent;
            border: 2px solid rgba(255, 255, 255, 0.7);
            color: white;
            padding: 10px 35px;
            font-size: 1.1rem;
            border-radius: 50px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1.5px;
            transition: all 0.3s ease;
            margin: 10px;
            text-decoration: none;
            display: inline-block;
        }

        .btn-outline-glass:hover {
            background: white;
            color: #001838;
            transform: translateY(-3px);
        }

        /* 6. Navbar Styles */
        .navbar {
            background: transparent !important;
            padding: 1.5rem 0;
            z-index: 10;
            transition: 0.3s;
        }
        
        .navbar-brand {
            font-family: 'Playfair Display', serif;
            font-size: 1.8rem;
            font-weight: bold;
            color: white !important;
        }

        /* Animations */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translate3d(0, 40px, 0);
            }
            to {
                opacity: 1;
                transform: translate3d(0, 0, 0);
            }
        }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg fixed-top">
        <div class="container">
            <a class="navbar-brand" href="#"><i class="fas fa-water me-2"></i>Ocean View</a>
            <div class="d-flex">
                 <a href="../auth/login.jsp" class="btn text-white fw-bold me-2">Login</a>
                 <a href="../auth/signup.jsp" class="btn btn-outline-light rounded-pill px-4">Sign Up</a>
            </div>
        </div>
    </nav>

    <section class="hero-section">
        <div class="hero-bg-img"></div>
        <div class="overlay"></div>

        <div class="container d-flex justify-content-center">
            <div class="glass-card">
                <i class="fas fa-crown fa-2x mb-3 text-warning"></i>
                <h1 class="resort-title">Ocean View Resort</h1>
                <p class="welcome-text">
                    Escape to a world of luxury and tranquility. <br>
                    Experience the ultimate beachfront paradise where every moment is a memory.
                </p>

                <div class="mt-4">
                    <a href="../reservations/add.jsp" class="btn-luxury">
                        <i class="fas fa-calendar-check me-2"></i> Book Now
                    </a>
                    
                    <a href="../reservations/viewAll.jsp" class="btn-outline-glass">
                        <i class="fas fa-bed me-2"></i> View Rooms
                    </a>
                </div>
                
                <div class="mt-4 text-white-50">
                    <small><i class="fas fa-star text-warning"></i> 5-Star Luxury Experience</small>
                </div>
            </div>
        </div>
    </section>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>