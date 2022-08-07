USE MRL 
GO
CREATE PROCEDURE BAD.SP_AUTENTICATE_ACCOUNT @Email NVARCHAR(300), @Password NVARCHAR(MAX)
AS
BEGIN
    DECLARE @ErrorMessage NVARCHAR(MAX) 
    DECLARE @AccountID INT 
    DECLARE @UserTypeID INT 
    DECLARE @MembershipID INT
    
    BEGIN TRY 
        SELECT 
            @AccountID = AccountId,
            @UserTypeID = UserTypeID,
            
        FROM BAD.Accounts
        WHERE Email = @Email
        AND [Password] = @Password
        
            IF @AccountID > 0 
                BEGIN
                    /*RML Affiliation Account information*/
                    SELECT 
                        @AccountID,
                        FirstName, LastName, BirthDate, Email,
                        MobilePilotID, SteamPilotID, FacebookAccount, TwitterAccount, 
                        DiscordAccount, YoutubeAccount, SteamAccount, [Status],
                        IsValidated, UserTypeID, MembershipID CreationDate
                    FROM BAD.Accounts
                    WHERE Email = @Email
                    AND [Password] = @Password

                    /*Player Account information*/
                    SELECT 
                        SMCID, Picture, [Status], SMCRank,
                        Divition, MainMecha1, MainMecha2, MainMecha3,
                        MainPilot, ClanID, ClanTitle, RMLFamePoints,
                        RMLPassActive, RMLTitle, CreationDate
                    FROM  BPD.PlayerAccount 
                    WHERE AccountID = @AccountID

                    /*UserType Information*/
                    SELECT
                        UserTypeID, UserType, CreationDate
                    FROM BAD.UserType
                    WHERE UserTypeID = @UserTypeID

                    /*UserTypeGrants Information*/
                    SELECT 
                        GrantID, UserTypeID, GrantKey, GrantValue, CreationDate
                    FROM BAD.UserTypeGrants
                    WHERE UserTypeID = @UserTypeID

                    /*Membership Data*/
                    SELECT 


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