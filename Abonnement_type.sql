-- Abonnement_type
--   sauvegarder
--   supprimer

-- id abonne_id date_abonnement date_renouvelement regler

CREATE OR REPLACE TYPE Abonnement_type as OBJECT(
  id NUMBER(19, 0),
  abonne_id NUMBER(19, 0),
  date_abonnement Date,
  date_renouvelement Date,
  regler NUMBER(1) default 0 NOT NULL,

  CONSTRUCTOR FUNCTION Abonnement_type (id NUMBER, abonne_id NUMBER, date_abonnement Date, date_renouvelement Date, regler NUMBER) RETURN SELF AS RESULT,
  MEMBER PROCEDURE sauvegarder,
  MEMBER PROCEDURE supprimer,
  STATIC FUNCTION getAbonnement(abo_id NUMBER) RETURN Abonnement_type
);

CREATE TABLE Abonnement of Abonnement_type;


ALTER TABLE Abonnement
ADD CONSTRAINT fk_abonnements_abonne
    FOREIGN KEY (abonne_id)
    REFERENCES Abonnee(id)

 
ALTER TABLE Abonnement
ADD CONSTRAINT pk_abo
    PRIMARY KEY (id);

CREATE OR REPLACE TYPE BODY Abonnement_type AS 
  
  CONSTRUCTOR FUNCTION Emprunt_type (id NUMBER, abonnes_id NUMBER, exemplaire_id NUMBER, date_emp DATE, date_retour DATE) 
  RETURN SELF AS RESULT IS
  BEGIN
    SELF.id := id;
    SELF.abonne_id := abonne_id;
    SELF.date_abonnement := date_abonnement;
    SELF.date_renouvelement := date_renouvelement;
    SELF.regler := regler;
  END;



  MEMBER PROCEDURE sauvegarder IS
  BEGIN
    INSERT INTO Emprunt('id','abonne_id','date_abonnement','date_renouvelement','regler') 
    VALUES (SELF.id, SELF.abonne_id, SELF.date_abonnement, SELF.date_renouvelement, SELF.regler);
    COMMIT;
  END sauvegarder;

  MEMBER PROCEDURE supprimer IS
  BEGIN
    DELETE FROM Emprunt as emp where emp = SELF.id
    COMMIT;
  END supprimer;

  STATIC FUNCTION getAbonnement(abo_id NUMBER) 
  Return Emprunt_type IS
    abo Emprunt_type
  BEGIN
    SELECT Emprunt_type(a.id, a.abonne_id, a.date_abonnement, a.date_renouvelement, a.regler) 
    into abo From Emprunt as a where  a.id = abo_id
    COMMIT;
    return abo;
  END getAbonnement;
END; 