USE uebungsdatenbank;
SELECT mitarbeiter.mitarbeiterid,sum(arbeitszeit.anzahlstunden), mitarbeiter.name, mitarbeiter.vorname FROM mitarbeiter JOIN arbeitszeit ON arbeitszeit.mitarbeiterid=mitarbeiter.mitarbeiterid GROUP BY mitarbeiter.mitarbeiterid ;

