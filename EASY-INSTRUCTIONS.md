# ⚡ SUPER SIMPLE 3-STEP SETUP

## Step 1: Organize Files

**RIGHT-CLICK** on this file: `SETUP.bat`  
Then click **"Run as administrator"**

(Don't double-click - RIGHT-CLICK!)

This will:
- Create all Maven folders
- Move all 24 Java files to correct locations

---

## Step 2: Setup MySQL Database

1. Open **MySQL Workbench** or **MySQL Command Line**
2. Login with your password
3. Click "File" → "Run SQL Script"
4. Choose file: `codeverse_schema.sql`
5. Click "Run"

OR paste this in MySQL:
```sql
source C:/Users/Akbari Nihar/Desktop/codeverse-3/codeverse_schema.sql
```

---

## Step 3: Update MySQL Password

1. Open this file in Notepad:
   ```
   src\main\resources\application.properties
   ```

2. Find this line:
   ```
   spring.datasource.password=root
   ```

3. Change `root` to YOUR MySQL password

4. Save the file

---

## Step 4: Build and Run

Open **Command Prompt** in this folder and run:

```batch
mvn clean install
mvn spring-boot:run
```

Wait for "CodeVerse Hackathon Marketplace Started!" message

---

## Step 5: Open in Browser

Go to: **http://localhost:8080/codeverse**

Login with:
- Username: `admin`
- Password: `Admin@123`

---

## 🎉 THAT'S IT!

Your complete Hackathon Marketplace is running!

---

## ❓ Troubleshooting

**Problem:** "mvn not found"  
**Solution:** Install Maven from https://maven.apache.org

**Problem:** "MySQL connection failed"  
**Solution:** Check your MySQL password in application.properties

**Problem:** Port 8080 in use  
**Solution:** Change port in application.properties to 8081

---

**Need help?** All 24 Java files are ready in your folder!
