CREATE TABLE [dbo].[additional_product](
  [product_id] [int] IDENTITY(1, 1) NOT NULL,
  [sku] [varchar](15) NOT NULL,
  [product_name] [varchar](30) NOT NULL,
  [size_oz] [int] NOT NULL,
  [price] [decimal](5, 2) NOT NULL,
  CONSTRAINT [pk__additional_product] PRIMARY KEY CLUSTERED
  (
    [product_id] ASC
  )
)
GO

CREATE TABLE [dbo].[additional_service](
  [service_id] [int] IDENTITY(1, 1) NOT NULL,
  [sku] [varchar](15) NOT NULL,
  [srvc_name] [varchar](50) NOT NULL,
  [min_participants] [int] NULL,
  [per_person_price] [decimal](5, 2) NOT NULL,
  [min_price] [decimal](5, 2) NOT NULL,
  CONSTRAINT [PK__additional_service] PRIMARY KEY CLUSTERED
  (
    [service_id] ASC
  )
)
GO