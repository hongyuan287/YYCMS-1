USE [master]
GO
/****** Object:  Database [MySite]    Script Date: 2017/8/28 18:11:52 ******/
CREATE DATABASE [MySite]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MySite_Data', FILENAME = N'E:\yang.liao\DB\MySite.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'MySite_log', FILENAME = N'E:\yang.liao\DB\MySite_log.ldf' , SIZE = 5120KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [MySite] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MySite].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MySite] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MySite] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MySite] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MySite] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MySite] SET ARITHABORT OFF 
GO
ALTER DATABASE [MySite] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [MySite] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MySite] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MySite] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MySite] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MySite] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MySite] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MySite] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MySite] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MySite] SET  DISABLE_BROKER 
GO
ALTER DATABASE [MySite] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MySite] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MySite] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MySite] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MySite] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MySite] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MySite] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MySite] SET RECOVERY FULL 
GO
ALTER DATABASE [MySite] SET  MULTI_USER 
GO
ALTER DATABASE [MySite] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MySite] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MySite] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MySite] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [MySite] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'MySite', N'ON'
GO
USE [MySite]
GO
/****** Object:  UserDefinedFunction [dbo].[f_GetCSharpDataTypeBySqlUserType]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[f_GetCSharpDataTypeBySqlUserType] (@userType VARCHAR(5),@maxLength INT)  
RETURNS varchar(50) AS
BEGIN
	DECLARE @columnType NVARCHAR(30)
	IF(@userType IN ('175','231','239'))
	BEGIN
		SET @columnType='nvarchar('+CAST(@maxLength/2 AS VARCHAR(5))+')'
	END
	ELSE IF(@userType IN ('56'))
	BEGIN
		SET @columnType='int'
	END
	ELSE IF(@userType IN ('61'))
	BEGIN
		SET @columnType='DateTime'
	END
	ELSE IF(@userType IN ('106'))
	BEGIN
		SET @columnType='money'
	END
	ELSE IF(@userType IN ('167'))
	BEGIN
		SET @columnType='varchar('+CAST(@maxLength AS VARCHAR(5))+')'
	END
	ELSE IF(@userType IN('104'))
	BEGIN
		SET @columnType='bit'
	END
return @columnType
END


GO
/****** Object:  Table [dbo].[ModulePermission]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ModulePermission](
	[p_id] [int] IDENTITY(1,1) NOT NULL,
	[p_gid] [varchar](8) NOT NULL,
	[p_m_gid] [varchar](8) NOT NULL,
	[p_name] [nvarchar](50) NOT NULL,
	[p_path] [varchar](50) NOT NULL,
	[p_createTime] [datetime] NOT NULL,
	[p_createUser] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_ModulePermission] PRIMARY KEY CLUSTERED 
(
	[p_gid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Role]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Role](
	[r_id] [int] IDENTITY(1,1) NOT NULL,
	[r_gid] [varchar](8) NOT NULL,
	[r_name] [nvarchar](50) NOT NULL,
	[r_createTime] [datetime] NOT NULL,
	[r_createUser] [nvarchar](50) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Role_ModualPermission_Mapping]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Role_ModualPermission_Mapping](
	[r_p_id] [int] IDENTITY(1,1) NOT NULL,
	[r_p_gid] [varchar](8) NULL,
	[r_gid] [varchar](8) NULL,
	[p_gid] [varchar](8) NULL,
	[r_p_CreateTime] [datetime] NULL,
	[r_p_CreateUser] [nvarchar](30) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Site_Cates]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Site_Cates](
	[c_id] [int] IDENTITY(1,1) NOT NULL,
	[c_gid] [varchar](8) NOT NULL,
	[c_path] [varchar](20) NOT NULL,
	[c_isMainCate] [bit] NOT NULL,
	[c_tableId] [int] NOT NULL,
	[c_name] [nvarchar](50) NOT NULL,
	[c_type] [nvarchar](50) NOT NULL,
	[c_createUser] [nvarchar](50) NOT NULL,
	[c_createTime] [datetime] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Site_CMSBlock]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Site_CMSBlock](
	[b_id] [int] IDENTITY(1,1) NOT NULL,
	[b_gid] [varchar](8) NOT NULL,
	[b_p_gid] [varchar](8) NOT NULL,
	[b_path] [varchar](20) NOT NULL,
	[b_name] [nvarchar](50) NOT NULL,
	[b_img_size] [varchar](20) NULL,
	[b_createUser] [nvarchar](50) NOT NULL,
	[b_createTime] [datetime] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Site_CMSItem]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Site_CMSItem](
	[i_id] [int] IDENTITY(1,1) NOT NULL,
	[i_gid] [varchar](8) NOT NULL,
	[i_b_gid] [varchar](8) NOT NULL,
	[i_p_gid] [varchar](8) NOT NULL,
	[i_title] [nvarchar](50) NOT NULL,
	[i_c_gid] [varchar](8) NOT NULL,
	[i_c_type] [nvarchar](50) NOT NULL,
	[i_subTitle] [nvarchar](20) NOT NULL,
	[i_intro] [nvarchar](500) NOT NULL,
	[i_c_img_src] [varchar](150) NULL,
	[i_status] [int] NOT NULL,
	[i_createUser] [nvarchar](30) NOT NULL,
	[i_createTime] [datetime] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Site_CMSPage]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Site_CMSPage](
	[p_id] [int] IDENTITY(1,1) NOT NULL,
	[p_gid] [varchar](8) NOT NULL,
	[p_name] [nvarchar](50) NOT NULL,
	[p_path] [nvarchar](100) NOT NULL,
	[p_tempPath] [nvarchar](100) NOT NULL,
	[p_filePath] [nvarchar](100) NOT NULL,
	[p_createTime] [datetime] NOT NULL,
	[p_createUser] [nvarchar](30) NOT NULL,
	[p_pageDuty] [nvarchar](100) NOT NULL,
	[p_siteName] [int] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Site_Content]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Site_Content](
	[c_id] [int] IDENTITY(1,1) NOT NULL,
	[c_gid] [varchar](8) NOT NULL,
	[c_c_gid] [varchar](8) NOT NULL,
	[c_title] [nvarchar](50) NOT NULL,
	[c_sub_title] [nvarchar](20) NOT NULL,
	[c_keywords] [nvarchar](50) NULL,
	[c_intro] [nvarchar](100) NULL,
	[c_content] [nvarchar](max) NULL,
	[c_img_src] [varchar](150) NULL,
	[c_createUserId] [varchar](8) NULL,
	[c_createUserName] [nvarchar](30) NULL,
	[c_createUserNickName] [nvarchar](30) NULL,
	[c_createTime] [datetime] NULL,
	[c_status] [int] NULL,
	[c_state] [bit] NULL,
 CONSTRAINT [PK__Site_Con__213EE77422898912] PRIMARY KEY CLUSTERED 
(
	[c_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SystemGroup]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SystemGroup](
	[g_id] [int] IDENTITY(1,1) NOT NULL,
	[g_gid] [varchar](8) NOT NULL,
	[g_name] [nvarchar](50) NOT NULL,
	[g_picCover] [nvarchar](50) NOT NULL,
	[g_createTime] [datetime] NOT NULL,
	[g_createUser] [nvarchar](50) NOT NULL,
	[g_sort] [int] NOT NULL,
 CONSTRAINT [PK_SystemGroup] PRIMARY KEY CLUSTERED 
(
	[g_gid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SystemModual]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SystemModual](
	[m_id] [int] IDENTITY(1,1) NOT NULL,
	[m_gid] [varchar](8) NOT NULL,
	[m_g_gid] [varchar](8) NOT NULL,
	[m_path] [varchar](50) NOT NULL,
	[m_name] [nvarchar](50) NOT NULL,
	[m_parent] [int] NOT NULL,
	[m_parent_gid] [varchar](8) NOT NULL,
	[m_Controller] [varchar](50) NOT NULL,
	[m_Action] [varchar](50) NOT NULL,
	[m_createTime] [datetime] NOT NULL,
	[m_createUser] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_SystemModual] PRIMARY KEY CLUSTERED 
(
	[m_gid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[User]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[User](
	[u_id] [int] IDENTITY(1,1) NOT NULL,
	[u_gid] [varchar](8) NOT NULL,
	[u_username] [nvarchar](50) NOT NULL,
	[u_password] [nvarchar](32) NOT NULL,
	[u_createTime] [datetime] NOT NULL,
	[u_createUser] [nvarchar](50) NOT NULL,
	[u_status] [int] NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[User_Role_Mapping]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[User_Role_Mapping](
	[u_r_id] [int] IDENTITY(1,1) NOT NULL,
	[u_r_gid] [varchar](8) NULL,
	[u_gid] [varchar](8) NULL,
	[r_gid] [varchar](8) NULL,
	[u_r_CreateTime] [datetime] NULL,
	[u_r_CreateUser] [nvarchar](30) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[ModulePermission] ON 

INSERT [dbo].[ModulePermission] ([p_id], [p_gid], [p_m_gid], [p_name], [p_path], [p_createTime], [p_createUser]) VALUES (10, N'0139855e', N'd3202f41', N'访问', N'System.PermissionAssignList', CAST(N'2014-07-29 15:59:35.000' AS DateTime), N'admin')
INSERT [dbo].[ModulePermission] ([p_id], [p_gid], [p_m_gid], [p_name], [p_path], [p_createTime], [p_createUser]) VALUES (13, N'2285e866', N'78443ef6', N'访问', N'Site.SiteCateList', CAST(N'2015-11-02 16:00:15.000' AS DateTime), N'admin')
INSERT [dbo].[ModulePermission] ([p_id], [p_gid], [p_m_gid], [p_name], [p_path], [p_createTime], [p_createUser]) VALUES (14, N'65021a6c', N'88c02cdc', N'访问', N'Site.SiteCMSPageList', CAST(N'2015-11-02 16:02:05.000' AS DateTime), N'admin')
INSERT [dbo].[ModulePermission] ([p_id], [p_gid], [p_m_gid], [p_name], [p_path], [p_createTime], [p_createUser]) VALUES (7, N'670712cd', N'1e7728d3', N'访问', N'System.SystemGroupList', CAST(N'2014-07-29 15:23:50.000' AS DateTime), N'admin')
INSERT [dbo].[ModulePermission] ([p_id], [p_gid], [p_m_gid], [p_name], [p_path], [p_createTime], [p_createUser]) VALUES (18, N'91dd03dd', N'c62cadf1', N'访问', N'Site.SiteCMSPageList', CAST(N'2017-08-14 17:25:04.000' AS DateTime), N'admin')
INSERT [dbo].[ModulePermission] ([p_id], [p_gid], [p_m_gid], [p_name], [p_path], [p_createTime], [p_createUser]) VALUES (1019, N'997877c5', N'9f9fe6f8', N'访问', N'System.UserList', CAST(N'2017-08-22 16:09:43.000' AS DateTime), N'admin')
INSERT [dbo].[ModulePermission] ([p_id], [p_gid], [p_m_gid], [p_name], [p_path], [p_createTime], [p_createUser]) VALUES (2, N'9vbk35dp', N'234esf34', N'访问', N'system.moduallist', CAST(N'2014-06-07 00:00:00.000' AS DateTime), N'admin')
INSERT [dbo].[ModulePermission] ([p_id], [p_gid], [p_m_gid], [p_name], [p_path], [p_createTime], [p_createUser]) VALUES (12, N'a7d438b2', N'234esf34', N'修改', N'system.ModuleEdit', CAST(N'2014-11-29 15:06:26.000' AS DateTime), N'admin')
INSERT [dbo].[ModulePermission] ([p_id], [p_gid], [p_m_gid], [p_name], [p_path], [p_createTime], [p_createUser]) VALUES (17, N'f9a194f6', N'700a0c77', N'访问', N'Site.SiteContentList', CAST(N'2016-11-14 15:04:28.000' AS DateTime), N'admin')
INSERT [dbo].[ModulePermission] ([p_id], [p_gid], [p_m_gid], [p_name], [p_path], [p_createTime], [p_createUser]) VALUES (5, N'lb723sd0', N'6fe2d17e', N'访问', N'System.RoleList', CAST(N'2014-07-28 00:00:00.000' AS DateTime), N'admin')
SET IDENTITY_INSERT [dbo].[ModulePermission] OFF
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([r_id], [r_gid], [r_name], [r_createTime], [r_createUser]) VALUES (1, N'12334422', N'超级管理员', CAST(N'2014-04-12 00:00:00.000' AS DateTime), N'admin')
INSERT [dbo].[Role] ([r_id], [r_gid], [r_name], [r_createTime], [r_createUser]) VALUES (2, N'23937f61', N'普通用户', CAST(N'2014-07-29 11:53:19.000' AS DateTime), N'admin')
SET IDENTITY_INSERT [dbo].[Role] OFF
SET IDENTITY_INSERT [dbo].[Role_ModualPermission_Mapping] ON 

INSERT [dbo].[Role_ModualPermission_Mapping] ([r_p_id], [r_p_gid], [r_gid], [p_gid], [r_p_CreateTime], [r_p_CreateUser]) VALUES (1, N'23pa5cx8', N'12334422', N'9vbk35dp', CAST(N'2014-04-12 00:00:00.000' AS DateTime), N'廖杨')
INSERT [dbo].[Role_ModualPermission_Mapping] ([r_p_id], [r_p_gid], [r_gid], [p_gid], [r_p_CreateTime], [r_p_CreateUser]) VALUES (1019, N'b825f017', N'12334422', N'997877c5', CAST(N'2017-08-22 17:43:45.000' AS DateTime), N'admin')
INSERT [dbo].[Role_ModualPermission_Mapping] ([r_p_id], [r_p_gid], [r_gid], [p_gid], [r_p_CreateTime], [r_p_CreateUser]) VALUES (6, N'b7f4a2c6', N'12334422', N'0139855e', CAST(N'2014-11-29 18:39:37.000' AS DateTime), N'admin')
INSERT [dbo].[Role_ModualPermission_Mapping] ([r_p_id], [r_p_gid], [r_gid], [p_gid], [r_p_CreateTime], [r_p_CreateUser]) VALUES (7, N'b8077cc7', N'12334422', N'670712cd', CAST(N'2014-11-29 18:39:57.000' AS DateTime), N'admin')
INSERT [dbo].[Role_ModualPermission_Mapping] ([r_p_id], [r_p_gid], [r_gid], [p_gid], [r_p_CreateTime], [r_p_CreateUser]) VALUES (14, N'f2f86eae', N'12334422', N'a7d438b2', CAST(N'2016-12-20 23:02:34.000' AS DateTime), N'admin')
INSERT [dbo].[Role_ModualPermission_Mapping] ([r_p_id], [r_p_gid], [r_gid], [p_gid], [r_p_CreateTime], [r_p_CreateUser]) VALUES (9, N'6833b16d', N'12334422', N'2285e866', CAST(N'2015-11-02 16:00:29.000' AS DateTime), N'admin')
INSERT [dbo].[Role_ModualPermission_Mapping] ([r_p_id], [r_p_gid], [r_gid], [p_gid], [r_p_CreateTime], [r_p_CreateUser]) VALUES (10, N'6c5e8fbb', N'12334422', N'65021a6c', CAST(N'2015-11-02 16:03:18.000' AS DateTime), N'admin')
INSERT [dbo].[Role_ModualPermission_Mapping] ([r_p_id], [r_p_gid], [r_gid], [p_gid], [r_p_CreateTime], [r_p_CreateUser]) VALUES (13, N'ae7b523d', N'12334422', N'f9a194f6', CAST(N'2016-11-14 15:04:33.000' AS DateTime), N'admin')
INSERT [dbo].[Role_ModualPermission_Mapping] ([r_p_id], [r_p_gid], [r_gid], [p_gid], [r_p_CreateTime], [r_p_CreateUser]) VALUES (15, N'418a40ed', N'12334422', N'91dd03dd', CAST(N'2017-08-14 17:25:19.000' AS DateTime), N'admin')
INSERT [dbo].[Role_ModualPermission_Mapping] ([r_p_id], [r_p_gid], [r_gid], [p_gid], [r_p_CreateTime], [r_p_CreateUser]) VALUES (1018, N'1ddc95fe', N'12334422', N'lb723sd0', CAST(N'2017-08-22 17:43:40.000' AS DateTime), N'admin')
INSERT [dbo].[Role_ModualPermission_Mapping] ([r_p_id], [r_p_gid], [r_gid], [p_gid], [r_p_CreateTime], [r_p_CreateUser]) VALUES (1020, N'392216ba', N'23937f61', N'2285e866', CAST(N'2017-08-23 10:09:39.000' AS DateTime), N'admin')
INSERT [dbo].[Role_ModualPermission_Mapping] ([r_p_id], [r_p_gid], [r_gid], [p_gid], [r_p_CreateTime], [r_p_CreateUser]) VALUES (1021, N'9d93cfdb', N'23937f61', N'65021a6c', CAST(N'2017-08-23 10:09:42.000' AS DateTime), N'admin')
INSERT [dbo].[Role_ModualPermission_Mapping] ([r_p_id], [r_p_gid], [r_gid], [p_gid], [r_p_CreateTime], [r_p_CreateUser]) VALUES (1022, N'59110d3e', N'23937f61', N'f9a194f6', CAST(N'2017-08-23 10:09:44.000' AS DateTime), N'admin')
INSERT [dbo].[Role_ModualPermission_Mapping] ([r_p_id], [r_p_gid], [r_gid], [p_gid], [r_p_CreateTime], [r_p_CreateUser]) VALUES (1023, N'703d55ac', N'23937f61', N'91dd03dd', CAST(N'2017-08-23 10:09:46.000' AS DateTime), N'admin')
SET IDENTITY_INSERT [dbo].[Role_ModualPermission_Mapping] OFF
SET IDENTITY_INSERT [dbo].[Site_Cates] ON 

INSERT [dbo].[Site_Cates] ([c_id], [c_gid], [c_path], [c_isMainCate], [c_tableId], [c_name], [c_type], [c_createUser], [c_createTime]) VALUES (1, N'97a2406b', N'11', 1, 0, N'要闻', N'news', N'admin', CAST(N'2015-11-02 16:18:58.000' AS DateTime))
INSERT [dbo].[Site_Cates] ([c_id], [c_gid], [c_path], [c_isMainCate], [c_tableId], [c_name], [c_type], [c_createUser], [c_createTime]) VALUES (3, N'2db7535d', N'1101', 0, 0, N'热点新闻', N'news', N'admin', CAST(N'2015-11-02 16:45:26.000' AS DateTime))
INSERT [dbo].[Site_Cates] ([c_id], [c_gid], [c_path], [c_isMainCate], [c_tableId], [c_name], [c_type], [c_createUser], [c_createTime]) VALUES (4, N'd89eebb3', N'1102', 0, 0, N'奇事异闻', N'news', N'admin', CAST(N'2016-11-20 23:11:37.000' AS DateTime))
INSERT [dbo].[Site_Cates] ([c_id], [c_gid], [c_path], [c_isMainCate], [c_tableId], [c_name], [c_type], [c_createUser], [c_createTime]) VALUES (5, N'79ccee17', N'1103', 0, 0, N'热辣美女', N'news', N'admin', CAST(N'2017-08-24 14:15:44.000' AS DateTime))
INSERT [dbo].[Site_Cates] ([c_id], [c_gid], [c_path], [c_isMainCate], [c_tableId], [c_name], [c_type], [c_createUser], [c_createTime]) VALUES (6, N'0f72a601', N'12', 1, 0, N'趣事', N'news', N'admin', CAST(N'2017-08-24 14:45:14.000' AS DateTime))
INSERT [dbo].[Site_Cates] ([c_id], [c_gid], [c_path], [c_isMainCate], [c_tableId], [c_name], [c_type], [c_createUser], [c_createTime]) VALUES (7, N'b70ba3c2', N'13', 1, 0, N'美女', N'news', N'admin', CAST(N'2017-08-24 14:45:28.000' AS DateTime))
INSERT [dbo].[Site_Cates] ([c_id], [c_gid], [c_path], [c_isMainCate], [c_tableId], [c_name], [c_type], [c_createUser], [c_createTime]) VALUES (8, N'12c69c6a', N'14', 1, 0, N'生活', N'news', N'admin', CAST(N'2017-08-24 14:45:38.000' AS DateTime))
INSERT [dbo].[Site_Cates] ([c_id], [c_gid], [c_path], [c_isMainCate], [c_tableId], [c_name], [c_type], [c_createUser], [c_createTime]) VALUES (9, N'483d3a14', N'15', 1, 0, N'搞笑', N'news', N'admin', CAST(N'2017-08-28 16:47:25.000' AS DateTime))
INSERT [dbo].[Site_Cates] ([c_id], [c_gid], [c_path], [c_isMainCate], [c_tableId], [c_name], [c_type], [c_createUser], [c_createTime]) VALUES (10, N'9bfd9ec8', N'16', 1, 0, N'斗图', N'news', N'admin', CAST(N'2017-08-28 16:48:20.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Site_Cates] OFF
SET IDENTITY_INSERT [dbo].[Site_CMSBlock] ON 

INSERT [dbo].[Site_CMSBlock] ([b_id], [b_gid], [b_p_gid], [b_path], [b_name], [b_img_size], [b_createUser], [b_createTime]) VALUES (1, N'ff98b921', N'e4f7afd1', N'10', N'焦点大图', N'700*300', N'admin', CAST(N'2016-11-09 14:59:11.000' AS DateTime))
INSERT [dbo].[Site_CMSBlock] ([b_id], [b_gid], [b_p_gid], [b_path], [b_name], [b_img_size], [b_createUser], [b_createTime]) VALUES (2, N'f08acefa', N'e4f7afd1', N'11', N'导航菜单', N'', N'admin', CAST(N'2016-11-09 15:33:51.000' AS DateTime))
INSERT [dbo].[Site_CMSBlock] ([b_id], [b_gid], [b_p_gid], [b_path], [b_name], [b_img_size], [b_createUser], [b_createTime]) VALUES (3, N'b92abf4b', N'2e94db1d', N'10', N'导航菜单(内容为分类ID)', N'', N'admin', CAST(N'2017-08-24 09:14:53.000' AS DateTime))
INSERT [dbo].[Site_CMSBlock] ([b_id], [b_gid], [b_p_gid], [b_path], [b_name], [b_img_size], [b_createUser], [b_createTime]) VALUES (4, N'716d33eb', N'e4f7afd1', N'12', N'右侧热点图文', N'100*90', N'admin', CAST(N'2017-08-24 14:21:03.000' AS DateTime))
INSERT [dbo].[Site_CMSBlock] ([b_id], [b_gid], [b_p_gid], [b_path], [b_name], [b_img_size], [b_createUser], [b_createTime]) VALUES (5, N'7ecd6a13', N'e4f7afd1', N'13', N'右侧列表', N'', N'admin', CAST(N'2017-08-24 14:32:20.000' AS DateTime))
INSERT [dbo].[Site_CMSBlock] ([b_id], [b_gid], [b_p_gid], [b_path], [b_name], [b_img_size], [b_createUser], [b_createTime]) VALUES (9, N'9f1272c7', N'e4f7afd1', N'14', N'要闻', N'60*60', N'admin', CAST(N'2017-08-28 17:03:27.000' AS DateTime))
INSERT [dbo].[Site_CMSBlock] ([b_id], [b_gid], [b_p_gid], [b_path], [b_name], [b_img_size], [b_createUser], [b_createTime]) VALUES (10, N'581fc42d', N'e4f7afd1', N'15', N'趣事', N'60*60', N'admin', CAST(N'2017-08-28 17:04:50.000' AS DateTime))
INSERT [dbo].[Site_CMSBlock] ([b_id], [b_gid], [b_p_gid], [b_path], [b_name], [b_img_size], [b_createUser], [b_createTime]) VALUES (11, N'13045a51', N'e4f7afd1', N'16', N'美女', N'60*60', N'admin', CAST(N'2017-08-28 17:05:04.000' AS DateTime))
INSERT [dbo].[Site_CMSBlock] ([b_id], [b_gid], [b_p_gid], [b_path], [b_name], [b_img_size], [b_createUser], [b_createTime]) VALUES (12, N'59adfc5c', N'e4f7afd1', N'17', N'生活', N'60*60', N'admin', CAST(N'2017-08-28 17:05:17.000' AS DateTime))
INSERT [dbo].[Site_CMSBlock] ([b_id], [b_gid], [b_p_gid], [b_path], [b_name], [b_img_size], [b_createUser], [b_createTime]) VALUES (13, N'5ba3f049', N'e4f7afd1', N'18', N'搞笑', N'60*60', N'admin', CAST(N'2017-08-28 17:05:37.000' AS DateTime))
INSERT [dbo].[Site_CMSBlock] ([b_id], [b_gid], [b_p_gid], [b_path], [b_name], [b_img_size], [b_createUser], [b_createTime]) VALUES (14, N'6a8c593d', N'e4f7afd1', N'19', N'斗图', N'60*60', N'admin', CAST(N'2017-08-28 17:05:49.000' AS DateTime))
INSERT [dbo].[Site_CMSBlock] ([b_id], [b_gid], [b_p_gid], [b_path], [b_name], [b_img_size], [b_createUser], [b_createTime]) VALUES (6, N'a7e4044e', N'33f112c1', N'10', N'周阅读排行', N'', N'admin', CAST(N'2017-08-28 15:57:51.000' AS DateTime))
INSERT [dbo].[Site_CMSBlock] ([b_id], [b_gid], [b_p_gid], [b_path], [b_name], [b_img_size], [b_createUser], [b_createTime]) VALUES (7, N'c21fde81', N'33f112c1', N'11', N'热门推荐', N'', N'admin', CAST(N'2017-08-28 15:58:05.000' AS DateTime))
INSERT [dbo].[Site_CMSBlock] ([b_id], [b_gid], [b_p_gid], [b_path], [b_name], [b_img_size], [b_createUser], [b_createTime]) VALUES (8, N'3484a8bd', N'33f112c1', N'12', N'热辣美女', N'240*240', N'admin', CAST(N'2017-08-28 15:58:20.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Site_CMSBlock] OFF
SET IDENTITY_INSERT [dbo].[Site_CMSItem] ON 

INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (1006, N'f2ee85f4', N'ff98b921', N'e4f7afd1', N'英国女王计划95岁退休', N'5663a04c', N'', N'英国女王计划95岁退休', N'英国女王计划95岁退休', N'http://img.jsonyang.com/2017/08/14/e1f5424b-b2b2-44_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-21 17:37:14.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (6, N'846d09d0', N'ff98b921', N'e4f7afd1', N'贾跃亭把一切给了公司', N'99853f87', N'', N'贾跃亭把一切给了公司', N'乐视：贾跃亭把一切给了公司 所有债务一个人扛', N'http://img.jsonyang.com/2017/08/14/b1f03e2c-ea31-41_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-18 16:57:54.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (1007, N'8b9a61e0', N'ff98b921', N'e4f7afd1', N'富豪殴打区委书记真相', N'5247938e', N'', N'富豪殴打区委书记真相', N'区委书记遭富豪殴打5天后已经上班 背后真相是啥', N'http://img.jsonyang.com/2017/08/18/66f118cf-ba99-43_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-21 17:37:14.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (1008, N'cab3de7e', N'ff98b921', N'e4f7afd1', N'习近平带领我们走过的这不平凡五年', N'5f7771b0', N'', N'习近平带领我们走过的这不平凡五年', N'习近平带领我们走过的这不平凡五年', N'http://img.jsonyang.com/2017/08/14/5ee9ead9-26bb-4a_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-21 17:37:14.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (7, N'3124cb0f', N'ff98b921', N'e4f7afd1', N'川西长途试力帆X80', N'e65ee665', N'', N'川西长途试力帆X80', N'顶配大七座不到15万 川西长途试力帆X80', N'http://img.jsonyang.com/2017/08/14/43785560-91c4-44_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-18 18:38:45.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2012, N'e18f58e7', N'b92abf4b', N'2e94db1d', N'首页', N'', N'', N'首页', N' ', N'', 2, N'admin', CAST(N'2017-08-24 12:36:06.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2013, N'8c53cfd2', N'b92abf4b', N'2e94db1d', N'要闻', N'', N'', N'要闻', N'1', N'', 2, N'admin', CAST(N'2017-08-24 12:36:38.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2014, N'b971355f', N'b92abf4b', N'2e94db1d', N'趣事', N'', N'', N'趣事', N'6', N'', 2, N'admin', CAST(N'2017-08-24 12:36:46.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2015, N'7c41c5c6', N'b92abf4b', N'2e94db1d', N'美女', N'', N'', N'美女', N'7', N'', 2, N'admin', CAST(N'2017-08-24 12:36:57.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2016, N'33bc1cb2', N'b92abf4b', N'2e94db1d', N'生活', N'', N'', N'生活', N'8', N'', 2, N'admin', CAST(N'2017-08-24 12:37:05.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2017, N'15cf5487', N'716d33eb', N'e4f7afd1', N'娇艳大奶美女', N'51aa82c9', N'', N'娇艳大奶美女', N'火辣娇艳大奶美女丰乳翘臀惹火娇媚销魂性感写真', N'http://img.jsonyang.com/2017/08/24/d3f324d6-90f0-43_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-24 14:21:14.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2018, N'b5ca1f6e', N'716d33eb', N'e4f7afd1', N'比基尼热辣美女洗车', N'073c85ef', N'', N'比基尼热辣美女洗车', N'比基尼热辣美女洗车 引市民围观', N'http://img.jsonyang.com/2017/08/24/2233a4c0-d549-42_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-24 14:21:14.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2019, N'412e4180', N'716d33eb', N'e4f7afd1', N'惹火销魂女神巨胸', N'b94c2872', N'', N'惹火销魂女神巨胸', N'惹火销魂女神巨胸 让人瞬间窒息大奶销魂火辣诱惑写真', N'http://img.jsonyang.com/2017/08/24/6b4912a1-85e5-4f_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-24 14:22:52.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2028, N'033101a1', N'a7e4044e', N'33f112c1', N'川西长途试力帆X80', N'e65ee665', N'', N'川西长途试力帆X80', N'顶配大七座不到15万 川西长途试力帆X80', N'http://img.jsonyang.com/2017/08/14/43785560-91c4-44_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 15:58:29.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2029, N'd18bf9ef', N'a7e4044e', N'33f112c1', N'贾跃亭把一切给了公司', N'99853f87', N'', N'贾跃亭把一切给了公司', N'乐视：贾跃亭把一切给了公司 所有债务一个人扛', N'http://img.jsonyang.com/2017/08/14/b1f03e2c-ea31-41_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 15:58:30.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2030, N'db32cf5d', N'a7e4044e', N'33f112c1', N'英国女王计划95岁退休', N'5663a04c', N'', N'英国女王计划95岁退休', N'英国女王计划95岁退休', N'http://img.jsonyang.com/2017/08/14/e1f5424b-b2b2-44_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 15:58:30.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2031, N'b0a1c771', N'a7e4044e', N'33f112c1', N'富豪殴打区委书记真相', N'5247938e', N'', N'富豪殴打区委书记真相', N'区委书记遭富豪殴打5天后已经上班 背后真相是啥', N'http://img.jsonyang.com/2017/08/18/66f118cf-ba99-43_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 15:58:30.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2032, N'24f417ca', N'a7e4044e', N'33f112c1', N'习近平带领我们走过的这不平凡五年', N'5f7771b0', N'', N'习近平带领我们走过的这不平凡五年', N'习近平带领我们走过的这不平凡五年', N'http://img.jsonyang.com/2017/08/14/5ee9ead9-26bb-4a_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 15:58:30.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2033, N'5da70cc3', N'c21fde81', N'33f112c1', N'川西长途试力帆X80', N'e65ee665', N'', N'川西长途试力帆X80', N'顶配大七座不到15万 川西长途试力帆X80', N'http://img.jsonyang.com/2017/08/14/43785560-91c4-44_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 15:58:32.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2034, N'7e977542', N'c21fde81', N'33f112c1', N'贾跃亭把一切给了公司', N'99853f87', N'', N'贾跃亭把一切给了公司', N'乐视：贾跃亭把一切给了公司 所有债务一个人扛', N'http://img.jsonyang.com/2017/08/14/b1f03e2c-ea31-41_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 15:58:32.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2035, N'1b74f90b', N'c21fde81', N'33f112c1', N'英国女王计划95岁退休', N'5663a04c', N'', N'英国女王计划95岁退休', N'英国女王计划95岁退休', N'http://img.jsonyang.com/2017/08/14/e1f5424b-b2b2-44_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 15:58:32.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2036, N'910d9e0f', N'c21fde81', N'33f112c1', N'富豪殴打区委书记真相', N'5247938e', N'', N'富豪殴打区委书记真相', N'区委书记遭富豪殴打5天后已经上班 背后真相是啥', N'http://img.jsonyang.com/2017/08/18/66f118cf-ba99-43_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 15:58:32.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2037, N'3e2bfcbe', N'c21fde81', N'33f112c1', N'习近平带领我们走过的这不平凡五年', N'5f7771b0', N'', N'习近平带领我们走过的这不平凡五年', N'习近平带领我们走过的这不平凡五年', N'http://img.jsonyang.com/2017/08/14/5ee9ead9-26bb-4a_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 15:58:32.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2038, N'423d117d', N'3484a8bd', N'33f112c1', N'川西长途试力帆X80', N'e65ee665', N'', N'川西长途试力帆X80', N'顶配大七座不到15万 川西长途试力帆X80', N'http://img.jsonyang.com/2017/08/14/43785560-91c4-44_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 15:58:34.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2052, N'27ee2d9e', N'6a8c593d', N'e4f7afd1', N'川西长途试力帆X80', N'e65ee665', N'', N'川西长途试力帆X80', N'顶配大七座不到15万 川西长途试力帆X80', N'http://img.jsonyang.com/2017/08/14/43785560-91c4-44_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 17:06:15.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2053, N'ddc7d0ae', N'6a8c593d', N'e4f7afd1', N'贾跃亭把一切给了公司', N'99853f87', N'', N'贾跃亭把一切给了公司', N'乐视：贾跃亭把一切给了公司 所有债务一个人扛', N'http://img.jsonyang.com/2017/08/14/b1f03e2c-ea31-41_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 17:06:15.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2054, N'78120304', N'6a8c593d', N'e4f7afd1', N'英国女王计划95岁退休', N'5663a04c', N'', N'英国女王计划95岁退休', N'英国女王计划95岁退休', N'http://img.jsonyang.com/2017/08/14/e1f5424b-b2b2-44_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 17:06:15.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2055, N'761de915', N'6a8c593d', N'e4f7afd1', N'富豪殴打区委书记真相', N'5247938e', N'', N'富豪殴打区委书记真相', N'区委书记遭富豪殴打5天后已经上班 背后真相是啥', N'http://img.jsonyang.com/2017/08/18/66f118cf-ba99-43_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 17:06:15.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2043, N'ef2b0fa1', N'a7e4044e', N'33f112c1', N'惹火销魂女神巨胸', N'b94c2872', N'', N'惹火销魂女神巨胸', N'惹火销魂女神巨胸 让人瞬间窒息大奶销魂火辣诱惑写真', N'http://img.jsonyang.com/2017/08/24/6b4912a1-85e5-4f_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 15:58:47.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2044, N'f245af8a', N'a7e4044e', N'33f112c1', N'娇艳大奶美女', N'51aa82c9', N'', N'娇艳大奶美女', N'火辣娇艳大奶美女丰乳翘臀惹火娇媚销魂性感写真', N'http://img.jsonyang.com/2017/08/24/d3f324d6-90f0-43_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 15:58:47.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2045, N'c00be2f7', N'a7e4044e', N'33f112c1', N'比基尼热辣美女洗车', N'073c85ef', N'', N'比基尼热辣美女洗车', N'比基尼热辣美女洗车 引市民围观', N'http://img.jsonyang.com/2017/08/24/2233a4c0-d549-42_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 15:58:47.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2046, N'1113e776', N'c21fde81', N'33f112c1', N'惹火销魂女神巨胸', N'b94c2872', N'', N'惹火销魂女神巨胸', N'惹火销魂女神巨胸 让人瞬间窒息大奶销魂火辣诱惑写真', N'http://img.jsonyang.com/2017/08/24/6b4912a1-85e5-4f_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 15:58:48.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2047, N'80801ffe', N'c21fde81', N'33f112c1', N'娇艳大奶美女', N'51aa82c9', N'', N'娇艳大奶美女', N'火辣娇艳大奶美女丰乳翘臀惹火娇媚销魂性感写真', N'http://img.jsonyang.com/2017/08/24/d3f324d6-90f0-43_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 15:58:48.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2048, N'b33a6b1f', N'c21fde81', N'33f112c1', N'比基尼热辣美女洗车', N'073c85ef', N'', N'比基尼热辣美女洗车', N'比基尼热辣美女洗车 引市民围观', N'http://img.jsonyang.com/2017/08/24/2233a4c0-d549-42_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 15:58:48.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2049, N'69d0b638', N'3484a8bd', N'33f112c1', N'惹火销魂女神巨胸', N'b94c2872', N'', N'惹火销魂女神巨胸', N'惹火销魂女神巨胸 让人瞬间窒息大奶销魂火辣诱惑写真', N'http://img.jsonyang.com/2017/08/24/6b4912a1-85e5-4f_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 15:58:50.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2050, N'42daf09e', N'3484a8bd', N'33f112c1', N'娇艳大奶美女', N'51aa82c9', N'', N'娇艳大奶美女', N'火辣娇艳大奶美女丰乳翘臀惹火娇媚销魂性感写真', N'http://img.jsonyang.com/2017/08/24/d3f324d6-90f0-43_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 15:58:50.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2020, N'feb5cccc', N'7ecd6a13', N'e4f7afd1', N'川西长途试力帆X80', N'e65ee665', N'', N'川西长途试力帆X80', N'顶配大七座不到15万 川西长途试力帆X80', N'http://img.jsonyang.com/2017/08/14/43785560-91c4-44_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-24 14:32:38.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2021, N'96f023aa', N'7ecd6a13', N'e4f7afd1', N'贾跃亭把一切给了公司', N'99853f87', N'', N'贾跃亭把一切给了公司', N'乐视：贾跃亭把一切给了公司 所有债务一个人扛', N'http://img.jsonyang.com/2017/08/14/b1f03e2c-ea31-41_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-24 14:32:38.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2022, N'c924de35', N'7ecd6a13', N'e4f7afd1', N'英国女王计划95岁退休', N'5663a04c', N'', N'英国女王计划95岁退休', N'英国女王计划95岁退休', N'http://img.jsonyang.com/2017/08/14/e1f5424b-b2b2-44_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-24 14:32:38.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2023, N'fdd263ea', N'7ecd6a13', N'e4f7afd1', N'富豪殴打区委书记真相', N'5247938e', N'', N'富豪殴打区委书记真相', N'区委书记遭富豪殴打5天后已经上班 背后真相是啥', N'http://img.jsonyang.com/2017/08/18/66f118cf-ba99-43_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-24 14:32:38.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2024, N'5824545b', N'7ecd6a13', N'e4f7afd1', N'习近平带领我们走过的这不平凡五年', N'5f7771b0', N'', N'习近平带领我们走过的这不平凡五年', N'习近平带领我们走过的这不平凡五年', N'http://img.jsonyang.com/2017/08/14/5ee9ead9-26bb-4a_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-24 14:32:38.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2025, N'26d704d4', N'7ecd6a13', N'e4f7afd1', N'惹火销魂女神巨胸', N'b94c2872', N'', N'惹火销魂女神巨胸', N'惹火销魂女神巨胸 让人瞬间窒息大奶销魂火辣诱惑写真', N'http://img.jsonyang.com/2017/08/24/6b4912a1-85e5-4f_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-24 14:32:48.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2026, N'ba63b7f3', N'7ecd6a13', N'e4f7afd1', N'娇艳大奶美女', N'51aa82c9', N'', N'娇艳大奶美女', N'火辣娇艳大奶美女丰乳翘臀惹火娇媚销魂性感写真', N'http://img.jsonyang.com/2017/08/24/d3f324d6-90f0-43_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-24 14:32:48.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2027, N'9a57f943', N'7ecd6a13', N'e4f7afd1', N'比基尼热辣美女洗车', N'073c85ef', N'', N'比基尼热辣美女洗车', N'比基尼热辣美女洗车 引市民围观', N'http://img.jsonyang.com/2017/08/24/2233a4c0-d549-42_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-24 14:32:48.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2051, N'18561bdb', N'3484a8bd', N'33f112c1', N'比基尼热辣美女洗车', N'073c85ef', N'', N'比基尼热辣美女洗车', N'比基尼热辣美女洗车 引市民围观', N'http://img.jsonyang.com/2017/08/24/2233a4c0-d549-42_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 15:58:50.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2100, N'43db13cc', N'b92abf4b', N'2e94db1d', N'搞笑', N'', N'', N'搞笑', N'9', N'', 2, N'admin', CAST(N'2017-08-28 17:20:09.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2101, N'dfdcaea1', N'b92abf4b', N'2e94db1d', N'斗图', N'', N'', N'斗图', N'10', N'', 2, N'admin', CAST(N'2017-08-28 17:20:18.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2056, N'11564e41', N'6a8c593d', N'e4f7afd1', N'习近平带领我们走过的这不平凡五年', N'5f7771b0', N'', N'习近平带领我们走过的这不平凡五年', N'习近平带领我们走过的这不平凡五年', N'http://img.jsonyang.com/2017/08/14/5ee9ead9-26bb-4a_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 17:06:15.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2057, N'd8e57493', N'5ba3f049', N'e4f7afd1', N'川西长途试力帆X80', N'e65ee665', N'', N'川西长途试力帆X80', N'顶配大七座不到15万 川西长途试力帆X80', N'http://img.jsonyang.com/2017/08/14/43785560-91c4-44_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 17:06:16.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2058, N'f99cb926', N'5ba3f049', N'e4f7afd1', N'贾跃亭把一切给了公司', N'99853f87', N'', N'贾跃亭把一切给了公司', N'乐视：贾跃亭把一切给了公司 所有债务一个人扛', N'http://img.jsonyang.com/2017/08/14/b1f03e2c-ea31-41_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 17:06:16.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2059, N'4c9a04ec', N'5ba3f049', N'e4f7afd1', N'英国女王计划95岁退休', N'5663a04c', N'', N'英国女王计划95岁退休', N'英国女王计划95岁退休', N'http://img.jsonyang.com/2017/08/14/e1f5424b-b2b2-44_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 17:06:16.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2060, N'fa276b25', N'5ba3f049', N'e4f7afd1', N'富豪殴打区委书记真相', N'5247938e', N'', N'富豪殴打区委书记真相', N'区委书记遭富豪殴打5天后已经上班 背后真相是啥', N'http://img.jsonyang.com/2017/08/18/66f118cf-ba99-43_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 17:06:16.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2061, N'f1428ded', N'5ba3f049', N'e4f7afd1', N'习近平带领我们走过的这不平凡五年', N'5f7771b0', N'', N'习近平带领我们走过的这不平凡五年', N'习近平带领我们走过的这不平凡五年', N'http://img.jsonyang.com/2017/08/14/5ee9ead9-26bb-4a_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 17:06:16.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2062, N'84d52190', N'59adfc5c', N'e4f7afd1', N'川西长途试力帆X80', N'e65ee665', N'', N'川西长途试力帆X80', N'顶配大七座不到15万 川西长途试力帆X80', N'http://img.jsonyang.com/2017/08/14/43785560-91c4-44_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 17:06:20.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2063, N'adb20568', N'59adfc5c', N'e4f7afd1', N'贾跃亭把一切给了公司', N'99853f87', N'', N'贾跃亭把一切给了公司', N'乐视：贾跃亭把一切给了公司 所有债务一个人扛', N'http://img.jsonyang.com/2017/08/14/b1f03e2c-ea31-41_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 17:06:20.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2064, N'da494faa', N'59adfc5c', N'e4f7afd1', N'英国女王计划95岁退休', N'5663a04c', N'', N'英国女王计划95岁退休', N'英国女王计划95岁退休', N'http://img.jsonyang.com/2017/08/14/e1f5424b-b2b2-44_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 17:06:20.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2065, N'88fd9cd0', N'59adfc5c', N'e4f7afd1', N'富豪殴打区委书记真相', N'5247938e', N'', N'富豪殴打区委书记真相', N'区委书记遭富豪殴打5天后已经上班 背后真相是啥', N'http://img.jsonyang.com/2017/08/18/66f118cf-ba99-43_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 17:06:20.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2066, N'f39924ea', N'59adfc5c', N'e4f7afd1', N'习近平带领我们走过的这不平凡五年', N'5f7771b0', N'', N'习近平带领我们走过的这不平凡五年', N'习近平带领我们走过的这不平凡五年', N'http://img.jsonyang.com/2017/08/14/5ee9ead9-26bb-4a_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 17:06:20.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2067, N'663f899b', N'13045a51', N'e4f7afd1', N'川西长途试力帆X80', N'e65ee665', N'', N'川西长途试力帆X80', N'顶配大七座不到15万 川西长途试力帆X80', N'http://img.jsonyang.com/2017/08/14/43785560-91c4-44_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 17:06:23.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2068, N'24ea3bc7', N'13045a51', N'e4f7afd1', N'贾跃亭把一切给了公司', N'99853f87', N'', N'贾跃亭把一切给了公司', N'乐视：贾跃亭把一切给了公司 所有债务一个人扛', N'http://img.jsonyang.com/2017/08/14/b1f03e2c-ea31-41_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 17:06:23.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2069, N'c03c33f2', N'13045a51', N'e4f7afd1', N'英国女王计划95岁退休', N'5663a04c', N'', N'英国女王计划95岁退休', N'英国女王计划95岁退休', N'http://img.jsonyang.com/2017/08/14/e1f5424b-b2b2-44_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 17:06:23.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2070, N'1a0cb3b6', N'13045a51', N'e4f7afd1', N'富豪殴打区委书记真相', N'5247938e', N'', N'富豪殴打区委书记真相', N'区委书记遭富豪殴打5天后已经上班 背后真相是啥', N'http://img.jsonyang.com/2017/08/18/66f118cf-ba99-43_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 17:06:23.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2071, N'ab8addec', N'13045a51', N'e4f7afd1', N'习近平带领我们走过的这不平凡五年', N'5f7771b0', N'', N'习近平带领我们走过的这不平凡五年', N'习近平带领我们走过的这不平凡五年', N'http://img.jsonyang.com/2017/08/14/5ee9ead9-26bb-4a_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 17:06:23.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2072, N'5c1ac8d4', N'581fc42d', N'e4f7afd1', N'川西长途试力帆X80', N'e65ee665', N'', N'川西长途试力帆X80', N'顶配大七座不到15万 川西长途试力帆X80', N'http://img.jsonyang.com/2017/08/14/43785560-91c4-44_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 17:06:25.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2073, N'8a08ca7c', N'581fc42d', N'e4f7afd1', N'贾跃亭把一切给了公司', N'99853f87', N'', N'贾跃亭把一切给了公司', N'乐视：贾跃亭把一切给了公司 所有债务一个人扛', N'http://img.jsonyang.com/2017/08/14/b1f03e2c-ea31-41_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 17:06:25.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2074, N'55097be7', N'581fc42d', N'e4f7afd1', N'英国女王计划95岁退休', N'5663a04c', N'', N'英国女王计划95岁退休', N'英国女王计划95岁退休', N'http://img.jsonyang.com/2017/08/14/e1f5424b-b2b2-44_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 17:06:25.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2075, N'3a0d4feb', N'581fc42d', N'e4f7afd1', N'富豪殴打区委书记真相', N'5247938e', N'', N'富豪殴打区委书记真相', N'区委书记遭富豪殴打5天后已经上班 背后真相是啥', N'http://img.jsonyang.com/2017/08/18/66f118cf-ba99-43_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 17:06:25.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2076, N'da2041a7', N'581fc42d', N'e4f7afd1', N'习近平带领我们走过的这不平凡五年', N'5f7771b0', N'', N'习近平带领我们走过的这不平凡五年', N'习近平带领我们走过的这不平凡五年', N'http://img.jsonyang.com/2017/08/14/5ee9ead9-26bb-4a_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 17:06:26.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2077, N'2304cefd', N'9f1272c7', N'e4f7afd1', N'川西长途试力帆X80', N'e65ee665', N'', N'川西长途试力帆X80', N'顶配大七座不到15万 川西长途试力帆X80', N'http://img.jsonyang.com/2017/08/14/43785560-91c4-44_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 17:06:28.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2078, N'c1b97001', N'9f1272c7', N'e4f7afd1', N'贾跃亭把一切给了公司', N'99853f87', N'', N'贾跃亭把一切给了公司', N'乐视：贾跃亭把一切给了公司 所有债务一个人扛', N'http://img.jsonyang.com/2017/08/14/b1f03e2c-ea31-41_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 17:06:28.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2079, N'6645b736', N'9f1272c7', N'e4f7afd1', N'英国女王计划95岁退休', N'5663a04c', N'', N'英国女王计划95岁退休', N'英国女王计划95岁退休', N'http://img.jsonyang.com/2017/08/14/e1f5424b-b2b2-44_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 17:06:28.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2080, N'7292d301', N'9f1272c7', N'e4f7afd1', N'富豪殴打区委书记真相', N'5247938e', N'', N'富豪殴打区委书记真相', N'区委书记遭富豪殴打5天后已经上班 背后真相是啥', N'http://img.jsonyang.com/2017/08/18/66f118cf-ba99-43_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 17:06:28.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2081, N'f5b730e6', N'9f1272c7', N'e4f7afd1', N'习近平带领我们走过的这不平凡五年', N'5f7771b0', N'', N'习近平带领我们走过的这不平凡五年', N'习近平带领我们走过的这不平凡五年', N'http://img.jsonyang.com/2017/08/14/5ee9ead9-26bb-4a_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 17:06:28.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2082, N'2ef6e2a4', N'9f1272c7', N'e4f7afd1', N'惹火销魂女神巨胸', N'b94c2872', N'', N'惹火销魂女神巨胸', N'惹火销魂女神巨胸 让人瞬间窒息大奶销魂火辣诱惑写真', N'http://img.jsonyang.com/2017/08/24/6b4912a1-85e5-4f_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 17:06:36.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2083, N'387e8000', N'9f1272c7', N'e4f7afd1', N'娇艳大奶美女', N'51aa82c9', N'', N'娇艳大奶美女', N'火辣娇艳大奶美女丰乳翘臀惹火娇媚销魂性感写真', N'http://img.jsonyang.com/2017/08/24/d3f324d6-90f0-43_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 17:06:36.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2084, N'dbde7560', N'9f1272c7', N'e4f7afd1', N'比基尼热辣美女洗车', N'073c85ef', N'', N'比基尼热辣美女洗车', N'比基尼热辣美女洗车 引市民围观', N'http://img.jsonyang.com/2017/08/24/2233a4c0-d549-42_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 17:06:36.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2085, N'c64f630c', N'581fc42d', N'e4f7afd1', N'惹火销魂女神巨胸', N'b94c2872', N'', N'惹火销魂女神巨胸', N'惹火销魂女神巨胸 让人瞬间窒息大奶销魂火辣诱惑写真', N'http://img.jsonyang.com/2017/08/24/6b4912a1-85e5-4f_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 17:06:39.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2086, N'b20400f6', N'581fc42d', N'e4f7afd1', N'娇艳大奶美女', N'51aa82c9', N'', N'娇艳大奶美女', N'火辣娇艳大奶美女丰乳翘臀惹火娇媚销魂性感写真', N'http://img.jsonyang.com/2017/08/24/d3f324d6-90f0-43_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 17:06:39.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2087, N'ef12229c', N'581fc42d', N'e4f7afd1', N'比基尼热辣美女洗车', N'073c85ef', N'', N'比基尼热辣美女洗车', N'比基尼热辣美女洗车 引市民围观', N'http://img.jsonyang.com/2017/08/24/2233a4c0-d549-42_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 17:06:39.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2088, N'13125099', N'13045a51', N'e4f7afd1', N'惹火销魂女神巨胸', N'b94c2872', N'', N'惹火销魂女神巨胸', N'惹火销魂女神巨胸 让人瞬间窒息大奶销魂火辣诱惑写真', N'http://img.jsonyang.com/2017/08/24/6b4912a1-85e5-4f_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 17:06:41.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2089, N'4c726631', N'13045a51', N'e4f7afd1', N'娇艳大奶美女', N'51aa82c9', N'', N'娇艳大奶美女', N'火辣娇艳大奶美女丰乳翘臀惹火娇媚销魂性感写真', N'http://img.jsonyang.com/2017/08/24/d3f324d6-90f0-43_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 17:06:41.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2090, N'38e8fbdf', N'13045a51', N'e4f7afd1', N'比基尼热辣美女洗车', N'073c85ef', N'', N'比基尼热辣美女洗车', N'比基尼热辣美女洗车 引市民围观', N'http://img.jsonyang.com/2017/08/24/2233a4c0-d549-42_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 17:06:41.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2091, N'd4d9625c', N'59adfc5c', N'e4f7afd1', N'惹火销魂女神巨胸', N'b94c2872', N'', N'惹火销魂女神巨胸', N'惹火销魂女神巨胸 让人瞬间窒息大奶销魂火辣诱惑写真', N'http://img.jsonyang.com/2017/08/24/6b4912a1-85e5-4f_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 17:06:44.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2092, N'e79bc56a', N'59adfc5c', N'e4f7afd1', N'娇艳大奶美女', N'51aa82c9', N'', N'娇艳大奶美女', N'火辣娇艳大奶美女丰乳翘臀惹火娇媚销魂性感写真', N'http://img.jsonyang.com/2017/08/24/d3f324d6-90f0-43_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 17:06:44.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2093, N'b0121b9e', N'59adfc5c', N'e4f7afd1', N'比基尼热辣美女洗车', N'073c85ef', N'', N'比基尼热辣美女洗车', N'比基尼热辣美女洗车 引市民围观', N'http://img.jsonyang.com/2017/08/24/2233a4c0-d549-42_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 17:06:44.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2094, N'cff00806', N'5ba3f049', N'e4f7afd1', N'惹火销魂女神巨胸', N'b94c2872', N'', N'惹火销魂女神巨胸', N'惹火销魂女神巨胸 让人瞬间窒息大奶销魂火辣诱惑写真', N'http://img.jsonyang.com/2017/08/24/6b4912a1-85e5-4f_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 17:06:46.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2095, N'd9ca781d', N'5ba3f049', N'e4f7afd1', N'娇艳大奶美女', N'51aa82c9', N'', N'娇艳大奶美女', N'火辣娇艳大奶美女丰乳翘臀惹火娇媚销魂性感写真', N'http://img.jsonyang.com/2017/08/24/d3f324d6-90f0-43_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 17:06:46.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2096, N'fd9a925f', N'5ba3f049', N'e4f7afd1', N'比基尼热辣美女洗车', N'073c85ef', N'', N'比基尼热辣美女洗车', N'比基尼热辣美女洗车 引市民围观', N'http://img.jsonyang.com/2017/08/24/2233a4c0-d549-42_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 17:06:46.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2097, N'bf908343', N'6a8c593d', N'e4f7afd1', N'惹火销魂女神巨胸', N'b94c2872', N'', N'惹火销魂女神巨胸', N'惹火销魂女神巨胸 让人瞬间窒息大奶销魂火辣诱惑写真', N'http://img.jsonyang.com/2017/08/24/6b4912a1-85e5-4f_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 17:06:47.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2098, N'a1bdfcf5', N'6a8c593d', N'e4f7afd1', N'娇艳大奶美女', N'51aa82c9', N'', N'娇艳大奶美女', N'火辣娇艳大奶美女丰乳翘臀惹火娇媚销魂性感写真', N'http://img.jsonyang.com/2017/08/24/d3f324d6-90f0-43_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 17:06:47.000' AS DateTime))
INSERT [dbo].[Site_CMSItem] ([i_id], [i_gid], [i_b_gid], [i_p_gid], [i_title], [i_c_gid], [i_c_type], [i_subTitle], [i_intro], [i_c_img_src], [i_status], [i_createUser], [i_createTime]) VALUES (2099, N'353b7475', N'6a8c593d', N'e4f7afd1', N'比基尼热辣美女洗车', N'073c85ef', N'', N'比基尼热辣美女洗车', N'比基尼热辣美女洗车 引市民围观', N'http://img.jsonyang.com/2017/08/24/2233a4c0-d549-42_700x10000x1.jpg', 2, N'admin', CAST(N'2017-08-28 17:06:47.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Site_CMSItem] OFF
SET IDENTITY_INSERT [dbo].[Site_CMSPage] ON 

INSERT [dbo].[Site_CMSPage] ([p_id], [p_gid], [p_name], [p_path], [p_tempPath], [p_filePath], [p_createTime], [p_createUser], [p_pageDuty], [p_siteName]) VALUES (1, N'fbe22aa6', N'BBS站点页面', N'21', N'', N'', CAST(N'2015-11-02 16:55:31.000' AS DateTime), N'admin', N'admin', 2)
INSERT [dbo].[Site_CMSPage] ([p_id], [p_gid], [p_name], [p_path], [p_tempPath], [p_filePath], [p_createTime], [p_createUser], [p_pageDuty], [p_siteName]) VALUES (2, N'1b0ded58', N'首页热点大图', N'2101', N'~/Views/Template/demo_template.cshtml', N'~/Views/Home/Test.cshtml', CAST(N'2015-11-02 16:57:46.000' AS DateTime), N'admin', N'admin', 2)
INSERT [dbo].[Site_CMSPage] ([p_id], [p_gid], [p_name], [p_path], [p_tempPath], [p_filePath], [p_createTime], [p_createUser], [p_pageDuty], [p_siteName]) VALUES (3, N'e4f7afd1', N'首页', N'1101', N'~/Views/Template/Main_Index_Temp.cshtml', N'~/Views/Home/Index.cshtml', CAST(N'2015-11-02 17:10:36.000' AS DateTime), N'admin', N'admin', 1)
INSERT [dbo].[Site_CMSPage] ([p_id], [p_gid], [p_name], [p_path], [p_tempPath], [p_filePath], [p_createTime], [p_createUser], [p_pageDuty], [p_siteName]) VALUES (4, N'5e248be7', N'主站点页面', N'11', N'', N'', CAST(N'2015-11-02 17:11:12.000' AS DateTime), N'admin', N'admin', 1)
INSERT [dbo].[Site_CMSPage] ([p_id], [p_gid], [p_name], [p_path], [p_tempPath], [p_filePath], [p_createTime], [p_createUser], [p_pageDuty], [p_siteName]) VALUES (5, N'c0dec77e', N'页尾', N'1102', N'~/Views/Template/Main_Index_Foot_Temp.cshtml', N'~/Views/Common/Index_Foot.cshtml', CAST(N'2017-06-07 16:29:17.000' AS DateTime), N'admin', N'admin', 1)
INSERT [dbo].[Site_CMSPage] ([p_id], [p_gid], [p_name], [p_path], [p_tempPath], [p_filePath], [p_createTime], [p_createUser], [p_pageDuty], [p_siteName]) VALUES (1005, N'01393ae7', N'导航', N'12', N'', N'', CAST(N'2017-08-24 09:12:06.000' AS DateTime), N'admin', N'admin', 1)
INSERT [dbo].[Site_CMSPage] ([p_id], [p_gid], [p_name], [p_path], [p_tempPath], [p_filePath], [p_createTime], [p_createUser], [p_pageDuty], [p_siteName]) VALUES (1006, N'2e94db1d', N'首页导航栏', N'1201', N'~/Views/Template/Main_Index_Nav_Temp.cshtml', N'~/Views/Home/Index_Nav.cshtml', CAST(N'2017-08-24 09:14:18.000' AS DateTime), N'admin', N'admin', 1)
INSERT [dbo].[Site_CMSPage] ([p_id], [p_gid], [p_name], [p_path], [p_tempPath], [p_filePath], [p_createTime], [p_createUser], [p_pageDuty], [p_siteName]) VALUES (1007, N'33f112c1', N'列表页右侧', N'1103', N'~/Views/Template/Main_ListRight_Temp.cshtml', N'~/Views/Common/ListRight.cshtml', CAST(N'2017-08-28 15:55:35.000' AS DateTime), N'admin', N'admin', 1)
SET IDENTITY_INSERT [dbo].[Site_CMSPage] OFF
SET IDENTITY_INSERT [dbo].[Site_Content] ON 

INSERT [dbo].[Site_Content] ([c_id], [c_gid], [c_c_gid], [c_title], [c_sub_title], [c_keywords], [c_intro], [c_content], [c_img_src], [c_createUserId], [c_createUserName], [c_createUserNickName], [c_createTime], [c_status], [c_state]) VALUES (2, N'5247938e', N'2db7535d', N'区委书记遭富豪殴打5天后已经上班 背后真相是啥', N'富豪殴打区委书记真相', N'富豪、区委书记、殴打', N'区委书记遭富豪殴打5天后已经上班 背后真相是啥', N'<p style="margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(64, 64, 64); text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);">8月13日，陕西省榆林市纪委和榆林市警方，就8月4日晚榆林市横山区区委书记王效力到榆和饭店赴宴，遭该饭店老板白浩亭殴打一事做出通报。</p><p style="margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(64, 64, 64); text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);">通报称，<strong>王效力8月4日晚因公应横山籍一退休市级领导邀请就餐，就餐地方对外开放营业，并非高档私人会所，且由个人埋单，并未违反有关纪律规定。打人者白浩亭被行政拘留10日，处罚款500元，并公开进行道歉。</strong></p><p class="f_center" style="margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; font-stretch: normal; line-height: 32px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(64, 64, 64); text-align: center; white-space: normal; background-color: rgb(255, 255, 255);"></p><p style="margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(64, 64, 64); text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);">“政事儿”注意到，8月4日晚，王效力受人邀请，到榆和饭店赴宴，宴会期间遭榆和饭店老板白浩亭殴打，王效力身边工作人员将其送至榆林市第一医院急诊科。期间曾有穿公安制服的人员出入，5日凌晨1点左右，王效力离开医院。</p><p style="margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(64, 64, 64); text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);"><img src="http://img.jsonyang.com/2017/08/18/66f118cf-ba99-43_700x10000x1.jpg"/></p><p style="margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(64, 64, 64); text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);">8月9日下午，榆林市纪委宣传部一名张姓工作人员对“政事儿”表示，针对横山区委书记被打一事，榆林市纪委已介入调查，现在调查还没有结束。</p><p style="margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(64, 64, 64); text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);">王效力到榆和饭店赴宴，是否违反中央八项规定？该工作人员称，“<strong>等调查结束后，如果王效力违纪，会根据相关规定，进行严肃处理，处理结果会在榆林市纪委官网通报。</strong>”</p><p style="margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(64, 64, 64); text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);">据榆林市纪委调查，8月4日晚7点，横山区委书记王效力受邀与北京专家洽谈讨论《横山旅游暨无定河文化小镇概念性规划》的调研事宜，在榆和饭店8楼一雅间用餐，饭菜主要以地方菜为主，<strong>饮用价格339元的“榆和饭店专用酒”一瓶，88元的长城牌干红一瓶，一行8人饭菜酒水消费总金额1194元，其中一人个人埋单。</strong>榆林市纪委调查认为，<strong>王效力受邀请就餐情况属实，但该就餐地方对外开放营业，并非高档私人会所，不违反有关纪律规定。</strong></p><p class="f_center" style="margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; font-stretch: normal; line-height: 32px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(64, 64, 64); text-align: center; white-space: normal; background-color: rgb(255, 255, 255);"><img alt="区委书记遭富豪殴打5天后已经上班 背后真相是啥" src="http://img.jsonyang.com/2017/08/18/b7439575-5dbd-40_700x10000x1.jpg" id="netease1502668568335372"/></p><p style="margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(64, 64, 64); text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);">榆和饭店（图片来自第三方酒店预订服务商网站）</p><p style="margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(64, 64, 64); text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);">榆林市公安局榆阳分局调查显示，8月4日晚8点30分左右，<strong>王效力一行结束用餐准备离开时，饭店老板白浩亭拉着王效力到大厅茶座喝茶谈事，白浩亭索要其为横山区一煤矿矿建垫付的工程款，王效力表示此事属于区政府管理，不是区委的事情。</strong></p><p style="margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(64, 64, 64); text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);">8点48分许，<strong>二人话不投机，王效力离开茶座行至一楼大厅外，被酒店两名保安和两名服务员挡住拉回后，白浩亭便上前实施了殴打。</strong>在此过程中，王效力没有还手。随后被送往榆林市第一医院急诊室接受治疗。对于王效力的伤情，法医认为符合轻微伤。<strong>当事人白浩亭次日对办案民警表示，由于自己饮用大量白酒，对当晚发生的事情完全失忆。</strong></p><p style="margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(64, 64, 64); text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);">榆阳公安分局调查认为，白浩亭殴打他人一案事实清楚，证据确凿，根据《中华人民共和国治安管理处罚法》第四十三条第一款之规定，<strong>鉴于白浩亭系横山区人大代表，经横山区人大常委会许可</strong>，榆阳公安分局决定对白浩亭依法处以行政拘留10日，罚款500元，并责成向王效力本人和社会进行公开道歉。</p><p class="f_center" style="margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; font-stretch: normal; line-height: 32px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(64, 64, 64); text-align: center; white-space: normal; background-color: rgb(255, 255, 255);"><img alt="区委书记遭富豪殴打5天后已经上班 背后真相是啥" src="http://img.jsonyang.com/2017/08/18/85af8455-80ae-40_700x10000x1.jpg" id="netease1502668568335404"/></p><p style="margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(64, 64, 64); text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);">打人者白浩亭道歉信</p><p style="margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(64, 64, 64); text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);">“政事儿”注意到，在被白浩亭殴打5天后，横山区委书记王效力已开始正常上班。</p><p style="margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(64, 64, 64); text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);">8月10日，横山区委召开常委（扩大）会议，传达贯彻落实全省、全市领导干部大会精神，总结横山上半年工作，安排部署下一阶段重点工作。王效力主持会议并作总结讲话。</p><p class="f_center" style="margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; font-stretch: normal; line-height: 32px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(64, 64, 64); text-align: center; white-space: normal; background-color: rgb(255, 255, 255);"><img alt="区委书记遭富豪殴打5天后已经上班 背后真相是啥" src="http://img.jsonyang.com/2017/08/18/5b6f14f0-a50f-4f_700x10000x1.jpg" id="netease1502668568335824"/></p><p style="margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(64, 64, 64); text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);">王效力在讲话中说，<strong>“要守好勤政廉洁这个根本底线。每一名党员领导干部都要认真履职尽责，正确行使自己的权力，做到自身过硬，把岗位权力完全用在为老百姓服务上。要深刻领会习近平总书记关于从严治党的重要战略和重要指示，不该说的坚决不说、不该做的坚决不做。”</strong></p><p style="margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(64, 64, 64); text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);">王效力出生于1962年11月。他曾长期在榆林市团委工作，2005年后任府谷县副县长、县长，2011年任横山县县委书记。</p><p><br/></p>', N'http://img.jsonyang.com/2017/08/18/66f118cf-ba99-43_700x10000x1.jpg', N'', N'admin', N'', CAST(N'2017-06-02 22:53:19.200' AS DateTime), 2, 0)
INSERT [dbo].[Site_Content] ([c_id], [c_gid], [c_c_gid], [c_title], [c_sub_title], [c_keywords], [c_intro], [c_content], [c_img_src], [c_createUserId], [c_createUserName], [c_createUserNickName], [c_createTime], [c_status], [c_state]) VALUES (3, N'5f7771b0', N'2db7535d', N'习近平带领我们走过的这不平凡五年——外交篇', N'习近平带领我们走过的这不平凡五年', N'习近平、外交、带领', N'习近平带领我们走过的这不平凡五年', N'<p><strong style="color: rgb(64, 64, 64); font-family: &quot;Microsoft Yahei&quot;; font-size: 18px; text-align: justify; text-indent: 36px; white-space: normal; background-color: rgb(255, 255, 255);">央视网消息：</strong><span style="color: rgb(64, 64, 64); font-family: &quot;Microsoft Yahei&quot;; font-size: 18px; text-align: justify; text-indent: 36px; background-color: rgb(255, 255, 255);">7月26日至27日，习近平在省部级主要领导干部“学习习近平总书记重要讲话精神，迎接党的十九大”专题研讨班开班式上发表重要讲话强调，党的十八大以来的5年，是党和国家发展进程中很不平凡的5年。我们坚定不移推进中国特色大国外交，营造了我国发展的和平国际环境和良好周边环境。本图解梳理了党的十八大以来，习近平全面、深入阐述中国特色大国外交的部分理念，开创了中国外交的新特色、新风格、新气派。</span></p><p style="text-align:center"><span style="color: rgb(64, 64, 64); font-family: &quot;Microsoft Yahei&quot;; font-size: 18px; text-align: justify; text-indent: 36px; background-color: rgb(255, 255, 255);"><img src="http://img.jsonyang.com/2017/08/14/5ee9ead9-26bb-4a_700x10000x1.jpg" alt="5"/></span></p><p><span style="color: rgb(64, 64, 64); font-family: &quot;Microsoft Yahei&quot;; font-size: 18px; text-align: justify; text-indent: 36px; background-color: rgb(255, 255, 255);"></span></p>', N'http://img.jsonyang.com/2017/08/14/5ee9ead9-26bb-4a_700x10000x1.jpg', N'', N'admin', N'', CAST(N'2017-06-02 22:53:19.200' AS DateTime), 2, 0)
INSERT [dbo].[Site_Content] ([c_id], [c_gid], [c_c_gid], [c_title], [c_sub_title], [c_keywords], [c_intro], [c_content], [c_img_src], [c_createUserId], [c_createUserName], [c_createUserNickName], [c_createTime], [c_status], [c_state]) VALUES (1003, N'5663a04c', N'2db7535d', N'英国女王或95岁退休 英国网友反对查尔斯王子继位', N'英国女王计划95岁退休', N'英国女王、退休', N'英国女王计划95岁退休', N'<p><strong style="color: rgb(64, 64, 64); font-family: &quot;Microsoft Yahei&quot;; font-size: 18px; text-align: justify; text-indent: 36px; white-space: normal; background-color: rgb(255, 255, 255);">海外网8月14日电&nbsp;</strong><span style="color: rgb(64, 64, 64); font-family: &quot;Microsoft Yahei&quot;; font-size: 18px; text-align: justify; text-indent: 36px; background-color: rgb(255, 255, 255);">据英国王室消息人士透露，现年91岁的英国女王伊丽莎白二世打算在95岁的时候退休，计划届时实施摄政法案，让她的儿子查尔斯王子担任摄政王。</span></p><p style="text-align: center;"><span style="color: rgb(64, 64, 64); font-family: &quot;Microsoft Yahei&quot;; font-size: 18px; text-align: justify; text-indent: 36px; background-color: rgb(255, 255, 255);"><img src="http://img.jsonyang.com/2017/08/14/e1f5424b-b2b2-44_700x10000x1.jpg" alt="600_phpl3Kcsl.jpg"/></span></p><p><span style="color: rgb(64, 64, 64); font-family: &quot;Microsoft Yahei&quot;; font-size: 18px; text-align: justify; text-indent: 36px; background-color: rgb(255, 255, 255);"></span></p><p style="margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(64, 64, 64); text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);">摄政法案是英国摄政制度的法律保障，按规定，如果君主一旦患有疾病无法履行国家元首职责，其权力可以转交给摄政王。虽然摄政王名义上不是国王，但在权力和职责上与国王等同。</p><p style="margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(64, 64, 64); text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);">据英国镜报报道，英国王室评论员罗伯特（Robert Jobson）介绍，王室内部人士表示王室权力过渡已准备就绪，工作人员正应命令多方加速审核摄政法案的通过速度，确保今后顺利实施。</p><p style="margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(64, 64, 64); text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);">罗伯特援引王室消息人士的话说：“女王希望在退休前为国家和人民尽一切努力，我知道女王在认真考虑95岁时将权力交给查尔斯的事情。”</p><p style="margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(64, 64, 64); text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);">对于女王即将退休并或将任命查尔斯为摄政王的消息引起了英国网友的热议。有人说，让安妮公主继位也比这个懦弱的国王强，有人表态，他永远不可能是我的国王，想都不敢想，太可怕了。另有网友直言，“希望女王不会真的这么做，我们的女王如此伟大，但是查尔斯就是只老鼠。”</p><p style="text-align:center"><img src="http://img.jsonyang.com/2017/08/14/bd7f2a8b-8829-45_700x10000x1.jpg" alt="1502669934446804.jpg"/></p><p><span style="color: rgb(64, 64, 64); font-family: &quot;Microsoft Yahei&quot;; font-size: 18px; text-align: justify; text-indent: 36px; background-color: rgb(255, 255, 255);"><br/></span></p><p style="margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(64, 64, 64); text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);">据了解，伊丽莎白二世1952年即位，4月21日满91岁的伊丽莎白二世是英国历史上在位时间最长的君主。伊丽莎白二世与菲利普亲王1947年结婚，8月2日，96岁的菲利普亲王最后一次履行王室公务，正式结束他长达65年的公职。</p><p style="margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(64, 64, 64); text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);">查尔斯王子出生于1948年11月14日，是英国女王伊丽莎白二世和丈夫菲利普亲王的长子，1958年被封为威尔士亲王，在伊丽莎白二世创下在位时间最长纪录的同时，查尔斯王子也创下了英国历史上最长储君的纪录。</p><p style="margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(64, 64, 64); text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);">虽然英国王室禁止英国报纸报道“秘密丑闻”，但查尔斯王子与卡米拉的故事可谓路人皆知。1981年，查尔斯王子与戴安娜完婚，婚后他迅速与卡米拉开展婚外情，成为结束这段童话般婚姻的导火索。当1992年，查尔斯与卡米拉的婚外情公之于众时，他们遭到了数百万英国人的抨击。</p><p style="margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(64, 64, 64); text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);">这位等待王位时间最长的老王子不受英国人喜爱已是不争的事实，据《太阳报》报道，调查显示65%的英国人希望查尔斯将王位让给长子威廉。</p><p><br/></p>', N'http://img.jsonyang.com/2017/08/14/e1f5424b-b2b2-44_700x10000x1.jpg', N'', N'admin', N'admin', CAST(N'2017-06-05 15:32:09.030' AS DateTime), 2, 0)
INSERT [dbo].[Site_Content] ([c_id], [c_gid], [c_c_gid], [c_title], [c_sub_title], [c_keywords], [c_intro], [c_content], [c_img_src], [c_createUserId], [c_createUserName], [c_createUserNickName], [c_createTime], [c_status], [c_state]) VALUES (1004, N'99853f87', N'2db7535d', N'乐视：贾跃亭把一切给了公司 所有债务一个人扛', N'贾跃亭把一切给了公司', N'贾跃亭', N'乐视：贾跃亭把一切给了公司 所有债务一个人扛', N'<p style="margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(64, 64, 64); text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);">上个月，乐视控股、乐视体育、乐视移动等多个乐视非上市体系公司的员工未能如期领取到工资，在业界引发轩然大波。而乐视方面也宣称将推迟一个月给员工发放工资。</p><p style="margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(64, 64, 64); text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);">《证券日报》记者了解到，8月10日，乐视控股、乐视移动等多家乐视非上市体系的公司的员工的部分工资已发放。不过，由于资金到账时间紧张，乐视非上市体系公司部分员工的员工在8月11日、8月14日陆续发放。</p><p style="margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(64, 64, 64); text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);">对于员工工资没有一次性发放的原因，一位乐视控股内部人士告诉记者：“由于涉及员工较多，资金到账的时间较为紧张，员工的工资会陆续到账。”</p><p style="margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(64, 64, 64); text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);">此次乐视工资能够发放下来，就来自于贾跃亭筹措到的首笔资金，这或是当天贾跃亭在与投资人谈判中做出很大让步的结果。</p><p style="margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(64, 64, 64); text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);"><strong>工资陆续到位</strong></p><p style="margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(64, 64, 64); text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);"><strong>供应商欠款等尚在筹措</strong></p><p style="margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(64, 64, 64); text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);">8月10日，乐视非上市体系公司员工的部分工资如期发放。而对于那些被拖欠款项的供应商来说意味着乐视可能还有还他们钱的希望。</p><p style="margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(64, 64, 64); text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);">《证券日报》记者了解到，8月10日，是乐视系公司全体员工的发薪日，乐视网、乐视致新、乐视影业等乐视上市体系的员工在当天中午，已提前收到工资。而乐视控股、乐视移动等多家乐视非上市体系的公司的员工的部分工资也如期发放。不过，由于资金到账时间紧张，乐视非上市体系公司部分员工的员工在8月11日、8月14日陆续发放。</p><p style="margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(64, 64, 64); text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);">乐视控股相关负责人接受《证券日报》记者采访时表示：“8月10日，发放完部分员工工资后，时间已经很晚，部分员工的工资还未发完，在8月11日后两个工作日发放。”</p><p style="margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(64, 64, 64); text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);">对于贾跃亭此笔钱的来源和借款方式，他表示：“是他个人借的钱。这笔款支付了乐视非上市体系员工6月份、7月份的2个月的工资和这2个月中离职员工的补偿。8月份的离职补偿未包含在内。”</p><p style="margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(64, 64, 64); text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);">对于员工工资没有一次性发放的原因，一位乐视控股内部人士告诉记者：“由于涉及员工较多，资金到账的时间较为紧张，员工的工资会陆续到账。”他同时透露：“8月10日公司该发的离职员工补偿工资，确实还没有到位，目前公司还在筹措。”而对于供应商的欠款，乐视方面也表示正在努力解决，还没有时间表。</p><p style="margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(64, 64, 64); text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);"><strong>融资环境艰难</strong></p><p style="margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(64, 64, 64); text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);"><strong>谈判中做了很大让步</strong></p><p style="margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(64, 64, 64); text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);">据了解，此次乐视工资能够发放下来，在很大程度上是贾跃亭四处筹资的结果。然而目前，金融政策收紧，融资难度加大。为了更好的筹措资金，贾跃亭辗转美国、中国香港等地，对贾跃亭来说也颇具难度。</p><p style="margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(64, 64, 64); text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);">有接近乐视人士称，8月10日，在众多讨债者和乐视员工等待乐视能否传出好消息的同时，贾跃亭在中国香港正在进行一场艰难的谈判。</p><p style="margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(64, 64, 64); text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);">有了“当天是乐视发工资的日子”这一有利筹码，贾跃亭与投资人谈判陷入苦战，双方就最关键的1%问题始终没有达成一致。</p><p style="margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(64, 64, 64); text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);">这场艰难的谈判一直持续到下午，直到有人提醒贾跃亭，香港的银行一般在下午4点半前就会停止业务办理。终于，贾跃亭做出了决定。一笔超1亿元的资金在下午4点前打到乐视国内的指定账户上，用于员工工资和离职补偿。紧接着，部分乐视员工开始陆续收到工资到账提示。</p><p style="margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(64, 64, 64); text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);">“为了及时发放员工工资，贾总在这场谈判中做了很大的让步。贾总把一切都给了公司，所有债务都自己一个人扛。”一位乐视控股内部人士向记者表示。</p><p style="margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(64, 64, 64); text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);">在乐视员工工资发放后的第二天，贾跃亭好在朋友圈转发了一组FF91的最新照片，并附言“黑夜的存在是等待光去穿透，笃定前行。”</p><p style="text-align: center;"><img src="http://img.jsonyang.com/2017/08/14/b1f03e2c-ea31-41_700x10000x1.jpg"/></p><p style="margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(64, 64, 64); text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);">自贾跃亭赴美造车之后，业界几乎每周都会传出贾跃亭回国的消息，而结果总是让外界失望。对于外界一直猜测的贾跃亭将何时回到北京，此次乐视方面也首度作出回应，称贾跃亭回北京的时间可能会延后，理由是他将继续在中国香港和美国进行融资工作。</p><p style="margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(64, 64, 64); text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);">虽然融资环境艰难，但有乐视内部人士向记者透露，并非如外界所传的财团对他避而不见，贾跃亭在中国香港每天都会密集地与金融机构会面，其中有相当一部分时间都用来谈判。</p><p style="margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(64, 64, 64); text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);">乐视控股传播副总裁程时盛也曾向记者透露，乐视控股及汽车相关业务高管与贾跃亭互动频繁，几乎每天都在进行密切沟通。“贾总白天与美国团队沟通汽车生态的各项工作，晚上还要与国内高管进行视频会议及微信沟通，指导和决策业务发展，推动各项债务问题的解决。”据了解，在凑集资金这段时间，贾跃亭时常每天工作到凌晨一两点才会睡。</p><p><br/></p>', N'http://img.jsonyang.com/2017/08/14/b1f03e2c-ea31-41_700x10000x1.jpg', N'', N'admin', N'admin', CAST(N'2017-06-05 15:33:29.417' AS DateTime), 2, 0)
INSERT [dbo].[Site_Content] ([c_id], [c_gid], [c_c_gid], [c_title], [c_sub_title], [c_keywords], [c_intro], [c_content], [c_img_src], [c_createUserId], [c_createUserName], [c_createUserNickName], [c_createTime], [c_status], [c_state]) VALUES (1005, N'12d33072', N'd89eebb3', N'业主注意事项', N'业主注意事项', N'打得过', N'业主注意事项', N'<p>业主注意事项</p><p>大的</p>', N'', N'', N'admin', N'admin', CAST(N'2017-06-07 15:47:04.717' AS DateTime), 2, 0)
INSERT [dbo].[Site_Content] ([c_id], [c_gid], [c_c_gid], [c_title], [c_sub_title], [c_keywords], [c_intro], [c_content], [c_img_src], [c_createUserId], [c_createUserName], [c_createUserNickName], [c_createTime], [c_status], [c_state]) VALUES (1006, N'e65ee665', N'2db7535d', N'顶配大七座不到15万 川西长途试力帆X80', N'川西长途试力帆X80', N'力帆、顶配、大七座', N'顶配大七座不到15万 川西长途试力帆X80', N'<p><strong style="color: rgb(64, 64, 64); font-family: &quot;Microsoft Yahei&quot;; font-size: 18px; text-align: justify; text-indent: 36px; white-space: normal; background-color: rgb(255, 255, 255);">网易汽车8月14日报道&nbsp;</strong><span style="color: rgb(64, 64, 64); font-family: &quot;Microsoft Yahei&quot;; font-size: 18px; text-align: justify; text-indent: 36px; background-color: rgb(255, 255, 255);">2.0T发动机、</span><a href="http://product.auto.163.com/series/1931.html#LT4001" title="汉兰达" style="color: rgb(15, 107, 153); text-decoration-line: none; font-family: &quot;Microsoft Yahei&quot;; font-size: 18px; text-align: justify; text-indent: 36px; white-space: normal; background-color: rgb(255, 255, 255);">汉兰达</a><span style="color: rgb(64, 64, 64); font-family: &quot;Microsoft Yahei&quot;; font-size: 18px; text-align: justify; text-indent: 36px; background-color: rgb(255, 255, 255);">那么大个头的七座</span><a href="http://product.auto.163.com/cartype/suv/" title="SUV" style="color: rgb(15, 107, 153); text-decoration-line: none; font-family: &quot;Microsoft Yahei&quot;; font-size: 18px; text-align: justify; text-indent: 36px; white-space: normal; background-color: rgb(255, 255, 255);">SUV</a><span style="color: rgb(64, 64, 64); font-family: &quot;Microsoft Yahei&quot;; font-size: 18px; text-align: justify; text-indent: 36px; background-color: rgb(255, 255, 255);">？就算是自主品牌怎么也要个十六七万吧？NO！今天我们体验的</span><a href="http://product.auto.163.com/series/18703.html#LT4001" title="力帆X80" style="color: rgb(15, 107, 153); text-decoration-line: none; font-family: &quot;Microsoft Yahei&quot;; font-size: 18px; text-align: justify; text-indent: 36px; white-space: normal; background-color: rgb(255, 255, 255);">力帆X80</a><span style="color: rgb(64, 64, 64); font-family: &quot;Microsoft Yahei&quot;; font-size: 18px; text-align: justify; text-indent: 36px; background-color: rgb(255, 255, 255);">，尺寸不小，顶配只要15万不到。它的表现如何？容我们细细道来。</span></p><p style="text-align: center;"><span style="color: rgb(64, 64, 64); font-family: &quot;Microsoft Yahei&quot;; font-size: 18px; text-align: justify; text-indent: 36px; background-color: rgb(255, 255, 255);"><img src="http://img.jsonyang.com/2017/08/14/43785560-91c4-44_700x10000x1.jpg" alt="保密协议到14号顶配大七座不到15万 川西长途试力帆X80"/></span></p><p><br/></p><p style="margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(64, 64, 64); text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);"><span style="color:#C00000"><strong>体验车型：力帆X80 2.0T AT舒适型</strong></span></p><p style="margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(64, 64, 64); text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);"><span style="color:#C00000"><strong>指导价格：13.99万元</strong></span></p><p style="margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(64, 64, 64); text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);"><strong>■ 造型</strong></p><p style="margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(64, 64, 64); text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);"><strong>—— 外观：协调顺眼</strong></p><p style="margin-top: 32px; margin-bottom: 0px; padding: 0px; font-size: 18px; text-indent: 2em; font-stretch: normal; line-height: 32px; font-family: &quot;Microsoft Yahei&quot;; color: rgb(64, 64, 64); text-align: justify; white-space: normal; background-color: rgb(255, 255, 255);">力帆X80的外观设计比较流畅，说不上太多亮点但也没有突兀之处，四平八稳其实是这类七座SUV最佳的选择。</p><p style="text-align:center"><img src="http://img.jsonyang.com/2017/08/14/1369f3fa-3da9-45_700x10000x1.jpg" alt="保密协议到14号顶配大七座不到15万 川西长途试力帆X80"/></p><p><span style="color: rgb(64, 64, 64); font-family: &quot;Microsoft Yahei&quot;; font-size: 18px; text-align: justify; text-indent: 36px; background-color: rgb(255, 255, 255);"><br/></span><br/></p>', N'http://img.jsonyang.com/2017/08/14/43785560-91c4-44_700x10000x1.jpg', N'', N'admin', N'admin', CAST(N'2017-06-07 16:11:51.517' AS DateTime), 2, 0)
INSERT [dbo].[Site_Content] ([c_id], [c_gid], [c_c_gid], [c_title], [c_sub_title], [c_keywords], [c_intro], [c_content], [c_img_src], [c_createUserId], [c_createUserName], [c_createUserNickName], [c_createTime], [c_status], [c_state]) VALUES (1007, N'073c85ef', N'79ccee17', N'比基尼热辣美女洗车 引市民围观', N'比基尼热辣美女洗车', N'比基尼、热辣美女、洗车', N'比基尼热辣美女洗车 引市民围观', N'<p><span style="font-size: 16px;"><strong><span style="color: rgb(102, 102, 102); font-family: SimSun; text-indent: 26px; background-color: rgb(255, 255, 255);">&nbsp; 8月1日上午11时许，西安城北文景路的一家洗车店，推出美女比基尼洗车服务。记者看到洗车店内四名身材火辣的美女，身着比基尼泳装，穿着高跟鞋，亭亭玉立地站在轿车边。一手拿喷头，一手执擦车海绵，小心翼翼地给豪车喷水，不时俯身下来擦洗车身。附近围观的车主和市民，纷纷掏出手机，对着比基尼美女一阵猛拍。</span></strong></span></p><p style="text-align: center;"><span style="font-size: 16px;"><strong><span style="color: rgb(102, 102, 102); font-family: SimSun; text-indent: 26px; background-color: rgb(255, 255, 255);"><img src="http://img.jsonyang.com/2017/08/24/2233a4c0-d549-42_700x10000x1.jpg" alt="比基尼热辣美女洗车 引市民围观"/></span></strong></span></p><p><span style="font-size: 16px;"><strong><span style="color: rgb(102, 102, 102); font-family: SimSun; text-indent: 26px; background-color: rgb(255, 255, 255);"><img src="http://img.jsonyang.com/2017/08/24/01d2a3d9-57e9-41_700x10000x1.jpg" alt="比基尼热辣美女洗车 引市民围观"/></span></strong></span></p>', N'http://img.jsonyang.com/2017/08/24/2233a4c0-d549-42_700x10000x1.jpg', N'', N'admin', N'admin', CAST(N'2017-08-24 14:18:17.277' AS DateTime), 2, 0)
INSERT [dbo].[Site_Content] ([c_id], [c_gid], [c_c_gid], [c_title], [c_sub_title], [c_keywords], [c_intro], [c_content], [c_img_src], [c_createUserId], [c_createUserName], [c_createUserNickName], [c_createTime], [c_status], [c_state]) VALUES (1008, N'51aa82c9', N'79ccee17', N'火辣娇艳大奶美女丰乳翘臀惹火娇媚销魂性感写真', N'娇艳大奶美女', N'娇艳、大奶美女、丰乳翘臀', N'火辣娇艳大奶美女丰乳翘臀惹火娇媚销魂性感写真', N'<p style="text-align: center;"><img src="http://img.jsonyang.com/2017/08/24/d3f324d6-90f0-43_700x10000x1.jpg"/></p><p>美不美</p><p style="text-align: center;"><img src="http://img.jsonyang.com/2017/08/24/ea38d2f6-19e3-48_700x10000x1.jpg"/></p>', N'http://img.jsonyang.com/2017/08/24/d3f324d6-90f0-43_700x10000x1.jpg', N'', N'admin', N'admin', CAST(N'2017-08-24 14:20:02.543' AS DateTime), 2, 0)
INSERT [dbo].[Site_Content] ([c_id], [c_gid], [c_c_gid], [c_title], [c_sub_title], [c_keywords], [c_intro], [c_content], [c_img_src], [c_createUserId], [c_createUserName], [c_createUserNickName], [c_createTime], [c_status], [c_state]) VALUES (1009, N'b94c2872', N'79ccee17', N'惹火销魂女神巨胸 让人瞬间窒息大奶销魂火辣诱惑写真', N'惹火销魂女神巨胸', N'女神、巨胸、销魂、写真', N'惹火销魂女神巨胸 让人瞬间窒息大奶销魂火辣诱惑写真', N'<p style="text-align: center;"><img src="http://img.jsonyang.com/2017/08/24/6b4912a1-85e5-4f_700x10000x1.jpg"/></p><p style="text-align: center;"><img src="http://img.jsonyang.com/2017/08/24/79bc2ac3-35c8-4b_700x10000x1.jpg"/></p>', N'http://img.jsonyang.com/2017/08/24/6b4912a1-85e5-4f_700x10000x1.jpg', N'', N'admin', N'admin', CAST(N'2017-08-24 14:22:41.667' AS DateTime), 2, 0)
SET IDENTITY_INSERT [dbo].[Site_Content] OFF
SET IDENTITY_INSERT [dbo].[SystemGroup] ON 

INSERT [dbo].[SystemGroup] ([g_id], [g_gid], [g_name], [g_picCover], [g_createTime], [g_createUser], [g_sort]) VALUES (1, N'78ehg5ed', N'系统设置', N'/Img/system.png', CAST(N'2014-09-01 00:00:00.000' AS DateTime), N'admin', 1)
INSERT [dbo].[SystemGroup] ([g_id], [g_gid], [g_name], [g_picCover], [g_createTime], [g_createUser], [g_sort]) VALUES (2, N'f74b51bf', N'站点管理', N'/ImageIcon/explorer.png', CAST(N'2015-11-02 15:57:23.970' AS DateTime), N'admin', 2)
SET IDENTITY_INSERT [dbo].[SystemGroup] OFF
SET IDENTITY_INSERT [dbo].[SystemModual] ON 

INSERT [dbo].[SystemModual] ([m_id], [m_gid], [m_g_gid], [m_path], [m_name], [m_parent], [m_parent_gid], [m_Controller], [m_Action], [m_createTime], [m_createUser]) VALUES (1, N'12343212', N'78ehg5ed', N'11', N'系统管理', 0, N'', N'', N'', CAST(N'2014-04-12 00:00:00.000' AS DateTime), N'admin')
INSERT [dbo].[SystemModual] ([m_id], [m_gid], [m_g_gid], [m_path], [m_name], [m_parent], [m_parent_gid], [m_Controller], [m_Action], [m_createTime], [m_createUser]) VALUES (11, N'1e7728d3', N'78ehg5ed', N'1103', N'系统模块组', 1, N'12343212', N'system', N'groupList', CAST(N'2014-07-23 15:42:37.000' AS DateTime), N'admin')
INSERT [dbo].[SystemModual] ([m_id], [m_gid], [m_g_gid], [m_path], [m_name], [m_parent], [m_parent_gid], [m_Controller], [m_Action], [m_createTime], [m_createUser]) VALUES (2, N'234esf34', N'78ehg5ed', N'1101', N'模块和权限', 1, N'12343212', N'system', N'moduleList', CAST(N'2014-04-12 00:00:00.000' AS DateTime), N'admin')
INSERT [dbo].[SystemModual] ([m_id], [m_gid], [m_g_gid], [m_path], [m_name], [m_parent], [m_parent_gid], [m_Controller], [m_Action], [m_createTime], [m_createUser]) VALUES (15, N'6fe2d17e', N'78ehg5ed', N'1203', N'角色管理', 3, N'hjdf34df', N'System', N'RoleList', CAST(N'2014-07-23 18:00:16.000' AS DateTime), N'admin')
INSERT [dbo].[SystemModual] ([m_id], [m_gid], [m_g_gid], [m_path], [m_name], [m_parent], [m_parent_gid], [m_Controller], [m_Action], [m_createTime], [m_createUser]) VALUES (21, N'700a0c77', N'f74b51bf', N'1303', N'站点内容', 18, N'89b2c81e', N'Site', N'SiteContentList', CAST(N'2016-11-14 15:00:16.000' AS DateTime), N'admin')
INSERT [dbo].[SystemModual] ([m_id], [m_gid], [m_g_gid], [m_path], [m_name], [m_parent], [m_parent_gid], [m_Controller], [m_Action], [m_createTime], [m_createUser]) VALUES (19, N'78443ef6', N'f74b51bf', N'1301', N'内容分类', 18, N'89b2c81e', N'Site', N'SiteCateList', CAST(N'2015-11-02 15:59:58.000' AS DateTime), N'admin')
INSERT [dbo].[SystemModual] ([m_id], [m_gid], [m_g_gid], [m_path], [m_name], [m_parent], [m_parent_gid], [m_Controller], [m_Action], [m_createTime], [m_createUser]) VALUES (20, N'88c02cdc', N'f74b51bf', N'1302', N'主站点页面', 18, N'89b2c81e', N'Site', N'SiteCMSPageList?siteName=1', CAST(N'2015-11-02 16:01:02.000' AS DateTime), N'admin')
INSERT [dbo].[SystemModual] ([m_id], [m_gid], [m_g_gid], [m_path], [m_name], [m_parent], [m_parent_gid], [m_Controller], [m_Action], [m_createTime], [m_createUser]) VALUES (18, N'89b2c81e', N'f74b51bf', N'13', N'站点管理', 0, N'', N'', N'', CAST(N'2015-11-02 15:59:24.000' AS DateTime), N'admin')
INSERT [dbo].[SystemModual] ([m_id], [m_gid], [m_g_gid], [m_path], [m_name], [m_parent], [m_parent_gid], [m_Controller], [m_Action], [m_createTime], [m_createUser]) VALUES (8, N'9f9fe6f8', N'78ehg5ed', N'1201', N'系统用户管理', 3, N'hjdf34df', N'System', N'UserList', CAST(N'2014-07-21 22:49:39.000' AS DateTime), N'admin')
INSERT [dbo].[SystemModual] ([m_id], [m_gid], [m_g_gid], [m_path], [m_name], [m_parent], [m_parent_gid], [m_Controller], [m_Action], [m_createTime], [m_createUser]) VALUES (22, N'c62cadf1', N'f74b51bf', N'1304', N'BBS站点页面', 18, N'89b2c81e', N'Site', N'SiteCMSPageList?siteName=2', CAST(N'2017-08-14 17:24:39.000' AS DateTime), N'admin')
INSERT [dbo].[SystemModual] ([m_id], [m_gid], [m_g_gid], [m_path], [m_name], [m_parent], [m_parent_gid], [m_Controller], [m_Action], [m_createTime], [m_createUser]) VALUES (17, N'd3202f41', N'78ehg5ed', N'1102', N'权限分配', 1, N'12343212', N'System', N'PermissionAssignList', CAST(N'2014-07-29 15:47:48.000' AS DateTime), N'admin')
INSERT [dbo].[SystemModual] ([m_id], [m_gid], [m_g_gid], [m_path], [m_name], [m_parent], [m_parent_gid], [m_Controller], [m_Action], [m_createTime], [m_createUser]) VALUES (3, N'hjdf34df', N'78ehg5ed', N'12', N'用户管理', 0, N'', N'', N'', CAST(N'2014-04-12 00:00:00.000' AS DateTime), N'admin')
SET IDENTITY_INSERT [dbo].[SystemModual] OFF
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([u_id], [u_gid], [u_username], [u_password], [u_createTime], [u_createUser], [u_status]) VALUES (1, N'123de43w', N'admin', N'21232F297A57A5A743894AE4A801FC3', CAST(N'2014-02-19 13:07:27.000' AS DateTime), N'admin', 1)
INSERT [dbo].[User] ([u_id], [u_gid], [u_username], [u_password], [u_createTime], [u_createUser], [u_status]) VALUES (2, N'sdf345fs', N'test', N'E1ADC3949BA59ABBE56E057F2F883E', CAST(N'2014-05-11 14:32:03.000' AS DateTime), N'admin', 1)
SET IDENTITY_INSERT [dbo].[User] OFF
SET IDENTITY_INSERT [dbo].[User_Role_Mapping] ON 

INSERT [dbo].[User_Role_Mapping] ([u_r_id], [u_r_gid], [u_gid], [r_gid], [u_r_CreateTime], [u_r_CreateUser]) VALUES (1, N'dfs4rfdw', N'123de43w', N'12334422', CAST(N'2014-04-12 00:00:00.000' AS DateTime), N'廖杨')
INSERT [dbo].[User_Role_Mapping] ([u_r_id], [u_r_gid], [u_gid], [r_gid], [u_r_CreateTime], [u_r_CreateUser]) VALUES (2, N'fd8070d7', N'sdf345fs', N'23937f61', CAST(N'2017-08-23 10:04:20.000' AS DateTime), N'admin')
SET IDENTITY_INSERT [dbo].[User_Role_Mapping] OFF
ALTER TABLE [dbo].[ModulePermission]  WITH CHECK ADD  CONSTRAINT [FK_ModulePermission_SystemModule] FOREIGN KEY([p_m_gid])
REFERENCES [dbo].[SystemModual] ([m_gid])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ModulePermission] CHECK CONSTRAINT [FK_ModulePermission_SystemModule]
GO
ALTER TABLE [dbo].[Role_ModualPermission_Mapping]  WITH CHECK ADD  CONSTRAINT [FK_Role_ModualPermission_Mapping_ModualPermission] FOREIGN KEY([p_gid])
REFERENCES [dbo].[ModulePermission] ([p_gid])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Role_ModualPermission_Mapping] CHECK CONSTRAINT [FK_Role_ModualPermission_Mapping_ModualPermission]
GO
ALTER TABLE [dbo].[SystemModual]  WITH CHECK ADD  CONSTRAINT [FK_SystemModual_SystemGroup] FOREIGN KEY([m_g_gid])
REFERENCES [dbo].[SystemGroup] ([g_gid])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[SystemModual] CHECK CONSTRAINT [FK_SystemModual_SystemGroup]
GO
/****** Object:  StoredProcedure [dbo].[Proc_ModulePermission_DeleteByp_gid]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****删除*****
*****CreateUser:yang.liao*****
*****CreateTime:07 29 2014  2:16PM*****/
create proc [dbo].[Proc_ModulePermission_DeleteByp_gid]
@p_gid VARCHAR(8)
AS
delete from [ModulePermission] where p_gid=@p_gid



