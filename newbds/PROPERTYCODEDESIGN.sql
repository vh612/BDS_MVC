CREATE TRIGGER PROPERTYCODEDESIGN
ON dbo.Property
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
	DECLARE @PropertyID int, @PropertyCode nvarchar(255) , @NAM int,@THANG int, @NGAY date,  @STT int;
	SELECT @PropertyID = ID FROM inserted;
	SET @NGAY = CONVERT(date, GETDATE());
    SET @THANG = MONTH(@NGAY);
    SET @NAM = YEAR(@NGAY);
	SET @STT = (
        SELECT COUNT(*) + 1
        FROM dbo.Property    
    );
	SET @PropertyCode = RIGHT('0000' + CAST(@STT AS varchar), 4)+'P'++ RIGHT('00' + CAST(@NAM AS varchar), 2)+RIGHT('00' + CAST(@THANG AS varchar), 2)+ RIGHT('00' + CAST(@NGAY AS varchar), 2)  ;
	UPDATE dbo.Property
    SET Property_Code = @PropertyCode
    WHERE ID = @PropertyID;
END;
SELECT *
FROM sys.triggers
WHERE name = 'PROPERTYCODEDESIGN';
INSERT INTO dbo.Property (Description, Property_Status_ID, Bath_Room, Area, Property_Name, Bed_Room, Address, Property_Type_ID, District_ID)
VALUES (N'Nhà rồng', 4, 2, 100, N'Phòng lịch sử', 7, N'24 tô ngọc vân', 4, 3);
select * from Property


