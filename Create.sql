-- 1. PERSON
CREATE TABLE Person (
    Person_IC VARCHAR2(20) PRIMARY KEY,
    Person_First_Name VARCHAR2(50) NOT NULL,
    Person_Last_Name VARCHAR2(50) NOT NULL,
    Person_Email VARCHAR2(100) UNIQUE NOT NULL
);

-- 2. STAFF
CREATE TABLE Staff (
    Staff_ID VARCHAR2(20) PRIMARY KEY,
    Staff_Date_Hired DATE NOT NULL,
    Staff_JobTitle VARCHAR2(50) NOT NULL,
    Staff_EmploymentStatus VARCHAR2(20) CHECK (Staff_EmploymentStatus IN ('Full-Time', 'Part-Time', 'Contract', 'Intern')) NOT NULL,
    Person_IC VARCHAR2(20) NOT NULL,
    CONSTRAINT fk_staff_person FOREIGN KEY (Person_IC) REFERENCES Person(Person_IC)
);

-- 3. FLOOR_STAFF
CREATE TABLE Floor_Staff (
    FloorStaff_ID VARCHAR2(20) PRIMARY KEY,
    FloorStaff_RefNum VARCHAR2(20) UNIQUE NOT NULL,
    FloorStaff_RoleType VARCHAR2(30),
    FloorStaff_WorkArea VARCHAR2(50),
    FloorStaff_TrainedArea VARCHAR2(100),
    FloorStaff_Multilingual VARCHAR2(5) CHECK (FloorStaff_Multilingual IN ('YES', 'NO')),
    FloorStaff_Counter VARCHAR2(30),
    FloorStaff_CashRegisterAcess VARCHAR2(5) CHECK (FloorStaff_CashRegisterAcess IN ('YES', 'NO')),
    FloorStaff_Typhoid_Cert VARCHAR2(5) CHECK (FloorStaff_Typhoid_Cert IN ('YES', 'NO')),
    FloorStaff_FoodCertified VARCHAR2(5) CHECK (FloorStaff_FoodCertified IN ('YES', 'NO')),
    Staff_ID VARCHAR2(20) NOT NULL,
    Person_IC VARCHAR2(20) NOT NULL,
    CONSTRAINT fk_floorstaff_staff FOREIGN KEY (Staff_ID) REFERENCES Staff(Staff_ID),
    CONSTRAINT fk_floorstaff_person FOREIGN KEY (Person_IC) REFERENCES Person(Person_IC)
);

-- 4. MANAGER
CREATE TABLE Manager (
    Manager_ID VARCHAR2(20) PRIMARY KEY,
    Manager_RefNum VARCHAR2(20) UNIQUE NOT NULL,
    Manager_Level VARCHAR2(30),
    Manager_OfficeLocation VARCHAR2(50),
    Manager_TeamSize NUMBER,
    Manager_AdminAccess VARCHAR2(5) CHECK (Manager_AdminAccess IN ('YES', 'NO')),
    Manager_Department VARCHAR2(50),
    Manager_TeamRemarks VARCHAR2(200),
    Manager_WeeklyTeamCheck VARCHAR2(5) CHECK (Manager_WeeklyTeamCheck IN ('YES', 'NO')),
    Manager_QualificationCert VARCHAR2(100),
    Staff_ID VARCHAR2(20) NOT NULL,
    Person_IC VARCHAR2(20) NOT NULL,
    CONSTRAINT fk_manager_staff FOREIGN KEY (Staff_ID) REFERENCES Staff(Staff_ID),
    CONSTRAINT fk_manager_person FOREIGN KEY (Person_IC) REFERENCES Person(Person_IC)
);

-- 5. CUSTOMER
CREATE TABLE Customer (
    Customer_ID VARCHAR2(20) PRIMARY KEY,
    Customer_RefNum VARCHAR2(20) UNIQUE NOT NULL,
    Age_Category VARCHAR2(20) CHECK (Age_Category IN ('Kids', 'Student', 'Adult', 'Senior')) NOT NULL,
    Customer_Address VARCHAR2(200),
    Person_IC VARCHAR2(20) NOT NULL,
    CONSTRAINT fk_customer_person FOREIGN KEY (Person_IC) REFERENCES Person(Person_IC)
);

-- 6. SENIOR_CITIZEN_CUSTOMER
CREATE TABLE Senior_Citizen_Customer (
    Senior_Citizen_ID VARCHAR2(20) PRIMARY KEY,
    Senior_Citizen_RefNum VARCHAR2(20) UNIQUE NOT NULL,
    Emergency_Contact_Name VARCHAR2(50),
    Emergency_Contact_Number VARCHAR2(15),
    Accessibility VARCHAR2(5) CHECK (Accessibility IN ('YES', 'NO')),
    Mobility_Aid_Type VARCHAR2(50),
    Health_Issues VARCHAR2(200),
    Food_Restriction VARCHAR2(100),
    Hearing_Aid_Required VARCHAR2(5) CHECK (Hearing_Aid_Required IN ('YES', 'NO')),
    Special_Seat_Required VARCHAR2(5) CHECK (Special_Seat_Required IN ('YES', 'NO')),
    Customer_ID VARCHAR2(20) NOT NULL,
    Person_IC VARCHAR2(20) NOT NULL,
    CONSTRAINT fk_senior_customer FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),
    CONSTRAINT fk_senior_person FOREIGN KEY (Person_IC) REFERENCES Person(Person_IC)
);

