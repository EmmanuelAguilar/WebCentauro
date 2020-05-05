--=============================================================================
-- EJERCICIO NO.1 "API REST EN .NET"                                          =
-- Scripts Necesarios														  =
--=============================================================================

-------------------------------------------------------------------------------------
-- 1.- Creación de Tablas CTL_ROLES, CTL_SYSTEM_LOG, CTL_USERS y sus relaciones     -
-------------------------------------------------------------------------------------

USE PRACTICACENTAURO
GO
CREATE TABLE CTL_ROLES(
						[Id]         INT          IDENTITY(1,1) NOT NULL PRIMARY KEY,
						[RoleName]   VARCHAR(25)  NOT NULL,
						[Status]     INT          NOT NULL						
					  )

CREATE TABLE CTL_SYSTEM_LOG(
							 [Id]                 INT           IDENTITY(1,1) NOT NULL PRIMARY KEY,
							 [DateRegister]       DATETIME      NOT NULL,
							 [IdMovement]         INT           NOT NULL,						
							 [IdAffectedRegiser]  INT           NOT NULL,
							 [Description]        VARCHAR(2000) NOT NULL,
							 [IdUser]             INT           NOT NULL,
							 [WebPage]            VARCHAR(50)   NOT NULL  
						   )

CREATE TABLE CTL_USERS(
							 [Id]                 INT             IDENTITY(1,1) NOT NULL PRIMARY KEY,
							 [IdRole]             INT             NOT NULL,
							 [Name]               VARCHAR(20)     NULL,						
							 [LastName]           VARCHAR(25)     NULL,
							 [Surname]            VARCHAR(25)     NULL,
							 [Email]              VARCHAR(80)     NOT NULL,
							 [UserName]           VARCHAR(15)     NOT NULL,  
							 [Password]           VARBINARY(8000) NOT NULL,
							 [Parent]             INT             NULL,
							 [Status]             INT             NOT NULL,
						   )

-- Relacionando tablas CTL_ROLES y CTL_USERS a través de una relacion 1:M
ALTER TABLE CTL_USERS ADD FOREIGN KEY (IdRole) REFERENCES CTL_ROLES(Id)

-------------------------------------------------------------------------------
-- 2. Inserción de datos(ficticios) en CTL_ROLES,CTL_USERS, CTL_SYSTEM_LOG	  -
-------------------------------------------------------------------------------
INSERT INTO CTL_ROLES VALUES('Rol Test1',1)
INSERT INTO CTL_ROLES VALUES('Rol Test2',1)
INSERT INTO CTL_ROLES VALUES('Rol Test3',0)
INSERT INTO CTL_ROLES VALUES('Rol Test4',1)
INSERT INTO CTL_ROLES VALUES('Rol Test5',0)
INSERT INTO CTL_ROLES VALUES('Rol Test6',1)
INSERT INTO CTL_ROLES VALUES('Rol Test7',1)
INSERT INTO CTL_ROLES VALUES('Rol Test8',0)
INSERT INTO CTL_ROLES VALUES('Rol Test9',1)
SELECT * FROM CTL_ROLES

INSERT INTO CTL_USERS VALUES(1,'Usuario1','ApellidoP','ApellidoM','user1@gmail.com','us1',PWDENCRYPT('12341'),1,1)
INSERT INTO CTL_SYSTEM_LOG VALUES(GETDATE(),1,1,'Creación de usuario',1,'gestionarUsuarios.aspx')

INSERT INTO CTL_USERS VALUES(2,'Usuario2','ApellidoP','ApellidoM','user2@gmail.com','us2',PWDENCRYPT('12342'),2,1)
INSERT INTO CTL_SYSTEM_LOG VALUES(GETDATE(),1,2,'Creación de usuario',2,'gestionarUsuarios.aspx')

INSERT INTO CTL_USERS VALUES(3,'Usuario3','ApellidoP','ApellidoM','user3@gmail.com','us3',PWDENCRYPT('12343'),3,1)
INSERT INTO CTL_SYSTEM_LOG VALUES(GETDATE(),1,3,'Creación de usuario',3,'gestionarUsuarios.aspx')

