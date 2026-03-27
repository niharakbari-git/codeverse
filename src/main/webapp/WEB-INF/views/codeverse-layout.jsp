<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CodeVerse - Hackathon Marketplace</title>
    <!-- Bootstrap 5.3.0 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome 6 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --secondary-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            --codeverse-purple: #667eea;
            --codeverse-dark-purple: #764ba2;
            --success-color: #10b981;
            --warning-color: #f59e0b;
            --danger-color: #ef4444;
        }

        * {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #f8f9fa;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        /* Header Styles */
        .codeverse-header {
            background: var(--primary-gradient);
            color: white;
            padding: 1rem 0;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .codeverse-logo {
            font-size: 1.8rem;
            font-weight: 700;
            color: white;
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .codeverse-logo:hover {
            color: white;
            text-decoration: none;
        }

        .codeverse-logo i {
            font-size: 2rem;
        }

        .navbar-nav .nav-link {
            color: rgba(255, 255, 255, 0.85) !important;
            margin-left: 0.5rem;
            margin-right: 0.5rem;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .navbar-nav .nav-link:hover {
            color: white !important;
            transform: translateY(-2px);
        }

        .navbar-nav .nav-link.active {
            color: white !important;
            border-bottom: 3px solid white;
        }

        .user-menu-dropdown {
            margin-left: auto;
        }

        .dropdown-toggle::after {
            content: none;
        }

        /* Sidebar Styles */
        .codeverse-sidebar {
            background: white;
            box-shadow: 2px 0 10px rgba(0, 0, 0, 0.05);
            position: sticky;
            top: 80px;
            height: calc(100vh - 80px);
            overflow-y: auto;
        }

        .sidebar-menu {
            list-style: none;
            padding: 1rem 0;
            margin: 0;
        }

        .sidebar-menu li {
            margin: 0;
        }

        .sidebar-menu a {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            padding: 0.75rem 1.25rem;
            color: #4b5563;
            text-decoration: none;
            font-weight: 500;
            border-left: 4px solid transparent;
            transition: all 0.3s ease;
        }

        .sidebar-menu a:hover {
            background-color: #f0f1f5;
            border-left-color: var(--codeverse-purple);
            color: var(--codeverse-purple);
        }

        .sidebar-menu a.active {
            background: linear-gradient(90deg, rgba(102, 126, 234, 0.1) 0%, transparent 100%);
            border-left-color: var(--codeverse-purple);
            color: var(--codeverse-purple);
        }

        .sidebar-menu a i {
            min-width: 1.25rem;
            text-align: center;
        }

        /* Main Content Area */
        .codeverse-main {
            flex: 1;
            overflow-y: auto;
        }

        .content-wrapper {
            padding: 2rem;
        }

        /* Flash Messages */
        .alert-dismissible .btn-close {
            padding: 0.5rem;
        }

        .alert {
            border: none;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            animation: slideIn 0.3s ease-out;
        }

        .alert-success {
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            color: white;
            border-left: 5px solid #047857;
        }

        .alert-danger {
            background: linear-gradient(135deg, #ef4444 0%, #dc2626 100%);
            color: white;
            border-left: 5px solid #b91c1c;
        }

        .alert-warning {
            background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
            color: white;
            border-left: 5px solid #b45309;
        }

        .alert-info {
            background: linear-gradient(135deg, #3b82f6 0%, #1d4ed8 100%);
            color: white;
            border-left: 5px solid #1e40af;
        }

        @keyframes slideIn {
            from {
                transform: translateY(-20px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        /* Footer Styles */
        .codeverse-footer {
            background: var(--primary-gradient);
            color: white;
            padding: 2rem 0;
            margin-top: auto;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
        }

        .footer-section h6 {
            font-weight: 600;
            margin-bottom: 1rem;
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .footer-section a {
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            font-size: 0.9rem;
            display: block;
            margin-bottom: 0.5rem;
            transition: all 0.3s ease;
        }

        .footer-section a:hover {
            color: white;
            margin-left: 0.25rem;
        }

        .footer-divider {
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            margin: 1.5rem 0;
        }

        /* Button Styles */
        .btn-codeverse {
            background: var(--primary-gradient);
            border: none;
            color: white;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.3);
        }

        .btn-codeverse:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.4);
            color: white;
        }

        .btn-outline-codeverse {
            border: 2px solid var(--codeverse-purple);
            color: var(--codeverse-purple);
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-outline-codeverse:hover {
            background: var(--primary-gradient);
            border-color: transparent;
            color: white;
            transform: translateY(-2px);
        }

        /* Card Styles */
        .card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
            transition: all 0.3s ease;
            height: 100%;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.12);
        }

        .card-header {
            background: var(--primary-gradient);
            color: white;
            border-radius: 12px 12px 0 0;
            border: none;
        }

        /* Table Styles */
        .table {
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }

        .table thead {
            background: linear-gradient(90deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .table thead th {
            border: none;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.85rem;
            letter-spacing: 0.5px;
            padding: 1rem;
        }

        .table tbody td {
            border-color: #e5e7eb;
            padding: 1rem;
            vertical-align: middle;
        }

        .table tbody tr {
            transition: all 0.3s ease;
        }

        .table tbody tr:hover {
            background-color: #f8f9fa;
        }

        /* Form Styles */
        .form-control, .form-select {
            border-radius: 8px;
            border: 2px solid #e5e7eb;
            padding: 0.75rem 1rem;
            transition: all 0.3s ease;
            font-size: 0.95rem;
        }

        .form-control:focus, .form-select:focus {
            border-color: var(--codeverse-purple);
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.15);
            outline: none;
        }

        .form-label {
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 0.5rem;
            font-size: 0.95rem;
        }

        .invalid-feedback {
            display: block;
            color: #ef4444;
            font-size: 0.85rem;
            margin-top: 0.25rem;
        }

        /* Badge Styles */
        .badge {
            border-radius: 20px;
            padding: 0.5rem 0.75rem;
            font-weight: 600;
            font-size: 0.85rem;
        }

        .badge-success {
            background-color: #d1fae5;
            color: #047857;
        }

        .badge-warning {
            background-color: #fef3c7;
            color: #92400e;
        }

        .badge-danger {
            background-color: #fee2e2;
            color: #991b1b;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .codeverse-sidebar {
                display: none;
            }

            .content-wrapper {
                padding: 1rem;
            }

            .sidebar-menu a {
                padding: 0.5rem 0.75rem;
                font-size: 0.9rem;
            }

            .card {
                margin-bottom: 1rem;
            }
        }

        /* Utility Classes */
        .text-gradient {
            background: var(--primary-gradient);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            font-weight: 700;
        }

        .divider {
            border-top: 2px solid #e5e7eb;
            margin: 1.5rem 0;
        }

        .icon-box {
            width: 50px;
            height: 50px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
        }

        .icon-box-primary {
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.1) 0%, rgba(118, 75, 162, 0.1) 100%);
            color: var(--codeverse-purple);
        }

        .section-title {
            font-size: 1.8rem;
            font-weight: 700;
            color: #1f2937;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .section-title i {
            color: var(--codeverse-purple);
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="codeverse-header">
        <nav class="navbar navbar-expand-lg">
            <div class="container-fluid">
                <a href="${pageContext.request.contextPath}/" class="codeverse-logo">
                    <i class="fas fa-code"></i>
                    CodeVerse
                </a>
                
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto user-menu-dropdown">
                        <c:if test="${not empty sessionScope.user}">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                                    <i class="fas fa-user-circle"></i>
                                    ${sessionScope.user.fullName}
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/profile">
                                        <i class="fas fa-id-card"></i> My Profile
                                    </a></li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li><a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                                        <i class="fas fa-sign-out-alt"></i> Logout
                                    </a></li>
                                </ul>
                            </li>
                        </c:if>
                        <c:if test="${empty sessionScope.user}">
                            <li class="nav-item">
                                <a class="nav-link" href="${pageContext.request.contextPath}/login">
                                    <i class="fas fa-sign-in-alt"></i> Login
                                </a>
                            </li>
                        </c:if>
                    </ul>
                </div>
            </div>
        </nav>
    </header>

    <div class="d-flex flex-grow-1">
        <!-- Sidebar Navigation -->
        <c:if test="${not empty sessionScope.user}">
            <nav class="codeverse-sidebar col-md-2">
                <ul class="sidebar-menu">
                    <c:choose>
                        <c:when test="${sessionScope.user.userType == 'ADMIN'}">
                            <li><a href="${pageContext.request.contextPath}/admin/dashboard" class="<c:if test="${param.page == 'dashboard'}">active</c:if>">
                                <i class="fas fa-chart-line"></i> Dashboard
                            </a></li>
                            <li><a href="${pageContext.request.contextPath}/admin/categories" class="<c:if test="${param.page == 'categories'}">active</c:if>">
                                <i class="fas fa-list"></i> Categories
                            </a></li>
                            <li><a href="${pageContext.request.contextPath}/admin/users" class="<c:if test="${param.page == 'users'}">active</c:if>">
                                <i class="fas fa-users"></i> Users
                            </a></li>
                        </c:when>
                        <c:when test="${sessionScope.user.userType == 'ORGANIZER'}">
                            <li><a href="${pageContext.request.contextPath}/organizer/dashboard" class="<c:if test="${param.page == 'dashboard'}">active</c:if>">
                                <i class="fas fa-chart-line"></i> Dashboard
                            </a></li>
                            <li><a href="${pageContext.request.contextPath}/organizer/hackathons" class="<c:if test="${param.page == 'hackathons'}">active</c:if>">
                                <i class="fas fa-trophy"></i> My Hackathons
                            </a></li>
                            <li><a href="${pageContext.request.contextPath}/organizer/registrations" class="<c:if test="${param.page == 'registrations'}">active</c:if>">
                                <i class="fas fa-clipboard-list"></i> Registrations
                            </a></li>
                        </c:when>
                        <c:when test="${sessionScope.user.userType == 'PARTICIPANT'}">
                            <li><a href="${pageContext.request.contextPath}/participant/dashboard" class="<c:if test="${param.page == 'dashboard'}">active</c:if>">
                                <i class="fas fa-chart-line"></i> Dashboard
                            </a></li>
                            <li><a href="${pageContext.request.contextPath}/participant/explore" class="<c:if test="${param.page == 'explore'}">active</c:if>">
                                <i class="fas fa-compass"></i> Explore
                            </a></li>
                            <li><a href="${pageContext.request.contextPath}/participant/bookings" class="<c:if test="${param.page == 'bookings'}">active</c:if>">
                                <i class="fas fa-bookmark"></i> My Bookings
                            </a></li>
                        </c:when>
                    </c:choose>
                </ul>
            </nav>
        </c:if>

        <!-- Main Content -->
        <main class="codeverse-main col-md-10 col-12">
            <div class="content-wrapper">
                <!-- Flash Messages -->
                <c:if test="${not empty sessionScope.successMessage}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle"></i>
                        <strong>Success!</strong> ${sessionScope.successMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <c:set var="successMessage" value="${null}" scope="session"/>
                </c:if>

                <c:if test="${not empty sessionScope.errorMessage}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-circle"></i>
                        <strong>Error!</strong> ${sessionScope.errorMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <c:set var="errorMessage" value="${null}" scope="session"/>
                </c:if>

                <c:if test="${not empty sessionScope.warningMessage}">
                    <div class="alert alert-warning alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-triangle"></i>
                        <strong>Warning!</strong> ${sessionScope.warningMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <c:set var="warningMessage" value="${null}" scope="session"/>
                </c:if>

                <!-- Page Content goes here -->
                <jsp:doBody/>
            </div>
        </main>
    </div>

    <!-- Footer -->
    <footer class="codeverse-footer">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-3 footer-section">
                    <h6><i class="fas fa-code"></i> CodeVerse</h6>
                    <p style="font-size: 0.9rem; margin-bottom: 1rem;">Your ultimate hackathon marketplace connecting innovators with opportunities.</p>
                </div>
                <div class="col-md-3 footer-section">
                    <h6>Quick Links</h6>
                    <a href="#">Home</a>
                    <a href="#">About Us</a>
                    <a href="#">Hackathons</a>
                    <a href="#">Contact</a>
                </div>
                <div class="col-md-3 footer-section">
                    <h6>Support</h6>
                    <a href="#">Help Center</a>
                    <a href="#">Documentation</a>
                    <a href="#">FAQ</a>
                    <a href="#">Contact Support</a>
                </div>
                <div class="col-md-3 footer-section">
                    <h6>Legal</h6>
                    <a href="#">Privacy Policy</a>
                    <a href="#">Terms of Service</a>
                    <a href="#">Cookie Policy</a>
                </div>
            </div>
            <div class="footer-divider"></div>
            <div class="row align-items-center">
                <div class="col-md-6">
                    <p style="font-size: 0.85rem; margin: 0;">&copy; 2024 CodeVerse. All rights reserved.</p>
                </div>
                <div class="col-md-6 text-end">
                    <a href="#" style="color: rgba(255, 255, 255, 0.8); margin: 0 0.75rem; text-decoration: none;">
                        <i class="fab fa-facebook"></i>
                    </a>
                    <a href="#" style="color: rgba(255, 255, 255, 0.8); margin: 0 0.75rem; text-decoration: none;">
                        <i class="fab fa-twitter"></i>
                    </a>
                    <a href="#" style="color: rgba(255, 255, 255, 0.8); margin: 0 0.75rem; text-decoration: none;">
                        <i class="fab fa-linkedin"></i>
                    </a>
                    <a href="#" style="color: rgba(255, 255, 255, 0.8); margin: 0 0.75rem; text-decoration: none;">
                        <i class="fab fa-github"></i>
                    </a>
                </div>
            </div>
        </div>
    </footer>

    <!-- Bootstrap 5.3.0 JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Auto-hide alerts after 5 seconds
        document.addEventListener('DOMContentLoaded', function() {
            const alerts = document.querySelectorAll('.alert');
            alerts.forEach(alert => {
                setTimeout(() => {
                    const bsAlert = new bootstrap.Alert(alert);
                    bsAlert.close();
                }, 5000);
            });

            // Form validation
            const forms = document.querySelectorAll('.needs-validation');
            Array.from(forms).forEach(form => {
                form.addEventListener('submit', event => {
                    if (!form.checkValidity()) {
                        event.preventDefault();
                        event.stopPropagation();
                    }
                    form.classList.add('was-validated');
                }, false);
            });
        });
    </script>
</body>
</html>