-- 7. KIDS_CUSTOMER
CREATE TABLE Kids_Customer (
    Kids_ID VARCHAR2(20) PRIMARY KEY,
    Guardian_ID VARCHAR2(20),
    Guardian_Name VARCHAR2(50),
    Guardian_Contact VARCHAR2(15),
    Kids_Club_Membership VARCHAR2(5) CHECK (Kids_Club_Membership IN ('YES', 'NO')),
    Accompanied_by_Adult VARCHAR2(5) CHECK (Accompanied_by_Adult IN ('YES', 'NO')),
    Preferred_Movie_Time VARCHAR2(20),
    Preferred_Seating_Location VARCHAR2(50),
    Age_Rating VARCHAR2(10),
    Birthday_Date DATE,
    Customer_ID VARCHAR2(20) NOT NULL,
    Person_IC VARCHAR2(20) NOT NULL,
    CONSTRAINT fk_kids_customer FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),
    CONSTRAINT fk_kids_person FOREIGN KEY (Person_IC) REFERENCES Person(Person_IC)
);

-- 8. STUDENT_CUSTOMER
CREATE TABLE Student_Customer (
    Student_ID VARCHAR2(20) PRIMARY KEY,
    Student_Email VARCHAR2(100) UNIQUE,
    Insitution_Name VARCHAR2(100),
    Course_of_Study VARCHAR2(100),
    Enrollment_Year NUMBER(4),
    University_Email VARCHAR2(100),
    University_Contact_Number VARCHAR2(15),
    Semester_Break_Discount VARCHAR2(5) CHECK (Semester_Break_Discount IN ('YES', 'NO')),
    Level_of_Study VARCHAR2(50),
    Age_Rating VARCHAR2(10),
    Customer_ID VARCHAR2(20) NOT NULL,
    Person_IC VARCHAR2(20) NOT NULL,
    CONSTRAINT fk_student_customer FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),
    CONSTRAINT fk_student_person FOREIGN KEY (Person_IC) REFERENCES Person(Person_IC)
);

-- 9. FRANCHISE
CREATE TABLE Franchise (
    Franchise_ID VARCHAR2(20) PRIMARY KEY,
    Franchise_SSM VARCHAR2(30) UNIQUE NOT NULL,
    Franchise_Name VARCHAR2(100) NOT NULL,
    Franchise_Address VARCHAR2(200),
    Franchise_Postcode VARCHAR2(10),
    Franchise_Region VARCHAR2(50),
    Franchise_Operating_Time VARCHAR2(50),
    Franchise_Phone_Num VARCHAR2(15),
    Franchise_Location_Type VARCHAR2(50),
    Franchise_Email VARCHAR2(100) UNIQUE,
    CONSTRAINT uq_franchise_id_ssm UNIQUE (Franchise_ID, Franchise_SSM)
);

CREATE TABLE Cinema (
    Cinema_ID VARCHAR2(20) PRIMARY KEY,
    Cinema_Email VARCHAR2(100) NOT NULL,
    Cinema_RefNum VARCHAR2(20) NOT NULL,
    Cinema_Name VARCHAR2(100) NOT NULL,
    Cinema_Location VARCHAR2(200),
    Cinema_Facilities VARCHAR2(300),
    Cinema_OpeningTime VARCHAR2(20),
    Cinema_ClosingTime VARCHAR2(20),
    Cinema_PopulationRating NUMBER(3,1),
    Cinema_ContactNum VARCHAR2(15),
    Franchise_ID VARCHAR2(20) NOT NULL,
    Franchise_SSM VARCHAR2(30) NOT NULL,
    CONSTRAINT uq_cinema_id_email_ref UNIQUE (Cinema_ID, Cinema_Email, Cinema_RefNum),
    CONSTRAINT fk_cinema_franchise_id FOREIGN KEY (Franchise_ID) REFERENCES Franchise(Franchise_ID),
    CONSTRAINT fk_cinema_franchise_ssm FOREIGN KEY (Franchise_SSM) REFERENCES Franchise(Franchise_SSM)
);


-- 11. HALL
CREATE TABLE Hall (
    Hall_ID VARCHAR2(20),
    Hall_RefNum VARCHAR2(20) NOT NULL,
    Hall_Name VARCHAR2(100),
    Hall_Type VARCHAR2(50),
    Hall_Facilities VARCHAR2(300),
    Hall_ScreenType VARCHAR2(50),
    Hall_AudioSystem VARCHAR2(50),
    Hall_Occupancy NUMBER,
    Hall_MaintainanceFeatures VARCHAR2(200),
    Hall_AccessibilityFeatures VARCHAR2(200),
    Hall_LightSystem VARCHAR2(50),
    Cinema_ID VARCHAR2(20) NOT NULL,
    Cinema_Email VARCHAR2(100) NOT NULL,
    Cinema_RefNum VARCHAR2(20) NOT NULL,
    CONSTRAINT pk_hall PRIMARY KEY (Hall_ID),
    CONSTRAINT uq_hall_id_ref UNIQUE (Hall_ID, Hall_RefNum),
    CONSTRAINT fk_hall_cinema_combo FOREIGN KEY (Cinema_ID, Cinema_Email, Cinema_RefNum)
        REFERENCES Cinema(Cinema_ID, Cinema_Email, Cinema_RefNum)
);



