USE MRL
GO
IF OBJECT_ID('BAD.SP_CREATE_PLAYER_ACCOUNT') IS NOT NULL
    BEGIN
        DROP PROCEDURE BAD.SP_CREATE_PLAYER_ACCOUNT
    END
GO
CREATE PROCEDURE BAD.SP_CREATE_PLAYER_ACCOUNT @AccountID INT,@SMCID VARCHAR(20),@Picture NVARCHAR(300),@Status VARCHAR(10),@SMCRank NVARCHAR(20),@Divition VARCHAR(10),@MainMecha1 INT,@MainMecha2 INT,@MainMecha3 INT,@MainPilot INT,@ClanID INT,@ClanTitle NVARCHAR(50),@RMLFamePoints INT,@RMLPassActive BIT,@RMLTitle NVARCHAR(100),@CreationDate DATETIME,@CreatedBy NVARCHAR(100)
AS
BEGIN
    DECLARE @ErrorMessage NVARCHAR(MAX)
    DECLARE @PlayerAccountExists INT = 0 

    BEGIN TRY

        IF @CreationDate IS NULL
            BEGIN
                SET @CreationDate = GETDATE()
            END
        IF @CreatedBy IS NULL
            BEGIN
                SET @CreatedBy = USER_NAME()
            END
    
        SELECT
            @PlayerAccountExists = COUNT(1)
        FROM BPD.PlayerAccount
        WHERE SMCID = @SMCID

        IF @PlayerAccountExists = 0
            BEGIN
                INSERT INTO BPD.PlayerAccount(AccountID,SMCID,Picture,[Status],SMCRank,Divition,
                                                MainMecha1,MainMecha2,MainMecha3,MainPilot,
                                                ClanID,ClanTitle,RMLFamePoints,RMLPassActive,
                                                RMLTitle,CreationDate,CreatedBy)
                                        VALUES(@AccountID,@SMCID,@Picture,@Status,@SMCRank,@Divition,
                                                @MainMecha1,@MainMecha2,@MainMecha3,@MainPilot,@ClanID,
                                                @ClanTitle,@RMLFamePoints,@RMLPassActive,
                                                @RMLTitle,@CreationDate,@CreatedBy)

                SELECT 
                    CONCAT('Player account for SMCID "',@SMCID,'" created sucessfully!') AS [MESSAGE],
                    '1' AS RESULT
            END
        ELSE
            BEGIN
                SELECT 
                    CONCAT('Player account for SMCID "',@SMCID,'" already exists. Aborting insertion...') AS [MESSAGE],
                    '0' AS RESULT
            END
    END TRY
    BEGIN CATCH
        SET @ErrorMessage = ERROR_MESSAGE()
        SELECT
            CONCAT('BAD.SP_CREATE_PLAYER_ACCOUNT: Exception => ',@ErrorMessage) AS [MESSAGE],
            '0' AS RESULT
    END CATCH
END
GO
EXEC BAD.SP_CREATE_PLAYER_ACCOUNT '10000000', '10000000','/some/dir/pic.png','ACTIVE','DIAMOND','DIAMOND','1','2','3','1','1','CLAN LEADER','100','1','LEADER',NULL,NULL