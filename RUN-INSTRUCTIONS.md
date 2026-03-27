# 🚀 COMPLETE RUN INSTRUCTIONS - CodeVerse Project

---

## ✅ STEP 1: SETUP DATABASE (5 minutes)

### Open MySQL Command Line Client:
```bash
mysql -u root -p
```
*(Enter your MySQL password)*

### Run this command:
```sql
source C:/Users/Akbari Nihar/Desktop/codeverse-3/codeverse_schema.sql
```

### Verify database created:
```sql
SHOW DATABASES;
USE codeverse_db;
SHOW TABLES;
```

**You should see 6 tables created ✅**

---

## ✅ STEP 2: BUILD PROJECT (2-5 minutes)

### Open Command Prompt (Windows + R → cmd):
```bash
cd C:\Users\Akbari Nihar\Desktop\codeverse-3
```

### Build the project:
```bash
mvn clean install
```

**Wait for:** `[INFO] BUILD SUCCESS` ✅

*(First time takes longer - Maven downloads dependencies)*

---

## ✅ STEP 3: RUN APPLICATION (30 seconds)

### Start the server:
```bash
mvn spring-boot:run
```

**Wait for this message:**
```
╔═══════════════════════════════════════════════╗
║   CodeVerse Hackathon Marketplace Started!   ║
║   Access: http://localhost:8080/codeverse    ║
╚═══════════════════════════════════════════════╝
```

**✅ Server is running! Keep Command Prompt open.**

---

## ✅ STEP 4: ACCESS APPLICATION

### Open browser and go to:
```
http://localhost:8080/codeverse
```

### Login with:
```
Email:    admin@codeverse.com
Password: Admin@123
```

**✅ You're in! Welcome to CodeVerse Dashboard!**

---

## 🎯 QUICK COMMANDS (Copy-Paste)

```bash
# Navigate to project
cd C:\Users\Akbari Nihar\Desktop\codeverse-3

# Build
mvn clean install

# Run
mvn spring-boot:run

# Access: http://localhost:8080/codeverse
# Login: admin@codeverse.com / Admin@123
```

---

## 🛑 TO STOP SERVER

Press **Ctrl + C** in Command Prompt → Type **Y**

---

## 🐛 COMMON ISSUES

### ❌ Port 8080 already in use
**Fix:** Stop other apps or change port in `application.properties`

### ❌ Database connection error
**Fix:** Check MySQL is running and password is correct

### ❌ BUILD FAILURE
**Fix:** Check Java 17 installed: `java -version`

### ❌ 404 Error
**Fix:** Use full URL: `http://localhost:8080/codeverse` (don't forget `/codeverse`)

---

## ✅ SUCCESS CHECKLIST

- [x] MySQL password updated in application.properties
- [x] Gmail SMTP password updated in application.properties
- [ ] MySQL database created (`codeverse_db`)
- [ ] Build successful (`mvn clean install`)
- [ ] Server started (`mvn spring-boot:run`)
- [ ] Can access http://localhost:8080/codeverse
- [ ] Can login as admin

---

## 🎉 THAT'S IT!

**Your CodeVerse Hackathon Marketplace is now LIVE!**

**3 Simple Commands:**
1. Setup database (MySQL)
2. `mvn clean install`
3. `mvn spring-boot:run`

**Then open:** http://localhost:8080/codeverse

---

**Need detailed help?** Check `✅_PROJECT_VERIFICATION_COMPLETE.md`
