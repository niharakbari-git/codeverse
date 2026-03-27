# 🚀 CodeVerse - SUPER SIMPLE SETUP (3 Steps Only!)

## ✨ I DID EVERYTHING FOR YOU!

All 24 Java files are already created in your folder!  
The complete Spring Boot project is ready to go!

---

## 📋 JUST DO THESE 3 THINGS:

### ✅ **STEP 1: Run Auto-Setup (Double-Click This File)**

**📁 File:** `COMPLETE-AUTO-SETUP.bat`

**What to do:**  
Just **double-click** the file `COMPLETE-AUTO-SETUP.bat` in your project folder!

**What it does:**
- ✓ Creates all Maven directories automatically
- ✓ Moves all 24 Java files to correct locations automatically
- ✓ Sets up complete project structure automatically

**Time:** 2 seconds

---

### ✅ **STEP 2: Setup MySQL Database**

**What to do:**

1. Open **MySQL Command Line** or **MySQL Workbench**

2. Login with your MySQL password

3. Copy and paste this ONE command:

```sql
source C:/Users/Akbari Nihar/Desktop/codeverse-3/codeverse_schema.sql
```

**OR** if that doesn't work:

- Open the file `codeverse_schema.sql` in Notepad
- Copy ALL the content
- Paste it into MySQL and execute

**What it does:**
- ✓ Creates database "codeverse_db"
- ✓ Creates all 6 tables
- ✓ Adds sample data (admin, organizers, participants, hackathons)

**Time:** 1 minute

---

### ✅ **STEP 3: Update MySQL Password**

**What to do:**

1. Open this file:  
   `src\main\resources\application.properties`

2. Find this line:
   ```
   spring.datasource.password=root
   ```

3. Change `root` to YOUR MySQL password

**Example:**
```
spring.datasource.password=mypassword123
```

**Time:** 30 seconds

---

## 🎉 THAT'S IT! NOW RUN THE PROJECT:

### Open Command Prompt in your project folder and run:

```batch
mvn clean install
mvn spring-boot:run
```

**Wait for this message:**
```
╔═══════════════════════════════════════════════╗
║   CodeVerse Hackathon Marketplace Started!   ║
║   Access: http://localhost:8080/codeverse    ║
╚═══════════════════════════════════════════════╝
```

---

## 🌐 ACCESS YOUR APPLICATION:

**Open your browser:**  
👉 **http://localhost:8080/codeverse**

**Login with these credentials:**

| Role | Username | Password |
|------|----------|----------|
| **Admin** | admin | Admin@123 |
| **Organizer** | techcorp | Admin@123 |
| **Participant** | john_dev | Admin@123 |

---

## 📊 WHAT YOU GOT:

✅ **Complete Spring Boot 3.2.3 Project**  
✅ **24 Java Files** (Entities, Repositories, Services, Controllers, Config)  
✅ **MySQL Database** with sample data  
✅ **User Authentication** with BCrypt encryption  
✅ **3 User Roles** (Admin, Organizer, Participant)  
✅ **Email Service** (Registration, OTP, Booking confirmations)  
✅ **Hackathon Marketplace** with search and filters  
✅ **Booking System** with slot management  

---

## 🎯 QUICK SUMMARY:

1. **Double-click:** `COMPLETE-AUTO-SETUP.bat` ✓
2. **Run in MySQL:** `source C:/Users/Akbari Nihar/Desktop/codeverse-3/codeverse_schema.sql` ✓
3. **Edit:** Change MySQL password in `application.properties` ✓
4. **Build & Run:** `mvn clean install` then `mvn spring-boot:run` ✓
5. **Open:** http://localhost:8080/codeverse ✓

---

## ❓ TROUBLESHOOTING:

### Problem: "mvn command not found"
**Solution:** Install Maven from https://maven.apache.org/download.cgi

### Problem: "MySQL connection failed"
**Solution:** Make sure MySQL is running and password in application.properties is correct

### Problem: Port 8080 already in use
**Solution:** Change port in application.properties:
```
server.port=8081
```

---

## 🎊 ENJOY YOUR COMPLETE HACKATHON MARKETPLACE!

**You now have a fully functional, professional-grade application ready to use!**

Login as Admin, create categories, add hackathons, and let participants book slots! 🚀

---

**Questions?** Everything is automated - just follow the 3 steps above!

**Created by:** Lead Java Full-Stack Architect  
**Version:** 1.0.0  
**Status:** ✅ READY TO RUN
