# 🎬 MM2 Cinema Management System (Oracle Database)

![Oracle Database](https://img.shields.io/badge/Database-Oracle-F80000?style=flat&logo=oracle&logoColor=white)
![Language](https://img.shields.io/badge/Language-PL%2FSQL-orange)

## 📌 Project Overview
This project is a relational database management system designed for **MM2 Screen Management Sdn. Bhd.** (MM Cineplexes). It streamlines cinema operations ranging from ticketing and movie scheduling to staff management, inventory control, and franchise administration.

The system is built using **Oracle SQL** and strictly adheres to relational database principles, utilizing complex constraints, normalization, and relationships to ensure data integrity.

---

## 📂 Repository Structure

```text
├── Create.sql           # DDL script to create tables, constraints, and relationships
├── InsertCode.sql       # DML script to populate the database with sample data
├── Drop.sql             # Script to drop all tables and clean the schema
└── Cinema EERD.jpg      # Entity Relationship Diagram (ERD) visualization
```

---

## 🏗️ Database Modules

The database schema is divided into several logical modules:

### 1. Person & HR Management
* **Person**: Supertype for all individuals (Staff & Customers).
* **Staff**: Management of employees, including Managers and Floor Staff.
* **HR**: Tracks `Shift`, `Attendance`, `Payslip`, and `Leave`.

### 2. Cinema Operations
* **Franchise & Cinema**: Manages franchise details and specific cinema branches.
* **Facilities**: Tracks `Hall` configurations (IMAX, Standard) and `Seat` availability.

### 3. Ticketing & Movies
* **Movie**: Stores movie metadata, ratings, and genres.
* **Ticket**: Handles booking logic linking customers to specific screenings and seats.

### 4. Inventory & Assets
* **Concessions**: Manages `Product`, `Food`, and `Drink` sales.
* **Supply Chain**: Tracks `Inventory`, `Storage` locations, and `Stock_Supplier`.
* **Assets**: Logs cinema equipment (`Asset`) and maintenance history (`Asset_Log`).

### 5. Customer & Feedback
* **Customer Profiles**: Segmentation into Student, Kids, and Senior Citizens for targeted pricing.
* **Reviews**: Captures customer ratings and feedback.

---

## ⚙️ Prerequisites
* **Oracle Database** (11g Express Edition or higher)
* **SQL Client**: Oracle SQL Developer, SQL*Plus, or VS Code with Oracle extension.

---

## 🚀 Installation & Usage
To set up the database, execute the SQL scripts in the following **strict order** to avoid foreign key constraint violations.

### 1. Clean Previous Installs (Optional)
If you are resetting the database, run the drop script first.
```sql
@Drop.sql
```

### 2. Create Schema
Builds the table structure, primary keys, and foreign keys.
```sql
@Create.sql
```

### 3. Insert Data
Populates the tables with dummy data for testing.
```sql
@InsertCode.sql
```

### 4. Verification
Run a test query to ensure data is loaded correctly.
```sql
SELECT * FROM Cinema;
```

---

## 📜 License & Course Info
* **Institution**: Universiti Teknologi PETRONAS
* **Course**: TEB1103 (CS) Data and Information Management
* **Semester**: May 2025 / June 2025
