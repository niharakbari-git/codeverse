<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="page" value="users"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Users - CodeVerse Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .status-badge {
            border-radius: 20px;
            padding: 0.35rem 0.75rem;
            font-weight: 600;
            font-size: 0.85rem;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .status-active {
            background: #d1fae5;
            color: #047857;
        }

        .status-inactive {
            background: #fee2e2;
            color: #991b1b;
        }

        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            font-size: 0.9rem;
            margin-right: 0.75rem;
        }

        .user-info {
            display: flex;
            align-items: center;
        }

        .user-details {
            display: flex;
            flex-direction: column;
            gap: 0.25rem;
        }

        .user-name {
            font-weight: 600;
            color: #2d3748;
        }

        .user-email {
            font-size: 0.85rem;
            color: #718096;
        }

        .filter-section {
            background: white;
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
            align-items: flex-end;
        }

        .filter-group {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        .filter-group label {
            font-weight: 600;
            font-size: 0.9rem;
            color: #2d3748;
        }

        .filter-group select {
            border-radius: 8px;
            border: 2px solid #e5e7eb;
            padding: 0.5rem 0.75rem;
            font-size: 0.9rem;
            min-width: 150px;
        }
    </style>
</head>
<body>
    <%@ include file="codeverse-layout.jsp" %>
    <jsp:include page="codeverse-layout.jsp">
        <jsp:param name="page" value="users"/>
        <jsp:body>
            <!-- Page Header -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="section-title">
                    <i class="fas fa-users"></i> Users Management
                </h2>
                <div>
                    <span style="color: #718096; margin-right: 1rem;">
                        <i class="fas fa-users"></i> Total Users: <strong>${totalUsers}</strong>
                    </span>
                </div>
            </div>

            <!-- Filter Section -->
            <div class="filter-section">
                <form method="GET" action="${pageContext.request.contextPath}/admin/users" style="display: flex; gap: 1rem; flex-wrap: wrap; align-items: flex-end; width: 100%;">
                    <div class="filter-group">
                        <label for="userType">User Type</label>
                        <select id="userType" name="userType" onchange="this.form.submit()">
                            <option value="">All Types</option>
                            <option value="ADMIN" <c:if test="${param.userType == 'ADMIN'}">selected</c:if>>Admin</option>
                            <option value="ORGANIZER" <c:if test="${param.userType == 'ORGANIZER'}">selected</c:if>>Organizer</option>
                            <option value="PARTICIPANT" <c:if test="${param.userType == 'PARTICIPANT'}">selected</c:if>>Participant</option>
                        </select>
                    </div>

                    <div class="filter-group">
                        <label for="status">Status</label>
                        <select id="status" name="status" onchange="this.form.submit()">
                            <option value="">All Status</option>
                            <option value="ACTIVE" <c:if test="${param.status == 'ACTIVE'}">selected</c:if>>Active</option>
                            <option value="INACTIVE" <c:if test="${param.status == 'INACTIVE'}">selected</c:if>>Inactive</option>
                            <option value="SUSPENDED" <c:if test="${param.status == 'SUSPENDED'}">selected</c:if>>Suspended</option>
                        </select>
                    </div>

                    <div style="flex: 1;"></div>

                    <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-outline-secondary" style="padding: 0.5rem 1rem; border-radius: 8px;">
                        <i class="fas fa-redo"></i> Reset Filters
                    </a>
                </form>
            </div>

            <!-- Users Table -->
            <div class="card">
                <div class="card-body">
                    <div style="overflow-x: auto;">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th><i class="fas fa-user"></i> User</th>
                                    <th><i class="fas fa-envelope"></i> Email</th>
                                    <th><i class="fas fa-tag"></i> Type</th>
                                    <th><i class="fas fa-phone"></i> Phone</th>
                                    <th><i class="fas fa-toggle-on"></i> Status</th>
                                    <th><i class="fas fa-calendar"></i> Joined</th>
                                    <th><i class="fas fa-cog"></i> Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:if test="${not empty users}">
                                    <c:forEach var="user" items="${users}">
                                        <tr>
                                            <td>
                                                <div class="user-info">
                                                    <div class="user-avatar">
                                                        ${fn:substring(user.fullName, 0, 1)}
                                                    </div>
                                                    <div class="user-details">
                                                        <div class="user-name">${user.fullName}</div>
                                                        <div class="user-email">@${user.username}</div>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>${user.email}</td>
                                            <td>
                                                <span class="badge" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white;">
                                                    <i class="fas fa-${user.userType == 'ADMIN' ? 'crown' : user.userType == 'ORGANIZER' ? 'star' : 'user'}"></i>
                                                    ${user.userType}
                                                </span>
                                            </td>
                                            <td>${user.phoneNumber}</td>
                                            <td>
                                                <form method="POST" action="${pageContext.request.contextPath}/admin/users/${user.id}/toggle-status" style="display: inline;">
                                                    <button type="submit" class="status-badge status-${user.status == 'ACTIVE' ? 'active' : 'inactive'}" style="border: none; cursor: pointer;">
                                                        <i class="fas fa-${user.status == 'ACTIVE' ? 'check-circle' : 'times-circle'}"></i>
                                                        ${user.status}
                                                    </button>
                                                </form>
                                            </td>
                                            <td>
                                                <i class="fas fa-calendar"></i> ${user.createdDate}
                                            </td>
                                            <td>
                                                <div style="display: flex; gap: 0.5rem;">
                                                    <a href="${pageContext.request.contextPath}/admin/users/${user.id}/view" 
                                                       class="btn btn-sm btn-outline-primary" 
                                                       title="View Details">
                                                        <i class="fas fa-eye"></i>
                                                    </a>
                                                    <a href="${pageContext.request.contextPath}/admin/users/${user.id}/edit" 
                                                       class="btn btn-sm btn-outline-secondary" 
                                                       title="Edit">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                                    <c:if test="${user.status != 'SUSPENDED'}">
                                                        <form method="POST" action="${pageContext.request.contextPath}/admin/users/${user.id}/suspend" 
                                                              style="display: inline;" 
                                                              onsubmit="return confirm('Are you sure you want to suspend this user?');">
                                                            <button type="submit" class="btn btn-sm btn-outline-warning" title="Suspend">
                                                                <i class="fas fa-ban"></i>
                                                            </button>
                                                        </form>
                                                    </c:if>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:if>
                                <c:if test="${empty users}">
                                    <tr>
                                        <td colspan="7" class="text-center py-4">
                                            <div style="color: #718096;">
                                                <i class="fas fa-inbox" style="font-size: 2rem; margin-bottom: 1rem; display: block;"></i>
                                                <p>No users found</p>
                                            </div>
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Pagination -->
            <c:if test="${totalPages > 1}">
                <nav aria-label="Page navigation" style="margin-top: 2rem;">
                    <ul class="pagination justify-content-center">
                        <c:if test="${currentPage > 1}">
                            <li class="page-item">
                                <a class="page-link" href="${pageContext.request.contextPath}/admin/users?page=1&userType=${param.userType}&status=${param.status}">First</a>
                            </li>
                            <li class="page-item">
                                <a class="page-link" href="${pageContext.request.contextPath}/admin/users?page=${currentPage - 1}&userType=${param.userType}&status=${param.status}">Previous</a>
                            </li>
                        </c:if>
                        
                        <c:forEach var="i" begin="1" end="${totalPages}">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link" href="${pageContext.request.contextPath}/admin/users?page=${i}&userType=${param.userType}&status=${param.status}">${i}</a>
                            </li>
                        </c:forEach>
                        
                        <c:if test="${currentPage < totalPages}">
                            <li class="page-item">
                                <a class="page-link" href="${pageContext.request.contextPath}/admin/users?page=${currentPage + 1}&userType=${param.userType}&status=${param.status}">Next</a>
                            </li>
                            <li class="page-item">
                                <a class="page-link" href="${pageContext.request.contextPath}/admin/users?page=${totalPages}&userType=${param.userType}&status=${param.status}">Last</a>
                            </li>
                        </c:if>
                    </ul>
                </nav>
            </c:if>
        </jsp:body>
    </jsp:include>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