INSERT INTO CTL_USERS VALUES(4,'Usuario4','ApellidoP','ApellidoM','user4@gmail.com','us4',PWDENCRYPT('12344'),4,1)
INSERT INTO CTL_SYSTEM_LOG VALUES(GETDATE(),1,4,'Creación de usuario',4,'gestionarUsuarios.aspx')

INSERT INTO CTL_USERS VALUES(5,'Usuario2','ApellidoP','ApellidoM','user5@gmail.com','us5',PWDENCRYPT('12345'),5,1)
INSERT INTO CTL_SYSTEM_LOG VALUES(GETDATE(),1,5,'Creación de usuario',5,'gestionarUsuarios.aspx')

INSERT INTO CTL_USERS VALUES(6,'UsuarioTest','ApellidoP','ApellidoM','userTest@gmail.com','usT',PWDENCRYPT('12346'),6,1)
INSERT INTO CTL_USERS VALUES(3,'UsuarioTest2','ApellidoP2','ApellidoM2','userTest2@gmail.com','usT2',PWDENCRYPT('12346'),6,1)

-------------------------------------------------------------------------------
-- 3. Creación de SP para consultar registros dinamicamente                   -
--          																  -
-------------------------------------------------------------------------------

USE PRACTICACENTAURO
GO
/*
	OBJECT:			SP_DYNAMIC_QUERY_SEARCH_USER
	DEVELOPER:		Ing.Emmanuel Aguilar Ventura
	CREATE DATE:	18/04/2020
	DESCRIPTION:	Stored procedure that builds and executes a dynamic query based on received parameters.
*/
CREATE PROCEDURE SP_DYNAMIC_QUERY_SEARCH_USER
(
	@nombre       VARCHAR(20) = NULL,
	@apellidoP    VARCHAR(25) = NULL,
	@apellidoM    VARCHAR(25) = NULL,
	@correo       VARCHAR(80) = NULL
)

