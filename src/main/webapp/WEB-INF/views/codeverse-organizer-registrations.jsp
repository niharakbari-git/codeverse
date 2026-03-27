<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="page" value="registrations"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrations - CodeVerse</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
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

        .status-badge {
            display: inline-block;
            padding: 0.35rem 0.75rem;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.85rem;
        }

        .status-confirmed {
            background: #d1fae5;
            color: #047857;
        }

        .status-pending {
            background: #fef3c7;
            color: #92400e;
        }

        .status-cancelled {
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
        }

        .registration-code {
            font-family: 'Courier New', monospace;
            background: #f0f1f5;
            padding: 0.25rem 0.5rem;
            border-radius: 4px;
            font-weight: 600;
            color: #667eea;
        }
    </style>
</head>
<body>
    <%@ include file="codeverse-layout.jsp" %>
    <jsp:include page="codeverse-layout.jsp">
        <jsp:param name="page" value="registrations"/>
        <jsp:body>
            <!-- Page Header -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="section-title">
                    <i class="fas fa-clipboard-list"></i> Registrations
                </h2>
                <div>
                    <span style="color: #718096;">
                        <i class="fas fa-users"></i> Total: <strong>${totalRegistrations}</strong>
                    </span>
                </div>
            </div>

            <!-- Filter Section -->
            <div class="filter-section">
                <form method="GET" action="${pageContext.request.contextPath}/organizer/registrations" style="display: flex; gap: 1rem; flex-wrap: wrap; align-items: flex-end; width: 100%;">
                    <div class="filter-group">
                        <label for="hackathon">Hackathon</label>
                        <select id="hackathon" name="hackathonId" onchange="this.form.submit()">
                            <option value="">All Hackathons</option>
                            <c:forEach var="hackathon" items="${hackathons}">
                                <option value="${hackathon.id}" <c:if test="${param.hackathonId == hackathon.id}">selected</c:if>>
                                    ${hackathon.title}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="filter-group">
                        <label for="status">Status</label>
                        <select id="status" name="status" onchange="this.form.submit()">
                            <option value="">All Status</option>
                            <option value="CONFIRMED" <c:if test="${param.status == 'CONFIRMED'}">selected</c:if>>Confirmed</option>
                            <option value="PENDING" <c:if test="${param.status == 'PENDING'}">selected</c:if>>Pending</option>
                            <option value="CANCELLED" <c:if test="${param.status == 'CANCELLED'}">selected</c:if>>Cancelled</option>
                        </select>
                    </div>

                    <div style="flex: 1;"></div>

                    <a href="${pageContext.request.contextPath}/organizer/registrations" class="btn btn-outline-secondary" style="padding: 0.5rem 1rem; border-radius: 8px;">
                        <i class="fas fa-redo"></i> Reset
                    </a>
                </form>
            </div>

            <!-- Registrations Table -->
            <div class="card">
                <div class="card-body">
                    <div style="overflow-x: auto;">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th><i class="fas fa-user"></i> Participant</th>
                                    <th><i class="fas fa-trophy"></i> Hackathon</th>
                                    <th><i class="fas fa-barcode"></i> Registration Code</th>
                                    <th><i class="fas fa-toggle-on"></i> Status</th>
                                    <th><i class="fas fa-calendar"></i> Registered Date</th>
                                    <th><i class="fas fa-cog"></i> Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:if test="${not empty registrations}">
                                    <c:forEach var="registration" items="${registrations}">
                                        <tr>
                                            <td>
                                                <div style="display: flex; align-items: center; gap: 0.75rem;">
                                                    <div class="user-avatar">
                                                        ${fn:substring(registration.participantName, 0, 1)}
                                                    </div>
                                                    <div>
                                                        <div style="font-weight: 600; color: #2d3748;">${registration.participantName}</div>
                                                        <div style="font-size: 0.85rem; color: #718096;">${registration.participantEmail}</div>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <strong>${registration.hackathonTitle}</strong>
                                            </td>
                                            <td>
                                                <span class="registration-code">${registration.registrationCode}</span>
                                            </td>
                                            <td>
                                                <span class="status-badge status-${registration.status}">
                                                    <i class="fas fa-circle"></i> ${registration.status}
                                                </span>
                                            </td>
                                            <td>
                                                <i class="fas fa-calendar"></i> ${registration.registeredDate}
                                            </td>
                                            <td>
                                                <div style="display: flex; gap: 0.5rem;">
                                                    <a href="${pageContext.request.contextPath}/organizer/registrations/${registration.id}/view" 
                                                       class="btn btn-sm btn-outline-primary" 
                                                       title="View Details">
                                                        <i class="fas fa-eye"></i>
                                                    </a>
                                                    <c:if test="${registration.status == 'PENDING'}">
                                                        <form method="POST" action="${pageContext.request.contextPath}/organizer/registrations/${registration.id}/confirm" style="display: inline;">
                                                            <button type="submit" class="btn btn-sm btn-outline-success" title="Confirm">
                                                                <i class="fas fa-check"></i>
                                                            </button>
                                                        </form>
                                                        <form method="POST" action="${pageContext.request.contextPath}/organizer/registrations/${registration.id}/cancel" style="display: inline;" onsubmit="return confirm('Cancel this registration?');">
                                                            <button type="submit" class="btn btn-sm btn-outline-danger" title="Cancel">
                                                                <i class="fas fa-times"></i>
                                                            </button>
                                                        </form>
                                                    </c:if>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:if>
                                <c:if test="${empty registrations}">
                                    <tr>
                                        <td colspan="6" class="text-center py-4">
                                            <div style="color: #718096;">
                                                <i class="fas fa-inbox" style="font-size: 2rem; margin-bottom: 1rem; display: block;"></i>
                                                <p>No registrations found</p>
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
                                <a class="page-link" href="${pageContext.request.contextPath}/organizer/registrations?page=1&hackathonId=${param.hackathonId}&status=${param.status}">First</a>
                            </li>
                            <li class="page-item">
                                <a class="page-link" href="${pageContext.request.contextPath}/organizer/registrations?page=${currentPage - 1}&hackathonId=${param.hackathonId}&status=${param.status}">Previous</a>
                            </li>
                        </c:if>
                        
                        <c:forEach var="i" begin="1" end="${totalPages}">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link" href="${pageContext.request.contextPath}/organizer/registrations?page=${i}&hackathonId=${param.hackathonId}&status=${param.status}">${i}</a>
                            </li>
                        </c:forEach>
                        
                        <c:if test="${currentPage < totalPages}">
                            <li class="page-item">
                                <a class="page-link" href="${pageContext.request.contextPath}/organizer/registrations?page=${currentPage + 1}&hackathonId=${param.hackathonId}&status=${param.status}">Next</a>
                            </li>
                            <li class="page-item">
                                <a class="page-link" href="${pageContext.request.contextPath}/organizer/registrations?page=${totalPages}&hackathonId=${param.hackathonId}&status=${param.status}">Last</a>
                            </li>
                        </c:if>
                    </ul>
                </nav>
            </c:if>

            <!-- Export Option -->
            <div style="margin-top: 2rem; text-align: right;">
                <a href="${pageContext.request.contextPath}/organizer/registrations/export" class="btn btn-outline-secondary">
                    <i class="fas fa-download"></i> Export as CSV
                </a>
            </div>
        </jsp:body>
    </jsp:include>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