-- 12. SEAT
CREATE TABLE Seat (
    Seat_ID VARCHAR2(20),
    Seat_RefNum VARCHAR2(20) NOT NULL,
    Seat_Type VARCHAR2(30),
    Seat_CleaningSchedule VARCHAR2(50),
    Seat_Row VARCHAR2(5),
    Seat_Column VARCHAR2(5),
    Seat_AvailabilityStatus VARCHAR2(20) CHECK (Seat_AvailabilityStatus IN ('Available', 'Reserved', 'Broken')),
    Seat_Features VARCHAR2(200),
    Seat_Layouts VARCHAR2(100),
    Seat_Size VARCHAR2(20),
    Cinema_ID VARCHAR2(20) NOT NULL,
    Cinema_Email VARCHAR2(100) NOT NULL,
    Cinema_RefNum VARCHAR2(20) NOT NULL,
    Hall_ID VARCHAR2(20) NOT NULL,
    Hall_RefNum VARCHAR2(20) NOT NULL,
    CONSTRAINT pk_seat PRIMARY KEY (Seat_ID),
    CONSTRAINT uq_seat_id_ref UNIQUE (Seat_ID, Seat_RefNum),
    CONSTRAINT fk_seat_cinema FOREIGN KEY (Cinema_ID, Cinema_Email, Cinema_RefNum)
        REFERENCES Cinema(Cinema_ID, Cinema_Email, Cinema_RefNum),
    CONSTRAINT fk_seat_hall FOREIGN KEY (Hall_ID, Hall_RefNum)
        REFERENCES Hall(Hall_ID, Hall_RefNum)
);

-- 13. MOVIE
CREATE TABLE Movie (
    Movie_ID VARCHAR2(20),
    Movie_RefNum VARCHAR2(20) NOT NULL,
    Movie_Name VARCHAR2(100) NOT NULL,
    Movie_Language VARCHAR2(50),
    Movie_SubtitleOptions VARCHAR2(100),
    Movie_ReleaseDate DATE,
    Movie_Genre VARCHAR2(50),
    Movie_Duration NUMBER(4), -- In minutes
    Movie_Description VARCHAR2(1000),
    Movie_AgeRating VARCHAR2(10),
    Movie_Director VARCHAR2(100),
    CONSTRAINT pk_movie PRIMARY KEY (Movie_ID),
    CONSTRAINT uq_movie_id_ref UNIQUE (Movie_ID, Movie_RefNum)
);


CREATE TABLE Product (
    Product_ID VARCHAR2(20),
    Product_Availibility VARCHAR2(5) CHECK (Product_Availibility IN ('YES', 'NO')),
    Product_Price NUMBER(8,2),
    Cinema_ID VARCHAR2(20) NOT NULL,
    Cinema_Email VARCHAR2(100) NOT NULL,
    Cinema_RefNum VARCHAR2(20) NOT NULL,
    CONSTRAINT pk_product PRIMARY KEY (Product_ID),
    CONSTRAINT fk_product_cinema_combo FOREIGN KEY (Cinema_ID, Cinema_Email, Cinema_RefNum)
        REFERENCES Cinema(Cinema_ID, Cinema_Email, Cinema_RefNum)
);



-- 15. FOOD
CREATE TABLE Food (
    Food_ID VARCHAR2(20),
    Food_RefNum VARCHAR2(20) UNIQUE NOT NULL,
    Food_Type VARCHAR2(50),
    Food_Cost NUMBER(8,2),
    Food_Size VARCHAR2(20),
    Food_Calories NUMBER,
    Food_Ingredients VARCHAR2(500),
    Food_Stock_Quantity NUMBER,
    Food_Allergy_Info VARCHAR2(200),
    Food_Promo_Eligibility VARCHAR2(5) CHECK (Food_Promo_Eligibility IN ('YES', 'NO')),
    Food_Picture VARCHAR2(200),
    Product_ID VARCHAR2(20), -- Foreign key column
    CONSTRAINT pk_food PRIMARY KEY (Food_ID),
    CONSTRAINT fk_food_product FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID)
);

-- 16. DRINK
CREATE TABLE Drink (
    Drinks_ID VARCHAR2(20) PRIMARY KEY,
    Drinks_RefNum VARCHAR2(20) UNIQUE NOT NULL,
    Drinks_Type VARCHAR2(50),
    Drinks_Cost NUMBER(8,2),
    Drinks_Size VARCHAR2(20),
    Drinks_Sugar_Content VARCHAR2(50),
    Drinks_Temperature VARCHAR2(20),
    Drinks_Stock_Quantity NUMBER,
    Drinks_Picture VARCHAR2(200),
    Drinks_Promo_Eligibility VARCHAR2(5) CHECK (Drinks_Promo_Eligibility IN ('YES', 'NO')),
    Drinks_Popular_Rating NUMBER(3,1),
    Product_ID VARCHAR2(20), -- Foreign key column
    CONSTRAINT fk_drink_product FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID)
);


-- 17. TICKET
CREATE TABLE Ticket (
    Ticket_ID VARCHAR2(20),
    Ticket_Booking_RefNum VARCHAR2(20),
    Ticket_Type VARCHAR2(30),
    Ticket_Cost NUMBER(8,2),
    Ticket_Status VARCHAR2(20) CHECK (Ticket_Status IN ('Booked', 'Checked-in', 'Cancelled', 'Expired')),
    Ticket_Refund_Policy VARCHAR2(100),
    Ticket_Holder_Name VARCHAR2(100),
    Ticket_Print_Option VARCHAR2(10) CHECK (Ticket_Print_Option IN ('E-ticket', 'Printed')),
    Ticket_Validation VARCHAR2(10) CHECK (Ticket_Validation IN ('QR', 'Manual')),
    Ticket_Expiration_Date DATE,
    Hall_ID VARCHAR2(20) NOT NULL,
    Hall_RefNum VARCHAR2(20) NOT NULL,
    Movie_ID VARCHAR2(20) NOT NULL,
    Movie_RefNum VARCHAR2(20) NOT NULL,
    Product_ID VARCHAR2(20), -- Foreign key column added
    PRIMARY KEY (Ticket_ID),
    UNIQUE (Ticket_Booking_RefNum),
    UNIQUE (Ticket_ID, Ticket_Booking_RefNum),
    CONSTRAINT fk_ticket_hall FOREIGN KEY (Hall_ID, Hall_RefNum)
        REFERENCES Hall(Hall_ID, Hall_RefNum),
    CONSTRAINT fk_ticket_movie FOREIGN KEY (Movie_ID, Movie_RefNum)
        REFERENCES Movie(Movie_ID, Movie_RefNum),
    CONSTRAINT fk_ticket_product FOREIGN KEY (Product_ID)
        REFERENCES Product(Product_ID)
);