GO
/****** Object:  StoredProcedure [dbo].[Proc_ModulePermission_Insert]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****插入*****
*****CreateUser:yang.liao*****
*****CreateTime:07 29 2014  2:16PM*****/
create proc [dbo].[Proc_ModulePermission_Insert]
@p_id int output,
@p_gid varchar(8),
@p_m_gid varchar(8),
@p_name nvarchar(50),
@p_path varchar(50),
@p_createTime DateTime,
@p_createUser nvarchar(50)
AS
insert into [ModulePermission](
p_gid,
p_m_gid,
p_name,
p_path,
p_createTime,
p_createUser
)
values(
@p_gid,
@p_m_gid,
@p_name,
@p_path,
@p_createTime,
@p_createUser
)
SET @p_id=@@IDENTITY



GO
/****** Object:  StoredProcedure [dbo].[Proc_ModulePermission_SelectByp_gid]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****查询*****
*****CreateUser:yang.liao*****
*****CreateTime:07 29 2014  2:16PM*****/
create proc [dbo].[Proc_ModulePermission_SelectByp_gid]
@p_gid VARCHAR(8)
AS
select * FROM [ModulePermission] WHERE p_gid=@p_gid



GO
/****** Object:  StoredProcedure [dbo].[Proc_ModulePermission_SelectModulePerByRoleGid]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Proc_ModulePermission_SelectModulePerByRoleGid]
	@rgid VARCHAR(8),
	@mgid VARCHAR(8)
 AS
  SELECT * FROM dbo.ModulePermission WHERE p_gid IN
 (SELECT p_gid FROM dbo.[Role_ModualPermission_Mapping] WHERE r_gid=@rgid) 
 AND p_m_gid=@mgid



GO
/****** Object:  StoredProcedure [dbo].[Proc_ModulePermission_SelectPage]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****查询*****
*****CreateUser:yang.liao*****
*****CreateTime:07 29 2014  2:16PM*****/
create proc [dbo].[Proc_ModulePermission_SelectPage]
@rowCount INT OUTPUT,
@cloumns VARCHAR(200),
@pageIndex INT,
@pageSize INT,
@orderBy VARCHAR(20),
@where VARCHAR(300)
AS
exec Proc_SelectPageBase @rowCount output,@cloumns,'p_id','ModulePermission',@pageIndex,@pageSize,@orderBy,@where



