-- Mediatheque
--   ::topTenAuteurs
--   ::topTenOeuvres
--   ::topTenGenres
--   ::oeuvreDisponibilite(Oeuvre)

CREATE OR REPLACE TYPE Mediatheque as OBJECT (
  STATIC PROCEDURE topTenAuteurs,
  STATIC PROCEDURE topTenOeuvres,
  STATIC PROCEDURE topTenGenres,
  STATIC PROCEDURE abonnementNonRegler,
  STATIC FUNCTION oeuvreDisponible(o Oeuvre) Return boolean 
 
);


CREATE OR REPLACE TYPE BODY Mediatheque AS 
  
  STATIC PROCEDURE topTenOeuvres() IS
  BEGIN
    Select * from Oeuvre where id in (
      Select ex.oeuvre_id from Emprunt emp inner join Exemplaire ex
      on ex.id = emp.exemplaire_id
      GROUP BY ex.oeuvre_id
      ORDER BY count(ex.oeuvre_id) DESC
      LIMIT 0 , 10
    )
  END

  STATIC PROCEDURE abonnementNonRegler() IS 
  BEGIN
    Select *
    From Abonnement inner join Abonnee
    on Abonnee.id = Abonnement.abonne_id 
    where 
  END

  STATIC PROCEDURE topTenAuteurs() IS
  BEGIN
    Select * from Author where id in (
      Select o.author_id from Emprunt emp inner join Exemplaire ex inner join Oeuvre O
      on ex.id = emp.exemplaire_id and o.id == ex.oeuvre_id
      GROUP BY o.author_id 
      ORDER BY count(o.author_id) DESC
      LIMIT 0 , 10
    )
  END

  STATIC PROCEDURE topTenGenres() IS
    Select * from GENRE where id in (
      Select o.genre_id from Emprunt emp inner join Exemplaire ex inner join Oeuvre O
      on ex.id = emp.exemplaire_id and o.id == ex.oeuvre_id
      GROUP BY o.genre_id 
      ORDER BY count(o.genre_id) DESC
      LIMIT 0 , 10
    )
  BEGIN

  END

  STATIC FUNCTION oeuvreDisponible(o Oeuvre) Return Date 
  IS
    result boolean
  BEGIN
    select result = 1 
    from Oeuvre inner join Exemplaire
    on Oeuvre.id = Exemplaire.oeuvre_id
    where o.id = Oeuvre.id and Exemplaire.disponible = 1;

    return(result);
  END

 
END; 