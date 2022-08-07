USE MRL 
GO
IF OBJECT_ID('BAD.SP_CREATE_NEW_ACCOUNT') IS NOT NULL
    BEGIN
        DROP PROCEDURE  BAD.SP_CREATE_NEW_ACCOUNT
    END
GO
CREATE PROCEDURE BAD.SP_CREATE_NEW_ACCOUNT @FirstName NVARCHAR(100),@LastName NVARCHAR(100),@BirthDate DATETIME,@Email NVARCHAR(300),@Password NVARCHAR(MAX),@FacebookAccount NVARCHAR(300),@TwitterAccount NVARCHAR(300),@DiscordAccount NVARCHAR(300),@YoutubeAccount NVARCHAR(300),@SteamAccount NVARCHAR(300),@Status VARCHAR(10),@IsValidated BIT,@UserTypeID INT,@MembershipID INT,@CreationDate DATETIME,@CreatedBy NVARCHAR(100)
AS
BEGIN
    DECLARE @AccountExists INT = 0
    DECLARE @ErrorMessage NVARCHAR(MAX) 
    
    BEGIN TRY 
        SELECT 
            @AccountExists = COUNT(1)
        FROM BAD.Accounts
        WHERE Email = @Email

        IF @CreationDate IS NULL 
            BEGIN
                SET @CreationDate = GETDATE()
            END
        IF @CreatedBy IS NULL
            BEGIN
                SET @CreatedBy = USER_NAME()
            END


        IF @AccountExists = 0 
            BEGIN
                INSERT INTO BAD.Accounts(FirstName,LastName,BirthDate,Email,[Password],
                                        FacebookAccount,TwitterAccount,DiscordAccount,
                                        YoutubeAccount,SteamAccount,[Status],IsValidated,UserTypeID,
                                        MembershipID,CreationDate,CreatedBy)
                VALUES(@FirstName,@LastName,@BirthDate,@Email,@Password,
                       @FacebookAccount,@TwitterAccount,@DiscordAccount,
                       @YoutubeAccount,@SteamAccount,@Status,@IsValidated,@UserTypeID,
                       @MembershipID,@CreationDate,@CreatedBy)
                
                SELECT 
                    CONCAT('Account for "',@Email,'" created sucessfully!') AS [MESSAGE],
                    '1' AS RESULT
            END
        ELSE 
            BEGIN
                SELECT 
                    CONCAT('Account for : "',@Email,'" already exists. Aborting insertion...') AS [MESSAGE],
                    '0' AS RESULT
            END
    END TRY 
    BEGIN CATCH
        SET @ErrorMessage = ERROR_MESSAGE()
        SELECT
            CONCAT('BAD.SP_CREATE_NEW_ACCOUNT: Exception => ',@ErrorMessage) AS [MESSAGE],
            '0' AS RESULT
    END CATCH
END
GO

USE MRL
GO
EXEC BAD.SP_CREATE_NEW_ACCOUNT 'MARCOS','BARRERA','1992-10-10 00:00:00','mmbarrerae@gmail.com','asdasd',
                                NULL, NULL, NULL, 
                                NULL, NULL, 'ACTIVE',0, 1,
                                1,NULL,'mbarrera'