GO
/****** Object:  StoredProcedure [dbo].[Proc_ModulePermission_SelectUserPerByu_gid]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Proc_ModulePermission_SelectUserPerByu_gid]
  @u_gid VARCHAR(8)
AS
SELECT * FROM dbo.ModulePermission WHERE p_gid IN (
SELECT p_gid FROM dbo.Role_ModualPermission_Mapping WHERE r_gid IN (
  SELECT r_gid FROM dbo.User_Role_Mapping WHERE u_gid=@u_gid)
  )



GO
/****** Object:  StoredProcedure [dbo].[Proc_ModulePermission_UpdateByp_gid]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****修改*****
*****CreateUser:yang.liao*****
*****CreateTime:07 29 2014  2:16PM*****/
create proc [dbo].[Proc_ModulePermission_UpdateByp_gid]
@p_gid varchar(8),
@p_m_gid varchar(8),
@p_name nvarchar(50),
@p_path varchar(50),
@p_createTime DateTime,
@p_createUser nvarchar(50)
AS
update [ModulePermission] SET 
p_m_gid=@p_m_gid,
p_name=@p_name,
p_path=@p_path,
p_createTime=@p_createTime,
p_createUser=@p_createUser
 where p_gid=@p_gid



GO
/****** Object:  StoredProcedure [dbo].[Proc_Role_DeleteByr_gid]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****删除*****
*****CreateUser:yang.liao*****
*****CreateTime:07 28 2014  5:06PM*****/
CREATE proc [dbo].[Proc_Role_DeleteByr_gid]
@r_gid VARCHAR(8)
AS
delete from [Role] where r_gid=@r_gid



