use database music;
use warehouse query;


create schema star_schema;
use schema star_schema;

create or replace table dimDate(
  date_key number identity(1,1) primary key,
  date date,
  year number, 
  quarter number, 
  month number, 
  day number, 
  week number, 
  is_weekend boolean
);

create  or replace table  DimAlbum(
    albumId number primary key, 
    artist string,
    birth_artist number,
    country_artist string,
    prodYear number,
    cdYear number
    
); 


create  or replace table  DimPlaylist (
    playlistId number primary key,
    name string

); 


create  or replace table DimTrack(
    TrackId number primary key,
    title string, 
    NameMediatype string,
    composer string,
    genre string,
    bytes number, 
    Price number
); 

create  or replace table FactAnalysTrack(
    AnalystTrackID number primary key,
    TrackId number foreign key references DimTrack(TrackId),
    albumId number foreign key references DimAlbum(albumId),
    dateId number foreign key references DimDate(date_key),
    playlistId number foreign key references DimPlayList(playlistId),
    milliseconds number    

);