-- 18. PAYSLIP
CREATE TABLE Payslip (
    Payslip_ID VARCHAR2(20),
    Payslip_Code VARCHAR2(20) NOT NULL,
    Payslip_AccountNumber VARCHAR2(30),
    Payslip_Status VARCHAR2(20) CHECK (Payslip_Status IN ('Pending', 'Paid', 'Failed')),
    Payslip_NetSalary NUMBER(10,2),
    Payslip_ScheduledTime TIMESTAMP,
    Payslip_ReceivedTime TIMESTAMP,
    Payslip_PaymentDate DATE,
    Payslip_GrossSalary NUMBER(10,2),
    Payslip_Deductions NUMBER(10,2),
    Cinema_ID VARCHAR2(20) NOT NULL,
    Cinema_Email VARCHAR2(100) NOT NULL,
    Cinema_RefNum VARCHAR2(20) NOT NULL,
    CONSTRAINT pk_payslip PRIMARY KEY (Payslip_ID),
    CONSTRAINT uq_payslip_id_code UNIQUE (Payslip_ID, Payslip_Code),
    CONSTRAINT fk_payslip_cinema_combo FOREIGN KEY (Cinema_ID, Cinema_Email, Cinema_RefNum)
        REFERENCES Cinema(Cinema_ID, Cinema_Email, Cinema_RefNum)
);


-- 19. ATTENDANCE
CREATE TABLE Attendance (
    Attendance_ID VARCHAR2(20),
    Attendance_Code VARCHAR2(20),
    Attendance_ShiftType VARCHAR2(30),
    Attendance_Status VARCHAR2(20) CHECK (Attendance_Status IN ('Present', 'Absent', 'On Leave')),
    Attendance_Date DATE,
    Attendance_CheckInTime TIMESTAMP,
    Attendance_CheckOutTime TIMESTAMP,
    Attendance_Reason VARCHAR2(200),
    Attendance_HoursWorked NUMBER(5,2),
    Attendance_Overtime_Hours NUMBER(5,2),
    Cinema_ID VARCHAR2(20) NOT NULL,
    Cinema_Email VARCHAR2(100) NOT NULL,
    Cinema_RefNum VARCHAR2(20) NOT NULL,
    Payslip_ID VARCHAR2(20) NOT NULL,
    Payslip_Code VARCHAR2(20) NOT NULL,
    CONSTRAINT pk_attendance PRIMARY KEY (Attendance_ID),
    CONSTRAINT uq_attendance_id_code UNIQUE (Attendance_ID, Attendance_Code),
    CONSTRAINT fk_attendance_cinema_combo FOREIGN KEY (Cinema_ID, Cinema_Email, Cinema_RefNum)
        REFERENCES Cinema(Cinema_ID, Cinema_Email, Cinema_RefNum),
    CONSTRAINT fk_attendance_payslip_combo FOREIGN KEY (Payslip_ID, Payslip_Code)
        REFERENCES Payslip(Payslip_ID, Payslip_Code)
);



-- 20. LEAVE
CREATE TABLE Leave (
    Leave_ID VARCHAR2(20) PRIMARY KEY,
    Leave_Code VARCHAR2(20) UNIQUE NOT NULL,
    Leave_Reason VARCHAR2(200),
    Leave_Approval VARCHAR2(10) CHECK (Leave_Approval IN ('APPROVED', 'REJECTED', 'PENDING')),
    Leave_StartDate DATE,
    Leave_StartTime TIMESTAMP,
    Leave_Hours NUMBER(5,2),
    Leave_EndDate DATE,
    Leave_EndTime TIMESTAMP,
    Leave_Balance NUMBER(5,2),
    Cinema_ID VARCHAR2(20) NOT NULL,
    Cinema_Email VARCHAR2(100) NOT NULL,
    Cinema_RefNum VARCHAR2(20) NOT NULL,
    Payslip_ID VARCHAR2(20) NOT NULL,
    Payslip_Code VARCHAR2(20) NOT NULL,
    CONSTRAINT fk_leave_cinema_combo FOREIGN KEY (Cinema_ID, Cinema_Email, Cinema_RefNum)
        REFERENCES Cinema(Cinema_ID, Cinema_Email, Cinema_RefNum),
    CONSTRAINT fk_leave_payslip_combo FOREIGN KEY (Payslip_ID, Payslip_Code)
        REFERENCES Payslip(Payslip_ID, Payslip_Code),
    CONSTRAINT uq_leave_id_code UNIQUE (Leave_ID, Leave_Code)
);



-- 21. SHIFT
CREATE TABLE Shift (
    Shift_ID VARCHAR2(20),
    Shift_Code VARCHAR2(20),
    Shift_Role VARCHAR2(50),
    Shift_Start_Date DATE,
    Shift_End_Date DATE,
    Shift_Description VARCHAR2(200),
    Shift_Start_Time TIMESTAMP,
    Shift_End_Time TIMESTAMP,
    Shift_Duration_Hours NUMBER(5,2),
    Shift_Pay_Per_Hour NUMBER(6,2),
    Cinema_ID VARCHAR2(20) NOT NULL,
    Cinema_Email VARCHAR2(100) NOT NULL,
    Cinema_RefNum VARCHAR2(20) NOT NULL,
    PRIMARY KEY (Shift_ID, Shift_Code),
    CONSTRAINT fk_shift_cinema_combo FOREIGN KEY (Cinema_ID, Cinema_Email, Cinema_RefNum)
        REFERENCES Cinema(Cinema_ID, Cinema_Email, Cinema_RefNum)
);


