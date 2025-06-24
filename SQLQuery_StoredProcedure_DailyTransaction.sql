CREATE PROCEDURE DailyTransaction
    @start_date DATE, 
    @end_date DATE 
AS
BEGIN
    SELECT 
        CAST(TransactionDate AS DATE) AS Date, 
        COUNT(*) AS TotalTransactions, 
        SUM(Amount) AS TotalAmount 
    FROM 
        FactTransaction
    WHERE 
        TransactionDate BETWEEN @start_date AND @end_date
    GROUP BY 
        CAST(TransactionDate AS DATE) 
    ORDER BY 
        Date; 
END

EXEC DailyTransaction '2024-01-01', '2024-01-31'

drop procedure DailyTransaction


