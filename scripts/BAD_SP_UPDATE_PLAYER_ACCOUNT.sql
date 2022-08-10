USE MRL
GO
IF OBJECT_ID('BAD.SP_UPDATE_PLAYER_ACCOUNT') IS NOT NULL
    BEGIN
        DROP PROCEDURE BAD.SP_UPDATE_PLAYER_ACCOUNT
    END
GO
CREATE PROCEDURE BAD.SP_UPDATE_PLAYER_ACCOUNT @PlayerAccountID INT, @AccountID INT,@SMCID VARCHAR(20),@Picture NVARCHAR(300),@Status VARCHAR(10),@SMCRank NVARCHAR(20),@Divition VARCHAR(10),@MainMecha1 INT,@MainMecha2 INT,@MainMecha3 INT,@MainPilot INT,@ClanID INT,@ClanTitle NVARCHAR(50),@RMLFamePoints INT,@RMLPassActive BIT,@RMLTitle NVARCHAR(100), @ModificationDate DATETIME,@ModifiedBy NVARCHAR(100)
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
                AccountID = @AccountID,
                SMCID = @SMCID,
                Picture = @Picture,
                [Status] = @Status,
                SMCRank = @SMCRank,
                Divition = @Divition,
                MainMecha1 = @MainMecha1,
                MainMecha2 = @MainMecha2,
                MainMecha3 = @MainMecha3,
                MainPilot = @MainPilot,
                ClanID = @ClanID,
                ClanTitle = @ClanTitle,
                RMLFamePoints = @RMLFamePoints,
                RMLPassActive = @RMLPassActive,
                RMLTitle = @RMLTitle,
                ModificationDate = @ModificationDate,
                ModifiedBy = @ModifiedBy
                WHERE PlayerAccountID = @PlayerAccountID

                SELECT 
                    CONCAT('Player account with PlayerAccountID "',@PlayerAccountID,'" Updated sucessfully!') AS [MESSAGE],
                    '1' AS RESULT
            END
        ELSE
            BEGIN
                SELECT 
                    CONCAT('Player account with PlayerAccountID "',@PlayerAccountID,'" does not exists. Aborting update...') AS [MESSAGE],
                    '0' AS RESULT
            END
    END TRY
    BEGIN CATCH
        SET @ErrorMessage = ERROR_MESSAGE()
        SELECT
            CONCAT('BAD.SP_UPDATE_PLAYER_ACCOUNT: Exception => ',@ErrorMessage) AS [MESSAGE],
            '0' AS RESULT
    END CATCH
END