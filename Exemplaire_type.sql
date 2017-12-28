 


CREATE OR REPLACE TYPE Exemplaire_type as OBJECT(
  id NUMBER(19, 0),
  oeuvre_id NUMBER(19, 0),
  numero_serie VARCHAR2(50),
  CONSTRUCTOR FUNCTION Exemplaire_type (id NUMBER, oeuvre_id NUMBER, numero_serie VARCHAR2) RETURN SELF AS RESULT,
  MEMBER PROCEDURE sauvegarder,
  MEMBER PROCEDURE supprimer
);

CREATE TABLE Exemplaire of Exemplaire_type;
 
ALTER TABLE Exemplaire
ADD CONSTRAINT pk_exemplaire
    PRIMARY KEY (id);


CREATE OR REPLACE TYPE BODY Exemplaire_type AS 
  
  CONSTRUCTOR FUNCTION Exemplaire_type id NUMBER, oeuvre_id NUMBER, numero_serie VARCHAR2)
  RETURN SELF AS RESULT IS
  BEGIN
    SELF.id := id 
    SELF.oeuvre_id := oeuvre_id
    SELF.numero_serie := numero_serie
  END;

  MEMBER PROCEDURE sauvegarder IS
  BEGIN
    INSERT INTO Exemplaire('id', 'oeuvre_id', 'numero_serie') VALUES (SELF.id, SELF.oeuvre_id, SELF.numero_serie);
    COMMIT;
  END sauvegarder;

  MEMBER PROCEDURE supprimer IS
  BEGIN
    DELETE FROM Exemplaire as exmp where exmp.id = SELF.id;
    COMMIT;
  END supprimer;

 
  STATIC FUNCTION getExemplaire(exmp_id NUMBER) 
  Return Exemplaire_type IS
    exmp Exemplaire_type
  BEGIN
    SELECT Exemplaire_type(a.id, a.nom) into exmp From Exemplaire as a where  a.id = exmp_id;
    COMMIT;
    return exmp;
  END getExemplaire;

END; 