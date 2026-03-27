<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - CodeVerse</title>
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
            padding: 2rem 0;
            overflow-x: hidden;
        }

        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: radial-gradient(circle at 20% 50%, rgba(255, 255, 255, 0.1) 0%, transparent 50%),
                        radial-gradient(circle at 80% 80%, rgba(255, 255, 255, 0.1) 0%, transparent 50%);
            pointer-events: none;
            z-index: 0;
        }

        .register-container {
            position: relative;
            z-index: 1;
            max-width: 600px;
            margin: 0 auto;
            padding: 0 1.5rem;
        }

        .register-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            overflow: hidden;
        }

        .register-header {
            background: var(--primary-gradient);
            color: white;
            padding: 2.5rem 2rem;
            text-align: center;
        }

        .register-logo {
            font-size: 2.5rem;
            margin-bottom: 0.75rem;
            display: inline-block;
        }

        .register-title {
            font-size: 1.6rem;
            font-weight: 700;
            margin-bottom: 0.25rem;
        }

        .register-subtitle {
            font-size: 0.9rem;
            opacity: 0.9;
        }

        .register-form {
            padding: 2.5rem 2rem;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
            margin-bottom: 1.5rem;
        }

        .form-row.full {
            grid-template-columns: 1fr;
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

        .form-control, .form-select {
            border-radius: 10px;
            border: 2px solid #e5e7eb;
            padding: 0.85rem 1.25rem;
            font-size: 0.95rem;
            transition: all 0.3s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.15);
            outline: none;
        }

        .form-control::placeholder {
            color: #a0aec0;
        }

        .password-strength {
            margin-top: 0.5rem;
            padding: 0.5rem 0.75rem;
            border-radius: 5px;
            font-size: 0.85rem;
            font-weight: 600;
            display: none;
        }

        .password-strength.weak {
            display: block;
            background: #fee2e2;
            color: #991b1b;
        }

        .password-strength.medium {
            display: block;
            background: #fef3c7;
            color: #92400e;
        }

        .password-strength.strong {
            display: block;
            background: #d1fae5;
            color: #047857;
        }

        .btn-register {
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

        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.4);
            color: white;
        }

        .register-links {
            text-align: center;
            padding: 1.5rem;
            background: #f8f9fa;
            border-top: 1px solid #e5e7eb;
        }

        .register-links p {
            margin: 0;
            font-size: 0.95rem;
            color: #4b5563;
        }

        .register-links a {
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .register-links a:hover {
            color: #764ba2;
            text-decoration: underline;
        }

        .terms-check {
            display: flex;
            align-items: flex-start;
            gap: 0.75rem;
            margin: 1.5rem 0;
            font-size: 0.9rem;
        }

        .form-check-input {
            width: 1.1rem;
            height: 1.1rem;
            margin-top: 0.25rem;
            border: 2px solid #e5e7eb;
            border-radius: 5px;
            cursor: pointer;
            transition: all 0.3s ease;
            flex-shrink: 0;
        }

        .form-check-input:checked {
            background-color: #667eea;
            border-color: #667eea;
        }

        .form-check-input:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.15);
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

        .invalid-feedback {
            display: block;
            color: #ef4444;
            font-size: 0.85rem;
            margin-top: 0.25rem;
        }

        @media (max-width: 576px) {
            .form-row {
                grid-template-columns: 1fr;
            }

            .register-header {
                padding: 2rem 1.5rem;
            }

            .register-form {
                padding: 2rem 1.5rem;
            }

            .register-title {
                font-size: 1.4rem;
            }

            .register-logo {
                font-size: 2rem;
            }
        }
    </style>
