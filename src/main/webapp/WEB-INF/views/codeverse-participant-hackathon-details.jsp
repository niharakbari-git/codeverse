<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="page" value="explore"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${hackathon.title} - CodeVerse</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .detail-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 3rem 0;
            margin-bottom: 2rem;
            border-radius: 12px;
            position: relative;
            overflow: hidden;
        }

        .detail-header::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 1px, transparent 1px);
            background-size: 50px 50px;
        }

        .header-content {
            position: relative;
            z-index: 1;
        }

        .detail-title {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 1rem;
            line-height: 1.2;
        }

        .detail-meta {
            display: flex;
            gap: 2rem;
            margin-bottom: 1.5rem;
            font-size: 1rem;
            flex-wrap: wrap;
        }

        .meta-item {
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .category-tag {
            display: inline-block;
            background: rgba(255, 255, 255, 0.25);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.9rem;
            backdrop-filter: blur(10px);
        }

        .content-wrapper {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 2rem;
            margin-bottom: 2rem;
        }

        .detail-section {
            background: white;
            border-radius: 12px;
            padding: 2rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
        }

        .section-title {
            font-size: 1.3rem;
            font-weight: 700;
            color: #2d3748;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .section-title i {
            color: #667eea;
        }

        .section-content {
            color: #4b5563;
            line-height: 1.8;
            font-size: 0.95rem;
        }

        .info-card {
            background: white;
            border-radius: 12px;
            padding: 1.5rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
            margin-bottom: 1.5rem;
        }

        .info-label {
            font-weight: 600;
            color: #718096;
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 0.5rem;
        }

        .info-value {
            font-size: 1.2rem;
            font-weight: 700;
            color: #2d3748;
        }

        .slots-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 12px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            text-align: center;
        }

        .slots-number {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .slots-text {
            font-size: 0.95rem;
            opacity: 0.9;
        }

        .slots-bar {
            width: 100%;
            height: 8px;
            background: rgba(255, 255, 255, 0.3);
            border-radius: 4px;
            overflow: hidden;
            margin-top: 1rem;
        }

        .slots-filled {
            height: 100%;
            background: rgba(255, 255, 255, 0.9);
        }

        .btn-book {
            width: 100%;
            padding: 1rem;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-bottom: 1rem;
        }

        .btn-book:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(102, 126, 234, 0.3);
            color: white;
        }

        .btn-book:disabled {
            background: #d1d5db;
            cursor: not-allowed;
            transform: none;
        }

        .btn-back {
            width: 100%;
            padding: 1rem;
            background: #e5e7eb;
            color: #4b5563;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            text-decoration: none;
            display: block;
            text-align: center;
            transition: all 0.3s ease;
        }

        .btn-back:hover {
            background: #d1d5db;
            text-decoration: none;
            color: #2d3748;
        }

        .booking-form {
            background: white;
            border-radius: 12px;
            padding: 2rem;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            font-weight: 600;
            color: #2d3748;
            margin-bottom: 0.75rem;
            display: block;
        }

        .form-control {
            width: 100%;
            padding: 0.75rem 1rem;
            border-radius: 8px;
            border: 2px solid #e5e7eb;
            font-size: 0.95rem;
            transition: all 0.3s ease;
        }

        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.15);
            outline: none;
        }

        .highlight {
            background: linear-gradient(135deg, rgba(102, 126, 234, 0.1) 0%, rgba(118, 75, 162, 0.1) 100%);
            padding: 1rem;
            border-radius: 8px;
            border-left: 4px solid #667eea;
            margin-bottom: 1rem;
        }

        @media (max-width: 768px) {
            .content-wrapper {
                grid-template-columns: 1fr;
            }

            .detail-title {
                font-size: 1.8rem;
            }

            .detail-meta {
                gap: 1rem;
            }
        }
    </style>