GO
/****** Object:  StoredProcedure [dbo].[Proc_Role_Insert]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****插入*****
*****CreateUser:yang.liao*****
*****CreateTime:07 28 2014  5:06PM*****/
CREATE proc [dbo].[Proc_Role_Insert]
@r_id int output,
@r_gid varchar(8),
@r_name nvarchar(50),
@r_createUser NVARCHAR(50),
@r_createTime DateTime
AS
insert into [Role](
r_gid,
r_name,
r_createTime,
r_createUser
)
values(
@r_gid,
@r_name,
@r_createTime,
@r_createUser
)
SET @r_id=@@IDENTITY



GO
/****** Object:  StoredProcedure [dbo].[Proc_Role_ModualPermission_Mapping_DeleteByr_gidAndp_gid]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****删除*****
*****CreateUser:yang.liao*****
*****CreateTime:11 29 2014  5:22PM*****/
create proc [dbo].[Proc_Role_ModualPermission_Mapping_DeleteByr_gidAndp_gid]
@r_gid VARCHAR(8),
@p_gid VARCHAR(8)

AS
delete from [Role_ModualPermission_Mapping] where r_gid=@r_gid AND p_gid=@p_gid



GO
/****** Object:  StoredProcedure [dbo].[Proc_Role_ModualPermission_Mapping_DeleteByr_p_id]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****删除*****
*****CreateUser:yang.liao*****
*****CreateTime:11 29 2014  5:22PM*****/
create proc [dbo].[Proc_Role_ModualPermission_Mapping_DeleteByr_p_id]
@r_p_id int
AS
delete from [Role_ModualPermission_Mapping] where r_p_id=@r_p_id



