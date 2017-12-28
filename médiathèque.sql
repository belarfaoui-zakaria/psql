-- Mediatheque
--   ::topTenAuteurs
--   ::topTenOeuvres
--   ::topTenGenres
--   ::oeuvreDisponibilite(Oeuvre)
-- 
-- Oeuvre_type
--   sauvegarder
--   supprimer
--   getAuthor
--   getGenre
--   getExemplaires
--   ::getOeuvre(id)
-- 
-- Emprunt_type
--   sauvegarder
--   supprimer
--   ::creerEmprunt(Oeuvre, Abonnee)
--   ::getEmprunt(id)
-- 
-- Exemplaire_type
--   sauvegarder
--   supprimer
--   getOeuvre
--   estDisponible
-- 
-- Author_type
--   sauvegarder
--   supprimer
--   getOeuvres
--   ::getAuthor(id)
-- 
-- Abonnee_type
--   sauvegarder
--   supprimer
--   estAboonee
--   ::getAbonnee
-- 
-- Abonnement_type
--   sauvegarder
--   supprimer
--   ::creerAbonnement(abonnee)


CREATE OR REPLACE PROCEDURE supprimer_table(Table_name IN VARCHAR)
IS
BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE ' || Table_name;
  EXECUTE IMMEDIATE 'DROP TYPE ' || type_name || '_type';
  commit ;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('no table');
END;

BEGIN
  supprimer_table('Genre');
  supprimer_table('Oeuvre');
  supprimer_table('Emprunt');
  supprimer_table('Exemplaire');
  supprimer_table('Author');
  supprimer_table('Abonne');
  supprimer_table('Abonnement');
END;