</head>
<body>
    <%@ include file="codeverse-layout.jsp" %>
    <jsp:include page="codeverse-layout.jsp">
        <jsp:param name="page" value="explore"/>
        <jsp:body>
            <!-- Back Button -->
            <div style="margin-bottom: 2rem;">
                <a href="${pageContext.request.contextPath}/participant/explore" style="color: #667eea; text-decoration: none; font-weight: 600; display: flex; align-items: center; gap: 0.5rem;">
                    <i class="fas fa-arrow-left"></i> Back to Explore
                </a>
            </div>

            <!-- Detail Header -->
            <div class="detail-header">
                <div class="header-content container-fluid">
                    <div style="margin-bottom: 1rem;">
                        <span class="category-tag">
                            <i class="fas fa-tag"></i> ${hackathon.category}
                        </span>
                    </div>
                    <h1 class="detail-title">${hackathon.title}</h1>
                    <div class="detail-meta">
                        <div class="meta-item">
                            <i class="fas fa-calendar"></i>
                            <span>${hackathon.startDate} - ${hackathon.endDate}</span>
                        </div>
                        <div class="meta-item">
                            <i class="fas fa-map-marker-alt"></i>
                            <span>${hackathon.location}</span>
                        </div>
                        <div class="meta-item">
                            <i class="fas fa-signal"></i>
                            <span>${hackathon.difficultyLevel} Level</span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Main Content -->
            <div class="content-wrapper">
                <!-- Left Column -->
                <div>
                    <!-- Description Section -->
                    <div class="detail-section">
                        <h2 class="section-title">
                            <i class="fas fa-align-left"></i> About This Hackathon
                        </h2>
                        <div class="section-content">
                            ${hackathon.description}
                        </div>
                    </div>

                    <!-- Prizes Section -->
                    <c:if test="${not empty hackathon.prizes}">
                        <div class="detail-section">
                            <h2 class="section-title">
                                <i class="fas fa-trophy"></i> Prizes & Rewards
                            </h2>
                            <div class="section-content">
                                ${hackathon.prizes}
                            </div>
                        </div>
                    </c:if>

                    <!-- Requirements Section -->
                    <c:if test="${not empty hackathon.requirements}">
                        <div class="detail-section">
                            <h2 class="section-title">
                                <i class="fas fa-list-check"></i> Requirements
                            </h2>
                            <div class="section-content">
                                ${hackathon.requirements}
                            </div>
                        </div>
                    </c:if>
                </div>

                <!-- Right Column (Sidebar) -->
                <div>
                    <!-- Slots Card -->
                    <div class="slots-card">
                        <div class="slots-number">${hackathon.availableSlots}</div>
                        <div class="slots-text">Slots Available</div>
                        <div class="slots-bar">
                            <div class="slots-filled" style="width: ${(hackathon.totalSlots - hackathon.availableSlots) / hackathon.totalSlots * 100}%"></div>
                        </div>
                    </div>

                    <!-- Quick Info -->
                    <div class="info-card">
                        <div class="info-label">Difficulty Level</div>
                        <div class="info-value">${hackathon.difficultyLevel}</div>
                    </div>

                    <div class="info-card">
                        <div class="info-label">Total Participants</div>
                        <div class="info-value">${hackathon.totalParticipants}</div>
                    </div>

                    <div class="info-card">
                        <div class="info-label">Entry Fee</div>
                        <div class="info-value">
                            <c:if test="${hackathon.isFree}">FREE</c:if>
                            <c:if test="${!hackathon.isFree}">\$${hackathon.entryFee}</c:if>
                        </div>
                    </div>

                    <!-- Booking Form -->
                    <c:if test="${hackathon.availableSlots > 0}">
                        <div class="booking-form">
                            <h5 style="margin-bottom: 1.5rem; font-weight: 700; color: #2d3748;">
                                <i class="fas fa-ticket-alt"></i> Book Your Slot
                            </h5>

                            <form method="POST" action="${pageContext.request.contextPath}/participant/hackathons/${hackathon.id}/book" class="needs-validation" novalidate>
                                <div class="highlight">
                                    <i class="fas fa-info-circle"></i> Fill out the form below to register for this hackathon
                                </div>

                                <div class="form-group">
                                    <label class="form-label">Your Name</label>
                                    <input type="text" class="form-control" value="${sessionScope.user.fullName}" disabled>
                                </div>

                                <div class="form-group">
                                    <label class="form-label">Email</label>
                                    <input type="email" class="form-control" value="${sessionScope.user.email}" disabled>
                                </div>

                                <div class="form-group">
                                    <label for="team" class="form-label">Team Name (Optional)</label>
                                    <input 
                                        type="text" 
                                        id="team" 
                                        name="teamName" 
                                        class="form-control" 
                                        placeholder="Enter your team name if participating as a team">
                                </div>

                                <div class="form-group">
                                    <label for="experience" class="form-label">Experience Level</label>
                                    <select id="experience" name="experienceLevel" class="form-control" required>
                                        <option value="" disabled selected>Select your experience level</option>
                                        <option value="BEGINNER">Beginner</option>
                                        <option value="INTERMEDIATE">Intermediate</option>
                                        <option value="ADVANCED">Advanced</option>
                                    </select>
                                </div>

                                <div class="form-group">
                                    <label class="form-label">
                                        <input type="checkbox" name="agreeTerms" required>
                                        I agree to the <a href="#" style="color: #667eea;">terms and conditions</a>
                                    </label>
                                </div>

                                <button type="submit" class="btn-book" <c:if test="${hackathon.availableSlots == 0}">disabled</c:if>>
                                    <i class="fas fa-check"></i> Confirm Booking
                                </button>
                            </form>
                        </div>
                    </c:if>

                    <c:if test="${hackathon.availableSlots == 0}">
                        <div class="detail-section" style="text-align: center; background: #fee2e2; color: #991b1b;">
                            <i class="fas fa-times-circle" style="font-size: 2rem; margin-bottom: 1rem; display: block;"></i>
                            <h5 style="color: inherit;">No Slots Available</h5>
                            <p style="color: inherit; margin-bottom: 0;">This hackathon is currently full. Check back later!</p>
                        </div>
                    </c:if>

                    <a href="${pageContext.request.contextPath}/participant/explore" class="btn-back" style="margin-top: 1rem;">
                        <i class="fas fa-arrow-left"></i> Back to Explore
                    </a>
                </div>
            </div>

            <!-- Similar Hackathons -->
            <c:if test="${not empty similarHackathons}">
                <div class="detail-section">
                    <h2 class="section-title">
                        <i class="fas fa-star"></i> Similar Hackathons
                    </h2>
                    <div class="row">
                        <c:forEach var="similar" items="${similarHackathons}">
                            <div class="col-md-6 col-lg-4 mb-3">
                                <div style="background: white; border-radius: 10px; padding: 1.5rem; border: 1px solid #e5e7eb; transition: all 0.3s; cursor: pointer;" onmouseover="this.style.boxShadow='0 8px 20px rgba(0,0,0,0.1)'" onmouseout="this.style.boxShadow='none'">
                                    <h6 style="font-weight: 700; margin-bottom: 0.5rem; color: #2d3748;">${similar.title}</h6>
                                    <p style="font-size: 0.85rem; color: #718096; margin-bottom: 1rem;">
                                        <i class="fas fa-calendar"></i> ${similar.startDate}
                                    </p>
                                    <a href="${pageContext.request.contextPath}/participant/hackathons/${similar.id}" style="color: #667eea; text-decoration: none; font-weight: 600;">
                                        View Details <i class="fas fa-arrow-right"></i>
                                    </a>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </c:if>
        </jsp:body>
    </jsp:include>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
