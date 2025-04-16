/*****************************************************************************
 STEP 1: CREATE DATABASE (IF NEEDED), CREATE TABLE T WITH NO INDEXES, NO PK
******************************************************************************/

USE QuizOne;
GO

IF OBJECT_ID('dbo.T', 'U') IS NOT NULL
    DROP TABLE dbo.T;
GO

-- col1 is NOT NULL to allow a PK later
CREATE TABLE dbo.T
(
    col1 INT NOT NULL,
    col2 VARCHAR(50),
    col3 DATETIME
);
GO

/*****************************************************************************
 STEP 2: INSERT ROWS (HEAP) AND SELECT * (TABLE SCAN)
******************************************************************************/
PRINT '*** STEP 2: Inserting rows into table T (Heap, no PK) ***';
DECLARE @i INT = 1;
DECLARE @n INT = 1000;  -- Change this for 50000, 100000, etc.

TRUNCATE TABLE dbo.T;

WHILE @i <= @n
BEGIN
    INSERT INTO dbo.T (col1, col2, col3)
    VALUES (@i, CONCAT('Row number ', @i), GETDATE());
    SET @i += 1;
END;

PRINT '*** STEP 2: SELECT * (Expect Table Scan) ***';
SET STATISTICS IO ON;
SET STATISTICS TIME ON;

SELECT * FROM dbo.T;  -- Table Scan expected

SET STATISTICS TIME OFF;
SET STATISTICS IO OFF;
GO

/*****************************************************************************
 STEP 3: CREATE A CLUSTERED INDEX (PRIMARY KEY), RE-INSERT ROWS, AND SELECT *
        (CLUSTERED INDEX SCAN)
******************************************************************************/
PRINT '*** STEP 3: Creating Clustered Index (Primary Key) ***';

IF EXISTS (SELECT * FROM sys.indexes WHERE name = 'PK_T')
BEGIN
    ALTER TABLE dbo.T DROP CONSTRAINT PK_T;
END;
GO

ALTER TABLE dbo.T
ADD CONSTRAINT PK_T PRIMARY KEY CLUSTERED (col1);
GO

PRINT '*** Re-inserting rows for Clustered Index Scan ***';
DECLARE @i2 INT = 1;
DECLARE @n2 INT = 1000;  -- Change this as well if you want to test a different row count

TRUNCATE TABLE dbo.T;

WHILE @i2 <= @n2
BEGIN
    INSERT INTO dbo.T (col1, col2, col3)
    VALUES (@i2, CONCAT('Row number ', @i2), GETDATE());
    SET @i2 += 1;
END;

PRINT '*** SELECT * (Expect Clustered Index Scan) ***';
SET STATISTICS IO ON;
SET STATISTICS TIME ON;

SELECT * FROM dbo.T;  -- Clustered Index Scan expected

SET STATISTICS TIME OFF;
SET STATISTICS IO OFF;
GO

/*****************************************************************************
 STEP 4: CREATE A NON-CLUSTERED INDEX ON col1, THEN SELECT col1
         (NON-CLUSTERED INDEX SCAN)
******************************************************************************/
PRINT '*** STEP 4: Creating Non-Clustered Index on col1 ***';
IF EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_T_col1')
BEGIN
    DROP INDEX IX_T_col1 ON dbo.T;
END;
GO

CREATE NONCLUSTERED INDEX IX_T_col1 ON dbo.T(col1);
GO

PRINT '*** SELECT col1 (Expect Non-Clustered Index Scan) ***';
SET STATISTICS IO ON;
SET STATISTICS TIME ON;

SELECT col1 FROM dbo.T;

SET STATISTICS TIME OFF;
SET STATISTICS IO OFF;
GO

PRINT '*** The Script is Complete!!! here are thee execution plans and times! ***';
