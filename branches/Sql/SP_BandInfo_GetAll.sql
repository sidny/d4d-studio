USE [d4d]
GO
/****** Object:  StoredProcedure [dbo].[BandInfo_GetAll]    Script Date: 10/20/2009 21:07:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		XinweiFeng
-- Create date: 2009-10-11
-- =============================================
CREATE PROCEDURE [dbo].[BandInfo_GetAll] 
   @MinIndex INT  
AS
BEGIN	
	
    SELECT 
               BandId, 
               BandName,
			   Info1,
			   Info2,
			   Info3,
			   Remark
    FROM bandinfo With(nolock)
    WHERE  DeleteFlag = 0 AND BandId>=@MinIndex
 
END
