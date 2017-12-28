-- Emprunt_type
--   sauvegarder
--   supprimer
--   ::getEmprunt(id)


CREATE OR REPLACE TYPE Emprunt_type as OBJECT(
  id NUMBER(19, 0),
  abonnes_id NUMBER(19, 0),
  exemplaire_id NUMBER(19, 0),
  date_emp DATE,
  date_retour DATE,
  is_back NUMBER(1) default 0  NOT NULL, 

  CONSTRUCTOR FUNCTION Emprunt_type (id NUMBER, abonnes_id NUMBER, exemplaire_id NUMBER, date_emp DATE, date_retour DATE) RETURN SELF AS RESULT,
  MEMBER PROCEDURE sauvegarder,
  MEMBER PROCEDURE supprimer,
  STATIC FUNCTION getEmprunt(emp_id NUMBER) Return Emprunt_type
);

CREATE TABLE Emprunt of Emprunt_type;


ALTER TABLE Emprunt
ADD CONSTRAINT fk_emprunts_exemplaire
   FOREIGN KEY exemplaire_id
   REFERENCES Exemplaire(id);

ALTER TABLE Emprunt
ADD CONSTRAINT fk_emprunts_abonne
    FOREIGN KEY (abonnes_id)
    REFERENCES Abonnes(id);
 
ALTER TABLE Emprunt
ADD CONSTRAINT pk_emp
    PRIMARY KEY (id);


CREATE OR REPLACE TYPE BODY Emprunt_type AS 
  
  CONSTRUCTOR FUNCTION Emprunt_type (id NUMBER, abonnes_id NUMBER, exemplaire_id NUMBER, date_emp DATE, date_retour DATE) 
  RETURN SELF AS RESULT IS
  BEGIN
    SELF.id := id
    SELF.abonnes_id := abonnes_id
    SELF.exemplaire_id := exemplaire_id
    SELF.date_emp := date_emp
    SELF.date_retour := date_retour
  END;

  MEMBER PROCEDURE sauvegarder IS
  BEGIN
    INSERT INTO Emprunt('id', 'abonnes_id', 'exemplaire_id', 'date_emp', 'date_retour') 
    VALUES (SELF.id, SELF.abonnes_id, SELF.exemplaire_id, SELF.date_emp, SELF.date_retour);
    COMMIT;
  END sauvegarder;

  MEMBER PROCEDURE supprimer IS
  BEGIN
    DELETE FROM Emprunt as emp where emp = SELF.id
    COMMIT;
  END supprimer;

  STATIC FUNCTION getEmprunt(emp_id NUMBER) 
  Return Emprunt_type IS
    emp Emprunt_type
  BEGIN
    SELECT Emprunt_type(e.id, e.abonnes_id, e.exemplaire_id, e.date_emp, e.date_retour, e.is_back) 
    into emp From Emprunt as e where  emp.id = emp_id
    COMMIT;
    return emp;
  END getEmprunt;
END; 