AS
BEGIN TRY

		--Variables que contendrán la cadena a ejecutar.
		DECLARE @sqlText      NVARCHAR(4000)
		DECLARE @SQLWHERE     NVARCHAR(4000)

		--Consulta base
		SET @sqlText = 'SELECT U.Id,U.NAME,
							   U.LastName,
							   U.Surname,
							   U.Email,
							   U.UserName,
							   U.Parent,
							   R.ID AS IdRole,
							   R.RoleName,
							   R.Status AS StatusRole,
							   (SELECT TOP(1) L.DateRegister FROM CTL_SYSTEM_LOG  AS L WHERE IdUser = U.Id) AS LogDateRegister,
							   (SELECT TOP(1) L.Description FROM CTL_SYSTEM_LOG  AS L WHERE IdUser = U.Id) AS LogDescription,
							   (SELECT TOP(1) L.WebPage FROM CTL_SYSTEM_LOG  AS L WHERE IdUser = U.Id) AS LogWebPage,
							   U.Status AS StatusUser	  
						FROM CTL_USERS AS U,
							 CTL_ROLES AS R '

		SET @SQLWHERE = 'WHERE U.IdRole = R.Id '

		IF (@nombre IS NOT NULL)
			SET @SQLWHERE = @SQLWHERE + ' AND U.Name LIKE ('''+'%'+@nombre+'%'+''')'+''

		IF (@apellidoP IS NOT NULL)
		   SET @SQLWHERE = @SQLWHERE + ' AND U.LastName LIKE ('''+'%'+@apellidoP+'%'+''')'+''

		IF (@apellidoM IS NOT NULL)
		   SET @SQLWHERE = @SQLWHERE + ' AND U.Surname LIKE ('''+'%'+@apellidoM+'%'+''')'+''

		IF (@correo IS NOT NULL)
		   SET @SQLWHERE = @SQLWHERE + ' AND U.Email LIKE ('''+'%'+@correo+'%'+''')'+''

		   PRINT (@sqlText+@SQLWHERE)
		   EXEC (@sqlText+@SQLWHERE)

END TRY
 BEGIN CATCH 
       PRINT ERROR_MESSAGE();
END CATCH

-------------------------------------------------------------------------------
-- Test de funcionamiento 													  -
-------------------------------------------------------------------------------
EXEC	[dbo].[SP_DYNAMIC_QUERY_SEARCH_USER]
		@nombre = NULL,
		@apellidoP = NULL,
		@apellidoM = NULL,
		@correo =  N'user'

-------------------------------------------------------------------------------
-- 4. Creación de Función para poblar DropDownList de roles                   -
-------------------------------------------------------------------------------

-- =============================================
-- Author:		Emmanuel Aguilar
-- Create date: 18/04/2020
-- Description:	Get all active roles
-- =============================================
CREATE FUNCTION [dbo].[FN_GET_ROLES]()
RETURNS @TB TABLE 
(
 Id			    INT,
 [Description]  VARCHAR(2000)
)
BEGIN
	
	INSERT INTO @TB    SELECT Id,
	                          RoleName
					   FROM CTL_ROLES 
					   WHERE [Status] = 1
					   ORDER BY RoleName ASC	
RETURN
END
GO

-------------------------------------------------------------------------------
-- 5. Creación de SP para matenimiento de usuarios                            -
-------------------------------------------------------------------------------
USE PRACTICACENTAURO
GO
/*
	OBJECT:			SP_NEW_USER
	DEVELOPER:		Ing.Emmanuel Aguilar Ventura
	CREATE DATE:	18/04/2020
	DESCRIPTION:	Stored procedure that Inserts, Edits or Deletes users
*/
ALTER PROCEDURE SP_NEW_USER
(
     @Action             CHAR(2)  ,
	 @Id                 INT             = NULL,
	 @IdRole	         INT             = NULL,
	 @Name		         VARCHAR(20)     = NULL,
	 @LastName	         VARCHAR(25)     = NULL,
	 @Surname	         VARCHAR(25)     = NULL,
	 @Email		         VARCHAR(80)     = NULL,
	 @UserName	         VARCHAR(15)     = NULL,
	 @Password	         VARCHAR(8000)   = NULL,
	 @Parent	         INT             = NULL,
	 @Status	         INT             = NULL,
     @IdLog              INT             = NULL,
	 @DateRegister       DATETIME        = NULL,
	 @IdMovement         INT             = NULL,
	 @IdAffectedRegiser  INT             = NULL,
	 @Description        VARCHAR(2000)   = NULL, 
	 @WebPage            VARCHAR(50)     = NULL,
	 @Result	         VARCHAR(MAX) OUTPUT 
) 

AS
BEGIN TRY

DECLARE @EXIST_ID_USER    INT = 0;
DECLARE @EXIST_NAME_USER  INT = 0;
DECLARE @EXIST_EMAIL_USER INT = 0;
DECLARE @USERNAME_TEMP    VARCHAR(15)
DECLARE @EMAIL_USER_TEMP  VARCHAR(15)
DECLARE @ID_REG           INT = 0;
DECLARE @ID_REG_LOG       INT = 0;
      
			IF (@Action = 'IN')
			BEGIN
			      --Validar que no exista registro con mismo nombre de usuario y correo
			      SET @EXIST_NAME_USER =  (SELECT COUNT(*) FROM CTL_USERS WHERE UserName =  @UserName)
				  SET @EXIST_EMAIL_USER = (SELECT COUNT(*) FROM CTL_USERS WHERE Email =  @Email)
				  IF(@EXIST_NAME_USER >0 OR  @EXIST_EMAIL_USER >0)
					  BEGIN
						  SET @Result = '2'       ---Nombre de usuario o correo ya registrado
					  END						  
				 ELSE							  
				 BEGIN	
					BEGIN TRANSACTION T1				       
						  INSERT INTO CTL_USERS VALUES(
						  								@IdRole,
						  								@Name,
						  								@LastName,
						  								@Surname,
						  								@Email,
						  								@UserName,
						  								PWDENCRYPT(@Password),
						  								@Parent,
						  								1  --Por defaul activo
						  							  )
						BEGIN TRANSACTION T2
						SET @ID_REG = (SELECT MAX(Id) FROM CTL_USERS)                   --Obtener ultimo ID
			                  INSERT INTO CTL_SYSTEM_LOG VALUES(
							                                     GETDATE(),             --DateRegister
																 1,                     --IdMovement
																 @ID_REG,               --IdAffectedRegiser
																 'Creación de usuario', --Description
																 @ID_REG,               --IdUser
																 @WebPage               --WebPage
																 )
						COMMIT TRAN T2
						COMMIT TRAN T1
				        SET @Result = '1'		  ---Usuario creado
				 END
			END

			ELSE IF (@Action = 'UP')
			BEGIN
			     SET @EXIST_ID_USER = (SELECT COUNT(*) FROM CTL_USERS WHERE Id =  @Id)

				 IF(@EXIST_ID_USER >0)
					 BEGIN
					       --Validar que no exista registro con mismo nombre de usuario y correo
						    SET @USERNAME_TEMP =   ( SELECT UserName FROM CTL_USERS WHERE Id =  @Id)
						    SET @EMAIL_USER_TEMP = ( SELECT Email    FROM CTL_USERS WHERE Id =  @Id)

							IF (@USERNAME_TEMP = @UserName AND @EMAIL_USER_TEMP = @Email)
								BEGIN
								        --UserName y  Email no cambian
										BEGIN TRANSACTION T3
										       UPDATE CTL_USERS SET 
											           [Name]   = @Name, 
											   		   LastName = @LastName,
											   		   Surname  = @Surname,
											   		   Email    = @Email,
											   		   UserName = @UserName,
											   		   IdRole   = @IdRole,
													   [Status] = @Status
											   WHERE Id=@Id 
								        COMMIT TRAN T3
								        SET @Result = '1'      --Registro actualizado								     
								END
							ELSE
								BEGIN
								   --UserName y Email han cambiado, antes de actualizar se debe validar que no existan 
								   SET @EXIST_NAME_USER  = (SELECT COUNT(*) FROM CTL_USERS WHERE UserName =  @UserName)
                                   SET @EXIST_EMAIL_USER = (SELECT COUNT(*) FROM CTL_USERS WHERE Email =  @Email)
								   IF(@EXIST_NAME_USER >0 OR  @EXIST_EMAIL_USER >0)
									   BEGIN
										     SET @Result = '2'		  --Registro inexistente
									   END
								   ELSE
										BEGIN
												BEGIN TRANSACTION T3
													   UPDATE CTL_USERS SET [Name]   = @Name, 
											   				   LastName = @LastName,
											   				   Surname  = @Surname,
											   				   Email    = @Email,
											   				   UserName = @UserName,
											   				   IdRole   = @IdRole
													   WHERE Id=@Id 
												COMMIT TRAN T3
												SET @Result = '1'      --Registro actualizado		
										END
								END
					 END
			     ELSE
					 BEGIN
						  SET @Result = '2'               --Registro inexistente
					 END			     
			END

			ELSE IF (@Action = 'DE')
				BEGIN
				      SET @EXIST_ID_USER = (SELECT COUNT(*) FROM CTL_USERS WHERE Id =  @Id)
					  
					  IF(@EXIST_ID_USER>0)
						  BEGIN
						       SET @ID_REG_LOG = (SELECT COUNT(*) FROM CTL_SYSTEM_LOG WHERE Id =  @Id)
							   IF (@ID_REG_LOG > = 1)
									   BEGIN
											  SET @Result = '2'   --No se pude eliminar, ya que tiene Log
									   END
							   ELSE
							   BEGIN
									 BEGIN TRANSACTION T4
									   DELETE CTL_USERS WHERE Id = @Id								   
									 COMMIT TRAN T4
									 SET @Result = '1'                --Registro eliminado
							   END
						  END
						  ELSE
							  BEGIN
									  SET @Result = '2'           --Registro inexistente
							  END
				END
END TRY
 BEGIN CATCH SET @Result='0'; --ERROR
 PRINT ERROR_MESSAGE();
 ROLLBACK
END CATCH
GO