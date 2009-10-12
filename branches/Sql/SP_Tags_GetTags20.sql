SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		XinweiFeng
-- Create date: 2009-10-10
-- Description:	Add  TagsHits
-- =============================================
CREATE PROCEDURE dbo.Tags_GetTags20  
   @tid1 int = null,
	@tid2 int = null,
	@tid3 int = null,
	@tid4 int = null,
	@tid5 int = null,
	@tid6 int = null,
	@tid7 int = null,
	@tid8 int = null,
	@tid9 int = null,
	@tid10 int = null,
	@tid11 int = null,
	@tid12 int = null,
	@tid13 int = null,
	@tid14 int = null,
	@tid15 int = null,
	@tid16 int = null,
	@tid17 int = null,
	@tid18 int = null,
	@tid19 int = null,
	@tid20 int = null
AS
BEGIN	
	
    SELECT [TagId],[Name],[Hits],[AddUserID],[AddDate] 
    FROM tags With(nolock)
    WHERE TagId IN
   (
          @tid1,
			@tid2,
			@tid3,
			@tid4,
			@tid5,
			@tid6,
			@tid7,
			@tid8,
			@tid9,
			@tid10,
			@tid11,
			@tid12,
			@tid13,
			@tid14,
			@tid15,
			@tid16,
			@tid17,
			@tid18,
			@tid19,
			@tid20
   ) 
 
END
GO