GO
/****** Object:  StoredProcedure [dbo].[Proc_Role_ModualPermission_Mapping_Insert]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****插入*****
*****CreateUser:yang.liao*****
*****CreateTime:11 29 2014  5:22PM*****/
create proc [dbo].[Proc_Role_ModualPermission_Mapping_Insert]
@r_p_id int output,
@r_p_gid varchar(8),
@r_gid varchar(8),
@p_gid varchar(8),
@r_p_CreateTime DateTime,
@r_p_CreateUser nvarchar(30)
AS
insert into [Role_ModualPermission_Mapping](
r_p_gid,
r_gid,
p_gid,
r_p_CreateTime,
r_p_CreateUser
)
values(
@r_p_gid,
@r_gid,
@p_gid,
@r_p_CreateTime,
@r_p_CreateUser
)
SET @r_p_id=@@IDENTITY



GO
/****** Object:  StoredProcedure [dbo].[Proc_Role_ModualPermission_Mapping_SelectByr_p_id]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****查询*****
*****CreateUser:yang.liao*****
*****CreateTime:11 29 2014  5:22PM*****/
create proc [dbo].[Proc_Role_ModualPermission_Mapping_SelectByr_p_id]
@r_p_id int
AS
select * FROM [Role_ModualPermission_Mapping] WHERE r_p_id=@r_p_id



