USE MRL
GO
IF OBJECT_ID('BAD.SP_CREATE_USERTYPE') IS NOT NULL
    BEGIN
        DROP PROCEDURE BAD.SP_CREATE_USERTYPE
    END
GO
CREATE PROCEDURE BAD.SP_CREATE_USERTYPE @UserType NVARCHAR(100), @Status VARCHAR(10), @CreationDate DATETIME, @CreatedBy NVARCHAR(100)
AS
BEGIN
    BEGIN TRY
        DECLARE @UserTypeExists INT = 0
        DECLARE @ErrorMessage NVARCHAR(MAX) 

        SELECT 
            @UserTypeExists = COUNT(1)
        FROM BAD.UserType
        WHERE UserType = @UserType

    IF @CreationDate IS NULL 
        BEGIN
            SET @CreationDate = GETDATE()
        END
    IF @CreatedBy IS NULL
        BEGIN
            SET @CreatedBy = USER_NAME()
        END

    IF @UserTypeExists = 0
        BEGIN
            INSERT INTO BAD.UserType(UserType,[Status],CreationDate,CreatedBy)
            VALUES(@UserType,@Status,@CreationDate,@CreatedBy)

            SELECT 
                CONCAT('UserType "',@UserType,'" created succesfully!')AS [MESSAGE],
                '1' AS RESULT
        END
    ELSE
        BEGIN
            SELECT 
                CONCAT('UserType "',@UserType,'" already exists. Aborting insertion...')AS [MESSAGE],
                '0' AS RESULT
        END
    END TRY
    BEGIN CATCH
         SET @ErrorMessage = ERROR_MESSAGE()

        SELECT
            CONCAT('BAD.SP_ADD_USERTYPE: Exception => ',@ErrorMessage) AS [MESSAGE],
            '0' AS RESULT
    END CATCH
END
GO
USE MRL
GO
EXEC BAD.SP_CREATE_USERTYPE 'TestUser','ACTIVE', NULL, 'mbarrera'