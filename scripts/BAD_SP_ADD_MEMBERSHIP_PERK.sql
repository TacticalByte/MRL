USE MRL
GO
IF OBJECT_ID('BAD.SP_ADD_MEMBERSHIP_PERK') IS NOT NULL
    BEGIN
        DROP PROCEDURE BAD.SP_ADD_MEMBERSHIP_PERK
    END
GO
CREATE PROCEDURE BAD.SP_ADD_MEMBERSHIP_PERK @MembershipID INT, @Name NVARCHAR(50), @Description NVARCHAR(MAX), @PerkKey VARCHAR(50), @PerkValue VARCHAR(50), @Status VARCHAR(10), @CreationDate DATETIME, @CreatedBy NVARCHAR(100)
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
        WHERE @MembershipID = @MembershipID


        IF @MembershipExists > 0
            BEGIN
                INSERT INTO BAD.MembershipPerks(MembershipID, [Name], [Description], PerkKey, PerkValue, [Status], CreationDate, CreatedBy)
                VALUES(@MembershipID,@Name,@Description,@PerkKey,@PerkValue,@Status,@CreationDate,@CreatedBy)

                SELECT
                    CONCAT('Membership Perk with Key/Name "',@PerkKey,'" created succesfully!')AS [MESSAGE],
                    '1' AS RESULT
            END
        ELSE
            BEGIN
                SELECT 
                    CONCAT('Membership with ID "',@MembershipID,'" does not exists. Aborting insertion of new perk...')AS [MESSAGE],
                    '0' AS RESULT
            END
    END TRY
    BEGIN CATCH
        SET @ErrorMessage = ERROR_MESSAGE()
        SELECT
            CONCAT('BAD.SP_ADD_MEMBERSHIP_PERK: Exception => ',@ErrorMessage) AS [MESSAGE],
            '0' AS RESULT
    END CATCH
END
GO

EXEC BAD.SP_ADD_MEMBERSHIP_PERK 1,'Free Tier Icond','This is for a Free Tier!', 'FREE_TIER','0','ACTIVE',NULL,NULL
-- SELECT * FROM BAD.MembershipPerks