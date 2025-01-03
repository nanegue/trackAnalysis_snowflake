use database music;
use schema star_schema;
use warehouse load;
alter warehouse load resume;


insert all 
into dimDate (Dyear)
select prodyear
from Album;

insert all 
into DimAlbum (albumId, 
    artist,
    birth_artist ,
    country_artist ,
    prodYear ,
    cdYear)
select  
    alb.AlbumId,
    art.name , 
    art.birth_year, 
    art.country,
    alb.prodYear,
    alb.cdYear
from Album alb
join Artist art  
on (alb.artistId = art.artistId);


insert all 
into DimPlaylist(  playlistId ,
    name)
Select   playlistId ,
    name
from playList;


insert all 
into DimTrack(  TrackId ,
    title , 
    NameMediatype ,
    composer,
    genre ,
    bytes , 
    Price )

Select  t.TrackId ,
    t.title , 
    m.Name ,
    t.composer,
    g.name ,
    t.bytes , 
    t.unitPrice
from track t
join mediaType m on (t.mediatypeId= m.mediatypeId)
join genre g on (t.genreId = g.genreId);

insert all
into FactAnalysTrack(
   -- AnalystTrackID ,
    TrackId ,
    albumId ,
    dateId ,
    playlistId ,
    milliseconds )
Select  t.TrackId ,
    a.albumId ,
    a.prodyear ,
    p.playlistId ,
    t.milliseconds
from track t 
join album a on t.albumId = a.albumId
join playlisttrack pt on pt.trackId = t.trackId
join playlist p on p.playlistID = pt.playlistId
;
