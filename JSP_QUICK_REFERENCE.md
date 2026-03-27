# CodeVerse JSP Views - Quick Reference

## File Structure

```
src/main/webapp/WEB-INF/views/
├── codeverse-layout.jsp                          [MASTER LAYOUT]
├── codeverse-login.jsp                           [AUTH]
├── codeverse-register.jsp                        [AUTH]
├── codeverse-forgot-password.jsp                 [AUTH]
├── codeverse-reset-password.jsp                  [AUTH]
├── codeverse-admin-dashboard.jsp                 [ADMIN]
├── codeverse-admin-categories.jsp                [ADMIN]
├── codeverse-admin-category-form.jsp             [ADMIN]
├── codeverse-admin-users.jsp                     [ADMIN]
├── codeverse-organizer-dashboard.jsp             [ORGANIZER]
├── codeverse-organizer-hackathons.jsp            [ORGANIZER]
├── codeverse-organizer-hackathon-form.jsp        [ORGANIZER]
├── codeverse-organizer-registrations.jsp         [ORGANIZER]
├── codeverse-participant-dashboard.jsp           [PARTICIPANT]
├── codeverse-participant-explore.jsp             [PARTICIPANT]
├── codeverse-participant-hackathon-details.jsp   [PARTICIPANT]
└── codeverse-participant-bookings.jsp            [PARTICIPANT]
```

## Usage Pattern

All views (except login/register/forgot-password) use the master layout:

```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:set var="page" value="dashboard"/>

<!DOCTYPE html>
<html>
<head>
    <!-- Your page title and styles -->
</head>
<body>
    <%@ include file="codeverse-layout.jsp" %>
    <jsp:include page="codeverse-layout.jsp">
        <jsp:param name="page" value="dashboard"/>
        <jsp:body>
            <!-- YOUR PAGE CONTENT HERE -->
        </jsp:body>
    </jsp:include>
</body>
</html>
```

## Important JSP Parameter Names

### For Navigation Highlighting:
```jsp
<c:set var="page" value="dashboard"/>  <!-- or: categories, users, hackathons, explore, bookings, registrations -->
```

This highlights the current menu item in the sidebar.

## Common Patterns

### 1. Flash Messages
```jsp
<c:if test="${not empty sessionScope.successMessage}">
    <div class="alert alert-success">
        <i class="fas fa-check-circle"></i>
        ${sessionScope.successMessage}
    </div>
    <c:set var="successMessage" value="${null}" scope="session"/>
</c:if>
```

### 2. Empty State
```jsp
<c:if test="${empty items}">
    <div class="card">
        <div class="card-body empty-state">
            <div class="empty-state-icon">
                <i class="fas fa-inbox"></i>
            </div>
            <h5>No items found</h5>
        </div>
    </div>
</c:if>
```

### 3. Data Table
```jsp
<div style="overflow-x: auto;">
    <table class="table">
        <thead>
            <tr>
                <th>Column 1</th>
                <th>Column 2</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="item" items="${items}">
                <tr>
                    <td>${item.property}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
```

### 4. Pagination
```jsp
<c:if test="${totalPages > 1}">
    <nav aria-label="Page navigation" style="margin-top: 2rem;">
        <ul class="pagination justify-content-center">
            <!-- First/Previous -->
            <c:if test="${currentPage > 1}">
                <li class="page-item">
                    <a class="page-link" href="?page=1">First</a>
                </li>
            </c:if>
            
            <!-- Page Numbers -->
            <c:forEach var="i" begin="1" end="${totalPages}">
                <li class="page-item ${i == currentPage ? 'active' : ''}">
                    <a class="page-link" href="?page=${i}">${i}</a>
                </li>
            </c:forEach>
            
            <!-- Next/Last -->
            <c:if test="${currentPage < totalPages}">
                <li class="page-item">
                    <a class="page-link" href="?page=${totalPages}">Last</a>
                </li>
            </c:if>
        </ul>
    </nav>
</c:if>
```