</head>
<body>
    <div class="register-container">
        <div class="register-card">
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

            <!-- Register Header -->
            <div class="register-header">
                <div class="register-logo">
                    <i class="fas fa-code"></i>
                </div>
                <div class="register-title">Join CodeVerse</div>
                <div class="register-subtitle">Create your account to get started</div>
            </div>

            <!-- Register Form -->
            <form method="POST" action="${pageContext.request.contextPath}/register" class="register-form needs-validation" novalidate>
                <div class="form-row">
                    <div class="form-group">
                        <label for="firstName" class="form-label">
                            <i class="fas fa-user"></i> First Name
                        </label>
                        <input 
                            type="text" 
                            class="form-control" 
                            id="firstName" 
                            name="firstName" 
                            placeholder="John" 
                            required>
                        <div class="invalid-feedback">
                            First name is required.
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="lastName" class="form-label">
                            <i class="fas fa-user"></i> Last Name
                        </label>
                        <input 
                            type="text" 
                            class="form-control" 
                            id="lastName" 
                            name="lastName" 
                            placeholder="Doe" 
                            required>
                        <div class="invalid-feedback">
                            Last name is required.
                        </div>
                    </div>
                </div>

                <div class="form-group form-row full">
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
                    <div class="invalid-feedback">
                        Please provide a valid email address.
                    </div>
                </div>

                <div class="form-group form-row full">
                    <label for="username" class="form-label">
                        <i class="fas fa-at"></i> Username
                    </label>
                    <input 
                        type="text" 
                        class="form-control" 
                        id="username" 
                        name="username" 
                        placeholder="johndoe" 
                        required
                        minlength="3"
                        pattern="^[a-zA-Z0-9_-]+$">
                    <div class="invalid-feedback">
                        Username must be 3+ characters (letters, numbers, -, _ only).
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="phoneNumber" class="form-label">
                            <i class="fas fa-phone"></i> Phone Number
                        </label>
                        <input 
                            type="tel" 
                            class="form-control" 
                            id="phoneNumber" 
                            name="phoneNumber" 
                            placeholder="+1-234-567-8900" 
                            required
                            pattern="^\+?[0-9\s\-\(\)]{10,}$">
                        <div class="invalid-feedback">
                            Please provide a valid phone number.
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="userType" class="form-label">
                            <i class="fas fa-tag"></i> Register As
                        </label>
                        <select class="form-select" id="userType" name="userType" required>
                            <option value="" disabled selected>Select your role</option>
                            <option value="PARTICIPANT">Participant</option>
                            <option value="ORGANIZER">Organizer</option>
                        </select>
                        <div class="invalid-feedback">
                            Please select a user type.
                        </div>
                    </div>
                </div>

                <div class="form-group form-row full">
                    <label for="password" class="form-label">
                        <i class="fas fa-lock"></i> Password
                    </label>
                    <input 
                        type="password" 
                        class="form-control" 
                        id="password" 
                        name="password" 
                        placeholder="••••••••" 
                        required
                        minlength="8"
                        onchange="checkPasswordStrength()">
                    <div class="invalid-feedback">
                        Password must be at least 8 characters.
                    </div>
                    <div class="password-strength" id="strengthIndicator"></div>
                </div>

                <div class="form-group form-row full">
                    <label for="confirmPassword" class="form-label">
                        <i class="fas fa-lock"></i> Confirm Password
                    </label>
                    <input 
                        type="password" 
                        class="form-control" 
                        id="confirmPassword" 
                        name="confirmPassword" 
                        placeholder="••••••••" 
                        required
                        minlength="8">
                    <div class="invalid-feedback">
                        Passwords do not match.
                    </div>
                </div>

                <div class="terms-check">
                    <input 
                        class="form-check-input" 
                        type="checkbox" 
                        id="terms" 
                        name="agreeTerms" 
                        value="on" 
                        required>
                    <label for="terms" style="cursor: pointer; margin-bottom: 0;">
                        I agree to the <a href="#" style="color: #667eea; font-weight: 600;">Terms of Service</a> and <a href="#" style="color: #667eea; font-weight: 600;">Privacy Policy</a>
                    </label>
                </div>

                <button type="submit" class="btn-register">
                    <i class="fas fa-user-plus"></i> Create Account
                </button>
            </form>

            <!-- Login Prompt -->
            <div class="register-links">
                <p>Already have an account? <a href="${pageContext.request.contextPath}/login">Login here</a></p>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function checkPasswordStrength() {
            const password = document.getElementById('password').value;
            const strengthIndicator = document.getElementById('strengthIndicator');
            
            let strength = 0;
            
            if (password.length >= 8) strength++;
            if (password.match(/[a-z]/)) strength++;
            if (password.match(/[A-Z]/)) strength++;
            if (password.match(/[0-9]/)) strength++;
            if (password.match(/[^a-zA-Z0-9]/)) strength++;
            
            strengthIndicator.classList.remove('weak', 'medium', 'strong');
            
            if (strength < 2) {
                strengthIndicator.classList.add('weak');
                strengthIndicator.textContent = '⚠️ Weak password';
            } else if (strength < 4) {
                strengthIndicator.classList.add('medium');
                strengthIndicator.textContent = '⚠️ Medium strength';
            } else {
                strengthIndicator.classList.add('strong');
                strengthIndicator.textContent = '✓ Strong password';
            }
        }

        document.addEventListener('DOMContentLoaded', function() {
            const form = document.querySelector('.needs-validation');
            form.addEventListener('submit', event => {
                const password = document.getElementById('password').value;
                const confirmPassword = document.getElementById('confirmPassword').value;
                
                if (password !== confirmPassword) {
                    event.preventDefault();
                    event.stopPropagation();
                    document.getElementById('confirmPassword').classList.add('is-invalid');
                } else {
                    document.getElementById('confirmPassword').classList.remove('is-invalid');
                }
                
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
