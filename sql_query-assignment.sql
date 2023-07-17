CREATE TABLE ProductSales AS
SELECT
  Product_Name,
  SUM(CASE WHEN table_name = 'CSheet' THEN REPLACE(REPLACE(Total_Sales, '$', ''), ',', '') + 0 ELSE 0 END) AS `CSheet - Total Sales`,
  SUM(CASE WHEN table_name = 'BSheet' THEN REPLACE(REPLACE(Total_Sales, '$', ''), ',', '') + 0 ELSE 0 END) AS `BSheet - Total Sales`,
  SUM(CASE WHEN table_name = 'ASheet' THEN REPLACE(REPLACE(Total_Sales, '$', ''), ',', '') + 0 ELSE 0 END) AS `ASheet - Total Sales`
FROM
  (SELECT Product_Name, Total_Sales, 'CSheet' AS table_name FROM csheet
   UNION ALL
   SELECT Product_Name, Total_Sales, 'BSheet' AS table_name FROM bsheet
   UNION ALL
   SELECT Product_Name, Total_Sales, 'ASheet' AS table_name FROM asheet) AS combined_data
GROUP BY Product_Name;


CREATE TABLE CombinedTable AS
SELECT *,
       DATE_FORMAT(STR_TO_DATE(Order_Date, '%m/%d/%Y'), '%b') AS Month,
       DATE_FORMAT(STR_TO_DATE(Order_Date, '%m/%d/%Y'), '%Y') AS Year,
       CONCAT(DATE_FORMAT(STR_TO_DATE(Order_Date, '%m/%d/%Y'), '%b'), ' ', DATE_FORMAT(STR_TO_DATE(Order_Date, '%m/%d/%Y'), '%Y')) AS `Month & Year`,
       CONCAT(Customer_First_Name, ' ', Customer_Second_Name) AS `Customer Name`
FROM asheet
union all 
SELECT *,
       DATE_FORMAT(STR_TO_DATE(Order_Date, '%m/%d/%Y'), '%b') AS Month,
       DATE_FORMAT(STR_TO_DATE(Order_Date, '%m/%d/%Y'), '%Y') AS Year,
       CONCAT(DATE_FORMAT(STR_TO_DATE(Order_Date, '%m/%d/%Y'), '%b'), ' ', DATE_FORMAT(STR_TO_DATE(Order_Date, '%m/%d/%Y'), '%Y')) AS `Month & Year`,
       CONCAT(Customer_First_Name, ' ', Customer_Second_Name) AS `Customer Name`
FROM bsheet
union all
SELECT *,
       DATE_FORMAT(STR_TO_DATE(Order_Date, '%m/%d/%Y'), '%b') AS Month,
       DATE_FORMAT(STR_TO_DATE(Order_Date, '%m/%d/%Y'), '%Y') AS Year,
       CONCAT(DATE_FORMAT(STR_TO_DATE(Order_Date, '%m/%d/%Y'), '%b'), ' ', DATE_FORMAT(STR_TO_DATE(Order_Date, '%m/%d/%Y'), '%Y')) AS `Month & Year`,
       CONCAT(Customer_First_Name, ' ', Customer_Second_Name) AS `Customer Name`
FROM csheet;

create table combinedsheet as
SELECT 'asheet' AS Sheet,
       SUM(CAST(REPLACE(REPLACE(Total_Sales, '$', ''), ',', '') AS DECIMAL(10, 2))) AS Total_Sales,
       SUM(REPLACE(Quantity_Purchased,'$',''))AS Total_Quantity_Purchased,
      AVG(CAST(REPLACE(REPLACE(Cost_Per_Item, '$', ''), ',', '') AS DECIMAL(10, 2))) AS Average_Cost_Per_Item
FROM asheet
UNION ALL
SELECT 'bsheet' AS Sheet,
      SUM(CAST(REPLACE(REPLACE(Total_Sales, '$', ''), ',', '') AS DECIMAL(10, 2))) AS Total_Sales,
       SUM(REPLACE(Quantity_Purchased,'$',''))AS Total_Quantity_Purchased,
      AVG(CAST(REPLACE(REPLACE(Cost_Per_Item, '$', ''), ',', '') AS DECIMAL(10, 2))) AS Average_Cost_Per_Item
FROM bsheet
UNION ALL
SELECT 'csheet' AS Sheet,
       SUM(CAST(REPLACE(REPLACE(Total_Sales, '$', ''), ',', '') AS DECIMAL(10, 2))) AS Total_Sales,
       SUM(REPLACE(Quantity_Purchased,'$',''))AS Total_Quantity_Purchased,
      AVG(CAST(REPLACE(REPLACE(Cost_Per_Item, '$', ''), ',', '') AS DECIMAL(10, 2))) AS Average_Cost_Per_Item
FROM csheet;




