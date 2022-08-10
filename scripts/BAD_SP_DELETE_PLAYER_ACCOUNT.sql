USE MRL
GO
IF OBJECT_ID('BAD.SP_DELETE_PLAYER_ACCOUNT') IS NOT NULL
    BEGIN
        DROP PROCEDURE BAD.SP_DELETE_PLAYER_ACCOUNT
    END
GO
CREATE PROCEDURE BAD.SP_DELETE_PLAYER_ACCOUNT @PlayerAccountID INT, @ModificationDate DATETIME,@ModifiedBy NVARCHAR(100)
AS
BEGIN
    DECLARE @ErrorMessage NVARCHAR(MAX)
    DECLARE @PlayerAccountExists INT = 0 

    BEGIN TRY

        IF @ModificationDate IS NULL
            BEGIN
                SET @ModificationDate = GETDATE()
            END
        IF @ModifiedBy IS NULL
            BEGIN
                SET @ModifiedBy = USER_NAME()
            END
    
        SELECT
            @PlayerAccountExists = COUNT(1)
        FROM BPD.PlayerAccount
        WHERE PlayerAccountID = @PlayerAccountID

        IF @PlayerAccountExists > 0
            BEGIN
                INSERT INTO BHD.PlayerAccountHistory(
                            PlayerAccountID,AccountID,SMCID,Picture,[Status],SMCRank,Divition,
                            MainMecha1,MainMecha2,MainMecha3,MainPilot,
                            ClanID,ClanTitle,RMLFamePoints,RMLPassActive,
                            RMLTitle,CreationDate,CreatedBy,ModificationDate,ModifiedBy)
                SELECT
                PlayerAccountID,AccountID,SMCID,Picture,[Status],SMCRank,Divition,
                MainMecha1,MainMecha2,MainMecha3,MainPilot,
                ClanID,ClanTitle,RMLFamePoints,RMLPassActive,
                RMLTitle,CreationDate,CreatedBy,@ModificationDate,@ModifiedBy
                FROM BPD.PlayerAccount
                WHERE PlayerAccountID = @PlayerAccountID

                UPDATE BPD.PlayerAccount SET
                [Status] = 'DELETED'
                WHERE PlayerAccountID = @PlayerAccountID

                SELECT 
                    CONCAT('Player account with PlayerAccountID "',@PlayerAccountID,'" deleted sucessfully!') AS [MESSAGE],
                    '1' AS RESULT
            END
        ELSE
            BEGIN
                SELECT 
                    CONCAT('Player account with PlayerAccountID "',@PlayerAccountID,'" Does not exists... Aborting... ') AS [MESSAGE],
                    '0' AS RESULT
            END
    END TRY
    BEGIN CATCH
        SET @ErrorMessage = ERROR_MESSAGE()
        SELECT
            CONCAT('BAD.SP_DELETE_PLAYER_ACCOUNT: Exception => ',@ErrorMessage) AS [MESSAGE],
            '0' AS RESULT
    END CATCH
END