-- 22. STORAGE
CREATE TABLE Storage (
    Storage_ID VARCHAR2(20) PRIMARY KEY,
    Storage_Item_Name VARCHAR2(100),
    Storage_Received_Date DATE,
    Storage_Type VARCHAR2(50),
    Cinema_ID VARCHAR2(20) NOT NULL,
    Cinema_Email VARCHAR2(100) NOT NULL,
    Cinema_RefNum VARCHAR2(20) NOT NULL,
    CONSTRAINT fk_storage_cinema_combo FOREIGN KEY (Cinema_ID, Cinema_Email, Cinema_RefNum)
        REFERENCES Cinema(Cinema_ID, Cinema_Email, Cinema_RefNum)
);


-- 23. ASSET
CREATE TABLE Asset (
    Asset_ID VARCHAR2(20),
    Asset_RefNum VARCHAR2(20),
    Asset_Type VARCHAR2(50),
    Asset_Description VARCHAR2(200),
    Asset_Future_Maintenance_Date DATE,
    Asset_Status VARCHAR2(20) CHECK (Asset_Status IN ('Active', 'Inactive', 'Maintenance')),
    Asset_Value NUMBER(10,2),
    Asset_Purchase_Date DATE,
    Asset_Warranty_Time VARCHAR2(30),
    Asset_Estimated_LifeSpan VARCHAR2(30),
    Storage_ID VARCHAR2(20) NOT NULL,
    PRIMARY KEY (Asset_ID),
    CONSTRAINT uq_asset_id_refnum UNIQUE (Asset_ID, Asset_RefNum),
    CONSTRAINT fk_asset_storage FOREIGN KEY (Storage_ID) REFERENCES Storage(Storage_ID)
);


-- 24. INVENTORY
CREATE TABLE Inventory (
    Inventory_ID VARCHAR2(20) PRIMARY KEY,
    Inventory_RefNum VARCHAR2(20) UNIQUE NOT NULL,
    Inventory_Minimum_Stock NUMBER,
    Inventory_Maximum_Stock NUMBER,
    Inventory_Quantity_Available NUMBER,
    Inventory_Unit_Measurement VARCHAR2(30),
    Inventory_Expiry_Date DATE,
    Inventory_Restock_Alert VARCHAR2(5) CHECK (Inventory_Restock_Alert IN ('YES', 'NO')),
    Inventory_Environment VARCHAR2(100),
    Inventory_Last_Checked_Date DATE,
    Storage_ID VARCHAR2(20) NOT NULL,
    CONSTRAINT fk_inventory_storage FOREIGN KEY (Storage_ID) REFERENCES Storage(Storage_ID)
);

-- 25. STOCK_SUPPLIER
CREATE TABLE Stock_Supplier (
    Supplier_ID VARCHAR2(20) PRIMARY KEY,
    Supplier_SSM VARCHAR2(30) UNIQUE NOT NULL,
    Supplier_Name VARCHAR2(100),
    Supplier_Type VARCHAR2(50),
    Supplier_Number VARCHAR2(20),
    Supplier_Address VARCHAR2(200),
    Supplier_BankAccount VARCHAR2(50),
    Supplier_Status VARCHAR2(20) CHECK (Supplier_Status IN ('Active', 'Inactive')),
    Supplier_DeliveryMode VARCHAR2(50),
    Supplier_PaymentMode VARCHAR2(50),
    CONSTRAINT uq_supplier_id_ssm UNIQUE (Supplier_ID, Supplier_SSM)
);


-- 26. ASSET_LOG
CREATE TABLE Asset_Log (
    AssetLog_ID VARCHAR2(20) PRIMARY KEY,
    AssetLog_Code VARCHAR2(20) UNIQUE NOT NULL,
    AssetLog_UsageStartTime TIMESTAMP,
    AssetLog_UsageEndTime TIMESTAMP,
    AssetLog_UsageDate DATE,
    AssetLog_UsageDuration NUMBER(5,2),
    AssetLog_Usage_Description VARCHAR2(200),
    AssetLog_Remarks VARCHAR2(200),
    AssetLog_Condition VARCHAR2(30),
    AssetLog_Location_Used VARCHAR2(100),
    Cinema_ID VARCHAR2(20) NOT NULL,
    Cinema_Email VARCHAR2(100) NOT NULL,
    Cinema_RefNum VARCHAR2(20) NOT NULL,
    Asset_ID VARCHAR2(20) NOT NULL,
    Asset_RefNum VARCHAR2(20) NOT NULL,
    CONSTRAINT uq_asset_id_code UNIQUE (AssetLog_ID, AssetLog_Code),
    CONSTRAINT fk_assetlog_cinema FOREIGN KEY (Cinema_ID, Cinema_Email, Cinema_RefNum) REFERENCES Cinema(Cinema_ID, Cinema_Email, Cinema_RefNum),
    CONSTRAINT fk_assetlog_asset FOREIGN KEY (Asset_ID, Asset_RefNum) REFERENCES Asset(Asset_ID, Asset_RefNum)
);

