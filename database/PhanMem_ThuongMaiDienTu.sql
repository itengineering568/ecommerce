
-- ================================
-- CƠ SỞ DỮ LIỆU CHO PHẦN MỀM TMĐT
-- ================================

-- 1. Bảng Users
CREATE TABLE Users (
    UserId UNIQUEIDENTIFIER PRIMARY KEY DEFAULT NEWID(),
    UserName NVARCHAR(100) NOT NULL,
    PasswordHash NVARCHAR(255) NOT NULL,
    Email NVARCHAR(255),
    Role NVARCHAR(50) CHECK (Role IN ('Admin', 'Customer')),
    CreatedAt DATETIME DEFAULT GETDATE()
);

-- 2. Bảng Customers
CREATE TABLE Customers (
    CustomerId INT IDENTITY(1,1) PRIMARY KEY,
    UserId UNIQUEIDENTIFIER UNIQUE FOREIGN KEY REFERENCES Users(UserId),
    FullName NVARCHAR(100) NOT NULL,
    Phone NVARCHAR(20),
    Address NVARCHAR(255),
    City NVARCHAR(100),
    Country NVARCHAR(100)
);

-- 3. Bảng Categories
CREATE TABLE Categories (
    CategoryId INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(255)
);

-- 4. Bảng Products
CREATE TABLE Products (
    ProductId INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(200) NOT NULL,
    Description NVARCHAR(MAX),
    Price DECIMAL(18, 2) NOT NULL,
    Stock INT NOT NULL,
    ImageUrl NVARCHAR(255),
    CategoryId INT FOREIGN KEY REFERENCES Categories(CategoryId),
    CreatedAt DATETIME DEFAULT GETDATE()
);

-- 5. Bảng Carts
CREATE TABLE Carts (
    CartId INT IDENTITY(1,1) PRIMARY KEY,
    CustomerId INT FOREIGN KEY REFERENCES Customers(CustomerId),
    CreatedAt DATETIME DEFAULT GETDATE()
);

-- 6. Bảng CartItems
CREATE TABLE CartItems (
    CartItemId INT IDENTITY(1,1) PRIMARY KEY,
    CartId INT FOREIGN KEY REFERENCES Carts(CartId),
    ProductId INT FOREIGN KEY REFERENCES Products(ProductId),
    Quantity INT NOT NULL
);

-- 7. Bảng Orders
CREATE TABLE Orders (
    OrderId INT IDENTITY(1,1) PRIMARY KEY,
    CustomerId INT FOREIGN KEY REFERENCES Customers(CustomerId),
    OrderDate DATETIME DEFAULT GETDATE(),
    TotalAmount DECIMAL(18, 2) NOT NULL,
    Status NVARCHAR(50) DEFAULT 'Pending'
);

-- 8. Bảng OrderDetails
CREATE TABLE OrderDetails (
    OrderDetailId INT IDENTITY(1,1) PRIMARY KEY,
    OrderId INT FOREIGN KEY REFERENCES Orders(OrderId),
    ProductId INT FOREIGN KEY REFERENCES Products(ProductId),
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(18, 2) NOT NULL
);
