<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="page" value="hackathons"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Hackathons - CodeVerse</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .hackathon-card {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
            transition: all 0.3s ease;
            display: flex;
            flex-direction: column;
            height: 100%;
        }

        .hackathon-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.12);
        }

        .hackathon-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            height: 120px;
            position: relative;
            overflow: hidden;
        }

        .hackathon-header::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 1px, transparent 1px);
            background-size: 50px 50px;
            animation: float 20s linear infinite;
        }

        @keyframes float {
            0% { transform: translate(0, 0); }
            100% { transform: translate(50px, 50px); }
        }

        .hackathon-category {
            position: absolute;
            top: 1rem;
            right: 1rem;
            background: rgba(255, 255, 255, 0.2);
            color: white;
            padding: 0.35rem 0.75rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            backdrop-filter: blur(10px);
        }

        .hackathon-content {
            padding: 1.5rem;
            flex: 1;
            display: flex;
            flex-direction: column;
        }

        .hackathon-title {
            font-size: 1.1rem;
            font-weight: 700;
            color: #2d3748;
            margin-bottom: 0.75rem;
            line-height: 1.3;
        }

        .hackathon-description {
            font-size: 0.9rem;
            color: #718096;
            margin-bottom: 1rem;
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
        }

        .hackathon-meta {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
            margin-bottom: 1rem;
            font-size: 0.85rem;
        }

        .meta-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: #718096;
        }

        .meta-item i {
            color: #667eea;
            min-width: 1rem;
            text-align: center;
        }

        .hackathon-footer {
            display: flex;
            gap: 0.5rem;
            margin-top: auto;
            padding-top: 1rem;
            border-top: 1px solid #e5e7eb;
        }

        .hackathon-footer a, .hackathon-footer button {
            flex: 1;
            padding: 0.5rem;
            font-size: 0.85rem;
            border-radius: 6px;
            border: none;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            text-align: center;
            white-space: nowrap;
        }

        .btn-edit {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-edit:hover {
            transform: translateY(-2px);
            color: white;
            text-decoration: none;
        }

        .btn-delete {
            background: #fee2e2;
            color: #991b1b;
        }

        .btn-delete:hover {
            background: #fecaca;
        }

        .status-badge {
            display: inline-block;
            padding: 0.35rem 0.75rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 1rem;
        }

        .status-upcoming {
            background: #dbeafe;
            color: #1e40af;
        }

        .status-active {
            background: #d1fae5;
            color: #047857;
        }

        .status-completed {
            background: #e5e7eb;
            color: #374151;
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
    </style>
</head>
<body>
    <%@ include file="codeverse-layout.jsp" %>
    <jsp:include page="codeverse-layout.jsp">
        <jsp:param name="page" value="hackathons"/>
        <jsp:body>
            <!-- Page Header -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="section-title">
                    <i class="fas fa-trophy"></i> My Hackathons
                </h2>
                <a href="${pageContext.request.contextPath}/organizer/hackathons/new" class="btn btn-codeverse">
                    <i class="fas fa-plus"></i> Create Hackathon
                </a>
            </div>

            <!-- Filter Section -->
            <div class="filter-section">
                <form method="GET" action="${pageContext.request.contextPath}/organizer/hackathons" style="display: flex; gap: 1rem; flex-wrap: wrap; align-items: flex-end; width: 100%;">
                    <div style="display: flex; flex-direction: column; gap: 0.5rem;">
                        <label style="font-weight: 600; font-size: 0.9rem; color: #2d3748;">Status</label>
                        <select name="status" onchange="this.form.submit()" style="border-radius: 8px; border: 2px solid #e5e7eb; padding: 0.5rem 0.75rem; font-size: 0.9rem;">
                            <option value="">All Status</option>
                            <option value="UPCOMING" <c:if test="${param.status == 'UPCOMING'}">selected</c:if>>Upcoming</option>
                            <option value="ACTIVE" <c:if test="${param.status == 'ACTIVE'}">selected</c:if>>Active</option>
                            <option value="COMPLETED" <c:if test="${param.status == 'COMPLETED'}">selected</c:if>>Completed</option>
                        </select>
                    </div>

                    <div style="flex: 1;"></div>

                    <a href="${pageContext.request.contextPath}/organizer/hackathons" class="btn btn-outline-secondary" style="padding: 0.5rem 1rem; border-radius: 8px;">
                        <i class="fas fa-redo"></i> Reset
                    </a>
                </form>
            </div>

            <!-- Hackathons Grid -->
            <c:if test="${not empty hackathons}">
                <div class="row">
                    <c:forEach var="hackathon" items="${hackathons}">
                        <div class="col-md-6 col-lg-4 mb-4">
                            <div class="hackathon-card">
                                <!-- Header -->
                                <div class="hackathon-header">
                                    <div class="hackathon-category">${hackathon.category}</div>
                                </div>

                                <!-- Content -->
                                <div class="hackathon-content">
                                    <div class="status-badge status-${hackathon.status}">
                                        <i class="fas fa-circle"></i> ${hackathon.status}
                                    </div>

                                    <h5 class="hackathon-title">${hackathon.title}</h5>

                                    <p class="hackathon-description">${hackathon.description}</p>

                                    <div class="hackathon-meta">
                                        <div class="meta-item">
                                            <i class="fas fa-calendar"></i>
                                            <span>${hackathon.startDate}</span>
                                        </div>
                                        <div class="meta-item">
                                            <i class="fas fa-map-marker-alt"></i>
                                            <span>${hackathon.location}</span>
                                        </div>
                                        <div class="meta-item">
                                            <i class="fas fa-users"></i>
                                            <span>${hackathon.participantCount} Participants</span>
                                        </div>
                                        <div class="meta-item">
                                            <i class="fas fa-chair"></i>
                                            <span>${hackathon.availableSlots} Slots Left</span>
                                        </div>
                                    </div>
                                </div>

                                <!-- Footer -->
                                <div class="hackathon-footer">
                                    <a href="${pageContext.request.contextPath}/organizer/hackathons/${hackathon.id}/edit" class="btn-edit">
                                        <i class="fas fa-edit"></i> Edit
                                    </a>
                                    <form method="POST" action="${pageContext.request.contextPath}/organizer/hackathons/${hackathon.id}/delete" style="flex: 1;" onsubmit="return confirm('Delete this hackathon?');">
                                        <button type="submit" class="btn-delete" style="width: 100%;">
                                            <i class="fas fa-trash"></i> Delete
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:if>

            <!-- Empty State -->
            <c:if test="${empty hackathons}">
                <div class="card">
                    <div class="card-body empty-state">
                        <div class="empty-state-icon">
                            <i class="fas fa-trophy"></i>
                        </div>
                        <h5 style="color: #2d3748; font-weight: 700; margin-bottom: 0.5rem;">No Hackathons Yet</h5>
                        <p style="margin-bottom: 1.5rem;">Start creating hackathons to engage with the community</p>
                        <a href="${pageContext.request.contextPath}/organizer/hackathons/new" class="btn btn-codeverse">
                            <i class="fas fa-plus"></i> Create Your First Hackathon
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
                                <a class="page-link" href="${pageContext.request.contextPath}/organizer/hackathons?page=1&status=${param.status}">First</a>
                            </li>
                            <li class="page-item">
                                <a class="page-link" href="${pageContext.request.contextPath}/organizer/hackathons?page=${currentPage - 1}&status=${param.status}">Previous</a>
                            </li>
                        </c:if>
                        
                        <c:forEach var="i" begin="1" end="${totalPages}">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link" href="${pageContext.request.contextPath}/organizer/hackathons?page=${i}&status=${param.status}">${i}</a>
                            </li>
                        </c:forEach>
                        
                        <c:if test="${currentPage < totalPages}">
                            <li class="page-item">
                                <a class="page-link" href="${pageContext.request.contextPath}/organizer/hackathons?page=${currentPage + 1}&status=${param.status}">Next</a>
                            </li>
                            <li class="page-item">
                                <a class="page-link" href="${pageContext.request.contextPath}/organizer/hackathons?page=${totalPages}&status=${param.status}">Last</a>
                            </li>
                        </c:if>
                    </ul>
                </nav>
            </c:if>
        </jsp:body>
    </jsp:include>
</body>
</html>
