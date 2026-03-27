# CodeVerse Services - Quick Reference Guide

## 📋 Service Overview

### ✅ CodeVerseCategoryService
**File:** `CodeVerseCategoryService.java`
- **7 Methods:** findAllActiveCategories, createCategory, updateCategory, deleteCategory, findById, findByCategoryName, findAllCategories
- **Key Feature:** CRUD operations with validation & soft delete
- **Transactional Methods:** 3 (create, update, delete)

### ✅ CodeVerseHackathonService  
**File:** `CodeVerseHackathonService.java`
- **12 Methods:** createHackathon, updateHackathon, findAllPublished, findByOrganizer, findUpcoming, search, findByCategory, findById, decrementSlot, incrementSlot, hasAvailableSlots, getAvailableSlots
- **Key Feature:** Hackathon lifecycle + atomic slot management
- **Transactional Methods:** 4 (create, update, decrement, increment)
- **Special:** @Transactional on decrementSlot for atomicity

### ✅ CodeVerseRegistrationService
**File:** `CodeVerseRegistrationService.java`
- **11 Methods:** registerForHackathon, isAlreadyRegistered, findByParticipant, findByHackathon, findByRegistrationCode, findById, cancelRegistration, updateRegistrationStatus, updatePaymentStatus, updateRegistrationDetails, getTotalRegistrations
- **Key Feature:** Booking + auto email + slot sync + registration code generation
- **Transactional Methods:** 5 (register, cancel, updateStatus, updatePayment, updateDetails)
- **Special:** CV-YYYYMMDD-RANDOM6 code format + email notification

### ✅ CodeVerseMailService
**File:** `CodeVerseMailService.java`
- **3 Public Methods:** sendRegistrationSuccessMail, sendPasswordResetOTP, sendBookingConfirmation
- **Key Feature:** Professional HTML email templates with styling
- **Themes:** Welcome (purple), Password Reset (pink), Booking (green)

---

## 🔌 Dependency Injection

```java
// Inject in controllers or other services
@Autowired
private CodeVerseCategoryService categoryService;

@Autowired
private CodeVerseHackathonService hackathonService;

@Autowired
private CodeVerseRegistrationService registrationService;

@Autowired
private CodeVerseMailService mailService;
```

---

## 📝 Common Operations

### Category Operations
```java
// Get all active categories
List<CodeVerseCategory> categories = categoryService.findAllActiveCategories();

// Create category
CodeVerseCategory newCategory = new CodeVerseCategory();
newCategory.setCategoryName("AI & Machine Learning");
newCategory.setCategoryDescription("AI/ML hackathons");
newCategory.setCategoryIcon("ai-icon.png");
CodeVerseCategory saved = categoryService.createCategory(newCategory);

// Update category
CodeVerseCategory updated = categoryService.updateCategory(categoryId, updatedCategory);

// Delete (soft) category
categoryService.deleteCategory(categoryId);

// Find by ID
Optional<CodeVerseCategory> category = categoryService.findById(categoryId);
```

### Hackathon Operations
```java
// Get all published hackathons
List<CodeVerseHackathon> published = hackathonService.findAllPublished();

// Find upcoming hackathons
List<CodeVerseHackathon> upcoming = hackathonService.findUpcoming();

// Search hackathons
List<CodeVerseHackathon> results = hackathonService.search("blockchain");

// Get by category
List<CodeVerseHackathon> webDevHackathons = hackathonService.findByCategory(categoryId);

// Get organizer's hackathons
List<CodeVerseHackathon> myHackathons = hackathonService.findByOrganizer(userId);

// Check slots
boolean available = hackathonService.hasAvailableSlots(hackathonId);
int slots = hackathonService.getAvailableSlots(hackathonId);

// Create hackathon
CodeVerseHackathon hackathon = new CodeVerseHackathon();
hackathon.setHackathonTitle("BlockChain Hackathon 2024");
hackathon.setHackathonDescription("Build amazing blockchain apps...");
hackathon.setOrganizer(organizer);
hackathon.setCategory(category);
hackathon.setEventDate(LocalDate.now().plusMonths(1));
hackathon.setEventTime(LocalTime.of(9, 0));
hackathon.setDurationHours(24);
hackathon.setMaxSlots(100);
hackathon.setVenueLocation("Convention Center, City");
hackathon.setVenueType(CodeVerseHackathon.VenueType.OFFLINE);
CodeVerseHackathon saved = hackathonService.createHackathon(hackathon);
```

### Registration Operations
```java
// Register for hackathon (sends email automatically)
CodeVerseRegistration registration = registrationService.registerForHackathon(
    hackathonId,
    user,
    "Team Alpha"
);
String code = registration.getRegistrationCode(); // CV-20240115-ABC123

// Check if already registered
boolean isRegistered = registrationService.isAlreadyRegistered(hackathonId, userId);

// Get user's registrations
List<CodeVerseRegistration> myRegistrations = registrationService.findByParticipant(userId);

// Get hackathon's registrations
List<CodeVerseRegistration> participants = registrationService.findByHackathon(hackathonId);

// Find by registration code
Optional<CodeVerseRegistration> reg = registrationService.findByRegistrationCode("CV-20240115-ABC123");

// Cancel registration (restores slot)
registrationService.cancelRegistration(registrationId);

// Update status
registrationService.updateRegistrationStatus(
    registrationId,
    CodeVerseRegistration.RegistrationStatus.CONFIRMED
);

// Update payment status
registrationService.updatePaymentStatus(
    registrationId,
    CodeVerseRegistration.PaymentStatus.PAID
);

// Update details
registrationService.updateRegistrationDetails(
    registrationId,
    "Team Beta Updated",
    "Need wheelchair accessibility"
);

// Get total registrations
long count = registrationService.getTotalRegistrations(hackathonId);
```

