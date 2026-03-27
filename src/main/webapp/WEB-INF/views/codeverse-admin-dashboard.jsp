<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="page" value="dashboard"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - CodeVerse</title>
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

        .stat-card.users {
            border-left-color: #667eea;
        }

        .stat-card.categories {
            border-left-color: #f59e0b;
        }

        .stat-card.hackathons {
            border-left-color: #10b981;
        }

        .stat-card.registrations {
            border-left-color: #f5576c;
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

        .stat-card.categories .stat-number {
            background: linear-gradient(135deg, #f59e0b 0%, #f5a623 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .stat-card.hackathons .stat-number {
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .stat-card.registrations .stat-number {
            background: linear-gradient(135deg, #f5576c 0%, #f5576c 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
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

        .recent-activity {
            background: white;
            border-radius: 12px;
            padding: 2rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
        }

        .activity-item {
            display: flex;
            gap: 1rem;
            padding: 1rem 0;
            border-bottom: 1px solid #e5e7eb;
        }

        .activity-item:last-child {
            border-bottom: none;
        }

        .activity-icon {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
            font-size: 1.2rem;
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.1) 0%, rgba(118, 75, 162, 0.1) 100%);
            color: #667eea;
        }

        .activity-content {
            flex: 1;
        }

        .activity-title {
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 0.25rem;
        }

        .activity-time {
            font-size: 0.85rem;
            color: #718096;
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
                    <i class="fas fa-chart-line"></i> Admin Dashboard
                </h2>
                <p style="color: #718096; margin: 0;">Welcome back, ${sessionScope.user.fullName}!</p>
            </div>

            <!-- Statistics Cards -->
            <div class="row mb-4">
                <div class="col-md-6 col-lg-3 mb-4">
                    <div class="stat-card users">
                        <div class="stat-icon">
                            <i class="fas fa-users"></i>
                        </div>
                        <div class="stat-number">${totalUsers}</div>
                        <div class="stat-label">Total Users</div>
                    </div>
                </div>

                <div class="col-md-6 col-lg-3 mb-4">
                    <div class="stat-card categories">
                        <div class="stat-icon">
                            <i class="fas fa-list"></i>
                        </div>
                        <div class="stat-number">${totalCategories}</div>
                        <div class="stat-label">Categories</div>
                    </div>
                </div>

                <div class="col-md-6 col-lg-3 mb-4">
                    <div class="stat-card hackathons">
                        <div class="stat-icon">
                            <i class="fas fa-trophy"></i>
                        </div>
                        <div class="stat-number">${totalHackathons}</div>
                        <div class="stat-label">Active Hackathons</div>
                    </div>
                </div>

                <div class="col-md-6 col-lg-3 mb-4">
                    <div class="stat-card registrations">
                        <div class="stat-icon">
                            <i class="fas fa-clipboard-list"></i>
                        </div>
                        <div class="stat-number">${totalRegistrations}</div>
                        <div class="stat-label">Registrations</div>
                    </div>
                </div>
            </div>

            <!-- Dashboard Grid -->
            <div class="row">
                <!-- Recent Activities -->
                <div class="col-lg-6 mb-4">
                    <div class="recent-activity">
                        <h5 style="margin-bottom: 1.5rem; font-weight: 700; color: #2d3748;">
                            <i class="fas fa-history"></i> Recent Activities
                        </h5>

                        <div class="activity-item">
                            <div class="activity-icon">
                                <i class="fas fa-user-plus"></i>
                            </div>
                            <div class="activity-content">
                                <div class="activity-title">New User Registered</div>
                                <div class="activity-time">2 hours ago</div>
                            </div>
                        </div>

                        <div class="activity-item">
                            <div class="activity-icon">
                                <i class="fas fa-trophy"></i>
                            </div>
                            <div class="activity-content">
                                <div class="activity-title">New Hackathon Created</div>
                                <div class="activity-time">5 hours ago</div>
                            </div>
                        </div>

                        <div class="activity-item">
                            <div class="activity-icon">
                                <i class="fas fa-bookmark"></i>
                            </div>
                            <div class="activity-content">
                                <div class="activity-title">Participant Registration</div>
                                <div class="activity-time">1 day ago</div>
                            </div>
                        </div>

                        <div class="activity-item">
                            <div class="activity-icon">
                                <i class="fas fa-cogs"></i>
                            </div>
                            <div class="activity-content">
                                <div class="activity-title">System Configuration Updated</div>
                                <div class="activity-time">2 days ago</div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Quick Actions -->
                <div class="col-lg-6 mb-4">
                    <div class="recent-activity">
                        <h5 style="margin-bottom: 1.5rem; font-weight: 700; color: #2d3748;">
                            <i class="fas fa-lightning-bolt"></i> Quick Actions
                        </h5>

                        <div style="display: grid; gap: 1rem;">
                            <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-outline-codeverse" style="text-align: left; justify-content: flex-start; padding: 1rem;">
                                <i class="fas fa-list" style="margin-right: 0.75rem;"></i> Manage Categories
                            </a>

                            <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-outline-codeverse" style="text-align: left; justify-content: flex-start; padding: 1rem;">
                                <i class="fas fa-users" style="margin-right: 0.75rem;"></i> Manage Users
                            </a>

                            <a href="${pageContext.request.contextPath}/admin/categories/new" class="btn btn-outline-codeverse" style="text-align: left; justify-content: flex-start; padding: 1rem;">
                                <i class="fas fa-plus" style="margin-right: 0.75rem;"></i> Add New Category
                            </a>

                            <a href="${pageContext.request.contextPath}/admin/reports" class="btn btn-outline-codeverse" style="text-align: left; justify-content: flex-start; padding: 1rem;">
                                <i class="fas fa-chart-bar" style="margin-right: 0.75rem;"></i> View Reports
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </jsp:body>
    </jsp:include>
</body>
</html>
