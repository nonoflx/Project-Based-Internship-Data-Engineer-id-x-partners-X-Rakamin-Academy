CREATE PROCEDURE BalancePerCustomer
    @name NVARCHAR(100) 
AS
BEGIN
    SELECT 
        c.CustomerName,
        a.AccountType,
        a.Balance,
        a.Balance + SUM(CASE WHEN t.TransactionType = 'Deposit' THEN t.Amount ELSE -t.Amount END) AS CurrentBalance
		
    FROM 
        DimAccount a 
    INNER JOIN DimCustomer c ON a.CustomerID = c.CustomerID
    LEFT JOIN FactTransaction t ON a.AccountID = t.AccountID 

    WHERE 
        c.CustomerName = @name AND
        a.status = 'active'

    GROUP BY 
        c.CustomerName, a.AccountType, a.Balance;
END

EXEC BalancePerCustomer 'SHELLY JUWITA';

drop procedure BalancePerCustomer