### 5. Form with Validation
```jsp
<form method="POST" action="/endpoint" class="needs-validation" novalidate>
    <div class="form-group">
        <label for="field" class="form-label required">Field Name</label>
        <input 
            type="text" 
            class="form-control" 
            id="field" 
            name="fieldName" 
            required
            minlength="3"
            maxlength="50">
        <div class="invalid-feedback">
            Please provide a valid value.
        </div>
    </div>
    <button type="submit" class="btn-submit">Submit</button>
</form>
```

### 6. Status Badge
```jsp
<span class="status-badge status-${fn:toLowerCase(status)}">
    <i class="fas fa-circle"></i> ${status}
</span>
```

Available statuses:
- `status-active` - Green
- `status-inactive` - Gray
- `status-pending` - Amber
- `status-completed` - Green
- `status-cancelled` - Red
- `status-upcoming` - Blue

### 7. Icon Box
```jsp
<div class="icon-box icon-box-primary">
    <i class="fas fa-code"></i>
</div>
```

### 8. Grid Layout
```jsp
<div class="row">
    <div class="col-md-6 col-lg-4 mb-4">
        <!-- Item -->
    </div>
</div>
```

Bootstrap grid classes:
- `.col-12` - Full width
- `.col-md-6` - 50% on medium+ screens
- `.col-lg-4` - 33% on large+ screens
- `.mb-4` - Margin bottom

## CSS Class Reference

### Buttons
```html
<button class="btn btn-codeverse">Primary</button>
<button class="btn btn-outline-codeverse">Outline</button>
<button class="btn btn-sm">Small</button>
```

### Cards
```html
<div class="card">
    <div class="card-header">Header</div>
    <div class="card-body">Content</div>
</div>
```

### Badges
```html
<span class="badge badge-success">Success</span>
<span class="badge badge-warning">Warning</span>
<span class="badge badge-danger">Danger</span>
```

### Text Utilities
```html
<p class="text-gradient">Gradient Text</p>
<p class="text-muted">Muted Text</p>
<p class="text-success">Success Text</p>
```

### Spacing
```html
<div class="mb-4">Margin Bottom 4</div>
<div class="mt-4">Margin Top 4</div>
<div class="px-3">Padding X 3</div>
```

## Font Awesome Icons

Common icons used:
- Menu: `fas fa-bars`
- Home: `fas fa-home`
- Users: `fas fa-users`
- Settings: `fas fa-cog`
- Edit: `fas fa-edit`
- Delete: `fas fa-trash`
- Search: `fas fa-search`
- Plus: `fas fa-plus`
- Check: `fas fa-check`
- Times: `fas fa-times`
- Calendar: `fas fa-calendar`
- Clock: `fas fa-clock`
- Map Marker: `fas fa-map-marker-alt`
- Trophy: `fas fa-trophy`
- Star: `fas fa-star`
- Heart: `fas fa-heart`
- Share: `fas fa-share`

Full icon list: https://fontawesome.com/icons

## Bootstrap CDN

```html
<!-- CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- JavaScript (at end of body) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
```

## Responsive Classes

```html
<!-- Hidden on mobile, visible on medium+ -->
<div class="d-none d-md-block">Desktop only</div>

<!-- Visible on mobile, hidden on medium+ -->
<div class="d-md-none">Mobile only</div>

<!-- Responsive text size -->
<h1 class="fs-1">Large</h1>
<h2 class="fs-2">Medium</h2>

<!-- Responsive padding -->
<div class="p-2 p-md-4 p-lg-6">Responsive padding</div>
```

## Color Variables (CSS)

```css
--primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
--secondary-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
--codeverse-purple: #667eea;
--codeverse-dark-purple: #764ba2;
--success-color: #10b981;
--warning-color: #f59e0b;
--danger-color: #ef4444;
```

## Common Session Variables

