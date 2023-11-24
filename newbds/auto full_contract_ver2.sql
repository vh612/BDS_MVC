alter TRIGGER Full_Contract_CODEDESIGN
ON dbo.Full_Contract
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
	DECLARE @PropertyID int, @Full_Contract_Code nvarchar(25), @NGAY date, @THANG int, @NAM int, @STT int;
	SELECT @PropertyID = ID FROM inserted;
	SET @NGAY = CONVERT(date, GETDATE());
    SET @THANG = MONTH(@NGAY);
    SET @NAM = YEAR(@NGAY);
	SET @STT = (
        SELECT COUNT(*) + 1
        FROM dbo.Full_Contract
        
    );

    SET @Full_Contract_Code = RIGHT('00' + CAST(@NGAY AS varchar), 2)+RIGHT('00' + CAST(@THANG AS varchar), 2)+ RIGHT('00' + CAST(@NAM AS varchar), 2) + RIGHT('00000' + CAST(@STT AS varchar), 5)+'FC' ;
	UPDATE dbo.Full_Contract
    SET Full_Contract_Code = @Full_Contract_Code
    WHERE ID = @PropertyID;
END;




select * from Full_Contract

INSERT INTO [dbo].[Full_Contract] ([Customer_Name], [Year_Of_Birth], [SSN], [Customer_Address], [Mobile], [Property_ID], [Date_Of_Contract], [Price], [Deposit], [Remain], [Status])
VALUES (N'thanhcong2', 2001, N'301198908', N'Thới An, Quận 12, Thành phố Hồ Chí Minh', N'0919686576', 1,GETDATE(), 1000000000, 100000000, 900000000, CAST ('True' AS bit))

DELETE FROM Full_Contract
WHERE SSN = '301198908'


