 


CREATE OR REPLACE TYPE Genre_type as OBJECT(
  id NUMBER(19, 0),
  nom VARCHAR2(50),

  CONSTRUCTOR FUNCTION Genre_type (id NUMBER, nom VARCHAR2) RETURN SELF AS RESULT,
  MEMBER PROCEDURE sauvegarder,
  MEMBER PROCEDURE supprimer
);

CREATE TABLE Genre of Genre_type;
 
ALTER TABLE Genre
ADD CONSTRAINT pk_genre
    PRIMARY KEY (id);


CREATE OR REPLACE TYPE BODY Genre_type AS 
  
  CONSTRUCTOR FUNCTION Genre_type (id NUMBER, nom VARCHAR2)
  RETURN SELF AS RESULT IS
  BEGIN
    SELF.id := id 
    SELF.nom := nom
  END;

  MEMBER PROCEDURE sauvegarder IS
  BEGIN
    INSERT INTO Genre('id', 'nom') VALUES (SELF.id, SELF.nom);
    COMMIT;
  END sauvegarder;

  MEMBER PROCEDURE supprimer IS
  BEGIN
    DELETE FROM Genre as o where o.id = SELF.id;
    COMMIT;
  END supprimer;

 
  STATIC FUNCTION getGenre(o_id NUMBER) 
  Return Genre_type IS
    genre Genre_type
  BEGIN
    SELECT Genre_type(a.id, a.nom) into genre From Genre as a where  a.id = o_id;
    COMMIT;
    return genre;
  END getGenre;

END; 