CREATE TABLE C_Order (
    Order_ID VARCHAR2(20) PRIMARY KEY,
    Order_RefNum VARCHAR2(20) UNIQUE NOT NULL,
    Order_Item VARCHAR2(100),
    Order_Date DATE,
    Order_Type VARCHAR2(30),
    Order_Status VARCHAR2(20) CHECK (Order_Status IN ('Pending', 'Completed', 'Cancelled')),
    Order_TotalAmount NUMBER(10,2),
    Order_StartTime TIMESTAMP,
    Order_EndTime TIMESTAMP,
    Order_Remarks VARCHAR2(200),
    Cinema_ID VARCHAR2(20) NOT NULL,
    Cinema_Email VARCHAR2(100) NOT NULL,
    Cinema_RefNum VARCHAR2(20) NOT NULL,
    Supplier_ID VARCHAR2(20),
    Supplier_SSM VARCHAR2(30),
    CONSTRAINT fk_order_cinema FOREIGN KEY (Cinema_ID, Cinema_Email, Cinema_RefNum)
        REFERENCES Cinema(Cinema_ID, Cinema_Email, Cinema_RefNum),
    CONSTRAINT fk_order_supplier FOREIGN KEY (Supplier_ID, Supplier_SSM)
        REFERENCES Stock_Supplier(Supplier_ID, Supplier_SSM),
    CONSTRAINT uq_order_id_ref UNIQUE (Order_ID, Order_RefNum)
);


CREATE TABLE Payment (
    Payment_ID VARCHAR2(20) PRIMARY KEY,
    Payment_TransactionRef VARCHAR2(30) NOT NULL,
    Payment_RefundStatus VARCHAR2(10) CHECK (Payment_RefundStatus IN ('YES', 'NO')),
    Payment_Date DATE,
    Payment_Method VARCHAR2(30),
    Payment_TotalAmount NUMBER(10,2),
    Payment_Tax NUMBER(8,2),
    Payment_Status VARCHAR2(20) CHECK (Payment_Status IN ('Completed', 'Pending', 'Failed', 'Refunded')),
    Payment_DiscountPromotion VARCHAR2(100),
    Payment_RefundAmount NUMBER(10,2),
    Cinema_ID VARCHAR2(20) NOT NULL,
    Cinema_Email VARCHAR2(100) NOT NULL,
    Cinema_RefNum VARCHAR2(20) NOT NULL,
    Supplier_ID VARCHAR2(20),
    Supplier_SSM VARCHAR2(30),
    Order_ID VARCHAR2(20),
    Order_RefNum VARCHAR2(20),
    CONSTRAINT fk_payment_cinema FOREIGN KEY (Cinema_ID, Cinema_Email, Cinema_RefNum)
        REFERENCES Cinema(Cinema_ID, Cinema_Email, Cinema_RefNum),
    CONSTRAINT fk_payment_supplier FOREIGN KEY (Supplier_ID, Supplier_SSM)
        REFERENCES Stock_Supplier(Supplier_ID, Supplier_SSM),
    CONSTRAINT fk_payment_order FOREIGN KEY (Order_ID, Order_RefNum)
        REFERENCES C_Order(Order_ID, Order_RefNum),
    CONSTRAINT uq_payment_id_ref UNIQUE (Payment_ID, Payment_TransactionRef)
);


CREATE TABLE Review (
    Review_ID VARCHAR2(20) PRIMARY KEY,
    Review_RefNum VARCHAR2(20) UNIQUE NOT NULL,
    Reviewer_Name VARCHAR2(100),
    Rating NUMBER(2,1) CHECK (Rating BETWEEN 0 AND 5),
    Comm VARCHAR2(500),
    Review_Date DATE,
    Review_Time TIMESTAMP,
    Like_Count NUMBER,
    Review_Count NUMBER,
    Helpful_Count NUMBER,
    Review_Source VARCHAR2(100),
    Cinema_ID VARCHAR2(20) NOT NULL,
    Cinema_Email VARCHAR2(100) NOT NULL,
    Cinema_RefNum VARCHAR2(20) NOT NULL,
    CONSTRAINT fk_review_cinema FOREIGN KEY (Cinema_ID, Cinema_Email, Cinema_RefNum)
        REFERENCES Cinema(Cinema_ID, Cinema_Email, Cinema_RefNum),
    CONSTRAINT uq_review_id_ref UNIQUE (Review_ID, Review_RefNum)
);

CREATE TABLE Cinema_Movie (
    Cinema_ID VARCHAR2(20),
    Cinema_Email VARCHAR2(100),
    Cinema_RefNum VARCHAR2(20),
    Movie_ID VARCHAR2(20),
    Movie_RefNum VARCHAR2(20),
    PRIMARY KEY (Cinema_ID, Cinema_Email, Cinema_RefNum, Movie_ID, Movie_RefNum),
    FOREIGN KEY (Cinema_ID, Cinema_Email, Cinema_RefNum) REFERENCES Cinema(Cinema_ID, Cinema_Email, Cinema_RefNum),
    FOREIGN KEY (Movie_ID, Movie_RefNum) REFERENCES Movie(Movie_ID, Movie_RefNum)
);

CREATE TABLE Person_Hall (
    Person_IC VARCHAR2(20),
    Hall_ID VARCHAR2(20),
    Hall_RefNum VARCHAR2(20),
    PRIMARY KEY (Person_IC, Hall_ID, Hall_RefNum),
    FOREIGN KEY (Person_IC) REFERENCES Person(Person_IC),
    FOREIGN KEY (Hall_ID, Hall_RefNum) REFERENCES Hall(Hall_ID, Hall_RefNum)
);

