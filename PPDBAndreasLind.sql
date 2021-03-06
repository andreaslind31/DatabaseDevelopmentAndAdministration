CREATE DATABASE [PPDBAndreasLind]

USE [PPDBAndreasLind]
GO
/****** Object:  Table [dbo].[ParkingSpot]    Script Date: 2021-02-05 16:45:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ParkingSpot](
	[ParkingSpotID] [int] IDENTITY(1,1) NOT NULL,
	[AvailableSpace] [int] NOT NULL,
 CONSTRAINT [PK_ParkingSpotID] PRIMARY KEY CLUSTERED 
(
	[ParkingSpotID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[EmptySpaces]    Script Date: 2021-02-05 16:45:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[EmptySpaces]
AS
SELECT ParkingSpotID
FROM     dbo.ParkingSpot
WHERE  (AvailableSpace > 2)
GO
/****** Object:  Table [dbo].[Vehicles]    Script Date: 2021-02-05 16:45:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vehicles](
	[VehicleID] [int] IDENTITY(1,1) NOT NULL,
	[VehicleType] [nvarchar](50) NOT NULL,
	[RegistrationNr] [nvarchar](500) NULL,
	[VehicleSize] [int] NOT NULL,
	[ParkedAtTime] [datetime] NOT NULL,
	[ParkingSpotID] [int] NOT NULL,
	[Price] [int] NOT NULL,
	[ParkingFee]  AS (case when datediff(minute,[ParkedAtTime],getdate())<(5) then (0) when datediff(minute,[ParkedAtTime],getdate())>=(5) AND datediff(minute,[ParkedAtTime],getdate())<=(120) AND [VehicleType]='Car' then (240) when datediff(minute,[ParkedAtTime],getdate())>=(5) AND datediff(minute,[ParkedAtTime],getdate())<=(120) then (120) when datediff(minute,[ParkedAtTime],getdate())>(120) AND [VehicleType]='Car' then (120)*(2)+(1)*datediff(hour,[ParkedAtTime],getdate()) when datediff(minute,[ParkedAtTime],getdate())>(120) then (120)+(1)*datediff(hour,[ParkedAtTime],getdate())  end),
	[ParkedHours]  AS (datediff(hour,[ParkedAtTime],getdate())),
	[ParkedMinutes]  AS (datediff(minute,[ParkedAtTime],getdate())),
 CONSTRAINT [PK_VehicleID] PRIMARY KEY CLUSTERED 
(
	[VehicleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Parkinglot]    Script Date: 2021-02-05 16:45:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Parkinglot]
AS
SELECT TOP 100 v.ParkingSpotID, v.RegistrationNr, v.ParkedAtTime, v.ParkedMinutes, v.ParkingFee
FROM     dbo.Vehicles v ORDER BY v.ParkingSpotID
GO
/****** Object:  Table [dbo].[History]    Script Date: 2021-02-05 16:45:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[History](
	[HistoryID] [int] IDENTITY(1,1) NOT NULL,
	[ParkingSpace] [int] NOT NULL,
	[VehicleID] [int] NOT NULL,
	[VehicleType] [nvarchar](50) NOT NULL,
	[ParkedAtTime] [datetime] NOT NULL,
	[RetrievedAtTime] [datetime] NULL,
	[RegistrationNr] [nvarchar](30) NOT NULL,
	[ParkingFee]  AS (case when datediff(minute,[ParkedAtTime],getdate())<(5) then (0) when datediff(minute,[ParkedAtTime],getdate())>=(5) AND datediff(minute,[ParkedAtTime],getdate())<=(120) AND [VehicleType]='Car' then (240) when datediff(minute,[ParkedAtTime],getdate())>=(5) AND datediff(minute,[ParkedAtTime],getdate())<=(120) then (120) when datediff(minute,[ParkedAtTime],getdate())>(120) AND [VehicleType]='Car' then (120)*(2)+(1)*datediff(hour,[ParkedAtTime],getdate()) when datediff(minute,[ParkedAtTime],getdate())>(120) then (120)+(1)*datediff(hour,[ParkedAtTime],getdate())  end),
	[ParkedHours]  AS (datediff(hour,[ParkedAtTime],getdate())),
	[ParkedMinutes]  AS (datediff(minute,[ParkedAtTime],getdate())),
 CONSTRAINT [PK_HistoryID] PRIMARY KEY CLUSTERED 
(
	[HistoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[View_History]    Script Date: 2021-02-05 16:45:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_History]
AS
SELECT ParkingSpace, RegistrationNr, VehicleType, ParkedAtTime, RetrievedAtTime, ParkingFee
FROM     dbo.History
GO
SET IDENTITY_INSERT [dbo].[History] ON 

INSERT [dbo].[History] ([HistoryID], [ParkingSpace], [VehicleID], [VehicleType], [ParkedAtTime], [RetrievedAtTime], [RegistrationNr]) VALUES (25, 46, 22, N'MC', CAST(N'2021-02-04T14:44:23.310' AS DateTime), CAST(N'2021-02-05T14:19:06.430' AS DateTime), N'Bis112')
INSERT [dbo].[History] ([HistoryID], [ParkingSpace], [VehicleID], [VehicleType], [ParkedAtTime], [RetrievedAtTime], [RegistrationNr]) VALUES (26, 2, 23, N'MC', CAST(N'2021-02-04T14:44:23.310' AS DateTime), CAST(N'2021-02-05T14:24:01.977' AS DateTime), N'Bis113')
INSERT [dbo].[History] ([HistoryID], [ParkingSpace], [VehicleID], [VehicleType], [ParkedAtTime], [RetrievedAtTime], [RegistrationNr]) VALUES (27, 3, 24, N'Car', CAST(N'2021-02-04T14:44:23.310' AS DateTime), CAST(N'2021-02-05T15:01:45.730' AS DateTime), N'Bis114')
INSERT [dbo].[History] ([HistoryID], [ParkingSpace], [VehicleID], [VehicleType], [ParkedAtTime], [RetrievedAtTime], [RegistrationNr]) VALUES (28, 4, 25, N'MC', CAST(N'2021-02-04T14:44:23.310' AS DateTime), CAST(N'2021-02-05T15:02:44.930' AS DateTime), N'Bis115')
INSERT [dbo].[History] ([HistoryID], [ParkingSpace], [VehicleID], [VehicleType], [ParkedAtTime], [RetrievedAtTime], [RegistrationNr]) VALUES (29, 4, 26, N'MC', CAST(N'2021-02-04T14:44:23.310' AS DateTime), CAST(N'2021-02-05T15:53:35.980' AS DateTime), N'Bis116')
INSERT [dbo].[History] ([HistoryID], [ParkingSpace], [VehicleID], [VehicleType], [ParkedAtTime], [RetrievedAtTime], [RegistrationNr]) VALUES (30, 5, 27, N'Car', CAST(N'2021-02-04T14:44:23.310' AS DateTime), NULL, N'Bis117')
INSERT [dbo].[History] ([HistoryID], [ParkingSpace], [VehicleID], [VehicleType], [ParkedAtTime], [RetrievedAtTime], [RegistrationNr]) VALUES (31, 6, 28, N'MC', CAST(N'2021-02-04T14:44:23.310' AS DateTime), NULL, N'Bis118')
INSERT [dbo].[History] ([HistoryID], [ParkingSpace], [VehicleID], [VehicleType], [ParkedAtTime], [RetrievedAtTime], [RegistrationNr]) VALUES (32, 7, 29, N'MC', CAST(N'2021-02-04T14:44:23.310' AS DateTime), NULL, N'Bis119')
INSERT [dbo].[History] ([HistoryID], [ParkingSpace], [VehicleID], [VehicleType], [ParkedAtTime], [RetrievedAtTime], [RegistrationNr]) VALUES (33, 8, 30, N'Car', CAST(N'2021-02-04T14:44:23.310' AS DateTime), NULL, N'Bis120')
INSERT [dbo].[History] ([HistoryID], [ParkingSpace], [VehicleID], [VehicleType], [ParkedAtTime], [RetrievedAtTime], [RegistrationNr]) VALUES (34, 9, 31, N'MC', CAST(N'2021-02-04T14:44:23.310' AS DateTime), NULL, N'Bis121')
INSERT [dbo].[History] ([HistoryID], [ParkingSpace], [VehicleID], [VehicleType], [ParkedAtTime], [RetrievedAtTime], [RegistrationNr]) VALUES (35, 10, 32, N'MC', CAST(N'2021-02-04T14:46:16.170' AS DateTime), NULL, N'Bis122')
INSERT [dbo].[History] ([HistoryID], [ParkingSpace], [VehicleID], [VehicleType], [ParkedAtTime], [RetrievedAtTime], [RegistrationNr]) VALUES (39, 1, 21, N'Car', CAST(N'2021-02-05T12:37:21.270' AS DateTime), CAST(N'2021-02-05T14:13:42.520' AS DateTime), N'Bis111')
INSERT [dbo].[History] ([HistoryID], [ParkingSpace], [VehicleID], [VehicleType], [ParkedAtTime], [RetrievedAtTime], [RegistrationNr]) VALUES (40, 2, 22, N'MC', CAST(N'2021-02-05T12:37:21.270' AS DateTime), CAST(N'2021-02-05T14:19:06.430' AS DateTime), N'Bis112')
INSERT [dbo].[History] ([HistoryID], [ParkingSpace], [VehicleID], [VehicleType], [ParkedAtTime], [RetrievedAtTime], [RegistrationNr]) VALUES (41, 2, 23, N'MC', CAST(N'2021-02-05T12:37:21.270' AS DateTime), CAST(N'2021-02-05T14:24:01.977' AS DateTime), N'Bis113')
INSERT [dbo].[History] ([HistoryID], [ParkingSpace], [VehicleID], [VehicleType], [ParkedAtTime], [RetrievedAtTime], [RegistrationNr]) VALUES (42, 3, 24, N'Car', CAST(N'2021-02-05T12:37:21.273' AS DateTime), CAST(N'2021-02-05T15:01:45.730' AS DateTime), N'Bis114')
INSERT [dbo].[History] ([HistoryID], [ParkingSpace], [VehicleID], [VehicleType], [ParkedAtTime], [RetrievedAtTime], [RegistrationNr]) VALUES (43, 4, 25, N'MC', CAST(N'2021-02-05T12:37:21.273' AS DateTime), CAST(N'2021-02-05T15:02:44.930' AS DateTime), N'Bis115')
INSERT [dbo].[History] ([HistoryID], [ParkingSpace], [VehicleID], [VehicleType], [ParkedAtTime], [RetrievedAtTime], [RegistrationNr]) VALUES (44, 4, 26, N'MC', CAST(N'2021-02-05T12:37:21.273' AS DateTime), CAST(N'2021-02-05T15:53:35.980' AS DateTime), N'Bis116')
INSERT [dbo].[History] ([HistoryID], [ParkingSpace], [VehicleID], [VehicleType], [ParkedAtTime], [RetrievedAtTime], [RegistrationNr]) VALUES (45, 5, 27, N'Car', CAST(N'2021-02-05T12:37:21.277' AS DateTime), NULL, N'Bis117')
INSERT [dbo].[History] ([HistoryID], [ParkingSpace], [VehicleID], [VehicleType], [ParkedAtTime], [RetrievedAtTime], [RegistrationNr]) VALUES (46, 6, 28, N'MC', CAST(N'2021-02-05T12:37:21.277' AS DateTime), NULL, N'Bis118')
INSERT [dbo].[History] ([HistoryID], [ParkingSpace], [VehicleID], [VehicleType], [ParkedAtTime], [RetrievedAtTime], [RegistrationNr]) VALUES (47, 7, 29, N'MC', CAST(N'2021-02-05T12:37:21.277' AS DateTime), NULL, N'Bis119')
INSERT [dbo].[History] ([HistoryID], [ParkingSpace], [VehicleID], [VehicleType], [ParkedAtTime], [RetrievedAtTime], [RegistrationNr]) VALUES (48, 8, 30, N'Car', CAST(N'2021-02-05T12:37:21.277' AS DateTime), NULL, N'Bis120')
INSERT [dbo].[History] ([HistoryID], [ParkingSpace], [VehicleID], [VehicleType], [ParkedAtTime], [RetrievedAtTime], [RegistrationNr]) VALUES (49, 9, 31, N'MC', CAST(N'2021-02-05T12:37:21.310' AS DateTime), NULL, N'Bis121')
INSERT [dbo].[History] ([HistoryID], [ParkingSpace], [VehicleID], [VehicleType], [ParkedAtTime], [RetrievedAtTime], [RegistrationNr]) VALUES (50, 10, 32, N'MC', CAST(N'2021-02-05T12:37:21.310' AS DateTime), NULL, N'Bis122')
INSERT [dbo].[History] ([HistoryID], [ParkingSpace], [VehicleID], [VehicleType], [ParkedAtTime], [RetrievedAtTime], [RegistrationNr]) VALUES (52, 43, 34, N'Car', CAST(N'2021-02-05T14:33:21.927' AS DateTime), NULL, N'Kalle')
INSERT [dbo].[History] ([HistoryID], [ParkingSpace], [VehicleID], [VehicleType], [ParkedAtTime], [RetrievedAtTime], [RegistrationNr]) VALUES (55, 42, 88, N'Car', CAST(N'2021-02-05T14:50:32.067' AS DateTime), CAST(N'2021-02-05T14:54:50.707' AS DateTime), N'Reg123')
INSERT [dbo].[History] ([HistoryID], [ParkingSpace], [VehicleID], [VehicleType], [ParkedAtTime], [RetrievedAtTime], [RegistrationNr]) VALUES (57, 77, 77, N'Car', CAST(N'2021-02-05T14:53:46.863' AS DateTime), NULL, N'Reg124')
INSERT [dbo].[History] ([HistoryID], [ParkingSpace], [VehicleID], [VehicleType], [ParkedAtTime], [RetrievedAtTime], [RegistrationNr]) VALUES (58, 40, 42, N'MC', CAST(N'2021-02-05T15:03:54.360' AS DateTime), NULL, N'Reg445')
INSERT [dbo].[History] ([HistoryID], [ParkingSpace], [VehicleID], [VehicleType], [ParkedAtTime], [RetrievedAtTime], [RegistrationNr]) VALUES (60, 4, 35, N'Car', CAST(N'2021-02-05T15:41:17.887' AS DateTime), CAST(N'2021-02-05T15:49:42.603' AS DateTime), N'Ball333')
INSERT [dbo].[History] ([HistoryID], [ParkingSpace], [VehicleID], [VehicleType], [ParkedAtTime], [RetrievedAtTime], [RegistrationNr]) VALUES (61, 4, 35, N'Car', CAST(N'2021-02-05T15:49:16.060' AS DateTime), CAST(N'2021-02-05T15:49:42.603' AS DateTime), N'Ball333')
INSERT [dbo].[History] ([HistoryID], [ParkingSpace], [VehicleID], [VehicleType], [ParkedAtTime], [RetrievedAtTime], [RegistrationNr]) VALUES (62, 4, 66, N'Car', CAST(N'2021-02-05T15:55:53.513' AS DateTime), CAST(N'2021-02-05T16:03:00.540' AS DateTime), N'Ball444')
INSERT [dbo].[History] ([HistoryID], [ParkingSpace], [VehicleID], [VehicleType], [ParkedAtTime], [RetrievedAtTime], [RegistrationNr]) VALUES (63, 4, 67, N'Car', CAST(N'2021-02-05T15:56:27.833' AS DateTime), CAST(N'2021-02-05T16:05:15.437' AS DateTime), N'Ball445')
INSERT [dbo].[History] ([HistoryID], [ParkingSpace], [VehicleID], [VehicleType], [ParkedAtTime], [RetrievedAtTime], [RegistrationNr]) VALUES (64, 4, 67, N'Car', CAST(N'2021-02-05T16:04:48.243' AS DateTime), CAST(N'2021-02-05T16:05:15.437' AS DateTime), N'Ball445')
INSERT [dbo].[History] ([HistoryID], [ParkingSpace], [VehicleID], [VehicleType], [ParkedAtTime], [RetrievedAtTime], [RegistrationNr]) VALUES (65, 1, 67, N'Car', CAST(N'2021-02-05T16:15:13.557' AS DateTime), NULL, N'Ball445')
INSERT [dbo].[History] ([HistoryID], [ParkingSpace], [VehicleID], [VehicleType], [ParkedAtTime], [RetrievedAtTime], [RegistrationNr]) VALUES (66, 2, 67, N'Car', CAST(N'2021-02-05T16:15:34.530' AS DateTime), CAST(N'2021-02-05T16:17:52.223' AS DateTime), N'Ball446')
INSERT [dbo].[History] ([HistoryID], [ParkingSpace], [VehicleID], [VehicleType], [ParkedAtTime], [RetrievedAtTime], [RegistrationNr]) VALUES (67, 2, 67, N'Car', CAST(N'2021-02-05T16:18:26.413' AS DateTime), NULL, N'Ball446')
INSERT [dbo].[History] ([HistoryID], [ParkingSpace], [VehicleID], [VehicleType], [ParkedAtTime], [RetrievedAtTime], [RegistrationNr]) VALUES (68, 2, 70, N'Car', CAST(N'2021-02-05T16:35:16.093' AS DateTime), NULL, N'RRR444')
INSERT [dbo].[History] ([HistoryID], [ParkingSpace], [VehicleID], [VehicleType], [ParkedAtTime], [RetrievedAtTime], [RegistrationNr]) VALUES (69, 3, 53, N'MC', CAST(N'2021-02-05T16:38:45.060' AS DateTime), NULL, N'cUnevAAH')
SET IDENTITY_INSERT [dbo].[History] OFF
GO
SET IDENTITY_INSERT [dbo].[ParkingSpot] ON 

INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (1, 0)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (2, 0)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (3, 2)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (4, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (5, 0)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (6, 0)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (7, 0)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (8, 0)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (9, 0)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (10, 0)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (11, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (12, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (13, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (14, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (15, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (16, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (17, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (18, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (19, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (20, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (21, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (22, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (23, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (24, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (25, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (26, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (27, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (28, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (29, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (30, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (31, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (32, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (33, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (34, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (35, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (36, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (37, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (38, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (39, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (40, 2)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (41, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (42, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (43, 0)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (44, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (45, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (46, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (47, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (48, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (49, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (50, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (51, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (52, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (53, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (54, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (55, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (56, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (57, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (58, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (59, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (60, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (61, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (62, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (63, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (64, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (65, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (66, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (67, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (68, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (69, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (70, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (71, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (72, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (73, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (74, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (75, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (76, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (77, 0)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (78, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (79, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (80, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (81, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (82, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (83, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (84, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (85, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (86, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (87, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (88, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (89, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (90, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (91, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (92, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (93, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (94, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (95, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (96, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (97, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (98, 4)
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (99, 4)
GO
INSERT [dbo].[ParkingSpot] ([ParkingSpotID], [AvailableSpace]) VALUES (100, 4)
SET IDENTITY_INSERT [dbo].[ParkingSpot] OFF
GO
SET IDENTITY_INSERT [dbo].[Vehicles] ON 

INSERT [dbo].[Vehicles] ([VehicleID], [VehicleType], [RegistrationNr], [VehicleSize], [ParkedAtTime], [ParkingSpotID], [Price]) VALUES (27, N'Car', N'Bis117', 4, CAST(N'2021-02-04T14:44:23.310' AS DateTime), 5, 20)
INSERT [dbo].[Vehicles] ([VehicleID], [VehicleType], [RegistrationNr], [VehicleSize], [ParkedAtTime], [ParkingSpotID], [Price]) VALUES (28, N'MC', N'Bis118', 2, CAST(N'2021-02-04T14:44:23.310' AS DateTime), 6, 10)
INSERT [dbo].[Vehicles] ([VehicleID], [VehicleType], [RegistrationNr], [VehicleSize], [ParkedAtTime], [ParkingSpotID], [Price]) VALUES (29, N'MC', N'Bis119', 2, CAST(N'2021-02-04T14:44:23.310' AS DateTime), 7, 10)
INSERT [dbo].[Vehicles] ([VehicleID], [VehicleType], [RegistrationNr], [VehicleSize], [ParkedAtTime], [ParkingSpotID], [Price]) VALUES (30, N'Car', N'Bis120', 4, CAST(N'2021-02-04T14:44:23.310' AS DateTime), 8, 20)
INSERT [dbo].[Vehicles] ([VehicleID], [VehicleType], [RegistrationNr], [VehicleSize], [ParkedAtTime], [ParkingSpotID], [Price]) VALUES (31, N'MC', N'Bis121', 2, CAST(N'2021-02-04T14:44:23.310' AS DateTime), 9, 10)
INSERT [dbo].[Vehicles] ([VehicleID], [VehicleType], [RegistrationNr], [VehicleSize], [ParkedAtTime], [ParkingSpotID], [Price]) VALUES (32, N'MC', N'Bis122', 2, CAST(N'2021-02-04T14:46:16.170' AS DateTime), 10, 10)
INSERT [dbo].[Vehicles] ([VehicleID], [VehicleType], [RegistrationNr], [VehicleSize], [ParkedAtTime], [ParkingSpotID], [Price]) VALUES (34, N'Car', N'Kalle', 4, CAST(N'2021-02-05T14:33:21.927' AS DateTime), 43, 20)
INSERT [dbo].[Vehicles] ([VehicleID], [VehicleType], [RegistrationNr], [VehicleSize], [ParkedAtTime], [ParkingSpotID], [Price]) VALUES (42, N'MC', N'Reg445', 2, CAST(N'2021-02-05T15:03:54.360' AS DateTime), 40, 10)
INSERT [dbo].[Vehicles] ([VehicleID], [VehicleType], [RegistrationNr], [VehicleSize], [ParkedAtTime], [ParkingSpotID], [Price]) VALUES (53, N'MC', N'cUnevAAH', 2, CAST(N'2021-02-05T16:38:45.060' AS DateTime), 3, 10)
INSERT [dbo].[Vehicles] ([VehicleID], [VehicleType], [RegistrationNr], [VehicleSize], [ParkedAtTime], [ParkingSpotID], [Price]) VALUES (67, N'Car', N'Ball445', 4, CAST(N'2021-02-05T16:15:13.557' AS DateTime), 1, 20)
INSERT [dbo].[Vehicles] ([VehicleID], [VehicleType], [RegistrationNr], [VehicleSize], [ParkedAtTime], [ParkingSpotID], [Price]) VALUES (70, N'Car', N'RRR444', 4, CAST(N'2021-02-05T16:35:16.093' AS DateTime), 2, 20)
INSERT [dbo].[Vehicles] ([VehicleID], [VehicleType], [RegistrationNr], [VehicleSize], [ParkedAtTime], [ParkingSpotID], [Price]) VALUES (77, N'Car', N'Reg124', 4, CAST(N'2021-02-05T14:53:46.863' AS DateTime), 77, 20)
SET IDENTITY_INSERT [dbo].[Vehicles] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Vehicles__6EF5E0470D3AA116]    Script Date: 2021-02-05 16:45:31 ******/
ALTER TABLE [dbo].[Vehicles] ADD UNIQUE NONCLUSTERED 
(
	[RegistrationNr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Vehicles__6EF5E047B5DB05AE]    Script Date: 2021-02-05 16:45:31 ******/
ALTER TABLE [dbo].[Vehicles] ADD UNIQUE NONCLUSTERED 
(
	[RegistrationNr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[History] ADD  CONSTRAINT [df_ParkedHistory]  DEFAULT (getdate()) FOR [ParkedAtTime]
GO
ALTER TABLE [dbo].[History] ADD  DEFAULT ('NIL') FOR [RegistrationNr]
GO
ALTER TABLE [dbo].[Vehicles] ADD  CONSTRAINT [df_VehicleType]  DEFAULT ('NIL') FOR [VehicleType]
GO
ALTER TABLE [dbo].[Vehicles] ADD  CONSTRAINT [df_RegistrationNr]  DEFAULT ('NIL') FOR [RegistrationNr]
GO
ALTER TABLE [dbo].[Vehicles] ADD  CONSTRAINT [df_VehicleSize]  DEFAULT ((2)) FOR [VehicleSize]
GO
ALTER TABLE [dbo].[Vehicles] ADD  CONSTRAINT [df_ParkedAtTime]  DEFAULT ((0)) FOR [ParkedAtTime]
GO
ALTER TABLE [dbo].[Vehicles] ADD  CONSTRAINT [df_ParkingSpotID]  DEFAULT ((0)) FOR [ParkingSpotID]
GO
ALTER TABLE [dbo].[Vehicles] ADD  CONSTRAINT [df_Price]  DEFAULT ((10)) FOR [Price]
GO
ALTER TABLE [dbo].[Vehicles]  WITH CHECK ADD  CONSTRAINT [FK_ParkingSpotID] FOREIGN KEY([ParkingSpotID])
REFERENCES [dbo].[ParkingSpot] ([ParkingSpotID])
GO
ALTER TABLE [dbo].[Vehicles] CHECK CONSTRAINT [FK_ParkingSpotID]
GO
ALTER TABLE [dbo].[ParkingSpot]  WITH CHECK ADD  CONSTRAINT [chk_MaxSpots] CHECK  (([ParkingSpotID]<(101)))
GO
ALTER TABLE [dbo].[ParkingSpot] CHECK CONSTRAINT [chk_MaxSpots]
GO
ALTER TABLE [dbo].[ParkingSpot]  WITH CHECK ADD  CONSTRAINT [chk_NoSpace] CHECK  (([AvailableSpace]>=(0)))
GO
ALTER TABLE [dbo].[ParkingSpot] CHECK CONSTRAINT [chk_NoSpace]
GO
ALTER TABLE [dbo].[Vehicles]  WITH CHECK ADD  CONSTRAINT [chk_RegNr] CHECK  ((len([RegistrationNr])>=(3) AND len([RegistrationNr])<=(10)))
GO
ALTER TABLE [dbo].[Vehicles] CHECK CONSTRAINT [chk_RegNr]
GO
ALTER TABLE [dbo].[Vehicles]  WITH CHECK ADD  CONSTRAINT [CHK_VehiclesVehType] CHECK  (([VehicleType]='Car' OR [VehicleType]='MC'))
GO
ALTER TABLE [dbo].[Vehicles] CHECK CONSTRAINT [CHK_VehiclesVehType]
GO
/****** Object:  StoredProcedure [dbo].[sp_Add_Vehicle]    Script Date: 2021-02-05 16:45:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dbo].[sp_Add_Vehicle] (@VehicleID int, @RegNo nvarchar(30), @ParkingID int, @VehicleType nvarchar(30))
AS
BEGIN
DECLARE @ArrivalTime datetime, @Price int, @TimeDiff bigint, @vSize int, @Availablespace int
	SET identity_insert Vehicles ON
		SET @Availablespace = (SELECT Availablespace FROM ParkingSpot WHERE ParkingSpotID = @ParkingID)
			IF @AvailableSpace = 0
			BEGIN
			Close [sp_Add_Vehicle]
			END 
			IF @RegNo = (SELECT RegistrationNr FROM Vehicles WHERE RegistrationNr = @RegNo)
			BEGIN
			Close [sp_Add_Vehicle]
			END 
		SET @ArrivalTime = GETDATE()
		SET @Price = 10
		SET @vSize = 2
	
		IF @VehicleType = 'Car'
		BEGIN
		SET @Price = 20
		SET @vSize = 4
		END 
		
		INSERT INTO Vehicles(VehicleID, RegistrationNr, VehicleSize, ParkingSpotID, ParkedAtTime, VehicleType, Price)
						VALUES(@VehicleID, @RegNo, @vSize, @ParkingID, @ArrivalTime, @VehicleType, @Price)
		INSERT INTO History(VehicleID, ParkingSpace, RegistrationNr, VehicleType, ParkedAtTime)
						VALUES(@VehicleID, @ParkingID, @RegNo, @VehicleType, @ArrivalTime)
		UPDATE ParkingSpot
		SET AvailableSpace -= @vSize
		WHERE ParkingSpotID = @ParkingID
			
	SET identity_insert Vehicles OFF
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Add_VehicleRandom]    Script Date: 2021-02-05 16:45:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROC [dbo].[sp_Add_VehicleRandom] (@VehicleID int, @RegNo nvarchar(30), @VehicleType nvarchar(30))
AS
BEGIN
DECLARE @ArrivalTime datetime, @Price int, @vSize int, @ParkingID int
SET @ArrivalTime = GETDATE()
		SET @Price = 10
		SET @vSize = 2
	IF @VehicleType = 'Car'
		BEGIN
		SET @Price = 20
		SET @vSize = 4
	END 
	SET identity_insert Vehicles ON
		SET @ParkingID = (SELECT TOP 1 p.ParkingSpotID FROM ParkingSpot p
			WHERE p.AvailableSpace >= @vSize)

			IF @RegNo = (SELECT RegistrationNr FROM Vehicles WHERE RegistrationNr = @RegNo)
			BEGIN
			Close [sp_Add_VehicleRandom]
			END 
			IF @VehicleID = (SELECT VehicleID FROM Vehicles WHERE VehicleID = @VehicleID)
			BEGIN
			Close [sp_Add_VehicleRandom]
			END 
		INSERT INTO Vehicles(VehicleID, RegistrationNr, VehicleSize, ParkingSpotID, ParkedAtTime, VehicleType, Price)
						VALUES(@VehicleID, @RegNo, @vSize, @ParkingID, @ArrivalTime, @VehicleType, @Price)
		INSERT INTO History(VehicleID, ParkingSpace, RegistrationNr, VehicleType, ParkedAtTime)
						VALUES(@VehicleID, @ParkingID, @RegNo, @VehicleType, @ArrivalTime)
		UPDATE ParkingSpot
		SET AvailableSpace -= @vSize
		WHERE ParkingSpotID = @ParkingID
			
	SET identity_insert Vehicles OFF
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Move_Vehicle]    Script Date: 2021-02-05 16:45:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE proc [dbo].[sp_Move_Vehicle] (@Regno nvarchar(30), @NewParkingSpot int)
AS
BEGIN
DECLARE @ArrivalTime datetime, @Price int, @vSize int, @AvailableSpace int
		SET @ArrivalTime = (SELECT ParkedAtTime FROM Vehicles Where RegistrationNr = @Regno)
		SET @Price = (SELECT Price FROM Vehicles Where RegistrationNr = @Regno)
		SET @vSize = (SELECT VehicleSize FROM Vehicles Where RegistrationNr = @Regno)
		SET @AvailableSpace = (SELECT AvailableSpace FROM ParkingSpot Where ParkingSpotID = @NewParkingSpot)

		IF @AvailableSpace = 0
		BEGIN
		Close [sp_Move_Vehicle]
		END 
		UPDATE ParkingSpot
		SET AvailableSpace -= @vSize
		WHERE ParkingSpotID = @NewParkingSpot

		UPDATE ParkingSpot
		SET AvailableSpace += @vSize
		WHERE ParkingSpotID = (SELECT ParkingSpotID FROM Vehicles Where RegistrationNr = @Regno)

		UPDATE Vehicles
		SET ParkingSpotID = @NewParkingSpot
		WHERE RegistrationNr = (SELECT RegistrationNr FROM Vehicles Where RegistrationNr = @Regno)

		UPDATE History
		SET ParkingSpace = @NewParkingSpot
		WHERE RegistrationNr = (SELECT RegistrationNr FROM Vehicles Where RegistrationNr = @Regno)	
END
GO
/****** Object:  StoredProcedure [dbo].[sp_Retrieve_Vehicle]    Script Date: 2021-02-05 16:45:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_Retrieve_Vehicle](@RegNo nvarchar(30))
AS
BEGIN
DECLARE @RetrieveTime datetime, @vSize int, @ParkingID int
	
		SET @vSize = (SELECT veh.VehicleSize FROM Vehicles veh WHERE veh.RegistrationNr = @RegNo)
		SET @RetrieveTime = GETDATE()
		SET @ParkingID = (SELECT veh.ParkingSpotID FROM Vehicles veh WHERE veh.RegistrationNr = @RegNo)

		UPDATE History
		SET RetrievedAtTime = GETDATE()
		WHERE RegistrationNr = @RegNo

		UPDATE ParkingSpot
		SET AvailableSpace = AvailableSpace +@vSize
		WHERE ParkingSpotID = @ParkingID

		DELETE Vehicles WHERE RegistrationNr = @RegNo	
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ShowVehicleInfo]    Script Date: 2021-02-05 16:45:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_ShowVehicleInfo](@Regno nvarchar(30))
AS 
SELECT v.ParkingSpotID, v.RegistrationNr, v.ParkedAtTime, v.ParkedMinutes, v.ParkingFee 
FROM Vehicles v WHERE v.RegistrationNr = @RegNo
GO
/****** Object:  StoredProcedure [dbo].[usp_ShowEmptySpaces]    Script Date: 2021-02-05 16:45:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_ShowEmptySpaces]
AS 
SELECT ParkingSpotID
FROM ParkingSpot p
WHERE AvailableSpace = 4
GO
/****** Object:  StoredProcedure [dbo].[usp_ShowParkingLot]    Script Date: 2021-02-05 16:45:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[usp_ShowParkingLot]
AS 
SELECT *
FROM Parkinglot
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "ParkingSpot"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 126
               Right = 245
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'EmptySpaces'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'EmptySpaces'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "ps"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 126
               Right = 496
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "h"
            Begin Extent = 
               Top = 19
               Left = 551
               Bottom = 182
               Right = 1159
            End
            DisplayFlags = 280
            TopColumn = 6
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Parkinglot'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Parkinglot'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "History"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 310
               Right = 261
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_History'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_History'
GO
USE [master]
GO
ALTER DATABASE [PPDBAndreasLind] SET  READ_WRITE 
GO
