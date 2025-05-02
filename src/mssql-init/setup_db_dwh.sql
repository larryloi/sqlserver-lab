CREATE DATABASE dwh ;
GO

USE dwh;
GO

CREATE SCHEMA DW_ETL;
GO


CREATE USER [kafka_sink] FOR LOGIN [kafka_sink] WITH DEFAULT_SCHEMA=[DW_ETL];
GO
CREATE USER [seatunnel_sink] FOR LOGIN [seatunnel_sink] WITH DEFAULT_SCHEMA=[DW_ETL];
GO

ALTER ROLE db_owner ADD MEMBER [kafka_sink];
GO
ALTER ROLE db_owner ADD MEMBER [seatunnel_sink];
GO






    