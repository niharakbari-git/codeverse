<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password - CodeVerse</title>
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

        .reset-container {
            position: relative;
            z-index: 1;
            width: 100%;
            max-width: 500px;
            padding: 1.5rem;
        }

        .reset-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            overflow: hidden;
        }

        .reset-header {
            background: var(--primary-gradient);
            color: white;
            padding: 3rem 2rem;
            text-align: center;
        }

        .reset-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
            display: inline-block;
        }

        .reset-title {
            font-size: 1.8rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .reset-subtitle {
            font-size: 0.95rem;
            opacity: 0.9;
        }

        .reset-form {
            padding: 2.5rem 2rem;
        }

        .step-indicator {
            display: flex;
            gap: 1rem;
            margin-bottom: 2rem;
            position: relative;
        }

        .step {
            flex: 1;
            text-align: center;
        }

        .step-number {
            width: 40px;
            height: 40px;
            background: #e5e7eb;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            color: #4b5563;
            margin: 0 auto 0.5rem;
            transition: all 0.3s ease;
        }

        .step.active .step-number {
            background: var(--primary-gradient);
            color: white;
        }

        .step.completed .step-number {
            background: #10b981;
            color: white;
        }

        .step-label {
            font-size: 0.85rem;
            color: #718096;
            font-weight: 600;
        }

        .step.active .step-label {
            color: #667eea;
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
            letter-spacing: 0.2rem;
        }

        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.15);
            outline: none;
        }

        .form-control::placeholder {
            color: #a0aec0;
        }

        .otp-inputs {
            display: flex;
            gap: 0.5rem;
            justify-content: center;
            margin-bottom: 1.5rem;
        }

        .otp-input {
            width: 50px;
            height: 50px;
            text-align: center;
            font-size: 1.5rem;
            border-radius: 8px;
            border: 2px solid #e5e7eb;
            transition: all 0.3s ease;
        }

        .otp-input:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.15);
            outline: none;
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

        .resend-otp {
            text-align: center;
            margin-top: 1rem;
            font-size: 0.9rem;
            color: #718096;
        }

        .resend-otp a {
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .resend-otp a:hover {
            color: #764ba2;
            text-decoration: underline;
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

        @media (max-width: 576px) {
            .reset-container {
                max-width: 100%;
            }

            .reset-header {
                padding: 2rem 1.5rem;
            }

            .reset-form {
                padding: 2rem 1.5rem;
            }

            .reset-title {
                font-size: 1.5rem;
            }

            .reset-icon {
                font-size: 2.5rem;
            }

            .otp-inputs {
                gap: 0.25rem;
            }

            .otp-input {
                width: 40px;
                height: 40px;
                font-size: 1rem;
            }
        }
    </style>
</head>
<body>
    <div class="reset-container">
        <div class="reset-card">
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

            <!-- Reset Password Header -->
            <div class="reset-header">
                <div class="reset-icon">
                    <i class="fas fa-shield-alt"></i>
                </div>
                <div class="reset-title">Reset Password</div>
                <div class="reset-subtitle">
                    Verify your identity and set a new password
                </div>
            </div>

            <!-- Reset Password Form -->
            <form method="POST" action="${pageContext.request.contextPath}/reset-password" class="reset-form needs-validation" novalidate>
                <!-- Step Indicator -->
                <div class="step-indicator">
                    <div class="step completed">
                        <div class="step-number"><i class="fas fa-check"></i></div>
                        <div class="step-label">Email Verified</div>
                    </div>
                    <div class="step active" id="otpStep">
                        <div class="step-number">2</div>
                        <div class="step-label">OTP Verification</div>
                    </div>
                    <div class="step" id="passwordStep">
                        <div class="step-number">3</div>
                        <div class="step-label">New Password</div>
                    </div>
                </div>

                <!-- OTP Verification Section -->
                <div id="otpSection">
                    <h6 style="margin-bottom: 1rem; color: #2d3748; font-weight: 700;">
                        <i class="fas fa-lock-open"></i> Enter OTP
                    </h6>

                    <p style="font-size: 0.9rem; color: #718096; margin-bottom: 1rem;">
                        We've sent a 6-digit OTP to your registered email address. Please enter it below.
                    </p>

                    <div class="form-group">
                        <label class="form-label">OTP Code</label>
                        <div class="otp-inputs">
                            <input type="text" class="otp-input" maxlength="1" required>
                            <input type="text" class="otp-input" maxlength="1" required>
                            <input type="text" class="otp-input" maxlength="1" required>
                            <input type="text" class="otp-input" maxlength="1" required>
                            <input type="text" class="otp-input" maxlength="1" required>
                            <input type="text" class="otp-input" maxlength="1" required>
                        </div>
                        <input type="hidden" id="otpCode" name="otpCode">
                    </div>

                    <div class="resend-otp">
                        Didn't receive the code? 
                        <a href="${pageContext.request.contextPath}/resend-otp">
                            <i class="fas fa-redo"></i> Resend OTP
                        </a>
                    </div>

                    <button type="button" class="btn-submit" onclick="verifyOTP()">
                        <i class="fas fa-arrow-right"></i> Continue
                    </button>
                </div>

                <!-- New Password Section (Hidden Initially) -->
                <div id="passwordSection" style="display: none;">
                    <h6 style="margin-bottom: 1rem; color: #2d3748; font-weight: 700;">
                        <i class="fas fa-lock"></i> Set New Password
                    </h6>

                    <div class="form-group">
                        <label for="newPassword" class="form-label">
                            <i class="fas fa-lock"></i> New Password
                        </label>
                        <input 
                            type="password" 
                            class="form-control" 
                            id="newPassword" 
                            name="newPassword" 
                            placeholder="••••••••" 
                            required
                            minlength="8"
                            onchange="checkPasswordStrength()">
                        <div class="invalid-feedback">
                            Password must be at least 8 characters.
                        </div>
                        <div class="password-strength" id="strengthIndicator"></div>
                    </div>

                    <div class="form-group">
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

                    <button type="submit" class="btn-submit">
                        <i class="fas fa-check"></i> Reset Password
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // OTP Input Auto-focus
        document.querySelectorAll('.otp-input').forEach((input, index) => {
            input.addEventListener('input', (e) => {
                if (e.target.value && index < 5) {
                    document.querySelectorAll('.otp-input')[index + 1].focus();
                }
            });

            input.addEventListener('keydown', (e) => {
                if (e.key === 'Backspace' && !e.target.value && index > 0) {
                    document.querySelectorAll('.otp-input')[index - 1].focus();
                }
            });
        });

        function verifyOTP() {
            const otpInputs = document.querySelectorAll('.otp-input');
            const otpCode = Array.from(otpInputs).map(input => input.value).join('');

            if (otpCode.length !== 6) {
                alert('Please enter all 6 digits of the OTP');
                return;
            }

            // Here you would typically validate the OTP with your backend
            // For now, we'll just switch views
            document.getElementById('otpSection').style.display = 'none';
            document.getElementById('passwordSection').style.display = 'block';
            document.getElementById('otpStep').classList.remove('active');
            document.getElementById('otpStep').classList.add('completed');
            document.getElementById('passwordStep').classList.add('active');
            document.getElementById('otpCode').value = otpCode;
        }

        function checkPasswordStrength() {
            const password = document.getElementById('newPassword').value;
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
                const newPassword = document.getElementById('newPassword').value;
                const confirmPassword = document.getElementById('confirmPassword').value;
                
                if (newPassword !== confirmPassword) {
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
