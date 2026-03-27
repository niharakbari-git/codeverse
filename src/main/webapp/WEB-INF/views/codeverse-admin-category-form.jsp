<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="page" value="categories"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${empty category ? 'Add New Category' : 'Edit Category'} - CodeVerse Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .form-section {
            background: white;
            border-radius: 12px;
            padding: 2rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
            margin-bottom: 2rem;
        }

        .form-section h5 {
            font-weight: 700;
            color: #2d3748;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 0.75rem;
            font-size: 0.95rem;
        }

        .form-control, .form-select {
            border-radius: 8px;
            border: 2px solid #e5e7eb;
            padding: 0.75rem 1rem;
            font-size: 0.95rem;
            transition: all 0.3s ease;
        }

        .form-control:focus, .form-select:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.15);
            outline: none;
        }

        .form-control::placeholder {
            color: #a0aec0;
        }

        .btn-submit {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 8px;
            padding: 0.75rem 2rem;
            font-weight: 600;
            transition: all 0.3s ease;
            margin-right: 1rem;
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.4);
            color: white;
        }

        .btn-cancel {
            background: #e5e7eb;
            color: #4b5563;
            border: none;
            border-radius: 8px;
            padding: 0.75rem 2rem;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn-cancel:hover {
            background: #d1d5db;
            color: #2d3748;
        }

        .invalid-feedback {
            display: block;
            color: #ef4444;
            font-size: 0.85rem;
            margin-top: 0.25rem;
        }

        .char-count {
            font-size: 0.85rem;
            color: #718096;
            text-align: right;
            margin-top: 0.25rem;
        }
    </style>
</head>
<body>
    <%@ include file="codeverse-layout.jsp" %>
    <jsp:include page="codeverse-layout.jsp">
        <jsp:param name="page" value="categories"/>
        <jsp:body>
            <!-- Page Header -->
            <div class="mb-4">
                <h2 class="section-title">
                    <i class="fas fa-${empty category ? 'plus' : 'edit'}"></i>
                    ${empty category ? 'Add New Category' : 'Edit Category'}
                </h2>
            </div>

            <!-- Form Section -->
            <div class="form-section">
                <h5>
                    <i class="fas fa-info-circle"></i> Category Information
                </h5>

                <form method="POST" 
                      action="${empty category ? pageContext.request.contextPath.concat('/admin/categories/create') : pageContext.request.contextPath.concat('/admin/categories/update/')}"
                      class="needs-validation" 
                      novalidate>

                    <!-- Category Name -->
                    <div class="form-group">
                        <label for="categoryName" class="form-label">
                            <i class="fas fa-tag"></i> Category Name <span style="color: #ef4444;">*</span>
                        </label>
                        <input 
                            type="text" 
                            class="form-control" 
                            id="categoryName" 
                            name="name" 
                            placeholder="e.g., Web Development, Mobile Apps" 
                            value="${category.name}"
                            required
                            minlength="3"
                            maxlength="50">
                        <div class="invalid-feedback">
                            Category name is required and must be 3-50 characters.
                        </div>
                        <div class="char-count" id="nameCount">0/50</div>
                    </div>

                    <!-- Category Description -->
                    <div class="form-group">
                        <label for="categoryDescription" class="form-label">
                            <i class="fas fa-align-left"></i> Description <span style="color: #ef4444;">*</span>
                        </label>
                        <textarea 
                            class="form-control" 
                            id="categoryDescription" 
                            name="description" 
                            placeholder="Describe what this category is about..." 
                            rows="5"
                            required
                            minlength="10"
                            maxlength="500">${category.description}</textarea>
                        <div class="invalid-feedback">
                            Description is required and must be 10-500 characters.
                        </div>
                        <div class="char-count" id="descCount">0/500</div>
                    </div>

                    <!-- Color/Icon (Optional) -->
                    <div class="form-group">
                        <label for="categoryIcon" class="form-label">
                            <i class="fas fa-palette"></i> Icon Class (Font Awesome)
                        </label>
                        <div style="display: flex; gap: 1rem; align-items: flex-end;">
                            <div style="flex: 1;">
                                <input 
                                    type="text" 
                                    class="form-control" 
                                    id="categoryIcon" 
                                    name="icon" 
                                    placeholder="e.g., fas fa-code" 
                                    value="${category.icon}">
                                <small class="text-muted">Optional: Font Awesome icon class</small>
                            </div>
                            <div id="iconPreview" style="font-size: 2rem; width: 50px; height: 50px; display: flex; align-items: center; justify-content: center; color: #667eea;">
                                <c:if test="${not empty category.icon}">
                                    <i class="${category.icon}"></i>
                                </c:if>
                            </div>
                        </div>
                    </div>

                    <!-- Form Actions -->
                    <div style="display: flex; gap: 1rem; margin-top: 2rem;">
                        <button type="submit" class="btn-submit">
                            <i class="fas fa-save"></i> 
                            ${empty category ? 'Create Category' : 'Update Category'}
                        </button>
                        <a href="${pageContext.request.contextPath}/admin/categories" class="btn-cancel">
                            <i class="fas fa-times"></i> Cancel
                        </a>
                    </div>
                </form>
            </div>

            <!-- Additional Info -->
            <div class="card" style="border: 1px solid #e5e7eb; border-radius: 12px;">
                <div class="card-body">
                    <h6 style="margin-bottom: 1rem; color: #2d3748; font-weight: 700;">
                        <i class="fas fa-lightbulb"></i> Tips
                    </h6>
                    <ul style="margin: 0; color: #718096; font-size: 0.9rem;">
                        <li>Use clear and descriptive category names to help users find relevant hackathons</li>
                        <li>Write detailed descriptions that explain the category's focus and target audience</li>
                        <li>Browse <a href="https://fontawesome.com/icons" target="_blank" style="color: #667eea;">Font Awesome icons</a> for appropriate category icons</li>
                        <li>Categories help organize hackathons and improve discoverability</li>
                    </ul>
                </div>
            </div>
        </jsp:body>
    </jsp:include>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Character count for name
            document.getElementById('categoryName').addEventListener('input', function() {
                document.getElementById('nameCount').textContent = this.value.length + '/50';
            });

            // Character count for description
            document.getElementById('categoryDescription').addEventListener('input', function() {
                document.getElementById('descCount').textContent = this.value.length + '/500';
            });

            // Icon preview
            document.getElementById('categoryIcon').addEventListener('input', function() {
                const iconPreview = document.getElementById('iconPreview');
                const iconClass = this.value.trim();
                if (iconClass) {
                    iconPreview.innerHTML = '<i class="' + iconClass + '"></i>';
                } else {
                    iconPreview.innerHTML = '';
                }
            });

            // Form validation
            const form = document.querySelector('.needs-validation');
            form.addEventListener('submit', event => {
                if (!form.checkValidity()) {
                    event.preventDefault();
                    event.stopPropagation();
                }
                form.classList.add('was-validated');
            }, false);

            // Initialize character counts
            document.getElementById('nameCount').textContent = document.getElementById('categoryName').value.length + '/50';
            document.getElementById('descCount').textContent = document.getElementById('categoryDescription').value.length + '/500';
        });
    </script>
</body>
</html>