GO
/****** Object:  StoredProcedure [dbo].[Proc_Role_ModualPermission_Mapping_SelectPage]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****查询*****
*****CreateUser:yang.liao*****
*****CreateTime:11 29 2014  5:22PM*****/
create proc [dbo].[Proc_Role_ModualPermission_Mapping_SelectPage]
@rowCount INT OUTPUT,
@cloumns VARCHAR(200),
@pageIndex INT,
@pageSize INT,
@orderBy VARCHAR(20),
@where VARCHAR(300)
AS
exec Proc_SelectPageBase @rowCount output,@cloumns,'r_p_id','Role_ModualPermission_Mapping',@pageIndex,@pageSize,@orderBy,@where



GO
/****** Object:  StoredProcedure [dbo].[Proc_Role_ModualPermission_Mapping_UpdateByr_p_id]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****修改*****
*****CreateUser:yang.liao*****
*****CreateTime:11 29 2014  5:22PM*****/
create proc [dbo].[Proc_Role_ModualPermission_Mapping_UpdateByr_p_id]
@r_p_id int,
@r_p_gid varchar(8),
@r_gid varchar(8),
@p_gid varchar(8),
@r_p_CreateTime DateTime,
@r_p_CreateUser nvarchar(30)
AS
update [Role_ModualPermission_Mapping] SET 
r_p_gid=@r_p_gid,
r_gid=@r_gid,
p_gid=@p_gid,
r_p_CreateTime=@r_p_CreateTime,
r_p_CreateUser=@r_p_CreateUser
 where r_p_id=@r_p_id



GO
/****** Object:  StoredProcedure [dbo].[Proc_Role_SelectByr_gid]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****查询*****
*****CreateUser:yang.liao*****
*****CreateTime:07 28 2014  5:06PM*****/
CREATE proc [dbo].[Proc_Role_SelectByr_gid]
@r_gid VARCHAR(8)
AS
select * FROM [Role] WHERE r_gid=@r_gid



GO
/****** Object:  StoredProcedure [dbo].[Proc_Role_SelectPage]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****查询*****
*****CreateUser:yang.liao*****
*****CreateTime:07 28 2014  5:06PM*****/
create proc [dbo].[Proc_Role_SelectPage]
@rowCount INT OUTPUT,
@cloumns VARCHAR(200),
@pageIndex INT,
@pageSize INT,
@orderBy VARCHAR(20),
@where VARCHAR(300)
AS
exec Proc_SelectPageBase @rowCount output,@cloumns,'r_id','Role',@pageIndex,@pageSize,@orderBy,@where



GO
/****** Object:  StoredProcedure [dbo].[Proc_Role_UpdateByr_gid]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****修改*****
*****CreateUser:yang.liao*****
*****CreateTime:07 28 2014  5:06PM*****/
create proc [dbo].[Proc_Role_UpdateByr_gid]
@r_gid varchar(8),
@r_name nvarchar(50),
@r_createTime DateTime
AS
update [Role] SET 
r_name=@r_name,
r_createTime=@r_createTime
 where r_gid=@r_gid



GO
/****** Object:  StoredProcedure [dbo].[Proc_SelectPageBase]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Proc_SelectPageBase]
	@rowCount INT OUTPUT,
	@columns VARCHAR(200),
	@Identity VARCHAR(20),
	@tableName VARCHAR(50),
	@pageIndex INT,
	@pageSize INT,
	@orderBy VARCHAR(20),
	@where VARCHAR(300)
AS
	DECLARE @sql NVARCHAR(2000),@sort NVARCHAR(50)
	SET @sort=@orderBy
	IF(@orderBy='')
	BEGIN
	SET @sort=@Identity
	END
	
	SET @sql=N'SELECT * FROM(
	SELECT ROW_NUMBER()OVER (ORDER BY '+@sort+')AS num,'+@columns+' FROM ['+@tableName+']'+@where+')AS t
	WHERE num > '+CAST((@pageIndex-1)*@pageSize AS VARCHAR(5))+' AND num <= '+CAST(@pageIndex*@pageSize AS VARCHAR(5))
	+' order by '+@sort+';
	SELECT @rowCount1= COUNT(1) FROM ['+@tableName+']'+@where
	PRINT @sql
	EXEC sp_executesql @sql,N'@rowCount1 int output',@rowCount1=@rowCount OUTPUT



GO
/****** Object:  StoredProcedure [dbo].[Proc_Site_Cates_DeleteByc_gid]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****删除*****
*****CreateUser:yang.liao*****
*****CreateTime:11  2 2015  3:42PM*****/
CREATE proc [dbo].[Proc_Site_Cates_DeleteByc_gid]
@c_gid VARCHAR(8)
AS
delete from [Site_Cates] where c_gid=@c_gid






GO
/****** Object:  StoredProcedure [dbo].[Proc_Site_Cates_Insert]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****插入*****
*****CreateUser:yang.liao*****
*****CreateTime:11  2 2015  3:42PM*****/
create proc [dbo].[Proc_Site_Cates_Insert]
@c_id int output,
@c_gid varchar(8),
@c_path varchar(20),
@c_isMainCate BIT,
@c_tableId varchar(20),
@c_name nvarchar(50),
@c_type nvarchar(50),
@c_createUser nvarchar(50),
@c_createTime DateTime
AS
insert into [Site_Cates](
c_gid,
c_path,
c_isMainCate,
c_tableId,
c_name,
c_type,
c_createUser,
c_createTime
)
values(
@c_gid,
@c_path,
@c_isMainCate,
@c_tableId,
@c_name,
@c_type,
@c_createUser,
@c_createTime
)
SET @c_id=@@IDENTITY






GO
/****** Object:  StoredProcedure [dbo].[Proc_Site_Cates_SelectByc_gid]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****查询*****
*****CreateUser:yang.liao*****
*****CreateTime:11  2 2015  3:42PM*****/
CREATE proc [dbo].[Proc_Site_Cates_SelectByc_gid]
@c_gid VARCHAR(8)
AS
select * FROM [Site_Cates] WHERE c_gid=@c_gid






GO
/****** Object:  StoredProcedure [dbo].[Proc_Site_Cates_SelectByc_id]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****查询*****
*****CreateUser:yang.liao*****
*****CreateTime:11  2 2015  3:42PM*****/
CREATE proc [dbo].[Proc_Site_Cates_SelectByc_id]
@c_id INT
AS
select * FROM [Site_Cates] WHERE c_id=@c_id






GO
/****** Object:  StoredProcedure [dbo].[Proc_Site_Cates_SelectPage]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****查询*****
*****CreateUser:yang.liao*****
*****CreateTime:11  2 2015  3:42PM*****/
create proc [dbo].[Proc_Site_Cates_SelectPage]
@rowCount INT OUTPUT,
@cloumns VARCHAR(200),
@pageIndex INT,
@pageSize INT,
@orderBy VARCHAR(20),
@where VARCHAR(300)
AS
exec Proc_SelectPageBase @rowCount output,@cloumns,'c_id','Site_Cates',@pageIndex,@pageSize,@orderBy,@where



GO
/****** Object:  StoredProcedure [dbo].[Proc_Site_Cates_UpdateByc_gid]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****修改*****
*****CreateUser:yang.liao*****
*****CreateTime:11  2 2015  3:42PM*****/
create proc [dbo].[Proc_Site_Cates_UpdateByc_gid]
@c_id int,
@c_gid varchar(8),
@c_path varchar(20),
@c_isMainCate BIT,
@c_tableId varchar(20),
@c_name nvarchar(50),
@c_type nvarchar(50),
@c_createUser nvarchar(50),
@c_createTime DateTime
AS
update [Site_Cates] SET 
c_path=@c_path,
c_isMainCate=@c_isMainCate,
c_tableId=@c_tableId,
c_name=@c_name,
c_type=@c_type,
c_createUser=@c_createUser,
c_createTime=@c_createTime
 where c_gid=@c_gid






GO
/****** Object:  StoredProcedure [dbo].[Proc_Site_CMSBlock_DeleteByb_gid]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****删除*****
*****CreateUser:yang.liao*****
*****CreateTime:11  2 2015  3:46PM*****/
create proc [dbo].[Proc_Site_CMSBlock_DeleteByb_gid]
@b_gid VARCHAR(8)
AS
delete from [Site_CMSBlock] where b_gid=@b_gid






GO
/****** Object:  StoredProcedure [dbo].[Proc_Site_CMSBlock_Insert]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****插入*****
*****CreateUser:yang.liao*****
*****CreateTime:11  2 2015  3:46PM*****/
CREATE proc [dbo].[Proc_Site_CMSBlock_Insert]
@b_id int output,
@b_gid varchar(8),
@b_p_gid varchar(8),
@b_path varchar(20),
@b_name nvarchar(50),
@b_img_size VARCHAR(20),
@b_createUser nvarchar(50),
@b_createTime DateTime
AS
insert into [Site_CMSBlock](
b_gid,
b_p_gid,
b_path,
b_name,
b_img_size,
b_createUser,
b_createTime
)
values(
@b_gid,
@b_p_gid,
@b_path,
@b_name,
@b_img_size,
@b_createUser,
@b_createTime
)
SET @b_id=@@IDENTITY






GO
/****** Object:  StoredProcedure [dbo].[Proc_Site_CMSBlock_SelectByb_gid]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****查询*****
*****CreateUser:yang.liao*****
*****CreateTime:11  2 2015  3:46PM*****/
create proc [dbo].[Proc_Site_CMSBlock_SelectByb_gid]
@b_gid VARCHAR(8)
AS
select * FROM [Site_CMSBlock] WHERE b_gid=@b_gid






GO
/****** Object:  StoredProcedure [dbo].[Proc_Site_CMSBlock_SelectPage]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****查询*****
*****CreateUser:yang.liao*****
*****CreateTime:11  2 2015  3:46PM*****/
create proc [dbo].[Proc_Site_CMSBlock_SelectPage]
@rowCount INT OUTPUT,
@cloumns VARCHAR(200),
@pageIndex INT,
@pageSize INT,
@orderBy VARCHAR(20),
@where VARCHAR(300)
AS
exec Proc_SelectPageBase @rowCount output,@cloumns,'b_id','Site_CMSBlock',@pageIndex,@pageSize,@orderBy,@where



GO
/****** Object:  StoredProcedure [dbo].[Proc_Site_CMSBlock_UpdateByb_gid]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****修改*****
*****CreateUser:yang.liao*****
*****CreateTime:11  2 2015  3:46PM*****/
CREATE proc [dbo].[Proc_Site_CMSBlock_UpdateByb_gid]
@b_id int,
@b_gid varchar(8),
@b_p_gid varchar(8),
@b_path varchar(20),
@b_name nvarchar(50),
@b_img_size VARCHAR(20),
@b_createUser nvarchar(50),
@b_createTime DateTime
AS
update [Site_CMSBlock] SET 
b_p_gid=@b_p_gid,
b_path=@b_path,
b_name=@b_name,
b_img_size=@b_img_size,
b_createUser=@b_createUser,
b_createTime=@b_createTime
 where b_gid=@b_gid






GO
/****** Object:  StoredProcedure [dbo].[Proc_Site_CMSItem_DeleteByi_gid]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****删除*****
*****CreateUser:yang.liao*****
*****CreateTime:11  2 2015  3:51PM*****/
create proc [dbo].[Proc_Site_CMSItem_DeleteByi_gid]
@i_gid VARCHAR(8)
AS
delete from [Site_CMSItem] where i_gid=@i_gid






GO
/****** Object:  StoredProcedure [dbo].[Proc_Site_CMSItem_Insert]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****插入*****
*****CreateUser:yang.liao*****
*****CreateTime:11  2 2015  3:51PM*****/
CREATE proc [dbo].[Proc_Site_CMSItem_Insert]
@i_id int output,
@i_gid varchar(8),
@i_b_gid varchar(8),
@i_p_gid varchar(8),
@i_title nvarchar(50),
@i_c_gid varchar(8),
@i_c_type nvarchar(50),
@i_subTitle nvarchar(20),
@i_intro nvarchar(500),
@i_c_img_src VARCHAR(150),
@i_status int,
@i_createUser nvarchar(30),
@i_createTime DATETIME
AS
insert into [Site_CMSItem](
i_gid,
i_b_gid,
i_p_gid,
i_title,
i_c_gid,
i_c_type,
i_subTitle,
i_intro,
i_c_img_src,
i_status,
i_createUser,
i_createTime
)
values(
@i_gid,
@i_b_gid,
@i_p_gid,
@i_title,
@i_c_gid,
@i_c_type,
@i_subTitle,
@i_intro,
@i_c_img_src,
@i_status,
@i_createUser,
@i_createTime
)
SET @i_id=@@IDENTITY






GO
/****** Object:  StoredProcedure [dbo].[Proc_Site_CMSItem_SelectByc_gidAndb_gid]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****查询*****
*****CreateUser:yang.liao*****
*****CreateTime:11  2 2015  3:51PM*****/
CREATE proc [dbo].[Proc_Site_CMSItem_SelectByc_gidAndb_gid]
@c_gid VARCHAR(8),
@b_gid VARCHAR(8)
AS
select * FROM [Site_CMSItem] WHERE i_c_gid=@c_gid AND i_b_gid=@b_gid






GO
/****** Object:  StoredProcedure [dbo].[Proc_Site_CMSItem_SelectByi_gid]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****查询*****
*****CreateUser:yang.liao*****
*****CreateTime:11  2 2015  3:51PM*****/
create proc [dbo].[Proc_Site_CMSItem_SelectByi_gid]
@i_gid VARCHAR(8)
AS
select * FROM [Site_CMSItem] WHERE i_gid=@i_gid






GO
/****** Object:  StoredProcedure [dbo].[Proc_Site_CMSItem_SelectPage]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****查询*****
*****CreateUser:yang.liao*****
*****CreateTime:11  2 2015  3:51PM*****/
create proc [dbo].[Proc_Site_CMSItem_SelectPage]
@rowCount INT OUTPUT,
@cloumns VARCHAR(200),
@pageIndex INT,
@pageSize INT,
@orderBy VARCHAR(20),
@where VARCHAR(300)
AS
exec Proc_SelectPageBase @rowCount output,@cloumns,'i_id','Site_CMSItem',@pageIndex,@pageSize,@orderBy,@where



GO
/****** Object:  StoredProcedure [dbo].[Proc_Site_CMSItem_UpdateByi_gid]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****修改*****
*****CreateUser:yang.liao*****
*****CreateTime:11  2 2015  3:51PM*****/
CREATE proc [dbo].[Proc_Site_CMSItem_UpdateByi_gid]
@i_id int,
@i_gid varchar(8),
@i_b_gid varchar(8),
@i_p_gid varchar(8),
@i_title nvarchar(50),
@i_c_gid varchar(8),
@i_c_type nvarchar(50),
@i_subTitle nvarchar(20),
@i_intro nvarchar(500),
@i_c_img_src VARCHAR(150),
@i_status int,
@i_createUser nvarchar(30),
@i_createTime DATETIME
AS
update [Site_CMSItem] SET 
i_b_gid=@i_b_gid,
i_p_gid=@i_p_gid,
i_title=@i_title,
i_c_gid=@i_c_gid,
i_c_type=@i_c_type,
i_subTitle=@i_subTitle,
i_intro=@i_intro,
i_c_img_src=@i_c_img_src,
i_status=@i_status,
i_createUser=@i_createUser,
i_createTime=@i_createTime
 where i_gid=@i_gid