CREATE TABLE Hall_Movie (
    Hall_ID VARCHAR2(20),
    Hall_RefNum VARCHAR2(20),
    Movie_ID VARCHAR2(20),
    Movie_RefNum VARCHAR2(20),
    PRIMARY KEY (Hall_ID, Hall_RefNum, Movie_ID, Movie_RefNum),
    FOREIGN KEY (Hall_ID, Hall_RefNum) REFERENCES Hall(Hall_ID, Hall_RefNum),
    FOREIGN KEY (Movie_ID, Movie_RefNum) REFERENCES Movie(Movie_ID, Movie_RefNum)
);

CREATE TABLE Staff_Asset_Log (
    Staff_ID VARCHAR2(20),
    AssetLog_ID VARCHAR2(20),
    AssetLog_Code VARCHAR2(20),
    PRIMARY KEY (Staff_ID, AssetLog_ID, AssetLog_Code),
    FOREIGN KEY (Staff_ID) REFERENCES Staff(Staff_ID),
    FOREIGN KEY (AssetLog_ID, AssetLog_Code) REFERENCES Asset_Log(AssetLog_ID, AssetLog_Code)
);

CREATE TABLE Staff_Attendance (
    Staff_ID VARCHAR2(20),
    Attendance_ID VARCHAR2(20),
    Attendance_Code VARCHAR2(20),
    PRIMARY KEY (Staff_ID, Attendance_ID, Attendance_Code),
    FOREIGN KEY (Staff_ID) REFERENCES Staff(Staff_ID),
    FOREIGN KEY (Attendance_ID, Attendance_Code) REFERENCES Attendance(Attendance_ID, Attendance_Code)
);

CREATE TABLE Staff_Leave (
    Staff_ID VARCHAR2(20),
    Leave_ID VARCHAR2(20),
    Leave_Code VARCHAR2(20),
    PRIMARY KEY (Staff_ID, Leave_ID, Leave_Code),
    FOREIGN KEY (Staff_ID) REFERENCES Staff(Staff_ID),
    FOREIGN KEY (Leave_ID, Leave_Code) REFERENCES Leave(Leave_ID, Leave_Code)
);

CREATE TABLE Cinema_Stock_Supplier (
    Cinema_ID VARCHAR2(20),
    Cinema_Email VARCHAR2(100),
    Cinema_RefNum VARCHAR2(20),
    Supplier_ID VARCHAR2(20),
    Supplier_SSM VARCHAR2(30),
    PRIMARY KEY (Cinema_ID, Cinema_Email, Cinema_RefNum, Supplier_ID, Supplier_SSM),
    FOREIGN KEY (Cinema_ID, Cinema_Email, Cinema_RefNum) REFERENCES Cinema(Cinema_ID, Cinema_Email, Cinema_RefNum),
    FOREIGN KEY (Supplier_ID, Supplier_SSM) REFERENCES Stock_Supplier(Supplier_ID, Supplier_SSM)
);

CREATE TABLE Storage_Stock_Supplier (
    Storage_ID VARCHAR2(20),
    Supplier_ID VARCHAR2(20),
    Supplier_SSM VARCHAR2(30),
    PRIMARY KEY (Storage_ID, Supplier_ID, Supplier_SSM),
    FOREIGN KEY (Storage_ID) REFERENCES Storage(Storage_ID),
    FOREIGN KEY (Supplier_ID, Supplier_SSM) REFERENCES Stock_Supplier(Supplier_ID, Supplier_SSM)
);

CREATE TABLE Product_Order (
    Order_ID VARCHAR2(20),
    Order_RefNum VARCHAR2(20),
    Product_ID VARCHAR2(20),
    PRIMARY KEY (Order_ID, Order_RefNum, Product_ID),
    FOREIGN KEY (Order_ID, Order_RefNum) REFERENCES C_Order(Order_ID, Order_RefNum),
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID)
);

CREATE TABLE Product_Stock_Supplier (
    Product_ID VARCHAR2(20),
    Supplier_ID VARCHAR2(20),
    Supplier_SSM VARCHAR2(30),
    PRIMARY KEY (Product_ID, Supplier_ID, Supplier_SSM),
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID),
    FOREIGN KEY (Supplier_ID, Supplier_SSM) REFERENCES Stock_Supplier(Supplier_ID, Supplier_SSM)
);

CREATE TABLE Payslip_Shift (
    Payslip_ID VARCHAR2(20),
    Payslip_Code VARCHAR2(20),
    Shift_ID VARCHAR2(20),
    Shift_Code VARCHAR2(20),
    PRIMARY KEY (Payslip_ID, Payslip_Code, Shift_ID, Shift_Code),
    FOREIGN KEY (Payslip_ID, Payslip_Code) REFERENCES Payslip(Payslip_ID, Payslip_Code),
    FOREIGN KEY (Shift_ID, Shift_Code) REFERENCES Shift(Shift_ID, Shift_Code)
);

CREATE TABLE Product_Payment (
    Product_ID VARCHAR2(20),
    Payment_ID VARCHAR2(20),
    Payment_TransactionRef VARCHAR2(30),
    PRIMARY KEY (Product_ID, Payment_ID, Payment_TransactionRef),
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID),
    FOREIGN KEY (Payment_ID, Payment_TransactionRef) REFERENCES Payment(Payment_ID, Payment_TransactionRef)
);

CREATE TABLE Product_Person (
    Product_ID VARCHAR2(20),
    Person_IC VARCHAR2(20),
    PRIMARY KEY (Product_ID, Person_IC),
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID),
    FOREIGN KEY (Person_IC) REFERENCES Person(Person_IC)
);

