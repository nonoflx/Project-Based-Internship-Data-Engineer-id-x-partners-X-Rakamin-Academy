create database DWH

use DWH

drop database DWH

SELECT * FROM DimCustomer;
SELECT * FROM DimAccount;
SELECT * FROM DimBranch;
SELECT * FROM FactTransaction;

--DimCustomer
CREATE TABLE [dbo].[DimCustomer](
    [CustomerID] [int] NOT NULL,
    [CustomerName] [varchar](50) NULL,
    [Address] [varchar](max) NULL,
    [CityName] [varchar](50) NULL,
    [StateName] [varchar](50) NULL,
    [Age] [varchar](3) NULL,
    [Gender] [varchar](10) NULL,
    [Email] [varchar](50) NULL,
    CONSTRAINT [PK_CustomerID] PRIMARY KEY CLUSTERED 
    (
        [CustomerID] ASC
    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF,
           IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
           ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

--DimAccount
CREATE TABLE [dbo].[DimAccount](
    [AccountID] [int] NOT NULL,
    [CustomerID] [int] NULL,
    [AccountType] [varchar](10) NULL,
    [Balance] [int] NULL,
    [DateOpened] [datetime2](0) NULL,
    [Status] [varchar](10) NULL,
    CONSTRAINT [PK_Account] PRIMARY KEY CLUSTERED 
    (
        [AccountID] ASC
    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF,
           ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON,
           OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[DimAccount] WITH CHECK ADD CONSTRAINT [FK_CustomerID] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[DimCustomer] ([CustomerID])
GO

ALTER TABLE [dbo].[DimAccount] CHECK CONSTRAINT [FK_CustomerID]
GO

--DimBranch
CREATE TABLE [dbo].[DimBranch](
    [BranchID] [int] NOT NULL,
    [BranchName] [varchar](50) NULL,
    [BranchLocation] [varchar](50) NULL,
    CONSTRAINT [PK_Branch] PRIMARY KEY CLUSTERED 
    (
        [BranchID] ASC
    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF,
           IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
           ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

--FactTransasction
CREATE TABLE [dbo].[FactTransaction](
    [TransactionID] [int] NOT NULL,
    [AccountID] [int] NULL,
    [TransactionDate] [datetime2](0) NULL,
    [Amount] [int] NULL,
    [TransactionType] [varchar](50) NULL,
    [BranchID] [int] NULL,
    CONSTRAINT [PK_Transaction] PRIMARY KEY CLUSTERED 
    (
        [TransactionID] ASC
    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF,
           IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
           ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[FactTransaction] WITH CHECK ADD CONSTRAINT [FK_Account] FOREIGN KEY([AccountID])
REFERENCES [dbo].[DimAccount] ([AccountID])
GO

ALTER TABLE [dbo].[FactTransaction] CHECK CONSTRAINT [FK_Account]
GO

ALTER TABLE [dbo].[FactTransaction] WITH CHECK ADD CONSTRAINT [FK_Branch] FOREIGN KEY([BranchID])
REFERENCES [dbo].[DimBranch] ([BranchID])
GO

ALTER TABLE [dbo].[FactTransaction] CHECK CONSTRAINT [FK_Branch]
GO