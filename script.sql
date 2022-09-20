CREATE SCHEMA users

CREATE TABLE Users.users.users (
	id bigint IDENTITY(1,1) NOT NULL,
	names nvarchar(50) NULL,
	last_names varchar(50) NULL,
	date_created datetime DEFAULT getdate() NULL
	CONSTRAINT id_user_PK PRIMARY KEY (id)
);
CREATE TABLE Users.users.type_document (
	id bigint IDENTITY(1,1) NOT NULL,
	type_document nvarchar(50) NULL,
	date_created datetime DEFAULT getdate() NULL
	CONSTRAINT type_document_PK PRIMARY KEY (id),
);

CREATE TABLE Users.users.documents (
	id bigint IDENTITY(1,1) NOT NULL,
	id_type_document bigInt NOT NULL,
	id_user bigint NOT NULL,
	document nvarchar(20),
	date_created datetime DEFAULT getdate() NULL
	CONSTRAINT document_PK PRIMARY KEY (id),
	CONSTRAINT document_FK FOREIGN KEY (id_user) REFERENCES Users.users.users(id),
	CONSTRAINT document2_FK FOREIGN KEY (id_type_document) REFERENCES Users.users.type_document(id)
);

CREATE TABLE Users.users.address (
	id bigint IDENTITY(1,1) NOT NULL,
	address nvarchar(50) NULL,
	id_user bigint NOT NULL,
	date_created datetime DEFAULT getdate() NULL
	CONSTRAINT address_PK PRIMARY KEY (id),
	CONSTRAINT Address_FK FOREIGN KEY (id_user) REFERENCES Users.users.users(id)
);


CREATE TABLE users.users.auditoria(
	id INT IDENTITY(1,1)  PRIMARY KEY,
	table_ VARCHAR(20) NOT NULL,
	action_ VARCHAR(20) NOT NULL,
	register_update VARCHAR(100) NOT NULL,
	register VARCHAR(100),
	date_updated DATETIME NOT NULL
)

	
	CREATE trigger [users_auditoria_Actualizar]
	ON users.users 
	FOR UPDATE
	AS 
		BEGIN
		INSERT users.auditoria SELECT 'users','update', names+' '+last_names, 
		(select RTRIM(names)+' '+RTRIM(last_names) from deleted),GETDATE() from inserted
		END;
	
	CREATE trigger [address_auditoria_Actualizar]
	ON users.address  
	FOR UPDATE
	AS 
		BEGIN
		INSERT users.auditoria SELECT 'address','update', address, 
		(select address from deleted),GETDATE() from inserted
		END;
	
	CREATE trigger [document_auditoria_Actualizar]
	ON users.documents  
	FOR UPDATE
	AS 
		BEGIN
		INSERT users.auditoria SELECT 'document','update', document, 
		(select document from deleted),GETDATE() from inserted
		END;
	
	


SELECT *  FROM  USERS.USERS.address A where A.id_user = :id

SELECT *  FROM users.users.documents d WHERE d.id_user = :id
