# 🚀 CodeVerse - Complete Setup Guide & All Source Files

## Table of Contents
1. [Project Structure Setup](#project-structure)
2. [All Java Entity Files](#java-entities)
3. [All Repository Interfaces](#repositories)
4. [All Service Classes](#services)
5. [Security Configuration](#security)
6. [All Controllers](#controllers)
7. [All JSP Views](#jsp-views)
8. [Step-by-Step Setup](#setup-instructions)

---

## Project Structure

Run the batch file `setup-structure.bat` that's already in your root directory OR manually create:

```
codeverse-3/
├── pom.xml (✓ ALREADY CREATED)
├── codeverse_schema.sql (✓ ALREADY CREATED)
├── README.md (✓ ALREADY CREATED)
└── src/
    ├── main/
    │   ├── java/com/codeverse/
    │   │   ├── CodeVerseApplication.java
    │   │   ├── entity/
    │   │   ├── repository/
    │   │   ├── service/
    │   │   ├── controller/
    │   │   └── config/
    │   ├── resources/
    │   │   └── application.properties
    │   └── webapp/WEB-INF/views/
    └── test/
```

---

## Step-by-Step Manual File Creation

### Step 1: Create Directory Structure

Open Command Prompt in `C:\Users\Akbari Nihar\Desktop\codeverse-3` and run:

```batch
mkdir src\main\java\com\codeverse\entity
mkdir src\main\java\com\codeverse\repository
mkdir src\main\java\com\codeverse\service
mkdir src\main\java\com\codeverse\controller
mkdir src\main\java\com\codeverse\config
mkdir src\main\resources
mkdir src\main\webapp\WEB-INF\views
```

### Step 2: Copy Application Entry Point

**Location:** `src/main/java/com/codeverse/CodeVerseApplication.java`

**File:** Copy from `CodeVerseApplication.java` (already in root directory)

### Step 3: Copy All Entity Files

**Location:** `src/main/java/com/codeverse/entity/`

Copy these files from root directory to entity folder:
- CodeVerseUserType.java
- CodeVerseUser.java
- CodeVerseCategory.java
- CodeVerseHackathon.java
- CodeVerseRegistration.java

### Step 4: Create Repository Interfaces

**Location:** `src/main/java/com/codeverse/repository/`

See `ALL_REPOSITORIES.md` for complete code. Create these files:
- CodeVerseUserRepository.java
- CodeVerseUserTypeRepository.java
- CodeVerseCategoryRepository.java
- CodeVerseHackathonRepository.java
- CodeVerseRegistrationRepository.java

### Step 5: Create Service Classes

**Location:** `src/main/java/com/codeverse/service/`

See `ALL_SERVICES.md` for complete code. Create these files:
- CodeVerseUserService.java
- CodeVerseCategoryService.java
- CodeVerseHackathonService.java
- CodeVerseRegistrationService.java
- CodeVerseMailService.java

### Step 6: Create Security Configuration

**Location:** `src/main/java/com/codeverse/config/CodeVerseSecurityConfig.java`

See `SECURITY_CONFIG.md` for complete code.

### Step 7: Create Controllers

**Location:** `src/main/java/com/codeverse/controller/`

See `ALL_CONTROLLERS_PART1.md` and `CodeVerseParticipantController.java` for complete code.

Create these files:
- CodeVerseAuthController.java
- CodeVerseAdminController.java
- CodeVerseOrganizerController.java
- CodeVerseParticipantController.java

### Step 8: Copy Application Properties

**Location:** `src/main/resources/application.properties`

Copy from `application.properties` in root directory.

### Step 9: Create JSP Views

**Location:** `src/main/webapp/WEB-INF/views/`

---

## ALL JSP VIEW FILES (Bootstrap 5)

### File: CodeVerseLayout.jsp
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${codeVersePageTitle} - CodeVerse</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --codeverse-primary: #667eea;
            --codeverse-secondary: #764ba2;
            --codeverse-success: #11998e;
            --codeverse-danger: #ff6b6b;
            --codeverse-dark: #2d3436;
            --codeverse-light: #f8f9fa;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
        }
        
        .codeverse-sidebar {
            min-height: 100vh;
            background: var(--codeverse-dark);
            color: white;
            position: fixed;
            left: 0;
            top: 0;
            width: 260px;
            padding: 20px 0;
            box-shadow: 4px 0 10px rgba(0,0,0,0.1);
            z-index: 1000;
        }
        
        .codeverse-logo {
            text-align: center;
            padding: 20px;
            background: linear-gradient(135deg, var(--codeverse-primary), var(--codeverse-secondary));
            margin: 0 15px 30px;
            border-radius: 10px;
        }
        
        .codeverse-logo h2 {
            margin: 0;
            font-size: 28px;
            font-weight: bold;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }
        
        .codeverse-nav-item {
            padding: 12px 25px;
            margin: 5px 15px;
            border-radius: 8px;
            transition: all 0.3s;
            color: #bbb;
            text-decoration: none;
            display: block;
        }
        
        .codeverse-nav-item:hover {
            background: rgba(102, 126, 234, 0.2);
            color: white;
            transform: translateX(5px);
        }
        
        .codeverse-nav-item.active {
            background: linear-gradient(135deg, var(--codeverse-primary), var(--codeverse-secondary));
            color: white;
        }
        
        .codeverse-nav-item i {
            margin-right: 10px;
            width: 20px;
            text-align: center;
        }
        
        .codeverse-content {
            margin-left: 260px;
            padding: 30px;
        }
        
        .codeverse-header {
            background: white;
            padding: 20px 30px;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .codeverse-user-badge {
            background: linear-gradient(135deg, var(--codeverse-primary), var(--codeverse-secondary));
            color: white;
            padding: 8px 20px;
            border-radius: 25px;
            font-size: 14px;
        }
        
        .codeverse-alert {
            border-radius: 10px;
            padding: 15px 20px;
            margin-bottom: 20px;
            border: none;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        
        @media (max-width: 768px) {
            .codeverse-sidebar {
                width: 200px;
            }
            .codeverse-content {
                margin-left: 200px;
            }
        }
    </style>
</head>
<body>
    <div class="codeverse-sidebar">
        <div class="codeverse-logo">
            <h2><i class="fas fa-code"></i> CodeVerse</h2>
            <small>Hackathon Marketplace</small>
        </div>
        
        <c:if test="${codeVerseUserType == 'ADMIN'}">
            <a href="${pageContext.request.contextPath}/admin/dashboard" class="codeverse-nav-item">
                <i class="fas fa-dashboard"></i> Dashboard
            </a>
            <a href="${pageContext.request.contextPath}/admin/categories" class="codeverse-nav-item">
                <i class="fas fa-tags"></i> Categories
            </a>
            <a href="${pageContext.request.contextPath}/admin/users" class="codeverse-nav-item">
                <i class="fas fa-users"></i> Users
            </a>
        </c:if>
        
        <c:if test="${codeVerseUserType == 'ORGANIZER'}">
            <a href="${pageContext.request.contextPath}/organizer/dashboard" class="codeverse-nav-item">
                <i class="fas fa-dashboard"></i> Dashboard
            </a>
            <a href="${pageContext.request.contextPath}/organizer/hackathons" class="codeverse-nav-item">
                <i class="fas fa-calendar"></i> My Hackathons
            </a>
            <a href="${pageContext.request.contextPath}/organizer/hackathons/create" class="codeverse-nav-item">
                <i class="fas fa-plus-circle"></i> Create Hackathon
            </a>
        </c:if>
        
        <c:if test="${codeVerseUserType == 'PARTICIPANT'}">
            <a href="${pageContext.request.contextPath}/participant/explore" class="codeverse-nav-item">
                <i class="fas fa-compass"></i> Explore
            </a>
            <a href="${pageContext.request.contextPath}/participant/bookings" class="codeverse-nav-item">
                <i class="fas fa-ticket-alt"></i> My Bookings
            </a>
            <a href="${pageContext.request.contextPath}/participant/dashboard" class="codeverse-nav-item">
                <i class="fas fa-dashboard"></i> Dashboard
            </a>
        </c:if>
        
        <a href="${pageContext.request.contextPath}/auth/logout" class="codeverse-nav-item" style="margin-top: 50px; border-top: 1px solid #444; padding-top: 20px;">
            <i class="fas fa-sign-out-alt"></i> Logout
        </a>
    </div>
    
    <div class="codeverse-content">
        <div class="codeverse-header">
            <div>
                <h3 style="margin: 0; color: var(--codeverse-dark);">${codeVersePageTitle}</h3>
            </div>
            <div>
                <span class="codeverse-user-badge">
                    <i class="fas fa-user-circle"></i> ${codeVerseCurrentUser.fullName}
                </span>
            </div>
        </div>
        
        <c:if test="${not empty codeVerseSuccessMessage}">
            <div class="alert alert-success codeverse-alert">
                <i class="fas fa-check-circle"></i> ${codeVerseSuccessMessage}
            </div>
        </c:if>
        
        <c:if test="${not empty codeVerseErrorMessage}">
            <div class="alert alert-danger codeverse-alert">
                <i class="fas fa-exclamation-circle"></i> ${codeVerseErrorMessage}
            </div>
        </c:if>
        
        <jsp:include page="${contentPage}" />
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
```

### File: CodeVerseLogin.jsp
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - CodeVerse</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .codeverse-login-container {
            max-width: 450px;
            width: 100%;
            padding: 20px;
        }
        
        .codeverse-login-card {
            background: white;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
        }
        
        .codeverse-logo {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .codeverse-logo h1 {
            font-size: 48px;
            background: linear-gradient(135deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin: 0;
        }
        
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
        
        .codeverse-btn-primary {
            background: linear-gradient(135deg, #667eea, #764ba2);
            border: none;
            color: white;
            padding: 12px;
            font-weight: bold;
            transition: all 0.3s;
        }
        
        .codeverse-btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }
    </style>
</head>
<body>
    <div class="codeverse-login-container">
        <div class="codeverse-login-card">
            <div class="codeverse-logo">
                <h1><i class="fas fa-code"></i></h1>
                <h2>CodeVerse</h2>
                <p class="text-muted">Hackathon Marketplace</p>
            </div>
            
            <c:if test="${not empty codeVerseErrorMessage}">
                <div class="alert alert-danger">
                    <i class="fas fa-exclamation-circle"></i> ${codeVerseErrorMessage}
                </div>
            </c:if>
            
            <c:if test="${not empty codeVerseSuccessMessage}">
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i> ${codeVerseSuccessMessage}
                </div>
            </c:if>
            
            <form action="${pageContext.request.contextPath}/auth/login" method="post">
                <div class="mb-3">
                    <label class="form-label"><i class="fas fa-user"></i> Username</label>
                    <input type="text" class="form-control" name="username" required>
                </div>
                
                <div class="mb-3">
                    <label class="form-label"><i class="fas fa-lock"></i> Password</label>
                    <input type="password" class="form-control" name="password" required>
                </div>
                
                <button type="submit" class="btn codeverse-btn-primary w-100">
                    <i class="fas fa-sign-in-alt"></i> Login to CodeVerse
                </button>
            </form>
            
            <hr class="my-4">
            
            <div class="text-center">
                <a href="${pageContext.request.contextPath}/auth/register" class="text-decoration-none">
                    Don't have an account? <strong>Register</strong>
                </a>
                <br>
                <a href="${pageContext.request.contextPath}/auth/forgot-password" class="text-muted mt-2 d-inline-block">
                    Forgot Password?
                </a>
            </div>
            
            <div class="mt-4 text-center text-muted small">
                <p>Default Credentials:</p>
                <p>Admin: admin / Admin@123</p>
                <p>Organizer: techcorp / Admin@123</p>
                <p>Participant: john_dev / Admin@123</p>
            </div>
        </div>
    </div>
</body>
</html>
```

### File: CodeVerseExplore.jsp
```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<div class="container-fluid">
    <div class="row mb-4">
        <div class="col-md-8">
            <form action="${pageContext.request.contextPath}/participant/explore" method="get" class="d-flex">
                <input type="text" name="search" class="form-control me-2" placeholder="🔍 Search hackathons..." value="${codeVerseSearchKeyword}">
                <button type="submit" class="btn btn-primary">Search</button>
            </form>
        </div>
        <div class="col-md-4">
            <select class="form-select" onchange="window.location.href='${pageContext.request.contextPath}/participant/explore?categoryId=' + this.value">
                <option value="">All Categories</option>
                <c:forEach var="category" items="${codeVerseCategories}">
                    <option value="${category.categoryId}" ${codeVerseSelectedCategory == category.categoryId ? 'selected' : ''}>
                        ${category.categoryName}
                    </option>
                </c:forEach>
            </select>
        </div>
    </div>
    
    <div class="row">
        <c:forEach var="hackathon" items="${codeVerseHackathons}">
            <div class="col-md-4 mb-4">
                <div class="card h-100 shadow-sm">
                    <div class="card-header bg-gradient text-white" style="background: linear-gradient(135deg, #667eea, #764ba2);">
                        <h5 class="card-title mb-0">${hackathon.hackathonTitle}</h5>
                    </div>
                    <div class="card-body">
                        <p class="card-text">${hackathon.hackathonDescription.substring(0, Math.min(100, hackathon.hackathonDescription.length()))}...</p>
                        <p><strong>Category:</strong> ${hackathon.category.categoryName}</p>
                        <p><strong>Date:</strong> ${hackathon.eventDate}</p>
                        <p><strong>Venue:</strong> ${hackathon.venueType}</p>
                        <p><strong>Prize Pool:</strong> $${hackathon.prizePool}</p>
                        <div class="progress mb-2">
                            <div class="progress-bar bg-success" style="width: ${(hackathon.availableSlots * 100) / hackathon.maxSlots}%">
                                ${hackathon.availableSlots} / ${hackathon.maxSlots} slots
                            </div>
                        </div>
                    </div>
                    <div class="card-footer">
                        <a href="${pageContext.request.contextPath}/participant/hackathon/${hackathon.hackathonId}" class="btn btn-primary w-100">
                            <i class="fas fa-eye"></i> View Details
                        </a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
    
    <c:if test="${empty codeVerseHackathons}">
        <div class="alert alert-info text-center">
            <i class="fas fa-info-circle"></i> No hackathons found. Try different search criteria.
        </div>
    </c:if>
</div>
```

### Continue with remaining JSP files in next document...

---

## Database Setup

1. Open MySQL Command Line or MySQL Workbench
2. Run the SQL script:
```sql
source C:/Users/Akbari Nihar/Desktop/codeverse-3/codeverse_schema.sql
```

## Configuration

Edit `src/main/resources/application.properties`:
- Update MySQL credentials
- Configure email settings for OTP functionality

## Build and Run

```bash
cd "C:\Users\Akbari Nihar\Desktop\codeverse-3"
mvn clean install
mvn spring-boot:run
```

## Access Application

- URL: http://localhost:8080/codeverse
- Admin: admin / Admin@123

---

© 2026 CodeVerse Hackathon Marketplace
