# CodeVerse - All JSP View Files (Complete)

## File Locations: src/main/webapp/WEB-INF/views/

---

### CodeVerseRegister.jsp
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - CodeVerse</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 40px 0;
        }
        
        .codeverse-register-card {
            background: white;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
            max-width: 600px;
            margin: 0 auto;
        }
        
        .codeverse-btn-primary {
            background: linear-gradient(135deg, #667eea, #764ba2);
            border: none;
            color: white;
            padding: 12px;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="codeverse-register-card">
            <div class="text-center mb-4">
                <h1><i class="fas fa-code"></i> CodeVerse</h1>
                <h3>Create Account</h3>
            </div>
            
            <c:if test="${not empty codeVerseErrorMessage}">
                <div class="alert alert-danger">${codeVerseErrorMessage}</div>
            </c:if>
            
            <form action="${pageContext.request.contextPath}/auth/register" method="post">
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Username</label>
                        <input type="text" class="form-control" name="username" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Full Name</label>
                        <input type="text" class="form-control" name="fullName" required>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Email</label>
                        <input type="email" class="form-control" name="email" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Phone Number</label>
                        <input type="tel" class="form-control" name="phoneNumber" required>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Password</label>
                        <input type="password" class="form-control" name="password" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">User Type</label>
                        <select class="form-select" name="userType" required>
                            <option value="PARTICIPANT">Participant</option>
                            <option value="ORGANIZER">Organizer</option>
                        </select>
                    </div>
                </div>
                
                <button type="submit" class="btn codeverse-btn-primary w-100">
                    <i class="fas fa-user-plus"></i> Register
                </button>
            </form>
            
            <hr class="my-4">
            <div class="text-center">
                <a href="${pageContext.request.contextPath}/auth/login">
                    Already have an account? <strong>Login</strong>
                </a>
            </div>
        </div>
    </div>
</body>
</html>
```

---

### CodeVerseDashboard.jsp (Participant)
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<div class="container-fluid">
    <div class="row mb-4">
        <div class="col-md-4">
            <div class="card bg-primary text-white shadow">
                <div class="card-body">
                    <h5><i class="fas fa-ticket-alt"></i> Total Bookings</h5>
                    <h2>${codeVerseTotalBookings}</h2>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card bg-success text-white shadow">
                <div class="card-body">
                    <h5><i class="fas fa-calendar-check"></i> Upcoming Events</h5>
                    <h2>${codeVerseUpcomingHackathons.size()}</h2>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card bg-info text-white shadow">
                <div class="card-body">
                    <h5><i class="fas fa-trophy"></i> Achievements</h5>
                    <h2>0</h2>
                </div>
            </div>
        </div>
    </div>
    
    <div class="row">
        <div class="col-md-6">
            <div class="card shadow">
                <div class="card-header bg-primary text-white">
                    <h5><i class="fas fa-calendar"></i> My Recent Bookings</h5>
                </div>
                <div class="card-body">
                    <c:forEach var="booking" items="${codeVerseMyBookings}" end="4">
                        <div class="border-bottom py-2">
                            <strong>${booking.hackathon.hackathonTitle}</strong>
                            <br>
                            <small class="text-muted">${booking.hackathon.eventDate} - ${booking.registrationStatus}</small>
                        </div>
                    </c:forEach>
                    <a href="${pageContext.request.contextPath}/participant/bookings" class="btn btn-sm btn-primary mt-3">
                        View All Bookings
                    </a>
                </div>
            </div>
        </div>
        
        <div class="col-md-6">
            <div class="card shadow">
                <div class="card-header bg-success text-white">
                    <h5><i class="fas fa-compass"></i> Recommended Hackathons</h5>
                </div>
                <div class="card-body">
                    <c:forEach var="hackathon" items="${codeVerseUpcomingHackathons}" end="4">
                        <div class="border-bottom py-2">
                            <strong>${hackathon.hackathonTitle}</strong>
                            <br>
                            <small class="text-muted">${hackathon.eventDate} - ${hackathon.availableSlots} slots</small>
                        </div>
                    </c:forEach>
                    <a href="${pageContext.request.contextPath}/participant/explore" class="btn btn-sm btn-success mt-3">
                        Explore More
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
```

---

### CodeVerseAdminDashboard.jsp
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<div class="container-fluid">
    <div class="row mb-4">
        <div class="col-md-3">
            <div class="card bg-primary text-white shadow">
                <div class="card-body text-center">
                    <h5><i class="fas fa-tags fa-3x"></i></h5>
                    <h2>${codeVerseTotalCategories}</h2>
                    <p>Categories</p>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card bg-success text-white shadow">
                <div class="card-body text-center">
                    <h5><i class="fas fa-users fa-3x"></i></h5>
                    <h2>${codeVerseTotalUsers}</h2>
                    <p>Total Users</p>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card bg-info text-white shadow">
                <div class="card-body text-center">
                    <h5><i class="fas fa-calendar fa-3x"></i></h5>
                    <h2>${codeVerseTotalHackathons}</h2>
                    <p>Hackathons</p>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card bg-warning text-white shadow">
                <div class="card-body text-center">
                    <h5><i class="fas fa-chart-line fa-3x"></i></h5>
                    <h2>98%</h2>
                    <p>System Health</p>
                </div>
            </div>
        </div>
    </div>
    
    <div class="row">
        <div class="col-md-12">
            <div class="card shadow">
                <div class="card-header bg-dark text-white">
                    <h5><i class="fas fa-tools"></i> Quick Actions</h5>
                </div>
                <div class="card-body">
                    <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-primary me-2">
                        <i class="fas fa-tags"></i> Manage Categories
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-success me-2">
                        <i class="fas fa-users"></i> Manage Users
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>
```

---

### CodeVerseAdminCategories.jsp
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<div class="container-fluid">
    <div class="card shadow mb-4">
        <div class="card-header bg-primary text-white">
            <h5><i class="fas fa-plus-circle"></i> Add New Category</h5>
        </div>
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/admin/categories/create" method="post">
                <div class="row">
                    <div class="col-md-4">
                        <input type="text" class="form-control" name="categoryName" placeholder="Category Name" required>
                    </div>
                    <div class="col-md-4">
                        <input type="text" class="form-control" name="categoryDescription" placeholder="Description">
                    </div>
                    <div class="col-md-2">
                        <input type="text" class="form-control" name="categoryIcon" placeholder="fa-icon">
                    </div>
                    <div class="col-md-2">
                        <button type="submit" class="btn btn-primary w-100">
                            <i class="fas fa-save"></i> Create
                        </button>
                    </div>
                </div>
            </form>
        </div>
    </div>
    
    <div class="card shadow">
        <div class="card-header bg-dark text-white">
            <h5><i class="fas fa-list"></i> All Categories</h5>
        </div>
        <div class="card-body">
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Description</th>
                        <th>Icon</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="category" items="${codeVerseCategories}">
                        <tr>
                            <td>${category.categoryId}</td>
                            <td>${category.categoryName}</td>
                            <td>${category.categoryDescription}</td>
                            <td><i class="fas ${category.categoryIcon}"></i> ${category.categoryIcon}</td>
                            <td>
                                <span class="badge ${category.isActive ? 'bg-success' : 'bg-danger'}">
                                    ${category.isActive ? 'Active' : 'Inactive'}
                                </span>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/categories/toggle/${category.categoryId}" 
                                   class="btn btn-sm btn-warning">
                                    <i class="fas fa-toggle-on"></i>
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/categories/delete/${category.categoryId}" 
                                   class="btn btn-sm btn-danger"
                                   onclick="return confirm('Are you sure?')">
                                    <i class="fas fa-trash"></i>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
```

---

### CodeVerseAdminUsers.jsp
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<div class="container-fluid">
    <div class="card shadow">
        <div class="card-header bg-dark text-white">
            <h5><i class="fas fa-users"></i> All Users</h5>
        </div>
        <div class="card-body">
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Username</th>
                        <th>Full Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Type</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="user" items="${codeVerseUsers}">
                        <tr>
                            <td>${user.userId}</td>
                            <td>${user.username}</td>
                            <td>${user.fullName}</td>
                            <td>${user.email}</td>
                            <td>${user.phoneNumber}</td>
                            <td>
                                <span class="badge bg-info">${user.userType.userTypeName}</span>
                            </td>
                            <td>
                                <span class="badge ${user.isActive ? 'bg-success' : 'bg-danger'}">
                                    ${user.isActive ? 'Active' : 'Inactive'}
                                </span>
                            </td>
                            <td>
                                <a href="${pageContext.request.contextPath}/admin/users/toggle/${user.userId}" 
                                   class="btn btn-sm btn-warning">
                                    <i class="fas fa-toggle-on"></i> Toggle
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
```

---

### CodeVerseOrganizerDashboard.jsp
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<div class="container-fluid">
    <div class="row mb-4">
        <div class="col-md-4">
            <div class="card bg-success text-white shadow">
                <div class="card-body text-center">
                    <h5><i class="fas fa-calendar fa-3x"></i></h5>
                    <h2>${codeVerseTotalHackathons}</h2>
                    <p>My Hackathons</p>
                </div>
            </div>
        </div>
    </div>
    
    <div class="card shadow">
        <div class="card-header bg-primary text-white">
            <h5><i class="fas fa-list"></i> Recent Hackathons</h5>
        </div>
        <div class="card-body">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>Title</th>
                        <th>Date</th>
                        <th>Slots</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="hackathon" items="${codeVerseMyHackathons}" end="9">
                        <tr>
                            <td>${hackathon.hackathonTitle}</td>
                            <td>${hackathon.eventDate}</td>
                            <td>${hackathon.availableSlots} / ${hackathon.maxSlots}</td>
                            <td><span class="badge bg-success">${hackathon.status}</span></td>
                            <td>
                                <a href="${pageContext.request.contextPath}/organizer/registrations/${hackathon.hackathonId}" 
                                   class="btn btn-sm btn-info">
                                    <i class="fas fa-users"></i> Registrations
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
```

---

### CodeVerseOrganizerHackathons.jsp
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<div class="container-fluid">
    <div class="mb-3">
        <a href="${pageContext.request.contextPath}/organizer/hackathons/create" class="btn btn-primary">
            <i class="fas fa-plus-circle"></i> Create New Hackathon
        </a>
    </div>
    
    <div class="card shadow">
        <div class="card-header bg-dark text-white">
            <h5><i class="fas fa-calendar"></i> My Hackathons</h5>
        </div>
        <div class="card-body">
            <table class="table table-striped table-hover">
                <thead>
                    <tr>
                        <th>Title</th>
                        <th>Category</th>
                        <th>Date</th>
                        <th>Venue</th>
                        <th>Slots</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="hackathon" items="${codeVerseHackathons}">
                        <tr>
                            <td>${hackathon.hackathonTitle}</td>
                            <td>${hackathon.category.categoryName}</td>
                            <td>${hackathon.eventDate}</td>
                            <td>${hackathon.venueType}</td>
                            <td>${hackathon.availableSlots} / ${hackathon.maxSlots}</td>
                            <td><span class="badge bg-success">${hackathon.status}</span></td>
                            <td>
                                <a href="${pageContext.request.contextPath}/organizer/registrations/${hackathon.hackathonId}" 
                                   class="btn btn-sm btn-info">
                                    <i class="fas fa-users"></i>
                                </a>
                                <a href="${pageContext.request.contextPath}/organizer/hackathons/delete/${hackathon.hackathonId}" 
                                   class="btn btn-sm btn-danger"
                                   onclick="return confirm('Are you sure?')">
                                    <i class="fas fa-trash"></i>
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
```

---

### CodeVerseOrganizerCreate.jsp
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<div class="container-fluid">
    <div class="card shadow">
        <div class="card-header bg-primary text-white">
            <h5><i class="fas fa-plus-circle"></i> Create New Hackathon</h5>
        </div>
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/organizer/hackathons/create" method="post">
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Hackathon Title</label>
                        <input type="text" class="form-control" name="hackathonTitle" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Category</label>
                        <select class="form-select" name="categoryId" required>
                            <c:forEach var="category" items="${codeVerseCategories}">
                                <option value="${category.categoryId}">${category.categoryName}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                
                <div class="mb-3">
                    <label class="form-label">Description</label>
                    <textarea class="form-control" name="hackathonDescription" rows="4" required></textarea>
                </div>
                
                <div class="row">
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Event Date</label>
                        <input type="date" class="form-control" name="eventDate" required>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Event Time</label>
                        <input type="time" class="form-control" name="eventTime" required>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Duration (Hours)</label>
                        <input type="number" class="form-control" name="durationHours" required>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-md-8 mb-3">
                        <label class="form-label">Venue Location</label>
                        <input type="text" class="form-control" name="venueLocation" required>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Venue Type</label>
                        <select class="form-select" name="venueType" required>
                            <option value="ONLINE">Online</option>
                            <option value="OFFLINE">Offline</option>
                            <option value="HYBRID">Hybrid</option>
                        </select>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Max Slots</label>
                        <input type="number" class="form-control" name="maxSlots" required>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label class="form-label">Skills Required</label>
                        <input type="text" class="form-control" name="skillsRequired" placeholder="Java, Python, React">
                    </div>
                </div>
                
                <button type="submit" class="btn btn-primary btn-lg">
                    <i class="fas fa-save"></i> Create Hackathon
                </button>
            </form>
        </div>
    </div>
</div>
```

---

### CodeVerseParticipantBookings.jsp
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<div class="container-fluid">
    <div class="card shadow">
        <div class="card-header bg-primary text-white">
            <h5><i class="fas fa-ticket-alt"></i> My Bookings</h5>
        </div>
        <div class="card-body">
            <c:if test="${empty codeVerseRegistrations}">
                <div class="alert alert-info text-center">
                    <i class="fas fa-info-circle"></i> No bookings yet. Explore hackathons to get started!
                </div>
            </c:if>
            
            <div class="row">
                <c:forEach var="registration" items="${codeVerseRegistrations}">
                    <div class="col-md-6 mb-4">
                        <div class="card border-primary">
                            <div class="card-header bg-primary text-white">
                                <h6>${registration.hackathon.hackathonTitle}</h6>
                            </div>
                            <div class="card-body">
                                <p><strong>Date:</strong> ${registration.hackathon.eventDate}</p>
                                <p><strong>Time:</strong> ${registration.hackathon.eventTime}</p>
                                <p><strong>Venue:</strong> ${registration.hackathon.venueLocation}</p>
                                <p><strong>Team:</strong> ${registration.teamName != null ? registration.teamName : 'Individual'}</p>
                                <p><strong>Registration Code:</strong> 
                                    <span class="badge bg-success">${registration.registrationCode}</span>
                                </p>
                                <p><strong>Status:</strong> 
                                    <span class="badge bg-info">${registration.registrationStatus}</span>
                                </p>
                            </div>
                            <div class="card-footer">
                                <c:if test="${registration.registrationStatus == 'CONFIRMED'}">
                                    <a href="${pageContext.request.contextPath}/participant/bookings/cancel/${registration.registrationId}" 
                                       class="btn btn-danger btn-sm"
                                       onclick="return confirm('Are you sure you want to cancel?')">
                                        <i class="fas fa-times"></i> Cancel Booking
                                    </a>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>
```

---

### CodeVerseHackathonDetails.jsp
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<div class="container">
    <div class="card shadow-lg">
        <div class="card-header text-white" style="background: linear-gradient(135deg, #667eea, #764ba2);">
            <h3>${codeVerseHackathon.hackathonTitle}</h3>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-8">
                    <h5>Description</h5>
                    <p>${codeVerseHackathon.hackathonDescription}</p>
                    
                    <h5 class="mt-4">Event Details</h5>
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item"><strong>Category:</strong> ${codeVerseHackathon.category.categoryName}</li>
                        <li class="list-group-item"><strong>Date:</strong> ${codeVerseHackathon.eventDate}</li>
                        <li class="list-group-item"><strong>Time:</strong> ${codeVerseHackathon.eventTime}</li>
                        <li class="list-group-item"><strong>Duration:</strong> ${codeVerseHackathon.durationHours} hours</li>
                        <li class="list-group-item"><strong>Venue:</strong> ${codeVerseHackathon.venueLocation}</li>
                        <li class="list-group-item"><strong>Type:</strong> ${codeVerseHackathon.venueType}</li>
                        <li class="list-group-item"><strong>Skills:</strong> ${codeVerseHackathon.skillsRequired}</li>
                        <li class="list-group-item"><strong>Prize Pool:</strong> $${codeVerseHackathon.prizePool}</li>
                    </ul>
                </div>
                
                <div class="col-md-4">
                    <div class="card bg-light">
                        <div class="card-body">
                            <h5>Available Slots</h5>
                            <h2 class="text-center text-primary">${codeVerseHackathon.availableSlots} / ${codeVerseHackathon.maxSlots}</h2>
                            <div class="progress mb-3">
                                <div class="progress-bar bg-success" style="width: ${(codeVerseHackathon.availableSlots * 100) / codeVerseHackathon.maxSlots}%"></div>
                            </div>
                            
                            <c:choose>
                                <c:when test="${codeVerseAlreadyBooked}">
                                    <button class="btn btn-secondary w-100" disabled>
                                        <i class="fas fa-check"></i> Already Booked
                                    </button>
                                </c:when>
                                <c:when test="${codeVerseHackathon.availableSlots <= 0}">
                                    <button class="btn btn-danger w-100" disabled>
                                        <i class="fas fa-times"></i> Fully Booked
                                    </button>
                                </c:when>
                                <c:otherwise>
                                    <button class="btn btn-primary w-100" data-bs-toggle="modal" data-bs-target="#bookingModal">
                                        <i class="fas fa-ticket-alt"></i> Book Slot
                                    </button>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Booking Modal -->
<div class="modal fade" id="bookingModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title">Book Slot</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <form action="${pageContext.request.contextPath}/participant/book" method="post">
                <div class="modal-body">
                    <input type="hidden" name="hackathonId" value="${codeVerseHackathon.hackathonId}">
                    
                    <div class="mb-3">
                        <label class="form-label">Team Name (Optional)</label>
                        <input type="text" class="form-control" name="teamName">
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label">Team Size</label>
                        <input type="number" class="form-control" name="teamSize" value="1" min="1" max="10">
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label">Special Requirements (Optional)</label>
                        <textarea class="form-control" name="specialRequirements" rows="3"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">Confirm Booking</button>
                </div>
            </form>
        </div>
    </div>
</div>
```

---

## Installation Instructions

1. Create all directories as shown in setup-structure.bat
2. Copy all Java files to their respective packages
3. Create all JSP files in src/main/webapp/WEB-INF/views/
4. Run the MySQL schema script
5. Update application.properties with your MySQL credentials
6. Build: `mvn clean install`
7. Run: `mvn spring-boot:run`
8. Access: http://localhost:8080/codeverse

© 2026 CodeVerse Hackathon Marketplace
