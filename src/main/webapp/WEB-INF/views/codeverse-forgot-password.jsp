<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password - CodeVerse</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        * {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background: var(--primary-gradient);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }

        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: radial-gradient(circle at 20% 50%, rgba(255, 255, 255, 0.1) 0%, transparent 50%),
                        radial-gradient(circle at 80% 80%, rgba(255, 255, 255, 0.1) 0%, transparent 50%);
            pointer-events: none;
        }

        .forgot-container {
            position: relative;
            z-index: 1;
            width: 100%;
            max-width: 450px;
            padding: 1.5rem;
        }

        .forgot-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            overflow: hidden;
        }

        .forgot-header {
            background: var(--primary-gradient);
            color: white;
            padding: 3rem 2rem;
            text-align: center;
        }

        .forgot-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
            display: inline-block;
            animation: float 3s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
        }

        .forgot-title {
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .forgot-subtitle {
            font-size: 0.95rem;
            opacity: 0.9;
            line-height: 1.5;
        }

        .forgot-form {
            padding: 2.5rem 2rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 0.75rem;
            font-size: 0.95rem;
        }

        .form-control {
            border-radius: 10px;
            border: 2px solid #e5e7eb;
            padding: 0.85rem 1.25rem;
            font-size: 0.95rem;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.15);
            outline: none;
        }

        .form-control::placeholder {
            color: #a0aec0;
        }

        .btn-submit {
            background: var(--primary-gradient);
            color: white;
            border: none;
            border-radius: 10px;
            padding: 0.85rem 1.5rem;
            font-weight: 600;
            font-size: 1rem;
            width: 100%;
            transition: all 0.3s ease;
            margin-top: 1.5rem;
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.4);
            color: white;
        }

        .forgot-links {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin-top: 1.5rem;
            font-size: 0.9rem;
        }

        .forgot-links a {
            color: #667eea;
            text-decoration: none;
            transition: all 0.3s ease;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .forgot-links a:hover {
            color: #764ba2;
            transform: translateX(-3px);
        }

        .alert {
            border: none;
            border-radius: 10px;
            margin-bottom: 1.5rem;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        .alert-danger {
            background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
            color: white;
        }

        .alert-success {
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            color: white;
        }

        .alert-info {
            background: linear-gradient(135deg, #3b82f6 0%, #1d4ed8 100%);
            color: white;
        }

        .invalid-feedback {
            display: block;
            color: #ef4444;
            font-size: 0.85rem;
            margin-top: 0.25rem;
        }

        .help-text {
            font-size: 0.85rem;
            color: #718096;
            margin-top: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        @media (max-width: 576px) {
            .forgot-container {
                max-width: 100%;
            }

            .forgot-header {
                padding: 2rem 1.5rem;
            }

            .forgot-form {
                padding: 2rem 1.5rem;
            }

            .forgot-title {
                font-size: 1.5rem;
            }

            .forgot-icon {
                font-size: 2.5rem;
            }

            .forgot-links {
                flex-direction: column;
                gap: 0.5rem;
            }

            .forgot-links a {
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <div class="forgot-container">
        <div class="forgot-card">
            <!-- Display Messages -->
            <c:if test="${not empty sessionScope.errorMessage}">
                <div style="padding: 1rem 2rem; padding-top: 2rem;">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-circle"></i> ${sessionScope.errorMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </div>
                <c:set var="errorMessage" value="${null}" scope="session"/>
            </c:if>

            <c:if test="${not empty sessionScope.successMessage}">
                <div style="padding: 1rem 2rem; padding-top: 2rem;">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle"></i> ${sessionScope.successMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </div>
                <c:set var="successMessage" value="${null}" scope="session"/>
            </c:if>

            <!-- Forgot Password Header -->
            <div class="forgot-header">
                <div class="forgot-icon">
                    <i class="fas fa-key"></i>
                </div>
                <div class="forgot-title">Forgot Password?</div>
                <div class="forgot-subtitle">
                    No worries! Enter your email address and we'll send you a link to reset your password.
                </div>
            </div>

            <!-- Forgot Password Form -->
            <form method="POST" action="${pageContext.request.contextPath}/forgot-password" class="forgot-form needs-validation" novalidate>
                <div class="form-group">
                    <label for="email" class="form-label">
                        <i class="fas fa-envelope"></i> Email Address
                    </label>
                    <input 
                        type="email" 
                        class="form-control" 
                        id="email" 
                        name="email" 
                        placeholder="you@example.com" 
                        required>
                    <div class="help-text">
                        <i class="fas fa-info-circle"></i> We'll send you an OTP to verify your identity
                    </div>
                    <div class="invalid-feedback">
                        Please provide a valid email address.
                    </div>
                </div>

                <button type="submit" class="btn-submit">
                    <i class="fas fa-paper-plane"></i> Send Reset Link
                </button>

                <div class="forgot-links">
                    <a href="${pageContext.request.contextPath}/login">
                        <i class="fas fa-arrow-left"></i> Back to Login
                    </a>
                    <a href="${pageContext.request.contextPath}/register">
                        <i class="fas fa-user-plus"></i> Create Account
                    </a>
                </div>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.querySelector('.needs-validation');
            form.addEventListener('submit', event => {
                if (!form.checkValidity()) {
                    event.preventDefault();
                    event.stopPropagation();
                }
                form.classList.add('was-validated');
            }, false);
        });
    </script>
</body>
</html>