CREATE TABLE Product_Storage (
    Product_ID VARCHAR2(20),
    Storage_ID VARCHAR2(20),
    PRIMARY KEY (Product_ID, Storage_ID),
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID),
    FOREIGN KEY (Storage_ID) REFERENCES Storage(Storage_ID)
);

CREATE TABLE Staff_Shift (
    Staff_ID VARCHAR2(20),
    Shift_ID VARCHAR2(20),
    Shift_Code VARCHAR2(20),
    PRIMARY KEY (Staff_ID, Shift_ID, Shift_Code),
    FOREIGN KEY (Staff_ID) REFERENCES Staff(Staff_ID),
    FOREIGN KEY (Shift_ID, Shift_Code) REFERENCES Shift(Shift_ID, Shift_Code)
);

CREATE TABLE Staff_Payslip (
    Staff_ID VARCHAR2(20),
    Payslip_ID VARCHAR2(20),
    Payslip_Code VARCHAR2(20),
    PRIMARY KEY (Staff_ID, Payslip_ID, Payslip_Code),
    FOREIGN KEY (Staff_ID) REFERENCES Staff(Staff_ID),
    FOREIGN KEY (Payslip_ID, Payslip_Code) REFERENCES Payslip(Payslip_ID, Payslip_Code)
);

CREATE TABLE Staff_Storage (
    Staff_ID VARCHAR2(20),
    Storage_ID VARCHAR2(20),
    PRIMARY KEY (Staff_ID, Storage_ID),
    FOREIGN KEY (Staff_ID) REFERENCES Staff(Staff_ID),
    FOREIGN KEY (Storage_ID) REFERENCES Storage(Storage_ID)
);

CREATE TABLE Seat_Ticket (
    Seat_ID VARCHAR2(20),
    Seat_RefNum VARCHAR2(20),
    Ticket_ID VARCHAR2(20),
    Ticket_Booking_RefNum VARCHAR2(20),
    PRIMARY KEY (Seat_ID, Seat_RefNum, Ticket_ID, Ticket_Booking_RefNum),
    FOREIGN KEY (Seat_ID, Seat_RefNum) REFERENCES Seat(Seat_ID, Seat_RefNum),
    FOREIGN KEY (Ticket_ID, Ticket_Booking_RefNum) REFERENCES Ticket(Ticket_ID, Ticket_Booking_RefNum)
);

CREATE TABLE Person_Seat (
    Person_IC VARCHAR2(20),
    Seat_ID VARCHAR2(20),
    Seat_RefNum VARCHAR2(20),
    PRIMARY KEY (Person_IC, Seat_ID, Seat_RefNum),
    FOREIGN KEY (Person_IC) REFERENCES Person(Person_IC),
    FOREIGN KEY (Seat_ID, Seat_RefNum) REFERENCES Seat(Seat_ID, Seat_RefNum)
);

CREATE TABLE Person_Cinema (
    Person_IC VARCHAR2(20),
    Cinema_ID VARCHAR2(20),
    Cinema_Email VARCHAR2(100),
    Cinema_RefNum VARCHAR2(20),
    PRIMARY KEY (Person_IC, Cinema_ID, Cinema_Email, Cinema_RefNum),
    FOREIGN KEY (Person_IC) REFERENCES Person(Person_IC),
    FOREIGN KEY (Cinema_ID, Cinema_Email, Cinema_RefNum) REFERENCES Cinema(Cinema_ID, Cinema_Email, Cinema_RefNum)
);

CREATE TABLE Person_Order (
    Person_IC VARCHAR2(20),
    Order_ID VARCHAR2(20),
    Order_RefNum VARCHAR2(20),
    PRIMARY KEY (Person_IC, Order_ID, Order_RefNum),
    FOREIGN KEY (Person_IC) REFERENCES Person(Person_IC),
    FOREIGN KEY (Order_ID, Order_RefNum) REFERENCES C_Order(Order_ID, Order_RefNum)
);

CREATE TABLE Person_Person (
    Person_IC1 VARCHAR2(20),
    Person_IC2 VARCHAR2(20),
    PRIMARY KEY (Person_IC1, Person_IC2),
    FOREIGN KEY (Person_IC1) REFERENCES Person(Person_IC),
    FOREIGN KEY (Person_IC2) REFERENCES Person(Person_IC)
);

CREATE TABLE Person_Payment (
    Person_IC VARCHAR2(20),
    Payment_ID VARCHAR2(20),
    Payment_TransactionRef VARCHAR2(30),
    PRIMARY KEY (Person_IC, Payment_ID, Payment_TransactionRef),
    FOREIGN KEY (Person_IC) REFERENCES Person(Person_IC),
    FOREIGN KEY (Payment_ID, Payment_TransactionRef) REFERENCES Payment(Payment_ID, Payment_TransactionRef)
);

CREATE TABLE Person_Franchise (
    Person_IC VARCHAR2(20),
    Franchise_ID VARCHAR2(20),
    Franchise_SSM VARCHAR2(30),
    PRIMARY KEY (Person_IC, Franchise_ID, Franchise_SSM),
    FOREIGN KEY (Person_IC) REFERENCES Person(Person_IC),
    FOREIGN KEY (Franchise_ID, Franchise_SSM) REFERENCES Franchise(Franchise_ID, Franchise_SSM)
);

CREATE TABLE Person_Review (
    Person_IC VARCHAR2(20),
    Review_ID VARCHAR2(20),
    Review_RefNum VARCHAR2(20),
    PRIMARY KEY (Person_IC, Review_ID, Review_RefNum),
    FOREIGN KEY (Person_IC) REFERENCES Person(Person_IC),
    FOREIGN KEY (Review_ID, Review_RefNum) REFERENCES Review(Review_ID, Review_RefNum)
);
