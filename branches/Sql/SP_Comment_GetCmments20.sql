USE [d4d]
GO
/****** Object:  StoredProcedure [dbo].[Tags_GetTags20]    Script Date: 10/27/2009 16:44:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Create date: 2009-10-10
-- Description:	Add  TagsHits
-- =============================================
CREATE PROCEDURE [dbo].[Comment_GetCmments20]
   @ObjectType INT,  
   @id1 int = null,
	@id2 int = null,
	@id3 int = null,
	@id4 int = null,
	@id5 int = null,
	@id6 int = null,
	@id7 int = null,
	@id8 int = null,
	@id9 int = null,
	@id10 int = null,
	@id11 int = null,
	@id12 int = null,
	@id13 int = null,
	@id14 int = null,
	@id15 int = null,
	@id16 int = null,
	@id17 int = null,
	@id18 int = null,
	@id19 int = null,
	@id20 int = null
AS
BEGIN	
	
 select Count(Commentid) as CommentCount ,ObjectID,ObjectType 
 From comments with(nolock)
 where objectType =@ObjectType AND
 ObjectID IN
   (
          @id1,
			@id2,
			@id3,
			@id4,
			@id5,
			@id6,
			@id7,
			@id8,
			@id9,
			@id10,
			@id11,
			@id12,
			@id13,
			@id14,
			@id15,
			@id16,
			@id17,
			@id18,
			@id19,
			@id20
   ) 
   Group By ObjectID,ObjectType
END
