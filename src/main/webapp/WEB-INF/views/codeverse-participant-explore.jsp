<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="page" value="explore"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Explore Hackathons - CodeVerse</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .search-filter-section {
            background: white;
            border-radius: 12px;
            padding: 2rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
            margin-bottom: 2rem;
        }

        .search-input {
            width: 100%;
            padding: 0.85rem 1.25rem;
            border-radius: 10px;
            border: 2px solid #e5e7eb;
            font-size: 0.95rem;
            transition: all 0.3s ease;
        }

        .search-input:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.15);
            outline: none;
        }

        .filter-chip {
            display: inline-block;
            padding: 0.5rem 1rem;
            background: white;
            border: 2px solid #e5e7eb;
            border-radius: 20px;
            margin-right: 0.5rem;
            margin-bottom: 0.5rem;
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: 600;
            color: #4b5563;
        }

        .filter-chip:hover, .filter-chip.active {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-color: transparent;
            color: white;
        }

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
            transform: translateY(-8px);
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.15);
        }

        .hackathon-image {
            height: 180px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            position: relative;
            overflow: hidden;
        }

        .hackathon-image::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 1px, transparent 1px);
            background-size: 50px 50px;
        }

        .category-badge {
            position: absolute;
            top: 1rem;
            right: 1rem;
            background: rgba(255, 255, 255, 0.25);
            color: white;
            padding: 0.4rem 0.85rem;
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
            margin-bottom: 0.5rem;
            line-height: 1.3;
        }

        .hackathon-description {
            font-size: 0.85rem;
            color: #718096;
            margin-bottom: 1rem;
            overflow: hidden;
            text-overflow: ellipsis;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
        }

        .hackathon-meta {
            display: flex;
            flex-direction: column;
            gap: 0.75rem;
            margin-bottom: 1rem;
            font-size: 0.85rem;
            color: #718096;
        }

        .meta-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .meta-item i {
            color: #667eea;
            min-width: 1rem;
            text-align: center;
        }

        .hackathon-slots {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.75rem;
            background: #f0f1f5;
            border-radius: 8px;
            margin-bottom: 1rem;
            font-size: 0.85rem;
            font-weight: 600;
            color: #667eea;
        }

        .slots-bar {
            width: 100%;
            height: 6px;
            background: #e5e7eb;
            border-radius: 3px;
            overflow: hidden;
            margin: 0 0.5rem;
        }

        .slots-filled {
            height: 100%;
            background: linear-gradient(90deg, #667eea 0%, #764ba2 100%);
        }

        .book-button {
            width: 100%;
            padding: 0.75rem;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .book-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(102, 126, 234, 0.3);
            color: white;
            text-decoration: none;
        }

        .book-button:disabled {
            background: #d1d5db;
            cursor: not-allowed;
            transform: none;
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

        .sort-dropdown {
            border-radius: 8px;
            border: 2px solid #e5e7eb;
            padding: 0.5rem 0.75rem;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
    <%@ include file="codeverse-layout.jsp" %>
    <jsp:include page="codeverse-layout.jsp">
        <jsp:param name="page" value="explore"/>
        <jsp:body>
            <!-- Page Header -->
            <h2 class="section-title mb-4">
                <i class="fas fa-compass"></i> Explore Hackathons
            </h2>

            <!-- Search & Filter Section -->
            <div class="search-filter-section">
                <form method="GET" action="${pageContext.request.contextPath}/participant/explore" style="margin-bottom: 1.5rem;">
                    <div class="row">
                        <div class="col-md-8 mb-3">
                            <div style="position: relative;">
                                <i class="fas fa-search" style="position: absolute; left: 1rem; top: 50%; transform: translateY(-50%); color: #a0aec0;"></i>
                                <input 
                                    type="text" 
                                    name="search" 
                                    class="search-input" 
                                    placeholder="Search hackathons by title or keyword..." 
                                    value="${param.search}"
                                    style="padding-left: 2.5rem;">
                            </div>
                        </div>
                        <div class="col-md-4 mb-3">
                            <select name="sortBy" class="sort-dropdown" style="width: 100%; padding: 0.65rem 0.75rem;">
                                <option value="latest" <c:if test="${param.sortBy == 'latest'}">selected</c:if>>Latest</option>
                                <option value="upcoming" <c:if test="${param.sortBy == 'upcoming'}">selected</c:if>>Upcoming</option>
                                <option value="slots" <c:if test="${param.sortBy == 'slots'}">selected</c:if>>Available Slots</option>
                                <option value="popular" <c:if test="${param.sortBy == 'popular'}">selected</c:if>>Popular</option>
                            </select>
                        </div>
                    </div>

                    <!-- Category Filters -->
                    <div style="margin-top: 1rem;">
                        <label style="font-weight: 600; color: #2d3748; margin-bottom: 0.75rem; display: block;">Filter by Category:</label>
                        <div>
                            <c:forEach var="category" items="${categories}">
                                <label class="filter-chip" style="cursor: pointer; margin-bottom: 0.5rem;">
                                    <input 
                                        type="checkbox" 
                                        name="categories" 
                                        value="${category.id}"
                                        <c:if test="${fn:contains(param.categories, category.id)}">checked</c:if>
                                        style="margin-right: 0.5rem; cursor: pointer;">
                                    <i class="fas fa-tag"></i> ${category.name}
                                </label>
                            </c:forEach>
                        </div>
                    </div>

                    <div style="margin-top: 1rem; display: flex; gap: 1rem;">
                        <button type="submit" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; border: none; padding: 0.75rem 1.5rem; border-radius: 8px; font-weight: 600; cursor: pointer;">
                            <i class="fas fa-search"></i> Search
                        </button>
                        <a href="${pageContext.request.contextPath}/participant/explore" style="background: #e5e7eb; color: #4b5563; padding: 0.75rem 1.5rem; border-radius: 8px; font-weight: 600; text-decoration: none;">
                            <i class="fas fa-redo"></i> Clear Filters
                        </a>
                    </div>
                </form>
            </div>

            <!-- Results Count -->
            <div style="margin-bottom: 1.5rem; color: #718096;">
                <i class="fas fa-info-circle"></i>
                <strong>${totalHackathons}</strong> hackathons found
                <c:if test="${not empty param.search}">
                    for "<strong>${param.search}</strong>"
                </c:if>
            </div>

            <!-- Hackathons Grid -->
            <c:if test="${not empty hackathons}">
                <div class="row">
                    <c:forEach var="hackathon" items="${hackathons}">
                        <div class="col-md-6 col-lg-4 mb-4">
                            <div class="hackathon-card">
                                <!-- Image Header -->
                                <div class="hackathon-image">
                                    <div class="category-badge">${hackathon.category}</div>
                                </div>

                                <!-- Content -->
                                <div class="hackathon-content">
                                    <h5 class="hackathon-title">${hackathon.title}</h5>

                                    <p class="hackathon-description">${hackathon.description}</p>

                                    <!-- Meta Information -->
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
                                            <i class="fas fa-signal"></i>
                                            <span>${hackathon.difficultyLevel}</span>
                                        </div>
                                    </div>

                                    <!-- Slots Information -->
                                    <div class="hackathon-slots">
                                        <i class="fas fa-chair"></i>
                                        <span>${hackathon.availableSlots} / ${hackathon.totalSlots}</span>
                                        <div class="slots-bar">
                                            <div class="slots-filled" style="width: ${(hackathon.totalSlots - hackathon.availableSlots) / hackathon.totalSlots * 100}%"></div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Book Button -->
                                <div style="padding: 1rem 1.5rem;">
                                    <c:if test="${hackathon.availableSlots > 0}">
                                        <a href="${pageContext.request.contextPath}/participant/hackathons/${hackathon.id}" class="book-button">
                                            <i class="fas fa-ticket-alt"></i> Book Slot
                                        </a>
                                    </c:if>
                                    <c:if test="${hackathon.availableSlots == 0}">
                                        <button class="book-button" disabled>
                                            <i class="fas fa-times"></i> No Slots Available
                                        </button>
                                    </c:if>
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
                            <i class="fas fa-inbox"></i>
                        </div>
                        <h5 style="color: #2d3748; font-weight: 700; margin-bottom: 0.5rem;">No Hackathons Found</h5>
                        <p>Try adjusting your search criteria or check back later for new hackathons</p>
                    </div>
                </div>
            </c:if>

            <!-- Pagination -->
            <c:if test="${totalPages > 1}">
                <nav aria-label="Page navigation" style="margin-top: 3rem;">
                    <ul class="pagination justify-content-center">
                        <c:if test="${currentPage > 1}">
                            <li class="page-item">
                                <a class="page-link" href="${pageContext.request.contextPath}/participant/explore?page=1&search=${param.search}&categories=${param.categories}">First</a>
                            </li>
                            <li class="page-item">
                                <a class="page-link" href="${pageContext.request.contextPath}/participant/explore?page=${currentPage - 1}&search=${param.search}&categories=${param.categories}">Previous</a>
                            </li>
                        </c:if>
                        
                        <c:forEach var="i" begin="1" end="${totalPages}">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link" href="${pageContext.request.contextPath}/participant/explore?page=${i}&search=${param.search}&categories=${param.categories}">${i}</a>
                            </li>
                        </c:forEach>
                        
                        <c:if test="${currentPage < totalPages}">
                            <li class="page-item">
                                <a class="page-link" href="${pageContext.request.contextPath}/participant/explore?page=${currentPage + 1}&search=${param.search}&categories=${param.categories}">Next</a>
                            </li>
                            <li class="page-item">
                                <a class="page-link" href="${pageContext.request.contextPath}/participant/explore?page=${totalPages}&search=${param.search}&categories=${param.categories}">Last</a>
                            </li>
                        </c:if>
                    </ul>
                </nav>
            </c:if>
        </jsp:body>
    </jsp:include>
</body>
</html>
