-- Create DimDate table
CREATE TABLE DimDate (
    DateKey INT PRIMARY KEY,
    FullDate DATE,
    Day INT,
    Month INT,
    Year INT
);

-- Populate DimDate table with dates
DECLARE @StartDate DATE = '2022-01-01';
DECLARE @EndDate DATE = '2023-12-31';
DECLARE @CurrentDate DATE = @StartDate;

-- Loop to insert dates into DimDate
WHILE @CurrentDate <= @EndDate
BEGIN
    INSERT INTO DimDate (FullDate, Day, Month, Year)
    VALUES (
        @CurrentDate,
        DATEPART(DAY, @CurrentDate),
        DATEPART(MONTH, @CurrentDate),
        DATEPART(YEAR, @CurrentDate)
    );

    SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate);
END;