GO
/****** Object:  StoredProcedure [dbo].[Proc_Site_CMSPage_DeleteByp_gid]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****删除*****
*****CreateUser:yang.liao*****
*****CreateTime:11  2 2015  3:53PM*****/
create proc [dbo].[Proc_Site_CMSPage_DeleteByp_gid]
@p_gid VARCHAR(8)
AS
delete from [Site_CMSPage] where p_gid=@p_gid






GO
/****** Object:  StoredProcedure [dbo].[Proc_Site_CMSPage_Insert]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****插入*****
*****CreateUser:yang.liao*****
*****CreateTime:11  2 2015  3:53PM*****/
create proc [dbo].[Proc_Site_CMSPage_Insert]
@p_id int output,
@p_gid varchar(8),
@p_name nvarchar(50),
@p_path nvarchar(100),
@p_tempPath nvarchar(100),
@p_filePath nvarchar(100),
@p_createTime DateTime,
@p_createUser nvarchar(30),
@p_pageDuty nvarchar(100),
@p_siteName nvarchar(30)
AS
insert into [Site_CMSPage](
p_gid,
p_name,
p_path,
p_tempPath,
p_filePath,
p_createTime,
p_createUser,
p_pageDuty,
p_siteName
)
values(
@p_gid,
@p_name,
@p_path,
@p_tempPath,
@p_filePath,
@p_createTime,
@p_createUser,
@p_pageDuty,
@p_siteName
)
SET @p_id=@@IDENTITY






GO
/****** Object:  StoredProcedure [dbo].[Proc_Site_CMSPage_SelectByp_gid]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****查询*****
*****CreateUser:yang.liao*****
*****CreateTime:11  2 2015  3:53PM*****/
create proc [dbo].[Proc_Site_CMSPage_SelectByp_gid]
@p_gid VARCHAR(8)
AS
select * FROM [Site_CMSPage] WHERE p_gid=@p_gid






GO
/****** Object:  StoredProcedure [dbo].[Proc_Site_CMSPage_SelectPage]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****查询*****
*****CreateUser:yang.liao*****
*****CreateTime:11  2 2015  3:53PM*****/
create proc [dbo].[Proc_Site_CMSPage_SelectPage]
@rowCount INT OUTPUT,
@cloumns VARCHAR(200),
@pageIndex INT,
@pageSize INT,
@orderBy VARCHAR(20),
@where VARCHAR(300)
AS
exec Proc_SelectPageBase @rowCount output,@cloumns,'p_id','Site_CMSPage',@pageIndex,@pageSize,@orderBy,@where



GO
/****** Object:  StoredProcedure [dbo].[Proc_Site_CMSPage_UpdateByp_gid]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****修改*****
*****CreateUser:yang.liao*****
*****CreateTime:11  2 2015  3:53PM*****/
create proc [dbo].[Proc_Site_CMSPage_UpdateByp_gid]
@p_id int,
@p_gid varchar(8),
@p_name nvarchar(50),
@p_path nvarchar(100),
@p_tempPath nvarchar(100),
@p_filePath nvarchar(100),
@p_createTime DateTime,
@p_createUser nvarchar(30),
@p_pageDuty nvarchar(100),
@p_siteName nvarchar(30)
AS
update [Site_CMSPage] SET 
p_name=@p_name,
p_path=@p_path,
p_tempPath=@p_tempPath,
p_filePath=@p_filePath,
p_createTime=@p_createTime,
p_createUser=@p_createUser,
p_pageDuty=@p_pageDuty,
p_siteName=@p_siteName
 where p_gid=@p_gid






GO
/****** Object:  StoredProcedure [dbo].[Proc_Site_Content_DeleteByc_id]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****删除*****
*****CreateUser:yang.liao*****
*****CreateTime:12 22 2016 10:57PM*****/
create proc [dbo].[Proc_Site_Content_DeleteByc_id]
@c_id int
AS
delete from [Site_Content] where c_id=@c_id




GO
/****** Object:  StoredProcedure [dbo].[Proc_Site_Content_Insert]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****插入*****
*****CreateUser:yang.liao*****
*****CreateTime:12 22 2016 11:05PM*****/
CREATE proc [dbo].[Proc_Site_Content_Insert]
@c_id int output,
@c_gid varchar(8),
@c_c_gid varchar(8),
@c_title nvarchar(50),
@c_keywords NVARCHAR(50),
@c_sub_title nvarchar(20),
@c_intro nvarchar(100),
@c_content nvarchar(MAX),
@c_img_src varchar(150),
@c_createUserId varchar(8),
@c_createUserName nvarchar(30),
@c_createUserNickName nvarchar(30),
@c_createTime DateTime,
@c_status int,
@c_state bit
AS
insert into [Site_Content](
c_gid,
c_c_gid,
c_title,
c_keywords,
c_sub_title,
c_intro,
c_content,
c_img_src,
c_createUserId,
c_createUserName,
c_createUserNickName,
c_createTime,
c_status,
c_state
)
values(
@c_gid,
@c_c_gid,
@c_title,
@c_keywords,
@c_sub_title,
@c_intro,
@c_content,
@c_img_src,
@c_createUserId,
@c_createUserName,
@c_createUserNickName,
@c_createTime,
@c_status,
@c_state
)
SET @c_id=@@IDENTITY




GO
/****** Object:  StoredProcedure [dbo].[Proc_Site_Content_SelectByc_gid]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****查询*****
*****CreateUser:yang.liao*****
*****CreateTime:12 22 2016 11:05PM*****/
CREATE proc [dbo].[Proc_Site_Content_SelectByc_gid]
@c_gid VARCHAR(8)
AS
select * FROM [Site_Content] WHERE c_gid=@c_gid
GO
/****** Object:  StoredProcedure [dbo].[Proc_Site_Content_SelectByc_id]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****查询*****
*****CreateUser:yang.liao*****
*****CreateTime:12 22 2016 10:57PM*****/
create proc [dbo].[Proc_Site_Content_SelectByc_id]
@c_id int
AS
select * FROM [Site_Content] WHERE c_id=@c_id




GO
/****** Object:  StoredProcedure [dbo].[Proc_Site_Content_SelectPage]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****查询*****
*****CreateUser:yang.liao*****
*****CreateTime:12 22 2016 10:57PM*****/
create proc [dbo].[Proc_Site_Content_SelectPage]
@rowCount INT OUTPUT,
@cloumns VARCHAR(200),
@pageIndex INT,
@pageSize INT,
@orderBy VARCHAR(20),
@where VARCHAR(300)
AS
exec Proc_SelectPageBase @rowCount output,@cloumns,'c_id','Site_Content',@pageIndex,@pageSize,@orderBy,@where

GO
/****** Object:  StoredProcedure [dbo].[Proc_Site_Content_SelectPageByc_id]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Proc_Site_Content_SelectPageByc_id]
@rowCount INT OUTPUT,
@cateId INT,
@pageIndex INT,
@pageSize INT
AS
SELECT * FROM (
SELECT ROW_NUMBER() OVER(ORDER BY t1.c_createTime DESC)AS nums ,* FROM dbo.Site_Content AS t1 WHERE t1.c_c_gid IN(
	SELECT c_gid FROM dbo.Site_Cates WHERE 
	LEFT(c_path,2)=(SELECT c_path FROM dbo.Site_Cates WHERE c_id=@cateId)
)) temp WHERE temp.nums BETWEEN ((@pageIndex-1)*@pageSize)+1 AND @pageIndex*@pageSize;
SELECT @rowCount= COUNT(1) FROM dbo.Site_Content t2 WHERE t2.c_c_gid IN(
	SELECT c_gid FROM dbo.Site_Cates WHERE 
	LEFT(c_path,2)=(SELECT c_path FROM dbo.Site_Cates WHERE c_id=@cateId)
);
GO
/****** Object:  StoredProcedure [dbo].[Proc_Site_Content_UpdateByc_id]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****修改*****
*****CreateUser:yang.liao*****
*****CreateTime:12 22 2016 11:05PM*****/
CREATE proc [dbo].[Proc_Site_Content_UpdateByc_id]
@c_id int,
@c_gid varchar(8),
@c_c_gid varchar(8),
@c_title nvarchar(50),
@c_keywords NVARCHAR(50),
@c_sub_title nvarchar(20),
@c_intro nvarchar(100),
@c_content nvarchar(MAX),
@c_img_src varchar(150),
@c_createUserId varchar(8),
@c_createUserName nvarchar(30),
@c_createUserNickName nvarchar(30),
@c_status int,
@c_state bit
AS
update [Site_Content] SET 
c_gid=@c_gid,
c_c_gid=@c_c_gid,
c_title=@c_title,
c_keywords=@c_keywords,
c_sub_title=@c_sub_title,
c_intro=@c_intro,
c_content=@c_content,
c_img_src=@c_img_src,
c_createUserId=@c_createUserId,
c_createUserName=@c_createUserName,
c_createUserNickName=@c_createUserNickName,
c_status=@c_status,
c_state=@c_state
 where c_id=@c_id




GO
/****** Object:  StoredProcedure [dbo].[Proc_SystemGroup_DeleteByg_gid]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****删除*****
*****CreateUser:yang.liao*****
*****CreateTime:11  2 2015  3:55PM*****/
create proc [dbo].[Proc_SystemGroup_DeleteByg_gid]
@g_gid VARCHAR(8)
AS
delete from [SystemGroup] where g_gid=@g_gid






GO
/****** Object:  StoredProcedure [dbo].[Proc_SystemGroup_Insert]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****插入*****
*****CreateUser:yang.liao*****
*****CreateTime:11  2 2015  3:55PM*****/
create proc [dbo].[Proc_SystemGroup_Insert]
@g_id int output,
@g_gid varchar(8),
@g_name nvarchar(50),
@g_picCover nvarchar(50),
@g_createTime DateTime,
@g_createUser nvarchar(50),
@g_sort int
AS
insert into [SystemGroup](
g_gid,
g_name,
g_picCover,
g_createTime,
g_createUser,
g_sort
)
values(
@g_gid,
@g_name,
@g_picCover,
@g_createTime,
@g_createUser,
@g_sort
)
SET @g_id=@@IDENTITY






GO
/****** Object:  StoredProcedure [dbo].[Proc_SystemGroup_SelectByg_gid]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****查询*****
*****CreateUser:yang.liao*****
*****CreateTime:11  2 2015  3:55PM*****/
create proc [dbo].[Proc_SystemGroup_SelectByg_gid]
@g_gid VARCHAR(8)
AS
select * FROM [SystemGroup] WHERE g_gid=@g_gid







GO
/****** Object:  StoredProcedure [dbo].[Proc_SystemGroup_SelectByu_gid]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Proc_SystemGroup_SelectByu_gid]
	@u_gid VARCHAR(8)
AS
	SELECT  * FROM dbo.SystemGroup WHERE g_gid IN(
	SELECT DISTINCT m_g_gid FROM dbo.SystemModual WHERE m_gid IN(
	SELECT p_m_gid FROM dbo.ModulePermission WHERE p_gid IN(
	SELECT p_gid FROM dbo.Role_ModualPermission_Mapping WHERE r_gid IN (
 	SELECT r_gid FROM dbo.User_Role_Mapping WHERE u_gid=@u_gid))))



GO
/****** Object:  StoredProcedure [dbo].[Proc_SystemGroup_SelectPage]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****查询*****
*****CreateUser:yang.liao*****
*****CreateTime:06 25 2014  3:07PM*****/
create proc [dbo].[Proc_SystemGroup_SelectPage]
@rowCount INT OUTPUT,
@cloumns VARCHAR(200),
@pageIndex INT,
@pageSize INT,
@orderBy VARCHAR(20),
@where VARCHAR(300)
AS
exec Proc_SelectPageBase @rowCount output,@cloumns,'g_id','SystemGroup',@pageIndex,@pageSize,@orderBy,@where



GO
/****** Object:  StoredProcedure [dbo].[Proc_SystemGroup_UpdateByg_gid]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****修改*****
*****CreateUser:yang.liao*****
*****CreateTime:11  2 2015  3:55PM*****/
create proc [dbo].[Proc_SystemGroup_UpdateByg_gid]
@g_id int,
@g_gid varchar(8),
@g_name nvarchar(50),
@g_picCover nvarchar(50),
@g_createTime DateTime,
@g_createUser nvarchar(50),
@g_sort int
AS
update [SystemGroup] SET 
g_name=@g_name,
g_picCover=@g_picCover,
g_createTime=@g_createTime,
g_createUser=@g_createUser,
g_sort=@g_sort
 where g_gid=@g_gid






GO
/****** Object:  StoredProcedure [dbo].[Proc_SystemModual_DeleteBym_gid]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****删除*****
*****CreateUser:yang.liao*****
*****CreateTime:05 22 2014 11:01PM*****/
CREATE proc [dbo].[Proc_SystemModual_DeleteBym_gid]
@m_gid VARCHAR(8)
AS
DELETE FROM [SystemModual] WHERE m_gid=@m_gid



GO
/****** Object:  StoredProcedure [dbo].[Proc_SystemModual_DeleteBym_id]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****删除*****
*****CreateUser:yang.liao*****
*****CreateTime:05 22 2014 11:01PM*****/
create proc [dbo].[Proc_SystemModual_DeleteBym_id]
@m_id int
AS
delete from [SystemModual] where m_id=@m_id



GO
/****** Object:  StoredProcedure [dbo].[Proc_SystemModual_Insert]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****插入*****
*****CreateUser:yang.liao*****
*****CreateTime:05 22 2014 11:01PM*****/
CREATE proc [dbo].[Proc_SystemModual_Insert]
@m_id int output,
@m_gid varchar(8),
@m_g_gid VARCHAR(8),
@m_name nvarchar(50),
@m_path NVARCHAR(50),
@m_parent int,
@m_parent_gid VARCHAR(8),
@m_Controller varchar(50),
@m_Action varchar(50),
@m_createTime DateTime,
@m_createUser nvarchar(50)
AS
insert into [SystemModual](
m_gid,
m_g_gid,
m_name,
m_path,
m_parent,
m_parent_gid,
m_Controller,
m_Action,
m_createTime,
m_createUser
)
values(
@m_gid,
@m_g_gid,
@m_name,
@m_path,
@m_parent,
@m_parent_gid,
@m_Controller,
@m_Action,
@m_createTime,
@m_createUser
)
SET @m_id=@@IDENTITY



GO
/****** Object:  StoredProcedure [dbo].[Proc_SystemModual_SelectBym_gid]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****查询*****
*****CreateUser:yang.liao*****
*****CreateTime:05 22 2014 11:01PM*****/
CREATE proc [dbo].[Proc_SystemModual_SelectBym_gid]
@m_gid VARCHAR(8)
AS
select * FROM [SystemModual] WHERE m_gid=@m_gid



GO
/****** Object:  StoredProcedure [dbo].[Proc_SystemModual_SelectByu_gid]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Proc_SystemModual_SelectByu_gid]
	@u_gid VARCHAR(8),
	@m_g_gid VARCHAR(8)
AS
	--一个用户可能对应多个角色
	---查询用户 模块组下的模块信息
WITH
	temp AS (
		SELECT * FROM dbo.SystemModual WHERE m_gid IN (--查询权限id对应的 模块信息
SELECT p_m_gid FROM ModulePermission WHERE p_gid IN(--查询模块权限 对应的 模块gid
SELECT p_gid FROM Role_ModualPermission_Mapping WHERE r_gid IN (--查询角色对应的 模块权限gid
SELECT r_gid FROM dbo.User_Role_Mapping WHERE u_gid=@u_gid)--查询用户对应的 角色gid
)) AND m_g_gid=@m_g_gid
)
SELECT * FROM dbo.SystemModual WHERE m_id IN (
	SELECT m_parent FROM temp
)
UNION
SELECT * FROM temp



GO
/****** Object:  StoredProcedure [dbo].[Proc_SystemModual_SelectPage]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****查询*****
*****CreateUser:yang.liao*****
*****CreateTime:05 22 2014 11:01PM*****/
create proc [dbo].[Proc_SystemModual_SelectPage]
@rowCount INT OUTPUT,
@cloumns VARCHAR(200),
@pageIndex INT,
@pageSize INT,
@orderBy VARCHAR(20),
@where VARCHAR(300)
AS
exec Proc_SelectPageBase @rowCount output,@cloumns,'m_id','SystemModual',@pageIndex,@pageSize,@orderBy,@where



GO
/****** Object:  StoredProcedure [dbo].[Proc_SystemModual_UpdateBym_gid]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****修改*****
*****CreateUser:yang.liao*****
*****CreateTime:05 22 2014 11:01PM*****/
CREATE proc [dbo].[Proc_SystemModual_UpdateBym_gid]
@m_gid varchar(8),
@m_name nvarchar(50),
@m_path NVARCHAR(50),
@m_parent int,
@m_parent_gid VARCHAR(8),
@m_Controller varchar(50),
@m_Action varchar(50),
@m_createTime DateTime,
@m_createUser nvarchar(50)
AS
update [SystemModual] SET 
m_name=@m_name,
m_path=@m_path,
m_parent=@m_parent,
m_parent_gid=@m_parent_gid,
m_Controller=@m_Controller,
m_Action=@m_Action,
m_createTime=@m_createTime,
m_createUser=@m_createUser
 where m_gid=@m_gid



GO
/****** Object:  StoredProcedure [dbo].[Proc_User_DeleteByu_gid]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****删除*****
*****CreateUser:yang.liao*****
*****CreateTime:05 17 2014  6:34PM*****/
CREATE proc [dbo].[Proc_User_DeleteByu_gid]
@u_gid VARCHAR(8)
AS
delete from [User] where u_gid=@u_gid



GO
/****** Object:  StoredProcedure [dbo].[Proc_User_Insert]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****插入*****
*****CreateUser:yang.liao*****
*****CreateTime:05 17 2014  6:34PM*****/
create proc [dbo].[Proc_User_Insert]
@u_id int output,
@u_gid varchar(8),
@u_username nvarchar(50),
@u_password nvarchar(16),
@u_createTime DateTime
AS
insert into [User](
u_gid,
u_username,
u_password,
u_createTime
)
values(
@u_gid,
@u_username,
@u_password,
@u_createTime
)
SET @u_id=@@IDENTITY



GO
/****** Object:  StoredProcedure [dbo].[Proc_User_Role_Mapping_DeleteByu_r_id]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****删除*****
*****CreateUser:yang.liao*****
*****CreateTime:08 23 2017 10:00AM*****/
create proc [dbo].[Proc_User_Role_Mapping_DeleteByu_r_id]
@u_r_id int
AS
delete from [User_Role_Mapping] where u_r_id=@u_r_id




GO
/****** Object:  StoredProcedure [dbo].[Proc_User_Role_Mapping_Insert]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****插入*****
*****CreateUser:yang.liao*****
*****CreateTime:08 23 2017 10:00AM*****/
create proc [dbo].[Proc_User_Role_Mapping_Insert]
@u_r_id int output,
@u_r_gid varchar(8),
@u_gid varchar(8),
@r_gid varchar(8),
@u_r_CreateTime DateTime,
@u_r_CreateUser nvarchar(30)
AS
insert into [User_Role_Mapping](
u_r_gid,
u_gid,
r_gid,
u_r_CreateTime,
u_r_CreateUser
)
values(
@u_r_gid,
@u_gid,
@r_gid,
@u_r_CreateTime,
@u_r_CreateUser
)
SET @u_r_id=@@IDENTITY




GO
/****** Object:  StoredProcedure [dbo].[Proc_User_Role_Mapping_SelectByu_gid]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****查询*****
*****CreateUser:yang.liao*****
*****CreateTime:08 23 2017 10:00AM*****/
CREATE proc [dbo].[Proc_User_Role_Mapping_SelectByu_gid]
@u_gid VARCHAR(8)
AS
select * FROM [User_Role_Mapping] WHERE u_gid=@u_gid




GO
/****** Object:  StoredProcedure [dbo].[Proc_User_Role_Mapping_SelectByu_r_id]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****查询*****
*****CreateUser:yang.liao*****
*****CreateTime:08 23 2017 10:00AM*****/
create proc [dbo].[Proc_User_Role_Mapping_SelectByu_r_id]
@u_r_id int
AS
select * FROM [User_Role_Mapping] WHERE u_r_id=@u_r_id




