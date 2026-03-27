<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="page" value="categories"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Categories - CodeVerse Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body>
    <%@ include file="codeverse-layout.jsp" %>
    <jsp:include page="codeverse-layout.jsp">
        <jsp:param name="page" value="categories"/>
        <jsp:body>
            <!-- Page Header -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="section-title">
                    <i class="fas fa-list"></i> Categories
                </h2>
                <a href="${pageContext.request.contextPath}/admin/categories/new" class="btn btn-codeverse">
                    <i class="fas fa-plus"></i> Add New Category
                </a>
            </div>

            <!-- Categories Table -->
            <div class="card">
                <div class="card-body">
                    <div style="overflow-x: auto;">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th><i class="fas fa-hashtag"></i> ID</th>
                                    <th><i class="fas fa-tag"></i> Category Name</th>
                                    <th><i class="fas fa-align-left"></i> Description</th>
                                    <th><i class="fas fa-trophy"></i> Hackathons</th>
                                    <th><i class="fas fa-calendar"></i> Created Date</th>
                                    <th><i class="fas fa-cog"></i> Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:if test="${not empty categories}">
                                    <c:forEach var="category" items="${categories}">
                                        <tr>
                                            <td><span class="badge badge-success">#${category.id}</span></td>
                                            <td>
                                                <strong>${category.name}</strong>
                                            </td>
                                            <td style="max-width: 200px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;">
                                                ${category.description}
                                            </td>
                                            <td>
                                                <span class="badge" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white;">
                                                    ${category.hackathonCount}
                                                </span>
                                            </td>
                                            <td>
                                                <i class="fas fa-calendar"></i> ${category.createdDate}
                                            </td>
                                            <td>
                                                <div style="display: flex; gap: 0.5rem;">
                                                    <a href="${pageContext.request.contextPath}/admin/categories/edit/${category.id}" 
                                                       class="btn btn-sm btn-outline-primary" 
                                                       title="Edit">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                                    <form method="POST" action="${pageContext.request.contextPath}/admin/categories/delete/${category.id}" 
                                                          style="display: inline;" 
                                                          onsubmit="return confirm('Are you sure you want to delete this category?');">
                                                        <button type="submit" class="btn btn-sm btn-outline-danger" title="Delete">
                                                            <i class="fas fa-trash"></i>
                                                        </button>
                                                    </form>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:if>
                                <c:if test="${empty categories}">
                                    <tr>
                                        <td colspan="6" class="text-center py-4">
                                            <div style="color: #718096;">
                                                <i class="fas fa-inbox" style="font-size: 2rem; margin-bottom: 1rem; display: block;"></i>
                                                <p>No categories found</p>
                                            </div>
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- Pagination (if needed) -->
            <c:if test="${totalPages > 1}">
                <nav aria-label="Page navigation" style="margin-top: 2rem;">
                    <ul class="pagination justify-content-center">
                        <c:if test="${currentPage > 1}">
                            <li class="page-item">
                                <a class="page-link" href="${pageContext.request.contextPath}/admin/categories?page=1">First</a>
                            </li>
                            <li class="page-item">
                                <a class="page-link" href="${pageContext.request.contextPath}/admin/categories?page=${currentPage - 1}">Previous</a>
                            </li>
                        </c:if>
                        
                        <c:forEach var="i" begin="1" end="${totalPages}">
                            <li class="page-item ${i == currentPage ? 'active' : ''}">
                                <a class="page-link" href="${pageContext.request.contextPath}/admin/categories?page=${i}">${i}</a>
                            </li>
                        </c:forEach>
                        
                        <c:if test="${currentPage < totalPages}">
                            <li class="page-item">
                                <a class="page-link" href="${pageContext.request.contextPath}/admin/categories?page=${currentPage + 1}">Next</a>
                            </li>
                            <li class="page-item">
                                <a class="page-link" href="${pageContext.request.contextPath}/admin/categories?page=${totalPages}">Last</a>
                            </li>
                        </c:if>
                    </ul>
                </nav>
            </c:if>
        </jsp:body>
    </jsp:include>
</body>
</html>
