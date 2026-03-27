<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="page" value="hackathons"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${empty hackathon ? 'Create Hackathon' : 'Edit Hackathon'} - CodeVerse</title>
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
            font-size: 1.1rem;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
            margin-bottom: 1.5rem;
        }

        .form-row.full {
            grid-template-columns: 1fr;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-label {
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 0.75rem;
            font-size: 0.95rem;
        }

        .required::after {
            content: ' *';
            color: #ef4444;
        }

        .form-control, .form-select, textarea {
            border-radius: 8px;
            border: 2px solid #e5e7eb;
            padding: 0.75rem 1rem;
            font-size: 0.95rem;
            transition: all 0.3s ease;
            font-family: inherit;
        }

        .form-control:focus, .form-select:focus, textarea:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.15);
            outline: none;
        }

        .form-control::placeholder, textarea::placeholder {
            color: #a0aec0;
        }

        textarea {
            resize: vertical;
            min-height: 100px;
        }

        .char-count {
            font-size: 0.85rem;
            color: #718096;
            text-align: right;
            margin-top: 0.25rem;
        }

        .invalid-feedback {
            display: block;
            color: #ef4444;
            font-size: 0.85rem;
            margin-top: 0.25rem;
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
            cursor: pointer;
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
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
        }

        .btn-cancel:hover {
            background: #d1d5db;
            color: #2d3748;
            text-decoration: none;
        }

        .help-text {
            font-size: 0.85rem;
            color: #718096;
            margin-top: 0.5rem;
        }

        @media (max-width: 768px) {
            .form-row {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <%@ include file="codeverse-layout.jsp" %>
    <jsp:include page="codeverse-layout.jsp">
        <jsp:param name="page" value="hackathons"/>
        <jsp:body>
            <!-- Page Header -->
            <div class="mb-4">
                <h2 class="section-title">
                    <i class="fas fa-${empty hackathon ? 'plus' : 'edit'}"></i>
                    ${empty hackathon ? 'Create New Hackathon' : 'Edit Hackathon'}
                </h2>
            </div>

            <!-- Main Form -->
            <form method="POST" 
                  action="${empty hackathon ? pageContext.request.contextPath.concat('/organizer/hackathons/create') : pageContext.request.contextPath.concat('/organizer/hackathons/update/')}"
                  class="needs-validation" 
                  novalidate>

                <!-- Basic Information Section -->
                <div class="form-section">
                    <h5><i class="fas fa-info-circle"></i> Basic Information</h5>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="title" class="form-label required">Hackathon Title</label>
                            <input 
                                type="text" 
                                class="form-control" 
                                id="title" 
                                name="title" 
                                placeholder="e.g., AI Innovation Hackathon 2024" 
                                value="${hackathon.title}"
                                required
                                minlength="5"
                                maxlength="100">
                            <div class="invalid-feedback">Title must be 5-100 characters.</div>
                            <div class="char-count" id="titleCount">0/100</div>
                        </div>

                        <div class="form-group">
                            <label for="category" class="form-label required">Category</label>
                            <select class="form-select" id="category" name="categoryId" required>
                                <option value="" disabled selected>Select a category</option>
                                <c:forEach var="category" items="${categories}">
                                    <option value="${category.id}" <c:if test="${hackathon.categoryId == category.id}">selected</c:if>>
                                        ${category.name}
                                    </option>
                                </c:forEach>
                            </select>
                            <div class="invalid-feedback">Please select a category.</div>
                        </div>
                    </div>

                    <div class="form-group form-row full">
                        <label for="description" class="form-label required">Description</label>
                        <textarea 
                            class="form-control" 
                            id="description" 
                            name="description" 
                            placeholder="Describe your hackathon, what participants can expect, themes, etc." 
                            required
                            minlength="20"
                            maxlength="2000">${hackathon.description}</textarea>
                        <div class="invalid-feedback">Description must be 20-2000 characters.</div>
                        <div class="char-count" id="descCount">0/2000</div>
                    </div>
                </div>

                <!-- Location & Dates Section -->
                <div class="form-section">
                    <h5><i class="fas fa-map-marker-alt"></i> Location & Dates</h5>

                    <div class="form-group form-row full">
                        <label for="location" class="form-label required">Location</label>
                        <input 
                            type="text" 
                            class="form-control" 
                            id="location" 
                            name="location" 
                            placeholder="e.g., New York, USA" 
                            value="${hackathon.location}"
                            required>
                        <div class="invalid-feedback">Location is required.</div>
                    </div>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="startDate" class="form-label required">Start Date & Time</label>
                            <input 
                                type="datetime-local" 
                                class="form-control" 
                                id="startDate" 
                                name="startDate" 
                                value="${hackathon.startDate}"
                                required>
                            <div class="invalid-feedback">Start date is required.</div>
                        </div>

                        <div class="form-group">
                            <label for="endDate" class="form-label required">End Date & Time</label>
                            <input 
                                type="datetime-local" 
                                class="form-control" 
                                id="endDate" 
                                name="endDate" 
                                value="${hackathon.endDate}"
                                required>
                            <div class="invalid-feedback">End date is required.</div>
                        </div>
                    </div>
                </div>

                <!-- Participation Details Section -->
                <div class="form-section">
                    <h5><i class="fas fa-users"></i> Participation Details</h5>

                    <div class="form-row">
                        <div class="form-group">
                            <label for="maxParticipants" class="form-label required">Total Slots</label>
                            <input 
                                type="number" 
                                class="form-control" 
                                id="maxParticipants" 
                                name="maxParticipants" 
                                placeholder="e.g., 100" 
                                value="${hackathon.maxParticipants}"
                                required
                                min="1"
                                max="10000">
                            <div class="invalid-feedback">Enter a valid number of slots.</div>
                        </div>

                        <div class="form-group">
                            <label for="difficulty" class="form-label required">Difficulty Level</label>
                            <select class="form-select" id="difficulty" name="difficultyLevel" required>
                                <option value="" disabled selected>Select difficulty</option>
                                <option value="BEGINNER" <c:if test="${hackathon.difficultyLevel == 'BEGINNER'}">selected</c:if>>Beginner</option>
                                <option value="INTERMEDIATE" <c:if test="${hackathon.difficultyLevel == 'INTERMEDIATE'}">selected</c:if>>Intermediate</option>
                                <option value="ADVANCED" <c:if test="${hackathon.difficultyLevel == 'ADVANCED'}">selected</c:if>>Advanced</option>
                            </select>
                            <div class="invalid-feedback">Select a difficulty level.</div>
                        </div>
                    </div>

                    <div class="form-group form-row full">
                        <label for="prizes" class="form-label">Prizes & Rewards</label>
                        <textarea 
                            class="form-control" 
                            id="prizes" 
                            name="prizes" 
                            placeholder="e.g., 1st Place: $5000, 2nd Place: $3000, 3rd Place: $1000"
                            maxlength="1000">${hackathon.prizes}</textarea>
                        <div class="char-count" id="prizeCount">0/1000</div>
                    </div>
                </div>

                <!-- Requirements Section -->
                <div class="form-section">
                    <h5><i class="fas fa-list-check"></i> Requirements</h5>

                    <div class="form-group form-row full">
                        <label for="requirements" class="form-label">Technical Requirements</label>
                        <textarea 
                            class="form-control" 
                            id="requirements" 
                            name="requirements" 
                            placeholder="List any technical requirements or tools participants should have installed" 
                            maxlength="1000">${hackathon.requirements}</textarea>
                        <div class="char-count" id="reqCount">0/1000</div>
                    </div>
                </div>

                <!-- Form Actions -->
                <div style="display: flex; gap: 1rem; margin-bottom: 2rem;">
                    <button type="submit" class="btn-submit">
                        <i class="fas fa-save"></i> 
                        ${empty hackathon ? 'Create Hackathon' : 'Update Hackathon'}
                    </button>
                    <a href="${pageContext.request.contextPath}/organizer/hackathons" class="btn-cancel">
                        <i class="fas fa-times"></i> Cancel
                    </a>
                </div>
            </form>
        </jsp:body>
    </jsp:include>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Character counters
            document.getElementById('title').addEventListener('input', function() {
                document.getElementById('titleCount').textContent = this.value.length + '/100';
            });

            document.getElementById('description').addEventListener('input', function() {
                document.getElementById('descCount').textContent = this.value.length + '/2000';
            });

            document.getElementById('prizes').addEventListener('input', function() {
                document.getElementById('prizeCount').textContent = this.value.length + '/1000';
            });

            document.getElementById('requirements').addEventListener('input', function() {
                document.getElementById('reqCount').textContent = this.value.length + '/1000';
            });

            // Form validation
            const form = document.querySelector('.needs-validation');
            form.addEventListener('submit', event => {
                const startDate = new Date(document.getElementById('startDate').value);
                const endDate = new Date(document.getElementById('endDate').value);
                
                if (endDate <= startDate) {
                    event.preventDefault();
                    event.stopPropagation();
                    alert('End date must be after start date');
                }
                
                if (!form.checkValidity()) {
                    event.preventDefault();
                    event.stopPropagation();
                }
                form.classList.add('was-validated');
            }, false);

            // Initialize counters
            document.getElementById('titleCount').textContent = document.getElementById('title').value.length + '/100';
            document.getElementById('descCount').textContent = document.getElementById('description').value.length + '/2000';
            document.getElementById('prizeCount').textContent = document.getElementById('prizes').value.length + '/1000';
            document.getElementById('reqCount').textContent = document.getElementById('requirements').value.length + '/1000';
        });
    </script>
</body>
</html>