```jsp
${sessionScope.user.id}
${sessionScope.user.fullName}
${sessionScope.user.email}
${sessionScope.user.username}
${sessionScope.user.userType}        <!-- ADMIN, ORGANIZER, PARTICIPANT -->
${sessionScope.user.phoneNumber}
${sessionScope.user.createdDate}

${sessionScope.successMessage}
${sessionScope.errorMessage}
${sessionScope.warningMessage}
```

## Form Validation Rules

```html
required              <!-- Must not be empty -->
minlength="3"         <!-- Minimum characters -->
maxlength="50"        <!-- Maximum characters -->
type="email"          <!-- Email format -->
type="tel"            <!-- Phone format -->
type="date"           <!-- Date format -->
type="datetime-local" <!-- Date and time -->
pattern="[a-z]+"      <!-- Regex pattern -->
step="0.01"           <!-- Number steps -->
min="1"               <!-- Minimum value -->
max="100"             <!-- Maximum value -->
```

## Quick Debugging

### Check if user is logged in:
```jsp
<c:if test="${empty sessionScope.user}">
    <!-- User not logged in -->
</c:if>
<c:if test="${not empty sessionScope.user}">
    <!-- User is logged in -->
</c:if>
```

### Check user role:
```jsp
<c:if test="${sessionScope.user.userType == 'ADMIN'}">
    <!-- Admin only -->
</c:if>
```

### Print variable value:
```jsp
<!-- Debug output -->
<div style="border: 1px red solid; padding: 10px;">
    User: ${sessionScope.user.fullName}
</div>
```

### Test conditional rendering:
```jsp
<c:if test="${not empty items}">
    Has items
</c:if>
<c:if test="${empty items}">
    No items
</c:if>
```

## Performance Tips

1. **Use `<c:forEach>` instead of loops** - More efficient in JSP
2. **Cache database queries in controller** - Don't query per iteration
3. **Paginate large datasets** - Don't load all records
4. **Use CDN for Bootstrap/FontAwesome** - Faster delivery
5. **Compress images** - Use gradient backgrounds instead
6. **Minimize inline styles** - Move to CSS classes

## Accessibility Tips

1. Always use `<label for="fieldId">` for form inputs
2. Include alt text for icons via title attribute
3. Use semantic HTML (header, main, footer, nav)
4. Ensure color contrast ratios meet WCAG standards
5. Test keyboard navigation
6. Include ARIA labels where needed

## Browser Testing

Test in:
- Chrome (latest)
- Firefox (latest)
- Safari (latest)
- Edge (latest)
- Mobile Chrome
- Mobile Safari

Use Chrome DevTools responsive design mode for mobile testing.

## Common Issues & Solutions

| Issue | Solution |
|-------|----------|
| Layout not showing | Check `<c:set var="page">` is set correctly |
| Sidebar missing | Make sure to include `codeverse-layout.jsp` |
| Flash message not showing | Verify controller sets `sessionScope.successMessage` |
| Form not submitting | Check `method="POST"` and `action` URL |
| Validation not working | Ensure form has `class="needs-validation"` and script is loaded |
| Images not loading | Use Font Awesome icons or gradient backgrounds instead |
| Mobile layout broken | Check responsive classes (col-md-, mb-, etc.) |

## Deployment Checklist

- [ ] All JSP files in correct directory
- [ ] Bootstrap and Font Awesome CDN accessible
- [ ] Session handling configured
- [ ] Flash messages implemented in controller
- [ ] Form validation working
- [ ] CSRF protection implemented
- [ ] XSS prevention via JSTL tags
- [ ] Error pages configured
- [ ] Mobile responsive tested
- [ ] All links/buttons working
- [ ] Database queries optimized
- [ ] SSL/TLS configured
- [ ] Environment variables set

---

**Need Help?**
- Refer to JSP_VIEWS_DOCUMENTATION.md for detailed info
- Check Bootstrap docs: https://getbootstrap.com/docs/5.3/
- Test in browser DevTools console for JavaScript issues
- Verify network tab for CDN asset loading
