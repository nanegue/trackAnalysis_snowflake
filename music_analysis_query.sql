use database music;
use warehouse load;
--alter warehouse load resume;
use schema star_schema;


-- Donnez les titres des albums qui ont plus de 1 CD.
select title, cdyear
from dimAlbum
where cdyear> 1;

-- les morceaux produits en 2000 ou en 2002.
select d.title, f.dateid as dateprod
from FactAnalysTrack f
join dimtrack d
on d.trackid = f.trackid
where f.dateid in (2000, 2002);

--le nom et le compositeur des morceaux de Rock et de Jazz.
select title, composer, genre
from dimtrack
where genre in ('Rock', 'Jazz');

-- les 10 albums les plus longs.
select d.title, round(sum(f.milliseconds)/60000) as duration_in_mn
from dimalbum d
join factanalystrack f
on d.albumid = f.albumid
group by d.albumid, d.title
order by duration_in_mn desc
limit 10;

-- le nombre d'albums produits pour chaque artiste.
select artist, count(*) nb_album
from dimalbum d
group by artist
order by artist;

-- le nombre de morceaux produits par chaque artiste.
select d.artist, count(distinct(f.trackid)) as nb_track
from dimalbum d
join factanalystrack f
on d.albumid = f.albumid
group by d.artist
order by d.artist ;


-- le genre de musique le plus écouté dans les années 2000.
select d.genre, count(distinct (f.playlistid)) as nb_playlist
from factanalystrack f
join dimtrack d
on d.trackid = f.trackid
where f.dateid = 2000
group by d.genre
order by nb_playlist desc;

-- les morceaux de Rock dont les artistes sont en France.
select dt.title,da.artist, da.country_artist
from dimtrack dt
join factanalystrack f
on dt.trackid = f.trackid
join dimalbum da
on da.albumid = f.albumid
where dt.genre = 'Rock'
and da.country_artist ='France';

-- la moyenne des tailles des morceaux par genre musical.
select genre, avg (f.milliseconds)/60000 mean_track_duration_in_minutes
from factanalystrack f
join dimtrack d
on d.trackid = f.trackid
group by d.genre;

-- les playlist où figurent des morceaux d'artistes nés avant 1990.
select distinct dp.name
from dimalbum da
join factanalystrack f
on da.albumid = f.albumid
join dimplaylist dp
on dp.playlistid = f.playlistid
where da.birth_artist <1990;


