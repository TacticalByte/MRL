USE MRL 
GO
IF OBJECT_ID('BAD.SP_UPDATE_USERTYPE') IS NOT NULL
    BEGIN
        DROP PROCEDURE BAD.SP_UPDATE_USERTYPE
    END
GO
CREATE PROCEDURE BAD.SP_UPDATE_USERTYPE @UserTypeID INT, @UserType NVARCHAR(100), @ModificationDate DATETIME, @ModifiedBy NVARCHAR(100)
AS
BEGIN
     BEGIN TRY
        DECLARE @UserTypeExists INT = 0
        DECLARE @ErrorMessage NVARCHAR(MAX) 

        SELECT 
            @UserTypeExists = COUNT(1)
        FROM BAD.UserType
        WHERE UserTypeID = @UserTypeID

    IF @ModificationDate IS NULL 
        BEGIN
            SET @ModificationDate = GETDATE()
        END
    IF @ModifiedBy IS NULL
        BEGIN
            SET @ModifiedBy = USER_NAME()
        END

    IF @UserTypeExists > 0
        BEGIN
            INSERT INTO BHD.UserTypeHistory(UserTypeID,UserType,CreationDate,CreatedBy,ModificationDate,ModifiedBy)
            SELECT 
            UserTypeID,UserType,
            CreationDate,CreatedBy,
            @ModificationDate,@ModifiedBy
            FROM BAD.UserType
            WHERE UserTypeID = @UserTypeID

            UPDATE BAD.UserType SET
            UserType = @UserType, 
            ModificationDate = @ModificationDate,
            ModifiedBy = @ModifiedBy
            WHERE UserTypeID = @UserTypeID

            SELECT 
                CONCAT('UserType with ID: "',@UserTypeID,'" updated succesfully!')AS [MESSAGE],
                '1' AS RESULT
        END
    ELSE
        BEGIN
            SELECT 
                CONCAT('UserType with ID: "',@UserTypeID,'"  cannot be updated. Aborting update...')AS [MESSAGE],
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
EXEC BAD.SP_UPDATE_USERTYPE 1,'UPDATED_USER', NULL, NULL