GO
/****** Object:  StoredProcedure [dbo].[Proc_User_Role_Mapping_SelectPage]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****查询*****
*****CreateUser:yang.liao*****
*****CreateTime:08 23 2017 10:00AM*****/
create proc [dbo].[Proc_User_Role_Mapping_SelectPage]
@rowCount INT OUTPUT,
@cloumns VARCHAR(200),
@pageIndex INT,
@pageSize INT,
@orderBy VARCHAR(20),
@where VARCHAR(300)
AS
exec Proc_SelectPageBase @rowCount output,@cloumns,'u_r_id','User_Role_Mapping',@pageIndex,@pageSize,@orderBy,@where

GO
/****** Object:  StoredProcedure [dbo].[Proc_User_Role_Mapping_UpdateByu_r_id]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****修改*****
*****CreateUser:yang.liao*****
*****CreateTime:08 23 2017 10:00AM*****/
create proc [dbo].[Proc_User_Role_Mapping_UpdateByu_r_id]
@u_r_id int,
@u_r_gid varchar(8),
@u_gid varchar(8),
@r_gid varchar(8),
@u_r_CreateTime DateTime,
@u_r_CreateUser nvarchar(30)
AS
update [User_Role_Mapping] SET 
u_r_gid=@u_r_gid,
u_gid=@u_gid,
r_gid=@r_gid,
u_r_CreateTime=@u_r_CreateTime,
u_r_CreateUser=@u_r_CreateUser
 where u_r_id=@u_r_id




GO
/****** Object:  StoredProcedure [dbo].[Proc_User_SelectByu_gid]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****查询*****
*****CreateUser:yang.liao*****
*****CreateTime:05 17 2014  6:34PM*****/
CREATE proc [dbo].[Proc_User_SelectByu_gid]
@u_gid NVARCHAR(8)
AS
select * FROM [User] WHERE u_gid=@u_gid



GO
/****** Object:  StoredProcedure [dbo].[Proc_User_SelectByu_name]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****查询*****
*****CreateUser:yang.liao*****
*****CreateTime:05 17 2014  6:34PM*****/
CREATE proc [dbo].[Proc_User_SelectByu_name]
@u_username NVARCHAR(50)
AS
select * FROM [User] WHERE u_username=@u_username



GO
/****** Object:  StoredProcedure [dbo].[Proc_User_SelectPage]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****查询*****
*****CreateUser:yang.liao*****
*****CreateTime:05 17 2014  6:34PM*****/
create proc [dbo].[Proc_User_SelectPage]
@rowCount INT OUTPUT,
@cloumns VARCHAR(200),
@pageIndex INT,
@pageSize INT,
@orderBy VARCHAR(20),
@where VARCHAR(300)
AS
exec Proc_SelectPageBase @rowCount output,@cloumns,'u_id','User',@pageIndex,@pageSize,@orderBy,@where



GO
/****** Object:  StoredProcedure [dbo].[Proc_User_UpdateByu_gid]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*****修改*****
*****CreateUser:yang.liao*****
*****CreateTime:05 17 2014  6:34PM*****/
CREATE proc [dbo].[Proc_User_UpdateByu_gid]
@u_gid varchar(8),
@u_password varchar(32),
@u_status INT,
@u_username NVARCHAR(50)
AS
update [User] SET 
u_password=@u_password,
u_status=@u_status,
u_username=@u_username
 where u_gid=@u_gid



GO
/****** Object:  StoredProcedure [dbo].[Tool_CreateDALByMSEnterlibry]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Tool_CreateDALByMSEnterlibry]
	@procname varchar(100),
	@returnType VARCHAR(50),
	@inputType VARCHAR(50)
AS
IF NOT EXISTS(SELECT * FROM sys.procedures WHERE name=@procname)
BEGIN
PRINT 'Not Find This Procdurece'
RETURN
END

DECLARE @name VARCHAR(30),@userType INT,@isOutPut BIT,@hasOutPut BIT,@outputArgu VARCHAR(30)
DECLARE columnCursor SCROLL CURSOR FOR
SELECT name,user_type_id,is_output FROM sys.parameters WHERE object_id=OBJECT_ID(@procname)



OPEN columnCursor

PRINT N'#region '+@procname
IF((CHARINDEX('selectPage',@procname)!=0))
	BEGIN
		PRINT N'public '+@returnType+' '+SUBSTRING(@procname,CHARINDEX('_',@procname)+1,LEN(@procname)-4)+'(string cloumns,int pageIndex,int pageSize,string orderBy,string where,out int rowCount)'
	END
ELSE
	BEGIN
		PRINT N'public '+@returnType+' '+SUBSTRING(@procname,CHARINDEX('_',@procname)+1,LEN(@procname)-4)+'('+@inputType+' obj)'
	END

PRINT N'{
		DbCommand dbCmd = db.GetStoredProcCommand("'+@procname+'");'
			
FETCH NEXT FROM columnCursor INTO @name,@userType,@isOutPut
DECLARE @csharpType VARCHAR(20)

WHILE @@FETCH_STATUS=0
BEGIN
	IF(@userType IN (56))
	SET @csharpType='Int32'
	ELSE IF(@userType IN (167,175,231))
	SET @csharpType='String'
	ELSE IF(@userType IN (60))
	SET @csharpType='Decimal'	
	ELSE IF(@userType IN (61))
	SET @csharpType='DateTime'
	ELSE IF(@userType IN (62))
	SET @csharpType='Single'
	ELSE IF(@userType IN (104))
	SET @csharpType='Boolean'
	ELSE
	SET @csharpType='String'
IF(@isOutPut=1)
	BEGIN
	SET @hasOutPut=1
	SET @outputArgu=@name
	PRINT N'		db.AddOutParameter(dbCmd, "'+@name+'", DbType.'+@csharpType+',4);'
	END
ELSE
	BEGIN
	IF(CHARINDEX('selectPage',@procname)!=0)
	BEGIN
		PRINT N'		db.AddInParameter(dbCmd, "'+@name+'", DbType.'+@csharpType+','+SUBSTRING(@name,2,LEN(@name)-1)+');'
	END
	else
	PRINT N'		db.AddInParameter(dbCmd, "'+@name+'", DbType.'+@csharpType+', obj.'+SUBSTRING(@name,2,LEN(@name)-1)+');'
	
	END

FETCH NEXT FROM columnCursor INTO @name,@userType,@isOutPut
END
DECLARE @modelType VARCHAR(30)
IF(LOWER(@returnType)='int' OR @returnType='')
BEGIN

PRINT N'		try
			{ 
				int returnValue = db.ExecuteNonQuery(dbCmd);'
	IF(@hasOutPut=1)
	BEGIN
		PRINT N'			int '+SUBSTRING(@outputArgu,2,LEN(@outputArgu)-1)+' = (int)dbCmd.Parameters["'+@outputArgu+'"].Value;'
	END
PRINT N'		return returnValue;
			}
			 catch(Exception e)
			{
				throw new Exception(e.Message);
			}'
END
ELSE IF(CHARINDEX('list',@returnType)!=0)
BEGIN
	SET @modelType=SUBSTRING(@procname,CHARINDEX('_',@procname)+1,CHARINDEX('_',@procname,6)-CHARINDEX('_',@procname)-1)
PRINT N'		'+@returnType+' list=new '+@returnType+'();
			try
            {
               using( IDataReader reader = db.ExecuteReader(dbCmd))
               {
					while (reader.Read())
					{
						'+@modelType+' obj=new '+@modelType+'();
						//属性赋值
	                    
						list.Add(obj);
					}'
		IF(CHARINDEX('selectPage',@procname)!=0)
		BEGIN
			PRINT N'					reader.NextResult();
				}'
			PRINT N'			'+SUBSTRING(@outputArgu,2,LEN(@outputArgu)-1)+' = (int)dbCmd.Parameters["'+@outputArgu+'"].Value;'
		END
PRINT'			return list;
            }
            catch (Exception e)
            {
                throw new Exception(e.Message);
            }'
END
ELSE
BEGIN
	
	SET @modelType=SUBSTRING(@procname,CHARINDEX('_',@procname)+1,CHARINDEX('_',@procname,6)-1-CHARINDEX('_',@procname))
	PRINT N'		'+@modelType+' obj=null;
			try
            {
               using(IDataReader reader = db.ExecuteReader(dbCmd))
               {
					while (reader.Read())
					{
						obj=new '+@modelType+'();
						//属性赋值
	                    
					}
                }'
		IF(CHARINDEX('selectPage',@procname)!=0)
		PRINT N'			'+SUBSTRING(@outputArgu,2,LEN(@outputArgu)-1)+' = (int)dbCmd.Parameters["'+@outputArgu+'"].Value;'
PRINT'			return obj;
            }
            catch (Exception e)
            {
                throw new Exception(e.Message);
            }'
END
PRINT N'}
	#endregion
'

CLOSE columnCursor
DEALLOCATE columnCursor



GO
/****** Object:  StoredProcedure [dbo].[Tool_CreateModel]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Tool_CreateModel]
	@tableName VARCHAR(50)
AS
--用来在游标中储值
DECLARE @modelName VARCHAR(50),@type VARCHAR(5)
--用来存储类型
DECLARE @fieldType VARCHAR(20)
-----------------------------查询表的所有字段
IF NOT EXISTS(SELECT * FROM sys.tables WHERE name=@tableName)
BEGIN
PRINT 'Not Find This Table'
RETURN
END


--定义游标 for 结果集
DECLARE modelCursor CURSOR FOR
(SELECT name,xtype FROM  syscolumns WHERE id=OBJECT_ID(@tableName))
--打开游标
OPEN modelCursor
--移动游标到下一个
FETCH NEXT FROM modelCursor INTO @modelName,@type
--循环取出游标的值

---打印Model类
	PRINT 'public class '+@tableName
	PRINT '{'
WHILE @@FETCH_STATUS=0
BEGIN
	IF(@type IN ('167','175','231','239'))
	BEGIN
		SET @fieldType='string'
	END
	ELSE IF(@type IN ('56'))
	BEGIN
		SET @fieldType='int'
	END
	ELSE IF(@type IN ('61'))
	BEGIN
		SET @fieldType='DateTime'
	END
	ELSE IF(@type IN ('106'))
	BEGIN
		SET @fieldType='decimal'
	END
	ELSE IF(@type IN ('104'))
	BEGIN
		SET @fieldType='bool'
	END
	ELSE
	BEGIN
		SET @fieldType='undifind'
	END
	--打印属性
	PRINT ''
	PRINT '#region '+@modelName
	PRINT 'private '+@fieldType+' _'+@modelName+';'
    PRINT 'public '+@fieldType+' '+@modelName
    PRINT '{'
    PRINT ' get {'
    PRINT '     return this._'+@modelName+';'
    PRINT ' }'
    PRINT ' set {'
    PRINT '     this._'+@modelName+' = value;'
    PRINT ' }'
    PRINT '}'
	PRINT '#endregion'
	--移动游标
	FETCH NEXT FROM modelCursor INTO @modelName,@type
END
PRINT '}'
---关闭游标
CLOSE modelCursor
---释放游标
DEALLOCATE modelCursor



GO
/****** Object:  StoredProcedure [dbo].[Tool_CreateProc]    Script Date: 2017/8/28 18:11:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Tool_CreateProc]
	@tableName VARCHAR(50),
	@createUser NVARCHAR(50)=''
AS
DECLARE @name VARCHAR(20),@userType VARCHAR(5),@isIdentity BIT,@maxLength INT

IF NOT EXISTS(SELECT * FROM sys.tables WHERE name=@tableName)
BEGIN
PRINT 'Not Find This Table'
RETURN
END


DECLARE columnsCursor SCROLL CURSOR FOR
--查询表有哪些列
SELECT name,user_type_id,is_identity,max_length FROM sys.columns WHERE object_id=OBJECT_ID(@tableName)

--打开游标
OPEN columnsCursor
--移动游标
FETCH NEXT FROM columnsCursor INTO @name,@userType,@isIdentity,@maxLength

----------------------------插入----------------------------------
PRINT N'
GO'
	PRINT N'if exists (select * from sysobjects where name=''Proc_'+@tableName+'_Insert'')
	begin
	print ''has exists this name Proc,please ensure''
	return
	end
GO
/*****插入*****
*****CreateUser:'+@createUser+'*****'+'
*****CreateTime:'+CAST(GETDATE()AS VARCHAR(30))+'*****/
create proc Proc_'+@tableName+'_Insert'
DECLARE @columnType NVARCHAR(30),@argus VARCHAR(100),@outPutArgument VARCHAR(30)

WHILE @@FETCH_STATUS=0
BEGIN
		--调用函数，得到数据类型
		SET @columnType=dbo.f_GetCSharpDataTypeBySqlUserType(@userType,@maxLength)
		IF(@isIdentity=1)
		BEGIN
		SET @argus= '@'+@name+' '+@columnType+' output'
		SET @outPutArgument=@name
		END
		ELSE
		SET @argus= '@'+@name+' '+@columnType
--移动游标,判断是否还有下一条
FETCH NEXT FROM columnsCursor INTO @name,@userType,@isIdentity,@maxLength
	IF(@@FETCH_STATUS=0)
	BEGIN
	PRINT @argus+','
	END
	ELSE
	BEGIN
	PRINT @argus
	END
END

-------------------------
PRINT 'AS'
PRINT 'insert into ['+@tableName+']('


--移动游标,判断是否还有下一条
FETCH FIRST FROM columnsCursor INTO @name,@userType,@isIdentity,@maxLength

WHILE @@FETCH_STATUS=0
BEGIN
	--调用函数，得到数据类型
	SET @columnType=dbo.f_GetCSharpDataTypeBySqlUserType(@userType,@maxLength)
	IF(@isIdentity=1)
	BEGIN
		--移动游标,判断是否还有下一条
		FETCH RELATIVE 1 FROM columnsCursor INTO @name,@userType,@isIdentity,@maxLength
		CONTINUE
	END
	ELSE
	BEGIN
		SET @argus=@name
	END
--移动游标,判断是否还有下一条
	FETCH RELATIVE 1 FROM columnsCursor INTO @name,@userType,@isIdentity,@maxLength
	IF(@@FETCH_STATUS=0)
	BEGIN
	PRINT @argus+','
	END
	ELSE
	BEGIN
	PRINT @argus
	END
	
END



PRINT ')
values('

--移动游标到第一条
FETCH FIRST FROM columnsCursor INTO @name,@userType,@isIdentity,@maxLength

WHILE @@FETCH_STATUS=0
BEGIN
	IF(@isIdentity=1)
	BEGIN
		--移动游标,判断是否还有下一条
		FETCH RELATIVE 1 FROM columnsCursor INTO @name,@userType,@isIdentity,@maxLength
		CONTINUE
	END
	ELSE
	BEGIN
		SET @argus='@'+@name
	END
--移动游标,判断是否还有下一条
	FETCH RELATIVE 1 FROM columnsCursor INTO @name,@userType,@isIdentity,@maxLength
	IF(@@FETCH_STATUS=0)
	BEGIN
	PRINT @argus+','
	END
	ELSE
	BEGIN
	PRINT @argus
	END
END
PRINT ')'
PRINT 'SET @'+@outPutArgument+'=@@IDENTITY'

-----------------------删除------------------------------
PRINT N'


GO'
	PRINT N'if exists (select * from sysobjects where name=''Proc_'+@tableName+'_DeleteBy'+@outPutArgument+''')
	begin
	print ''has exists this name Proc,please ensure''
	return
	end
GO
/*****删除*****
*****CreateUser:'+@createUser+'*****'+'
*****CreateTime:'+CAST(GETDATE()AS VARCHAR(30))+'*****/
create proc Proc_'+@tableName+'_DeleteBy'+@outPutArgument
PRINT '@'+@outPutArgument+' int
AS
'
PRINT 'delete from ['+@tableName+'] where '+@outPutArgument+'='+'@'+@outPutArgument

-----------------------修改------------------------------
PRINT N'


GO'
PRINT N'if exists (select * from sysobjects where name=''Proc_'+@tableName+'_UpdateBy'+@outPutArgument+''')
	begin
	print ''has exists this name Proc,please ensure''
	return
	end
GO
/*****修改*****
*****CreateUser:'+@createUser+'*****'+'
*****CreateTime:'+CAST(GETDATE()AS VARCHAR(30))+'*****/
create proc Proc_'+@tableName+'_UpdateBy'+@outPutArgument

--移动游标到第一条
FETCH FIRST FROM columnsCursor INTO @name,@userType,@isIdentity,@maxLength

WHILE @@FETCH_STATUS=0
BEGIN
		--调用函数，得到数据类型
		SET @columnType=dbo.f_GetCSharpDataTypeBySqlUserType(@userType,@maxLength)
		--IF(@isIdentity=1)
		--BEGIN
		----SET @argus=''
		--SET @outPutArgument=@name
		----移动游标,判断是否还有下一条
		--FETCH RELATIVE 1 FROM columnsCursor INTO @name,@userType,@isIdentity,@maxLength
		--CONTINUE
		--END
		--ELSE
		SET @argus= '@'+@name+' '+@columnType
--移动游标,判断是否还有下一条
FETCH RELATIVE 1 FROM columnsCursor INTO @name,@userType,@isIdentity,@maxLength
	IF(@@FETCH_STATUS=0)
	BEGIN
	PRINT @argus+','
	END
	ELSE
	BEGIN
	PRINT @argus
	END
END
PRINT 'AS'
PRINT 'update ['+@tableName+'] SET '

--移动游标到第一条
FETCH FIRST FROM columnsCursor INTO @name,@userType,@isIdentity,@maxLength
DECLARE @VALUES VARCHAR(50)
WHILE @@FETCH_STATUS=0
BEGIN
		IF(@isIdentity=1)
		BEGIN
		--移动游标,判断是否还有下一条
		FETCH RELATIVE 1 FROM columnsCursor INTO @name,@userType,@isIdentity,@maxLength
		CONTINUE
		END
		ELSE
		SET @VALUES= @name+'='+'@'+@name
--移动游标,判断是否还有下一条
FETCH RELATIVE 1 FROM columnsCursor INTO @name,@userType,@isIdentity,@maxLength
	IF(@@FETCH_STATUS=0)
	BEGIN
	PRINT @VALUES+','
	END
	ELSE
	BEGIN
	PRINT @VALUES
	END
END
PRINT ' where '+@outPutArgument+'='+'@'+@outPutArgument



-----------------------查询------------------------------
PRINT N'


GO'
	PRINT N'if exists (select * from sysobjects where name=''Proc_'+@tableName+'_SelectBy'+@outPutArgument+''')
	begin
	print ''has exists this name Proc,please ensure''
	return
	end
GO
/*****查询*****
*****CreateUser:'+@createUser+'*****'+'
*****CreateTime:'+CAST(GETDATE()AS VARCHAR(30))+'*****/
create proc Proc_'+@tableName+'_SelectBy'+@outPutArgument
PRINT '@'+@outPutArgument+' int'
PRINT 'AS
select * FROM ['+@tableName+'] WHERE '+@outPutArgument+'='+'@'+@outPutArgument

-----------------------分页查询------------------------------
PRINT N'


GO'
PRINT N'if exists (select * from sysobjects where name=''Proc_'+@tableName+'_SelectPage'+''')
	begin
	print ''has exists this name Proc,please ensure''
	return
	end
GO
/*****查询*****
*****CreateUser:'+@createUser+'*****'+'
*****CreateTime:'+CAST(GETDATE()AS VARCHAR(30))+'*****/
create proc Proc_'+@tableName+'_SelectPage'
PRINT '@rowCount INT OUTPUT,
@cloumns VARCHAR(200),
@pageIndex INT,
@pageSize INT,
@orderBy VARCHAR(20),
@where VARCHAR(300)
AS
'
PRINT 'exec Proc_SelectPageBase @rowCount output,@cloumns,'''+@outPutArgument+''','''+@tableName+''',@pageIndex,@pageSize,@orderBy,@where'




--关闭游标
CLOSE columnsCursor
--释放游标
DEALLOCATE columnsCursor


--EXEC Tool_CreateProc 'User'



GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'模块对应的模块组 gid' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SystemModual', @level2type=N'COLUMN',@level2name=N'm_g_gid'
GO
USE [master]
GO
ALTER DATABASE [MySite] SET  READ_WRITE 
GO
