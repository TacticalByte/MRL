CREATE DATABASE MRL
GO
USE MRL
GO
/*Base account data*/
CREATE SCHEMA BAD
GO
/*Base player data*/
CREATE SCHEMA BPD  
GO
/*Base League data*/
CREATE SCHEMA BLD
GO
/*Base Game data*/
CREATE SCHEMA BGD
GO
/*Base History Data*/
Create SCHEMA BHD
GO
/*Creating BGD tables*/
CREATE TABLE BGD.IngamePilots(
    IngamePilotID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [Name] NVARCHAR(100) NOT NULL,
    Picture NVARCHAR(300) NULL,
    [Status] VARCHAR(10) NOT NULL, -- Active, Inactive, Banned, etc
    CreationDate DATETIME NOT NULL DEFAULT GETDATE(),
    CreatedBy NVARCHAR(100) NOT NULL DEFAULT USER_NAME(),
    ModificationDate DATETIME NULL,
    ModifiedBy NVARCHAR(100) NULL
)
CREATE TABLE BGD.Mechas(
    MechaID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [Name] NVARCHAR(100) NOT NULL,
    Picture NVARCHAR(300) NULL,
    [Status] VARCHAR(10) NOT NULL,
    -- Active, Inactive, Banned, etc
    CreationDate DATETIME NOT NULL DEFAULT GETDATE(),
    CreatedBy NVARCHAR(100) NOT NULL DEFAULT USER_NAME(),
    ModificationDate DATETIME NULL,
    ModifiedBy NVARCHAR(100) NULL
)
CREATE TABLE BGD.Ranks(
    RankID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [Name] NVARCHAR(100) NOT NULL,
    Picture NVARCHAR(300) NULL,
    [Status] VARCHAR(10) NOT NULL,-- Active, Inactive, Banned, etc
    CreationDate DATETIME NOT NULL DEFAULT GETDATE(),
    CreatedBy NVARCHAR(100) NOT NULL DEFAULT USER_NAME(),
    ModificationDate DATETIME NULL,
    ModifiedBy NVARCHAR(100) NULL
)
GO
/*Creating BLD tables*/
CREATE TABLE BLD.Provinces(
    PronviceID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [Name] NVARCHAR(100) NOT NULL,
    RMLWeeklyPoints INT NOT NULL DEFAULT 100,
    RMLAccumulatedPoints INT NOT NULL DEFAULT 0,
    CreationDate DATETIME NOT NULL DEFAULT GETDATE(),
    CreatedBy NVARCHAR(100) NOT NULL DEFAULT USER_NAME(),
    ModificationDate DATETIME NULL,
    ModifiedBy NVARCHAR(100) NULL
)
GO
/*Creating BAD Tables*/
CREATE TABLE BAD.UserType(
    UserTypeID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    UserType NVARCHAR(100) NOT NULL,
    CreationDate DATETIME NOT NULL DEFAULT GETDATE(),
    CreatedBy NVARCHAR(100) NOT NULL DEFAULT USER_NAME(),
    ModificationDate DATETIME NULL,
    ModifiedBy NVARCHAR(100) NULL
)
CREATE TABLE BAD.Memberships(
    MembershipID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [Name] NVARCHAR(50) NOT NULL,
    Price MONEY NOT NULL,
    Discount DECIMAL(2,1) NOT NULL DEFAULT 0.0,
    [Status] VARCHAR(10) NOT NULL, -- Active, Inactive, etc
    CreationDate DATETIME NOT NULL DEFAULT GETDATE(),
    CreatedBy NVARCHAR(100) NOT NULL DEFAULT USER_NAME(),
    ModificationDate DATETIME NULL,
    ModifiedBy NVARCHAR(100) NULL
)
CREATE TABLE BAD.MembershipPerks(
    PerkID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    MembershipID INT NOT NULL,
    [Name] NVARCHAR(50) NOT NULL,
    [Description] NVARCHAR(MAX) NOT NULL,
    PerkKey VARCHAR(50) NOT NULL,
    PerkValue VaRCHAR(50) NOT NULL,
    [Status] VARCHAR(10) NOT NULL, -- Active, Inactive, etc
    CreationDate DATETIME NOT NULL DEFAULT GETDATE(),
    CreatedBy NVARCHAR(100) NOT NULL DEFAULT USER_NAME(),
    ModificationDate DATETIME NULL,
    ModifiedBy NVARCHAR(100) NULL,
    CONSTRAINT FK_Membership FOREIGN KEY(MembershipID) REFERENCES BAD.Memberships(MembershipID)
)
CREATE TABLE BAD.UserTypeGrants(
    GrantID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    UserTypeID INT NOT NULL,
    GrantKey VARCHAR(50) NOT NULL,
    GrantValue VARCHAR(50) NOT NULL,
    CreationDate DATETIME NOT NULL DEFAULT GETDATE(),
    CreatedBy NVARCHAR(100) NOT NULL DEFAULT USER_NAME(),
    ModificationDate DATETIME NULL,
    ModifiedBy NVARCHAR(100) NULL,
    CONSTRAINT FK_UserType FOREIGN KEY (UserTypeID) REFERENCES BAD.UserType(UserTypeID)
)
GO
/*Creating BPD tables*/
CREATE TABLE BPD.Clans(
    ClanID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    [Name] NVARCHAR(100) NOT NULL,
    Picture NVARCHAR(300) NULL,
    [Status] VARCHAR(10) NOT NULL, -- Active, Inactive, Banned.
    RMLFamePoints INT NOT NULL DEFAULT 0,
    RegisterDate DATETIME NOT NULL DEFAULT GETDATE(),
    CreationDate DATETIME NOT NULL DEFAULT GETDATE(),
    CreatedBy NVARCHAR(100) NOT NULL DEFAULT USER_NAME(),
    ModificationDate DATETIME NULL,
    ModifiedBy NVARCHAR(100) NULL
)
CREATE TABLE BAD.Accounts(
    AccountID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    FirstName NVARCHAR(100) NOT NULL,
    LastName NVARCHAR(100) NOT NULL,
    BirthDate DATETIME NOT NULL,
    Email NVARCHAR(300) NOT NULL,
    [Password] NVARCHAR(MAX) NOT NULL,
    FacebookAccount NVARCHAR(300) NULL,
    TwitterAccount NVARCHAR(300) NULL,
    DiscordAccount NVARCHAR(300) NULL,
    YoutubeAccount NVARCHAR(300) NULL,
    SteamAccount NVARCHAR(300) NULL,
    [Status] VARCHAR(10) NOT NULL,    -- Active, Inactive, Banned, etc
    IsValidated BIT NOT NULL DEFAULT 0,
    UserTypeID INT NOT NULL,
    MembershipID INT NOT NULL,
    CreationDate DATETIME NOT NULL DEFAULT GETDATE(),
    CreatedBy NVARCHAR(100) NOT NULL DEFAULT USER_NAME(),
    ModificationDate DATETIME NULL,
    ModifiedBy NVARCHAR(100) NULL,
    CONSTRAINT FK_MembershipActive FOREIGN KEY (MembershipID) REFERENCES BAD.Memberships(MembershipID),
    CONSTRAINT FK_UserTypeID FOREIGN KEY (UserTypeID) REFERENCES BAD.UserType(UserTypeID)
)
CREATE TABLE BAD.MembershipReceipts(
    ReceiptID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    AccountID INT NOT NULL,
    MembershipID INT NOT NULL,
    CreationDate DATETIME NOT NULL DEFAULT GETDATE(),
    CreatedBy NVARCHAR(100) NOT NULL DEFAULT USER_NAME(),
    ModificationDate DATETIME NULL,
    ModifiedBy NVARCHAR(100) NULL,
    CONSTRAINT FK_Account FOREIGN KEY (AccountID) REFERENCES BAD.Accounts(AccountID),
    CONSTRAINT FK_HeaderMembership FOREIGN KEY (MembershipID) REFERENCES BAD.Memberships(MembershipID)
)
CREATE TABLE BPD.PlayerAccount(
    PlayerAccountID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    AccountID INT,
    SMCID VARCHAR(20) NOT NULL,
    Picture NVARCHAR(300) NULL,
    [Status] VARCHAR(10) NOT NULL,    -- Active, Inactive, Banned, etc
    SMCRank NVARCHAR(20) NOT NULL,
    Divition VARCHAR(10) NOT NULL DEFAULT 'MOBILE',
    MainMecha1 INT NOT NULL,
    MainMecha2 INT NOT NULL,
    MainMecha3 INT NOT NULL,
    MainPilot INT NOT NULL,
    ClanID INT NULL,
    ClanTitle NVARCHAR(50) NULL,
    RMLFamePoints INT NOT NULL DEFAULT 0,
    RMLPassActive BIT NOT NULL DEFAULT 0,
    RMLTitle NVARCHAR(100) NOT NULL DEFAULT 'NEW PILOT',
    CreationDate DATETIME NOT NULL DEFAULT GETDATE(),
    CreatedBy NVARCHAR(100) NOT NULL DEFAULT USER_NAME(),
    ModificationDate DATETIME NULL,
    ModifiedBy NVARCHAR(100) NULL,
    CONSTRAINT FK_MainAccountID FOREIGN KEY (AccountID) REFERENCES BAD.Accounts(AccountID),
    CONSTRAINT FK_Mecha1 FOREIGN KEY (MainMecha1) REFERENCES BGD.Mechas(MechaID),
    CONSTRAINT FK_Mecha2 FOREIGN KEY (MainMecha2) REFERENCES BGD.Mechas(MechaID),
    CONSTRAINT FK_Mecha3 FOREIGN KEY (MainMecha3) REFERENCES BGD.Mechas(MechaID),
    CONSTRAINT FK_Pilot FOREIGN KEY (MainPilot) REFERENCES BGD.IngamePilots(IngamePilotID)
)
CREATE TABLE BPD.ClanPilotInfo(
    ClanInfoID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    ClanID INT NOT NULL,
    PlayerAccountID INT NOT NULL,
    [Status] VARCHAR(10) NOT NULL,
    -- Active, Inactive, Banned, etc
    ClanMemberTitle NVARCHAR(100) NOT NULL,
    IsOwner BIT NOT NULL DEFAULT 0,
    IsFounder BIT NOT NULL DEFAULT 0,
    CreationDate DATETIME NOT NULL DEFAULT GETDATE(),
    CreatedBy NVARCHAR(100) NOT NULL DEFAULT USER_NAME(),
    ModificationDate DATETIME NULL,
    ModifiedBy NVARCHAR(100) NULL,
    CONSTRAINT FK_ClanID FOREIGN KEY (ClanID) REFERENCES BPD.Clans(ClanID),
    CONSTRAINT FK_PlayerAccountID FOREIGN KEY (PlayerAccountID) REFERENCES BPD.PlayerAccount(PlayerAccountID)
)
CREATE TABLE BLD.Seasons(
    SeasonID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    SeasonName NVARCHAR(100) NOT NULL,
    SeasonMode VARCHAR(100) NOT NULL ,
    StartDate DATETIME NOT NULL DEFAULT GETDATE(),
    EndDate DATETIME NOT NULL,
    ClanWinner INT NOT NULL,
    PlayerAccountMVP INT NOT NULL,
    CreationDate DATETIME NOT NULL DEFAULT GETDATE(),
    CreatedBy NVARCHAR(100) NOT NULL DEFAULT USER_NAME(),
    ModificationDate DATETIME NULL,
    ModifiedBy NVARCHAR(100) NULL,
    CONSTRAINT FK_ClanID FOREIGN KEY (ClanWinner) REFERENCES BPD.Clans(ClanID),
    CONSTRAINT FK_PilotMVP FOREIGN KEY (PlayerAccountMVP) REFERENCES BPD.PlayerAccount(PlayerAccountID)
)
GO
/*Creating BHD Tables*/
CREATE TABLE BHD.AccountHistory(
    AccountHistoryID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    AccountID INT,
    FirstName NVARCHAR(100) NOT NULL,
    LastName NVARCHAR(100) NOT NULL,
    BirthDate DATETIME NOT NULL,
    Email NVARCHAR(300) NOT NULL,
    [Password] NVARCHAR(MAX) NOT NULL,
    FacebookAccount NVARCHAR(300) NULL,
    TwitterAccount NVARCHAR(300) NULL,
    DiscordAccount NVARCHAR(300) NULL,
    YoutubeAccount NVARCHAR(300) NULL,
    SteamAccount NVARCHAR(300) NULL,
    [Status] VARCHAR(10) NOT NULL,    -- Active, Inactive, Banned, etc
    IsValidated BIT NOT NULL DEFAULT 0,
    UserTypeID INT NOT NULL,
    MembershipID INT NOT NULL,
    CreationDate DATETIME NOT NULL DEFAULT GETDATE(),
    CreatedBy NVARCHAR(100) NOT NULL DEFAULT USER_NAME(),
    ModificationDate DATETIME NULL,
    ModifiedBy NVARCHAR(100) NULL
)
CREATE TABLE BHD.PlayerAccountHistory(
    PlayerAccountHistoryID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    PlayerAccountID INT,
    AccountID INT,
    SMCID VARCHAR(20) NOT NULL,
    Picture NVARCHAR(300) NULL,
    [Status] VARCHAR(10) NOT NULL,    -- Active, Inactive, Banned, etc
    SMCRank NVARCHAR(20) NOT NULL,
    Divition VARCHAR(10) NOT NULL DEFAULT 'MOBILE',
    MainMecha1 INT NOT NULL,
    MainMecha2 INT NOT NULL,
    MainMecha3 INT NOT NULL,
    MainPilot INT NOT NULL,
    ClanID INT NULL,
    ClanTitle NVARCHAR(50) NULL,
    RMLFamePoints INT NOT NULL DEFAULT 0,
    RMLPassActive BIT NOT NULL DEFAULT 0,
    RMLTitle NVARCHAR(100) NOT NULL DEFAULT 'NEW PILOT',
    CreationDate DATETIME NOT NULL DEFAULT GETDATE(),
    CreatedBy NVARCHAR(100) NOT NULL DEFAULT USER_NAME(),
    ModificationDate DATETIME NULL,
    ModifiedBy NVARCHAR(100) NULL
)
CREATE TABLE BHD.ClansHistory(
    ClanHistoryID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    ClanID INT NOT NULL,
    [Name] NVARCHAR(100) NOT NULL,
    Picture NVARCHAR(300) NULL,
    [Status] VARCHAR(10) NOT NULL,
    -- Active, Inactive, Banned, etc
    RMLFamePoints INT NOT NULL DEFAULT 0,
    RegisterDate DATETIME NOT NULL DEFAULT GETDATE(),
    CreationDate DATETIME NOT NULL DEFAULT GETDATE(),
    CreatedBy NVARCHAR(100) NOT NULL DEFAULT USER_NAME(),
    ModificationDate DATETIME NULL,
    ModifiedBy NVARCHAR(100) NULL
)
CREATE TABLE BHD.ClanPilotInfoHistory(
    ClanPilotInfoHistoryID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    ClanInfoID INT,
    ClanID INT NOT NULL,
    PlayerAccountID INT NOT NULL,
    [Status] VARCHAR(10) NOT NULL,
    ClanMemberTitle NVARCHAR(100) NOT NULL,
    IsOwner BIT NOT NULL DEFAULT 0,
    IsFounder BIT NOT NULL DEFAULT 0,
    CreationDate DATETIME NOT NULL DEFAULT GETDATE(),
    CreatedBy NVARCHAR(100) NOT NULL DEFAULT USER_NAME(),
    ModificationDate DATETIME NULL,
    ModifiedBy NVARCHAR(100) NULL
)
CREATE TABLE BHD.SeasonsHistory(
    SeasonHistoryID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    SeasonID INT,
    SeasonName NVARCHAR(100) NOT NULL,
    SeasonMode VARCHAR(100) NOT NULL ,
    StartDate DATETIME NOT NULL DEFAULT GETDATE(),
    EndDate DATETIME NOT NULL,
    ClanWinner INT NOT NULL,
    PlayerAccountMVP INT NOT NULL,
    CreationDate DATETIME NOT NULL DEFAULT GETDATE(),
    CreatedBy NVARCHAR(100) NOT NULL DEFAULT USER_NAME(),
    ModificationDate DATETIME NULL,
    ModifiedBy NVARCHAR(100) NULL
)
CREATE TABLE BHD.UserTypeHistory(
    UserTypeHistoryID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    UserTypeID INT,
    UserType NVARCHAR(100) NOT NULL,
    CreationDate DATETIME NOT NULL DEFAULT GETDATE(),
    CreatedBy NVARCHAR(100) NOT NULL DEFAULT USER_NAME(),
    ModificationDate DATETIME NULL,
    ModifiedBy NVARCHAR(100) NULL
)
CREATE TABLE BHD.UserTypeGrantsHistory(
    UserTypeGrantHistoryID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    GrantID INT,
    UserTypeID INT NOT NULL,
    GrantKey VARCHAR(50) NOT NULL,
    GrantValue VARCHAR(50) NOT NULL,
    CreationDate DATETIME NOT NULL DEFAULT GETDATE(),
    CreatedBy NVARCHAR(100) NOT NULL DEFAULT USER_NAME(),
    ModificationDate DATETIME NULL,
    ModifiedBy NVARCHAR(100) NULL
)
CREATE TABLE BHD.MembershipsHistory(
    MembershipHistoryID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    MembershipID INT,
    [Name] NVARCHAR(50) NOT NULL,
    Price MONEY NOT NULL,
    Discount DECIMAL(2,1) NOT NULL DEFAULT 0.0,
    [Status] VARCHAR(10) NOT NULL, -- Active, Inactive, etc
    CreationDate DATETIME NOT NULL DEFAULT GETDATE(),
    CreatedBy NVARCHAR(100) NOT NULL DEFAULT USER_NAME(),
    ModificationDate DATETIME NULL,
    ModifiedBy NVARCHAR(100) NULL
)
CREATE TABLE BHD.MerbershipPerksHistory(
    MembershipPerkHistoryID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    PerkID INT,
    MembershipID INT NOT NULL,
    [Name] NVARCHAR(50) NOT NULL,
    [Description] NVARCHAR(MAX) NOT NULL,
    PerkKey VARCHAR(50) NOT NULL,
    PerkValue VaRCHAR(50) NOT NULL,
    [Status] VARCHAR(10) NOT NULL, -- Active, Inactive, etc
    CreationDate DATETIME NOT NULL DEFAULT GETDATE(),
    CreatedBy NVARCHAR(100) NOT NULL DEFAULT USER_NAME(),
    ModificationDate DATETIME NULL,
    ModifiedBy NVARCHAR(100) NULL,
)
GO


-- /*Dropping database*/
-- USE MASTER
-- GO
-- DROP DATABASE MRL