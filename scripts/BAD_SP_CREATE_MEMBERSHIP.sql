USE MRL
GO
IF OBJECT_ID('BAD.SP_CREATE_MEMBERSHIP') IS NOT NULL
    BEGIN
        DROP PROCEDURE BAD.SP_CREATE_MEMBERSHIP
    END
GO
CREATE PROCEDURE BAD.SP_CREATE_MEMBERSHIP @MembershipName NVARCHAR(50), @Price MONEY, @Discount DECIMAL(2,1), @Status VARCHAR(10), @CreationDate DATETIME, @CreatedBy NVARCHAR(100)
AS
BEGIN
    DECLARE @ErrorMessage NVARCHAR(MAX)
    DECLARE @MembershipExists INT = 0

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
            @MembershipExists = COUNT(1)
        FROM BAD.Memberships
        WHERE [Name] = @MembershipName

        IF @MembershipExists = 0 
            BEGIN
                INSERT INTO BAD.Memberships([Name],Price, Discount, [Status], CreationDate, CreatedBy)
                VALUES(@MembershipName, @Price, @Discount, @Status, @CreationDate, @CreatedBy)

                SELECT
                    CONCAT('Membership with name "',@MembershipName,'" created succesfully!')AS [MESSAGE],
                    '1' AS RESULT
            END
        ELSE
            BEGIN
                  SELECT 
                CONCAT('Membership with name "',@MembershipName,'" already exists. Aborting insertion...')AS [MESSAGE],
                '0' AS RESULT
            END
    END TRY
    BEGIN CATCH
        SET @ErrorMessage = ERROR_MESSAGE()

        SELECT
            CONCAT('BAD.SP_CREATE_MEMBERSHIP: Exception => ',@ErrorMessage) AS [MESSAGE],
            '0' AS RESULT
    END CATCH
END
GO

EXEC BAD.SP_CREATE_MEMBERSHIP 'TestMembership', 2.0, 0,'ACTIVE', NULL,NULL