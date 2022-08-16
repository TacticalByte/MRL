USE MRL 
GO
IF OBJECT_ID('BAD.SP_UPDATE_ACCOUNT') IS NOT NULL
    BEGIN
        DROP PROCEDURE BAD.SP_UPDATE_ACCOUNT
    END
GO
CREATE PROCEDURE BAD.SP_UPDATE_ACCOUNT @AccountID INT,@FirstName NVARCHAR(100),@LastName NVARCHAR(100),@BirthDate DATETIME,@Email NVARCHAR(300),@Password NVARCHAR(MAX),@FacebookAccount NVARCHAR(300),@TwitterAccount NVARCHAR(300),@DiscordAccount NVARCHAR(300),@YoutubeAccount NVARCHAR(300),@SteamAccount NVARCHAR(300),@Status VARCHAR(10),@IsValidated BIT,@UserTypeID INT,@MembershipID INT,@ModificationDate DATETIME,@ModifiedBy NVARCHAR(100)
AS
BEGIN
    DECLARE @AccountExists INT = 0
    DECLARE @ErrorMessage NVARCHAR(MAX)

    BEGIN TRY
        SELECT 
            @AccountExists = COUNT(1)
        FROM BAD.Accounts
        WHERE AccountID = @AccountID
    
    IF @ModificationDate IS NULL 
        BEGIN
            SET @ModificationDate = GETDATE();
        END
    IF @ModifiedBy IS NULL
        BEGIN
            SET @ModifiedBy = USER_NAME()
        END
    
    IF @AccountExists > 0
        BEGIN
            INSERT INTO BHD.AccountHistory(
                AccountID,FirstName,LastName,BirthDate,Email,[Password],
                FacebookAccount,TwitterAccount,DiscordAccount,YoutubeAccount,SteamAccount,
                [Status],IsValidated,UserTypeID,MembershipID,CreationDate,CreatedBy
            )
            SELECT
            AccountID,FirstName,LastName,BirthDate,Email,[Password],
            FacebookAccount,TwitterAccount,DiscordAccount,YoutubeAccount,SteamAccount,
            [Status],IsValidated,UserTypeID,MembershipID,@ModificationDate,@ModifiedBy
            FROM BAD.Accounts
            WHERE AccountID = @AccountID

            UPDATE BAD.Accounts SET
            FirstName = @FirstName,
            LastName = @LastName,
            BirthDate = @BirthDate,
            Email = @Email,
            [Password] = @Password,
            FacebookAccount = @FacebookAccount,
            TwitterAccount = @TwitterAccount,
            DiscordAccount = @DiscordAccount,
            YoutubeAccount = @YoutubeAccount,
            SteamAccount = @SteamAccount,
            [Status] = @Status,
            IsValidated = @IsValidated,
            UserTypeID = @UserTypeID,
            MembershipID = @MembershipID,
            ModificationDate = @ModificationDate,
            ModifiedBy = @ModifiedBy
            WHERE AccountID = @AccountID

            SELECT 
                    CONCAT('Account ID: "',@AccountId,'" updated sucessfully!') AS [MESSAGE],
                    '1' AS RESULT

        END
    ELSE
        BEGIN  SELECT 
                    CONCAT('Account ID: "',@AccountId,'" does not exists. Abort update...') AS [MESSAGE],
                    '0' AS RESULT
        END

    END TRY
    BEGIN CATCH
        SET @ErrorMessage = ERROR_MESSAGE()
        SELECT
            CONCAT('BAD.SP_UPDATE_ACCOUNT: Exception => ',@ErrorMessage) AS [MESSAGE],
            '0' AS RESULT
    END CATCH
END
