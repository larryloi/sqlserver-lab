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



CREATE TABLE [INV].[orders](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[order_id] [nvarchar](36) NOT NULL,
	[supplier_id] [int] NOT NULL,
	[item_id] [int] NOT NULL,
	[status] [nvarchar](20) NOT NULL,
	[qty] [int] NOT NULL,
	[net_price] [int] NOT NULL,
	[issued_at] [datetime] NOT NULL,
	[completed_at] [datetime] NULL,
	[spec] [nvarchar](1024) NULL,
	[created_at] [datetime] NULL,
	[updated_at] [datetime] NULL,
 CONSTRAINT [PK_orders] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


CREATE NONCLUSTERED INDEX [IDX_order_issued_at] ON [INV].[orders]
(
	[issued_at] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

USE [inventory]
GO

SET ANSI_PADDING ON
GO

CREATE UNIQUE NONCLUSTERED INDEX [IDX_order_order_id] ON [INV].[orders]
(
	[order_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

USE [inventory]
GO

CREATE NONCLUSTERED INDEX [IDX_order_completed_at] ON [INV].[orders]
(
	[completed_at] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

USE [inventory]
GO

CREATE NONCLUSTERED INDEX [IDX_order_created_at] ON [INV].[orders]
(
	[created_at] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

USE [inventory]
GO

CREATE NONCLUSTERED INDEX [IDX_order_updated_at] ON [INV].[orders]
(
	[updated_at] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO


-- Enable CDC on the table
EXEC sys.sp_cdc_enable_table
    @source_schema = N'INV',
    @source_name = N'orders',
    @role_name = NULL;
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
GO
    