-- Apple iTunes Music Analysis Project
-- Database Setup Script
-- Tool: MySQL Workbench
-- Author: Mohsin Khaled
-- Description: Creates relational schema and imports CSV datasets.

-- Create Database
CREATE DATABASE itunes_analysis;
USE itunes_analysis;

-- Artist Table
CREATE TABLE artist (
    ArtistId INT PRIMARY KEY,
    Name VARCHAR(255)
);

-- Album Table
CREATE TABLE album (
    AlbumId INT PRIMARY KEY,
    Title VARCHAR(255),
    ArtistId INT,
    FOREIGN KEY (ArtistId) REFERENCES artist(ArtistId)
);

-- Genre Table
CREATE TABLE genre (
    GenreId INT PRIMARY KEY,
    Name VARCHAR(255)
);

-- Media Type Table
CREATE TABLE media_type (
    MediaTypeId INT PRIMARY KEY,
    Name VARCHAR(255)
);

-- Track Table
CREATE TABLE track (
    TrackId INT PRIMARY KEY,
    Name VARCHAR(255),
    AlbumId INT,
    MediaTypeId INT,
    GenreId INT,
    Composer VARCHAR(255),
    Milliseconds INT,
    Bytes INT,
    UnitPrice DECIMAL(10,2),
    FOREIGN KEY (AlbumId) REFERENCES album(AlbumId),
    FOREIGN KEY (MediaTypeId) REFERENCES media_type(MediaTypeId),
    FOREIGN KEY (GenreId) REFERENCES genre(GenreId)
);

-- Employee Table
CREATE TABLE employee (
    EmployeeId INT PRIMARY KEY,
    LastName VARCHAR(50),
    FirstName VARCHAR(50),
    Title VARCHAR(100),
    ReportsTo INT,
    BirthDate VARCHAR(50),
    HireDate VARCHAR(50),
    Address VARCHAR(255),
    City VARCHAR(100),
    State VARCHAR(100),
    Country VARCHAR(100),
    PostalCode VARCHAR(20),
    Phone VARCHAR(50),
    Fax VARCHAR(50),
    Email VARCHAR(100)
);

-- Customer Table
CREATE TABLE customer (
    CustomerId INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Company VARCHAR(255),
    Address VARCHAR(255),
    City VARCHAR(100),
    State VARCHAR(100),
    Country VARCHAR(100),
    PostalCode VARCHAR(20),
    Phone VARCHAR(50),
    Fax VARCHAR(50),
    Email VARCHAR(100),
    SupportRepId INT,
    FOREIGN KEY (SupportRepId) REFERENCES employee(EmployeeId)
);

-- Invoice Table
CREATE TABLE invoice (
    InvoiceId INT PRIMARY KEY,
    CustomerId INT,
    InvoiceDate DATETIME,
    BillingAddress VARCHAR(255),
    BillingCity VARCHAR(100),
    BillingState VARCHAR(100),
    BillingCountry VARCHAR(100),
    BillingPostalCode VARCHAR(20),
    Total DECIMAL(10,2),
    FOREIGN KEY (CustomerId) REFERENCES customer(CustomerId)
);

-- Invoice Line Table
CREATE TABLE invoice_line (
    InvoiceLineId INT PRIMARY KEY,
    InvoiceId INT,
    TrackId INT,
    UnitPrice DECIMAL(10,2),
    Quantity INT,
    FOREIGN KEY (InvoiceId) REFERENCES invoice(InvoiceId),
    FOREIGN KEY (TrackId) REFERENCES track(TrackId)
);

-- Playlist Table
CREATE TABLE playlist (
    PlaylistId INT PRIMARY KEY,
    Name VARCHAR(255)
);

-- Playlist Track Table
CREATE TABLE playlist_track (
    PlaylistId INT,
    TrackId INT,
    PRIMARY KEY (PlaylistId, TrackId),
    FOREIGN KEY (PlaylistId) REFERENCES playlist(PlaylistId),
    FOREIGN KEY (TrackId) REFERENCES track(TrackId)
);

-- ========================================
-- Data Import using LOAD DATA INFILE
-- ========================================

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/artist.csv'
INTO TABLE artist
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/album.csv'
INTO TABLE album
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/genre.csv'
INTO TABLE genre
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/media_type.csv'
INTO TABLE media_type
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/employee.csv'
INTO TABLE employee
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@EmployeeId, @LastName, @FirstName, @Title, @ReportsTo, @Levels, @BirthDate, @HireDate,
 @Address, @City, @State, @Country, @PostalCode, @Phone, @Fax, @Email)
SET
EmployeeId = @EmployeeId,
LastName = @LastName,
FirstName = @FirstName,
Title = @Title,
ReportsTo = NULLIF(@ReportsTo,''),
BirthDate = @BirthDate,
HireDate = @HireDate,
Address = @Address,
City = @City,
State = @State,
Country = @Country,
PostalCode = @PostalCode,
Phone = @Phone,
Fax = @Fax,
Email = @Email;
 


LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/customer.csv'
INTO TABLE customer
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/track.csv'
INTO TABLE track
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/invoice.csv'
INTO TABLE invoice
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/invoice_line.csv'
INTO TABLE invoice_line
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/playlist.csv'
INTO TABLE playlist
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/playlist_track.csv'
INTO TABLE playlist_track
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

