<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="page" value="dashboard"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Organizer Dashboard - CodeVerse</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .stat-card {
            background: white;
            border-radius: 12px;
            padding: 2rem;
            text-align: center;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
            transition: all 0.3s ease;
            border-left: 5px solid #667eea;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.12);
        }

        .stat-number {
            font-size: 2.5rem;
            font-weight: 700;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin: 1rem 0;
        }

        .stat-label {
            font-size: 0.95rem;
            color: #718096;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .stat-icon {
            font-size: 3rem;
            margin-bottom: 1rem;
            opacity: 0.2;
        }

        .quick-action-card {
            background: white;
            border-radius: 12px;
            padding: 1.5rem;
            text-align: center;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
            transition: all 0.3s ease;
            text-decoration: none;
            color: inherit;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 1rem;
        }

        .quick-action-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.12);
            color: inherit;
            text-decoration: none;
        }

        .quick-action-icon {
            width: 60px;
            height: 60px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.8rem;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .quick-action-title {
            font-weight: 600;
            color: #2d3748;
            font-size: 0.95rem;
        }
    </style>
</head>
<body>
    <%@ include file="codeverse-layout.jsp" %>
    <jsp:include page="codeverse-layout.jsp">
        <jsp:param name="page" value="dashboard"/>
        <jsp:body>
            <!-- Dashboard Title -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="section-title">
                    <i class="fas fa-chart-line"></i> Organizer Dashboard
                </h2>
                <p style="color: #718096; margin: 0;">Welcome, ${sessionScope.user.fullName}!</p>
            </div>

            <!-- Statistics Cards -->
            <div class="row mb-4">
                <div class="col-md-6 col-lg-3 mb-4">
                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fas fa-trophy"></i>
                        </div>
                        <div class="stat-number">${totalHackathons}</div>
                        <div class="stat-label">My Hackathons</div>
                    </div>
                </div>

                <div class="col-md-6 col-lg-3 mb-4">
                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fas fa-users"></i>
                        </div>
                        <div class="stat-number">${totalParticipants}</div>
                        <div class="stat-label">Total Participants</div>
                    </div>
                </div>

                <div class="col-md-6 col-lg-3 mb-4">
                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fas fa-calendar-check"></i>
                        </div>
                        <div class="stat-number">${upcomingHackathons}</div>
                        <div class="stat-label">Upcoming Events</div>
                    </div>
                </div>

                <div class="col-md-6 col-lg-3 mb-4">
                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fas fa-check-circle"></i>
                        </div>
                        <div class="stat-number">${completedHackathons}</div>
                        <div class="stat-label">Completed</div>
                    </div>
                </div>
            </div>

            <!-- Quick Actions -->
            <div class="mb-4">
                <h5 style="margin-bottom: 1.5rem; font-weight: 700; color: #2d3748;">
                    <i class="fas fa-lightning-bolt"></i> Quick Actions
                </h5>
                <div class="row">
                    <div class="col-md-6 col-lg-3 mb-4">
                        <a href="${pageContext.request.contextPath}/organizer/hackathons/new" class="quick-action-card">
                            <div class="quick-action-icon">
                                <i class="fas fa-plus"></i>
                            </div>
                            <div class="quick-action-title">Create Hackathon</div>
                        </a>
                    </div>

                    <div class="col-md-6 col-lg-3 mb-4">
                        <a href="${pageContext.request.contextPath}/organizer/hackathons" class="quick-action-card">
                            <div class="quick-action-icon">
                                <i class="fas fa-list"></i>
                            </div>
                            <div class="quick-action-title">View All Hackathons</div>
                        </a>
                    </div>

                    <div class="col-md-6 col-lg-3 mb-4">
                        <a href="${pageContext.request.contextPath}/organizer/registrations" class="quick-action-card">
                            <div class="quick-action-icon">
                                <i class="fas fa-clipboard-list"></i>
                            </div>
                            <div class="quick-action-title">View Registrations</div>
                        </a>
                    </div>

                    <div class="col-md-6 col-lg-3 mb-4">
                        <a href="${pageContext.request.contextPath}/organizer/reports" class="quick-action-card">
                            <div class="quick-action-icon">
                                <i class="fas fa-chart-bar"></i>
                            </div>
                            <div class="quick-action-title">View Reports</div>
                        </a>
                    </div>
                </div>
            </div>

            <!-- Recent Hackathons -->
            <div class="row">
                <div class="col-lg-8 mb-4">
                    <div style="background: white; border-radius: 12px; padding: 2rem; box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);">
                        <h5 style="margin-bottom: 1.5rem; font-weight: 700; color: #2d3748;">
                            <i class="fas fa-star"></i> Recent Hackathons
                        </h5>

                        <c:if test="${not empty recentHackathons}">
                            <c:forEach var="hackathon" items="${recentHackathons}">
                                <div style="padding: 1rem 0; border-bottom: 1px solid #e5e7eb;">
                                    <div style="display: flex; justify-content: space-between; align-items: start; gap: 1rem;">
                                        <div>
                                            <h6 style="margin: 0 0 0.5rem 0; color: #2d3748; font-weight: 600;">
                                                ${hackathon.title}
                                            </h6>
                                            <p style="margin: 0 0 0.5rem 0; font-size: 0.9rem; color: #718096;">
                                                <i class="fas fa-calendar"></i> ${hackathon.startDate} - ${hackathon.endDate}
                                            </p>
                                            <div style="display: flex; gap: 1rem; font-size: 0.85rem;">
                                                <span style="background: #f0f1f5; padding: 0.25rem 0.75rem; border-radius: 20px; color: #4b5563;">
                                                    <i class="fas fa-users"></i> ${hackathon.participantCount} Participants
                                                </span>
                                                <span style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 0.25rem 0.75rem; border-radius: 20px;">
                                                    ${hackathon.status}
                                                </span>
                                            </div>
                                        </div>
                                        <a href="${pageContext.request.contextPath}/organizer/hackathons/${hackathon.id}/edit" class="btn btn-sm btn-outline-primary">
                                            <i class="fas fa-edit"></i> Edit
                                        </a>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:if>
                        <c:if test="${empty recentHackathons}">
                            <div style="text-align: center; color: #718096; padding: 2rem;">
                                <i class="fas fa-inbox" style="font-size: 2rem; margin-bottom: 1rem; display: block;"></i>
                                <p>No hackathons yet. <a href="${pageContext.request.contextPath}/organizer/hackathons/new" style="color: #667eea;">Create one now</a></p>
                            </div>
                        </c:if>
                    </div>
                </div>

                <!-- Info Card -->
                <div class="col-lg-4 mb-4">
                    <div style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); border-radius: 12px; padding: 2rem; color: white; box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);">
                        <h6 style="margin-bottom: 1rem; font-weight: 700;">
                            <i class="fas fa-info-circle"></i> Organizer Tips
                        </h6>
                        <ul style="margin: 0; padding-left: 1.5rem; font-size: 0.9rem; line-height: 1.6;">
                            <li style="margin-bottom: 0.75rem;">Create compelling hackathon descriptions</li>
                            <li style="margin-bottom: 0.75rem;">Set appropriate difficulty levels</li>
                            <li style="margin-bottom: 0.75rem;">Monitor participant registrations</li>
                            <li style="margin-bottom: 0;">Engage with your community</li>
                        </ul>
                    </div>
                </div>
            </div>
        </jsp:body>
    </jsp:include>
</body>
</html>
