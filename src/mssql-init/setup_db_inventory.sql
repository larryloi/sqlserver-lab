CREATE DATABASE inventory ;
GO

USE inventory;
GO

CREATE SCHEMA INV;
GO


CREATE USER [kafka_src] FOR LOGIN [kafka_src] WITH DEFAULT_SCHEMA=[INV];
GO
CREATE USER [seatunnel_src] FOR LOGIN [seatunnel_src] WITH DEFAULT_SCHEMA=[INV];
GO


ALTER ROLE db_owner ADD MEMBER [kafka_src];
GO
ALTER ROLE db_owner ADD MEMBER [seatunnel_src];
GO



-- Enable CDC on the database
EXEC sys.sp_cdc_enable_db;
GO
-- Enable CDC on the table  

CREATE TABLE inventory.INV.abc (
    id INT NOT NULL IDENTITY(1,1),
    name VARCHAR(30) NOT NULL,
    PRIMARY KEY (id)
);
GO

-- Enable CDC on the table
EXEC sys.sp_cdc_enable_table
    @source_schema = N'INV',
    @source_name = N'abc',
    @role_name = NULL;


    