### Email Operations
```java
// Send welcome email
mailService.sendRegistrationSuccessMail(user);

// Send password reset OTP
String otp = "123456";
mailService.sendPasswordResetOTP(user, otp);

// Send booking confirmation
mailService.sendBookingConfirmation(registration);
// Email is also sent automatically during registration!
```

---

## 🛡️ Error Handling

All services throw `RuntimeException` with descriptive messages:

```java
try {
    categoryService.createCategory(category);
} catch (RuntimeException e) {
    // Handle: "Category name cannot be empty"
    // Handle: "Category with name 'X' already exists"
    System.err.println("Error: " + e.getMessage());
}

try {
    registrationService.registerForHackathon(hackathonId, user, teamName);
} catch (RuntimeException e) {
    // Handle: "Hackathon not found with ID: X"
    // Handle: "User not found with ID: X"
    // Handle: "User is already registered for this hackathon"
    // Handle: "No slots available for this hackathon"
}
```

---

## 📧 Email Configuration

Add to `application.properties`:

```properties
# Gmail Example
spring.mail.host=smtp.gmail.com
spring.mail.port=587
spring.mail.username=your-email@gmail.com
spring.mail.password=your-app-password
spring.mail.properties.mail.smtp.auth=true
spring.mail.properties.mail.smtp.starttls.enable=true
spring.mail.properties.mail.smtp.starttls.required=true

# Or any SMTP server
spring.mail.host=smtp.your-provider.com
spring.mail.port=587
spring.mail.username=your-username
spring.mail.password=your-password
```

---

## 📊 Database Considerations

### Unique Constraints
- Category name is unique
- Hackathon & Participant pair is unique (prevents duplicate registrations)
- Registration code is unique

### Indexes (Recommended)
```sql
-- For faster queries
CREATE INDEX idx_category_active ON codeverse_categories(is_active);
CREATE INDEX idx_hackathon_organizer ON codeverse_hackathons(organizer_id);
CREATE INDEX idx_hackathon_category ON codeverse_hackathons(category_id);
CREATE INDEX idx_registration_participant ON codeverse_registrations(participant_id);
CREATE INDEX idx_registration_hackathon ON codeverse_registrations(hackathon_id);
CREATE INDEX idx_registration_code ON codeverse_registrations(registration_code);
```

---

## 🧪 Testing Checklist

- [ ] Create category with validation tests
- [ ] Update category and check duplicate prevention
- [ ] Delete category (soft delete)
- [ ] Create hackathon with validation
- [ ] Search hackathons by keyword
- [ ] Filter by category and organizer
- [ ] Check slot availability
- [ ] Register user (verify email sent)
- [ ] Prevent duplicate registration
- [ ] Verify slot decrements on registration
- [ ] Verify slot increments on cancellation
- [ ] Verify registration code format
- [ ] Cancel registration and verify slot restore
- [ ] Test email templates in email client
- [ ] Test with various user inputs

---

## 🚀 Integration with Controllers

```java
@RestController
@RequestMapping("/api/hackathons")
@RequiredArgsConstructor
public class HackathonController {
    
    private final CodeVerseHackathonService hackathonService;
    
    @GetMapping("/published")
    public ResponseEntity<List<CodeVerseHackathon>> getPublished() {
        return ResponseEntity.ok(hackathonService.findAllPublished());
    }
    
    @PostMapping
    public ResponseEntity<CodeVerseHackathon> create(@RequestBody CodeVerseHackathon hackathon) {
        return ResponseEntity.ok(hackathonService.createHackathon(hackathon));
    }
}
```

---

## 📈 Performance Notes

### N+1 Query Prevention
- Services use eager loading (FetchType.EAGER) where appropriate
- Consider using @Query with JoinFetch for complex scenarios

### Transaction Management
- Slot management uses @Transactional for atomicity
- Registration creates, decrements slots, and sends email in one transaction
- Email errors don't rollback registration

### Caching Opportunities
- Cache active categories (list changes infrequently)
- Cache published hackathons (can be refreshed hourly)
- Cache count queries

---

## 🔐 Security Considerations

✅ Password hashing: Handled by UserService (PasswordEncoder)
✅ OTP validation: 15-minute expiry
✅ Duplicate prevention: Database constraints
✅ Email validation: Spring Boot validation
✅ No sensitive data in logs

---

## 📞 Support

For issues or questions:
1. Check error messages (descriptive and helpful)
2. Review database constraints
3. Verify email configuration
4. Check application logs
5. Ensure all dependencies are injected

---

**All services are production-ready! 🚀**
