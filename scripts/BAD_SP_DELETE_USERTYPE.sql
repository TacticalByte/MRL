USE MRL
GO
IF OBJECT_ID('BAD.SP_DELETE_USERTYPE') IS NOT NULL
    BEGIN
        DROP PROCEDURE BAD.SP_DELETE_USERTYPE
    END
GO
CREATE PROCEDURE BAD.SP_DELETE_USERTYPE @UserTypeID INT, @ModificationDate DATETIME, @ModifiedBy NVARCHAR(100)
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
            INSERT INTO BHD.UserTypeHistory(UserTypeID,UserType,[Status],CreationDate,CreatedBy,ModificationDate,ModifiedBy)
            SELECT 
            UserTypeID,UserType,[Status],
            CreationDate,CreatedBy,
            @ModificationDate,@ModifiedBy
            FROM BAD.UserType
            WHERE UserTypeID = @UserTypeID

            UPDATE BAD.UserType SET
            [Status] = 'DELETED'
            WHERE UserTypeID = @UserTypeID

            SELECT 
                CONCAT('UserTypeID: "',@UserTypeID,'" deleted succesfully!')AS [MESSAGE],
                '1' AS RESULT
        END
    ELSE
        BEGIN
            SELECT 
                CONCAT('UserTypeID: "',@UserTypeID,'" does not exists. Aborting deletion...')AS [MESSAGE],
                '0' AS RESULT
        END
    END TRY
    BEGIN CATCH
         SET @ErrorMessage = ERROR_MESSAGE()

        SELECT
            CONCAT('BAD.SP_DELETE_USERTYPE: Exception => ',@ErrorMessage) AS [MESSAGE],
            '0' AS RESULT
    END CATCH
END