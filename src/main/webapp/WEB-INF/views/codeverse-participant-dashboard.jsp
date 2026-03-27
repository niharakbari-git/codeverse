<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="page" value="dashboard"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Participant Dashboard - CodeVerse</title>
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

        .quick-action-btn {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            width: 100%;
            padding: 1rem;
            background: white;
            border: 2px solid #e5e7eb;
            border-radius: 10px;
            text-decoration: none;
            color: inherit;
            transition: all 0.3s ease;
            font-weight: 600;
            margin-bottom: 1rem;
        }

        .quick-action-btn:hover {
            border-color: #667eea;
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.05) 0%, rgba(118, 75, 162, 0.05) 100%);
            color: inherit;
            text-decoration: none;
            transform: translateX(5px);
        }

        .quick-action-btn i {
            font-size: 1.5rem;
            color: #667eea;
        }

        .upcoming-card {
            background: white;
            border-radius: 12px;
            padding: 1.5rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
            transition: all 0.3s ease;
            border-left: 4px solid #f59e0b;
        }

        .upcoming-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(0, 0, 0, 0.12);
        }

        .upcoming-title {
            font-weight: 700;
            color: #2d3748;
            margin-bottom: 0.5rem;
        }

        .upcoming-meta {
            font-size: 0.85rem;
            color: #718096;
            display: flex;
            gap: 1rem;
            margin-bottom: 1rem;
        }

        .upcoming-meta i {
            color: #f59e0b;
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
                    <i class="fas fa-chart-line"></i> Participant Dashboard
                </h2>
                <p style="color: #718096; margin: 0;">Welcome, ${sessionScope.user.fullName}!</p>
            </div>

            <!-- Statistics Cards -->
            <div class="row mb-4">
                <div class="col-md-6 col-lg-3 mb-4">
                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fas fa-bookmark"></i>
                        </div>
                        <div class="stat-number">${totalBookings}</div>
                        <div class="stat-label">My Bookings</div>
                    </div>
                </div>

                <div class="col-md-6 col-lg-3 mb-4">
                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fas fa-trophy"></i>
                        </div>
                        <div class="stat-number">${completedHackathons}</div>
                        <div class="stat-label">Completed</div>
                    </div>
                </div>

                <div class="col-md-6 col-lg-3 mb-4">
                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fas fa-fire"></i>
                        </div>
                        <div class="stat-number">${totalPoints}</div>
                        <div class="stat-label">Points Earned</div>
                    </div>
                </div>

                <div class="col-md-6 col-lg-3 mb-4">
                    <div class="stat-card">
                        <div class="stat-icon">
                            <i class="fas fa-star"></i>
                        </div>
                        <div class="stat-number">${averageRating}</div>
                        <div class="stat-label">Rating</div>
                    </div>
                </div>
            </div>

            <!-- Main Content Grid -->
            <div class="row">
                <!-- Quick Actions -->
                <div class="col-lg-4 mb-4">
                    <div style="background: white; border-radius: 12px; padding: 2rem; box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);">
                        <h5 style="margin-bottom: 1.5rem; font-weight: 700; color: #2d3748;">
                            <i class="fas fa-lightning-bolt"></i> Quick Actions
                        </h5>

                        <a href="${pageContext.request.contextPath}/participant/explore" class="quick-action-btn">
                            <i class="fas fa-compass"></i> Explore Hackathons
                        </a>

                        <a href="${pageContext.request.contextPath}/participant/bookings" class="quick-action-btn">
                            <i class="fas fa-bookmark"></i> My Bookings
                        </a>

                        <a href="${pageContext.request.contextPath}/profile" class="quick-action-btn">
                            <i class="fas fa-user"></i> My Profile
                        </a>

                        <a href="#" class="quick-action-btn">
                            <i class="fas fa-certificate"></i> My Certificates
                        </a>
                    </div>
                </div>

                <!-- Upcoming Hackathons -->
                <div class="col-lg-8 mb-4">
                    <div style="background: white; border-radius: 12px; padding: 2rem; box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);">
                        <h5 style="margin-bottom: 1.5rem; font-weight: 700; color: #2d3748;">
                            <i class="fas fa-calendar"></i> Your Upcoming Hackathons
                        </h5>

                        <c:if test="${not empty upcomingHackathons}">
                            <c:forEach var="hackathon" items="${upcomingHackathons}">
                                <div class="upcoming-card">
                                    <div class="upcoming-title">${hackathon.title}</div>
                                    <div class="upcoming-meta">
                                        <span><i class="fas fa-calendar"></i> ${hackathon.startDate}</span>
                                        <span><i class="fas fa-map-marker-alt"></i> ${hackathon.location}</span>
                                    </div>
                                    <div style="display: flex; gap: 0.5rem;">
                                        <a href="${pageContext.request.contextPath}/participant/hackathons/${hackathon.id}" class="btn btn-sm btn-outline-primary" style="flex: 1;">
                                            <i class="fas fa-arrow-right"></i> View Details
                                        </a>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:if>

                        <c:if test="${empty upcomingHackathons}">
                            <div style="text-align: center; color: #718096; padding: 2rem;">
                                <i class="fas fa-inbox" style="font-size: 2rem; margin-bottom: 1rem; display: block;"></i>
                                <p>No upcoming hackathons. <a href="${pageContext.request.contextPath}/participant/explore" style="color: #667eea;">Explore now</a></p>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>

            <!-- Recent Activity -->
            <div style="background: white; border-radius: 12px; padding: 2rem; box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08); margin-bottom: 2rem;">
                <h5 style="margin-bottom: 1.5rem; font-weight: 700; color: #2d3748;">
                    <i class="fas fa-history"></i> Recent Activity
                </h5>

                <c:if test="${not empty recentActivity}">
                    <c:forEach var="activity" items="${recentActivity}">
                        <div style="padding: 1rem 0; border-bottom: 1px solid #e5e7eb; display: flex; gap: 1rem; align-items: center;">
                            <div style="width: 40px; height: 40px; border-radius: 50%; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); display: flex; align-items: center; justify-content: center; color: white; flex-shrink: 0;">
                                <i class="${activity.icon}"></i>
                            </div>
                            <div>
                                <div style="font-weight: 600; color: #2d3748;">${activity.title}</div>
                                <div style="font-size: 0.85rem; color: #718096;">${activity.timestamp}</div>
                            </div>
                        </div>
                    </c:forEach>
                </c:if>

                <c:if test="${empty recentActivity}">
                    <div style="text-align: center; color: #718096; padding: 2rem;">
                        <p>No recent activity</p>
                    </div>
                </c:if>
            </div>

            <!-- Achievements / Badges -->
            <div style="background: white; border-radius: 12px; padding: 2rem; box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);">
                <h5 style="margin-bottom: 1.5rem; font-weight: 700; color: #2d3748;">
                    <i class="fas fa-award"></i> Achievements
                </h5>

                <div style="display: grid; grid-template-columns: repeat(auto-fill, minmax(100px, 1fr)); gap: 1rem;">
                    <div style="text-align: center; padding: 1rem; background: #f8f9fa; border-radius: 10px;">
                        <div style="font-size: 2rem; margin-bottom: 0.5rem;">🎯</div>
                        <div style="font-size: 0.8rem; font-weight: 600; color: #2d3748;">First Hack</div>
                    </div>
                    <div style="text-align: center; padding: 1rem; background: #f8f9fa; border-radius: 10px;">
                        <div style="font-size: 2rem; margin-bottom: 0.5rem;">🚀</div>
                        <div style="font-size: 0.8rem; font-weight: 600; color: #2d3748;">Speed Demon</div>
                    </div>
                    <div style="text-align: center; padding: 1rem; background: #f8f9fa; border-radius: 10px;">
                        <div style="font-size: 2rem; margin-bottom: 0.5rem;">⭐</div>
                        <div style="font-size: 0.8rem; font-weight: 600; color: #2d3748;">Rising Star</div>
                    </div>
                </div>
            </div>
        </jsp:body>
    </jsp:include>
</body>
</html>
