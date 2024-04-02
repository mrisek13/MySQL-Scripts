-- 1. Ispisati prosječni kapacitet radnika iz tablice radionica. Rezultat ispisati sa nazivom stupca prosjek.
SELECT AVG(kapacitetRadnika) FROM radionica;

-- 2. Ispisati sve radnike koji žive u mjestu sa poštanskim brojem između 10000 i 21000. Radnike ispisati
-- u jednom stupcu, i to u obliku 'prezimeradnika, imeradnika' te ih sortirati po prezimenu radnika uzlazno.
SELECT CONCAT (prezimeRadnik, ', ', imeRadnik) FROM radnik WHERE pbrStan BETWEEN 10000 AND 21000 ORDER BY prezimeRadnik ASC;

-- 3. Ispisati sve šifre klijenata koji su uneseni u tekucem mjesecu tekuce godine.
SELECT sifKlijent FROM klijent WHERE MONTH(datUnosKlijent) = MONTH(CURRENT_DATE);

-- 4. Ispisati za sva mjesta skracenice naziva mjesta. Pretpostavimo da se skracenica naziva mjesta sastoji od prva 3 slova naziva. 
-- Skracenice je potrebno ispisati velikim slovima.
SELECT UPPER(SUBSTRING(nazivMjesto, 1, 3)) FROM mjesto ORDER BY 1 DESC;

-- 5. Izbrisati sve klijente koji imaju vozilo registrirano u mjestu sa poštanskim brojem manji od 10050.
DELETE FROM klijent WHERE pbrReg<10050;

-- 6. Ispisati sve naloge i sve radnike koji na njima rade.
SELECT nalog.*, CONCAT(imeRadnik, ' ', prezimeRadnik)
FROM nalog
JOIN radnik
ON nalog.sifRadnik=radnik.sifRadnik;

-- 7. Ispisati sve kvarove i kraj njih predviđen broj sati servisa za one kvarove čije su rezervacije zaprimljene ponedjeljkom.
SELECT nazivKvar, satServis
FROM kvar
JOIN rezervacija
ON kvar.sifKvar=rezervacija.sifKvar
WHERE datVrstaDan='PO';

-- 8. Ispisati koliko je ukupno sati potrošeno (suma) na servisiranje vozila za sve naloge zaprimljene u travnju 2006. godine.
SELECT SUM(satiKvar)
FROM kvar
JOIN nalog
ON kvar.sifKvar=nalog.sifKvar
WHERE MONTH(datPrimitkaNalog)=4 AND YEAR(datPrimitkaNalog)=2006;

-- 9. Ispisati ime i prezime klijenata te nazive mjesta i županija za one klijente koji žive u Bjelovarsko-bilogorskoj županiji,
-- a duljina prezimena im je manja ili jednaka 5.
SELECT imeKlijent, prezimeKlijent, nazivMjesto, nazivZupanija
FROM klijent
JOIN mjesto
ON mjesto.pbrMjesto=klijent.pbrKlijent
JOIN zupanija
ON mjesto.sifZupanija=zupanija.sifZupanija
WHERE nazivZupanija='Bjelovarsko-bilogorska' AND LENGTH(prezimeKlijent)=5;

-- 10. Svakom radniku generirati i ispisati e-mail adresu u obliku imeRadnik.prezimeRadnik@nazivZupanija.hr. 
-- Neka sve adrese budu ispisane malim slovima.
-- Adrese sortirati uzlazno po prezimenu radnika.
SELECT REPLACE(LCASE(CONCAT(imeRadnik, '.', prezimeRadnik, '@', nazivZupanija, '.hr')), ' ' , '')
FROM radnik
JOIN mjesto 
ON radnik.pbrStan=mjesto.pbrMjesto
JOIN zupanija
ON mjesto.sifZupanija=zupanija.sifZupanija
ORDER BY prezimeRadnik ASC;