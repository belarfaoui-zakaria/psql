-- Author_type
--   sauvegarder
--   supprimer
--   getOeuvres
--   ::getAuthor(id)


CREATE OR REPLACE TYPE Author_type as OBJECT(
  id NUMBER(19, 0),
  nom VARCHAR2(50),
  CONSTRUCTOR FUNCTION Author_type (id NUMBER, nom VARCHAR2) RETURN SELF AS RESULT,
  MEMBER PROCEDURE sauvegarder,
  MEMBER PROCEDURE supprimer
);

CREATE TABLE Author of Author_type;
 
ALTER TABLE Author
ADD CONSTRAINT pk_author
    PRIMARY KEY (id);


CREATE OR REPLACE TYPE BODY Author_type AS 
  
  CONSTRUCTOR FUNCTION Author_type (id NUMBER, nom VARCHAR2)
  RETURN SELF AS RESULT IS
  BEGIN
    SELF.id := id 
    SELF.nom := nom  
  END;

  MEMBER PROCEDURE sauvegarder IS
  BEGIN
    INSERT INTO Author('id', 'nom') VALUES (SELF.id, SELF.nom);
    COMMIT;
  END sauvegarder;

  MEMBER PROCEDURE supprimer IS
  BEGIN
    DELETE FROM Author as auth where auth.id = SELF.id;
    COMMIT;
  END supprimer;

 
  STATIC FUNCTION getAuthor(auth_id NUMBER) 
  Return Author_type IS
    auth Author_type
  BEGIN
    SELECT Author_type(a.id, a.nom) into auth From Author as a where  a.id = auth_id;
    COMMIT;
    return auth;
  END getEmprunt;

END; 