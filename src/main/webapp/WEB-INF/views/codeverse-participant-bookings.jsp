<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="page" value="bookings"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Bookings - CodeVerse</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .booking-card {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
            transition: all 0.3s ease;
            margin-bottom: 1.5rem;
            border-left: 5px solid #667eea;
        }

        .booking-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.12);
        }

        .booking-card.upcoming {
            border-left-color: #3b82f6;
        }

        .booking-card.completed {
            border-left-color: #10b981;
        }

        .booking-card.cancelled {
            border-left-color: #ef4444;
        }

        .booking-header {
            padding: 1.5rem;
            background: linear-gradient(90deg, #f8f9fa 0%, white 100%);
            border-bottom: 1px solid #e5e7eb;
            display: flex;
            justify-content: space-between;
            align-items: start;
        }

        .booking-title {
            font-size: 1.1rem;
            font-weight: 700;
            color: #2d3748;
        }

        .status-badge {
            display: inline-block;
            padding: 0.4rem 0.85rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
        }

        .status-upcoming {
            background: #dbeafe;
            color: #1e40af;
        }

        .status-completed {
            background: #d1fae5;
            color: #047857;
        }

        .status-cancelled {
            background: #fee2e2;
            color: #991b1b;
        }

        .booking-body {
            padding: 1.5rem;
            display: grid;
            grid-template-columns: 2fr 1fr 1fr;
            gap: 2rem;
            align-items: center;
        }

        .booking-info {
            display: flex;
            flex-direction: column;
            gap: 0.75rem;
        }

        .info-row {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            font-size: 0.95rem;
            color: #4b5563;
        }

        .info-row i {
            color: #667eea;
            min-width: 1.25rem;
            text-align: center;
        }

        .registration-code-box {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 1rem;
            border-radius: 8px;
            text-align: center;
        }

        .code-label {
            font-size: 0.8rem;
            opacity: 0.9;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 0.5rem;
        }

        .code-value {
            font-size: 1.3rem;
            font-weight: 700;
            font-family: 'Courier New', monospace;
            word-break: break-all;
            margin-bottom: 0.75rem;
        }

        .copy-btn {
            background: rgba(255, 255, 255, 0.2);
            border: 1px solid rgba(255, 255, 255, 0.3);
            color: white;
            padding: 0.4rem 0.75rem;
            border-radius: 6px;
            font-size: 0.8rem;
            cursor: pointer;
            transition: all 0.3s;
        }

        .copy-btn:hover {
            background: rgba(255, 255, 255, 0.3);
            color: white;
        }

        .action-buttons {
            display: flex;
            gap: 0.75rem;
        }

        .action-btn {
            flex: 1;
            padding: 0.6rem 0.75rem;
            border-radius: 6px;
            border: none;
            font-size: 0.85rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .action-btn.primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .action-btn.primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 15px rgba(102, 126, 234, 0.3);
            color: white;
            text-decoration: none;
        }

        .action-btn.secondary {
            background: #e5e7eb;
            color: #4b5563;
        }

        .action-btn.secondary:hover {
            background: #d1d5db;
            text-decoration: none;
        }

        .action-btn.danger {
            background: #fee2e2;
            color: #991b1b;
        }

        .action-btn.danger:hover {
            background: #fecaca;
            text-decoration: none;
        }

        .filter-tabs {
            display: flex;
            gap: 1rem;
            margin-bottom: 2rem;
            border-bottom: 2px solid #e5e7eb;
        }

        .filter-tab {
            padding: 0.75rem 1.5rem;
            background: none;
            border: none;
            font-weight: 600;
            color: #718096;
            cursor: pointer;
            transition: all 0.3s;
            border-bottom: 3px solid transparent;
            margin-bottom: -2px;
        }

        .filter-tab.active {
            color: #667eea;
            border-bottom-color: #667eea;
        }

        .filter-tab:hover {
            color: #4b5563;
        }

        .empty-state {
            text-align: center;
            padding: 3rem 2rem;
            color: #718096;
        }

        .empty-state-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
            opacity: 0.5;
        }

        @media (max-width: 768px) {
            .booking-body {
                grid-template-columns: 1fr;
            }

            .action-buttons {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <%@ include file="codeverse-layout.jsp" %>
    <jsp:include page="codeverse-layout.jsp">
        <jsp:param name="page" value="bookings"/>
        <jsp:body>
            <!-- Page Header -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="section-title">
                    <i class="fas fa-bookmark"></i> My Bookings
                </h2>
                <a href="${pageContext.request.contextPath}/participant/explore" class="btn btn-codeverse">
                    <i class="fas fa-plus"></i> Browse Hackathons
                </a>
            </div>

            <!-- Filter Tabs -->
            <div class="filter-tabs">
                <form method="GET" action="${pageContext.request.contextPath}/participant/bookings" style="display: contents;">
                    <button type="button" class="filter-tab <c:if test="${param.status == '' || empty param.status}">active</c:if>" onclick="window.location='${pageContext.request.contextPath}/participant/bookings'">
                        <i class="fas fa-list"></i> All Bookings (${totalBookings})
                    </button>
                    <button type="button" class="filter-tab <c:if test="${param.status == 'UPCOMING'}">active</c:if>" onclick="window.location='${pageContext.request.contextPath}/participant/bookings?status=UPCOMING'">
                        <i class="fas fa-calendar"></i> Upcoming (${upcomingCount})
                    </button>
                    <button type="button" class="filter-tab <c:if test="${param.status == 'COMPLETED'}">active</c:if>" onclick="window.location='${pageContext.request.contextPath}/participant/bookings?status=COMPLETED'">
                        <i class="fas fa-check-circle"></i> Completed (${completedCount})
                    </button>
                    <button type="button" class="filter-tab <c:if test="${param.status == 'CANCELLED'}">active</c:if>" onclick="window.location='${pageContext.request.contextPath}/participant/bookings?status=CANCELLED'">
                        <i class="fas fa-times-circle"></i> Cancelled (${cancelledCount})
                    </button>
                </form>
            </div>

            <!-- Bookings List -->
            <c:if test="${not empty bookings}">
                <c:forEach var="booking" items="${bookings}">
                    <div class="booking-card ${fn:toLowerCase(booking.status)}">
                        <!-- Header -->
                        <div class="booking-header">
                            <div>
                                <div class="booking-title">${booking.hackathonTitle}</div>
                                <div style="font-size: 0.85rem; color: #718096; margin-top: 0.25rem;">
                                    <i class="fas fa-calendar"></i> ${booking.hackathonStartDate}
                                </div>
                            </div>
                            <span class="status-badge status-${fn:toLowerCase(booking.status)}">
                                <i class="fas fa-circle"></i> ${booking.status}
                            </span>
                        </div>

                        <!-- Body -->
                        <div class="booking-body">
                            <!-- Booking Info -->
                            <div class="booking-info">
                                <div class="info-row">
                                    <i class="fas fa-map-marker-alt"></i>
                                    <span>${booking.location}</span>
                                </div>
                                <div class="info-row">
                                    <i class="fas fa-clock"></i>
                                    <span><strong>Registered:</strong> ${booking.registeredDate}</span>
                                </div>
                                <c:if test="${not empty booking.teamName}">
                                    <div class="info-row">
                                        <i class="fas fa-users"></i>
                                        <span><strong>Team:</strong> ${booking.teamName}</span>
                                    </div>
                                </c:if>
                                <div class="info-row">
                                    <i class="fas fa-signal"></i>
                                    <span><strong>Level:</strong> ${booking.experienceLevel}</span>
                                </div>
                            </div>

                            <!-- Registration Code -->
                            <div class="registration-code-box">
                                <div class="code-label">Your Registration Code</div>
                                <div class="code-value">${booking.registrationCode}</div>
                                <button type="button" class="copy-btn" onclick="copyToClipboard('${booking.registrationCode}')">
                                    <i class="fas fa-copy"></i> Copy Code
                                </button>
                            </div>

                            <!-- Actions -->
                            <div class="action-buttons">
                                <a href="${pageContext.request.contextPath}/participant/hackathons/${booking.hackathonId}" class="action-btn primary">
                                    <i class="fas fa-eye"></i> View Details
                                </a>
                                <c:if test="${booking.status == 'UPCOMING'}">
                                    <form method="POST" action="${pageContext.request.contextPath}/participant/bookings/${booking.id}/cancel" style="flex: 1;" onsubmit="return confirm('Are you sure you want to cancel this booking?');">
                                        <button type="submit" class="action-btn danger" style="width: 100%;">
                                            <i class="fas fa-times"></i> Cancel
                                        </button>
                                    </form>
                                </c:if>
                                <c:if test="${booking.status == 'COMPLETED'}">
                                    <a href="${pageContext.request.contextPath}/participant/bookings/${booking.id}/certificate" class="action-btn secondary">
                                        <i class="fas fa-certificate"></i> Certificate
                                    </a>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:if>

            <!-- Empty State -->
            <c:if test="${empty bookings}">
                <div class="card">
                    <div class="card-body empty-state">
                        <div class="empty-state-icon">
                            <i class="fas fa-inbox"></i>
                        </div>
                        <h5 style="color: #2d3748; font-weight: 700; margin-bottom: 0.5rem;">No Bookings Found</h5>
                        <p style="margin-bottom: 1.5rem;">You haven't booked any hackathons yet. Start exploring!</p>
                        <a href="${pageContext.request.contextPath}/participant/explore" class="btn btn-codeverse">
                            <i class="fas fa-compass"></i> Explore Hackathons
                        </a>
                    </div>
                </div>
            </c:if>

            <!-- Pagination -->
            <c:if test="${totalPages > 1}">
                <nav aria-label="Page navigation" style="margin-top: 2rem;">
                    <ul class="pagination justify-content-center">
                        <c:if test="${currentPage > 1}">
                            <li class="page-item">
                                <a class="page-link" href="${pageContext.request.contextPath}/participant/bookings?page=1&status=${param.status}">First</a>
                            </li>
                            <li class="page-item">
                                <a class="page-link" href="${pageContext.request.contextPath}/participant/bookings?page=${currentPage - 1}&status=${param.status}">Previous</a>
                            </li>
                        </c:if>
                        
                        <c:forEach var="i" begin="1" end="${totalPages}">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link" href="${pageContext.request.contextPath}/participant/bookings?page=${i}&status=${param.status}">${i}</a>
                            </li>
                        </c:forEach>
                        
                        <c:if test="${currentPage < totalPages}">
                            <li class="page-item">
                                <a class="page-link" href="${pageContext.request.contextPath}/participant/bookings?page=${currentPage + 1}&status=${param.status}">Next</a>
                            </li>
                            <li class="page-item">
                                <a class="page-link" href="${pageContext.request.contextPath}/participant/bookings?page=${totalPages}&status=${param.status}">Last</a>
                            </li>
                        </c:if>
                    </ul>
                </nav>
            </c:if>
        </jsp:body>
    </jsp:include>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function copyToClipboard(text) {
            navigator.clipboard.writeText(text).then(() => {
                alert('Registration code copied to clipboard!');
            }).catch(err => {
                console.error('Failed to copy:', err);
            });
        }
    </script>
</body>
</html>
