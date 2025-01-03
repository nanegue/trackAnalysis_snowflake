use database music;
use schema public;

use warehouse load;
alter warehouse load resume;

create stage s3_data
  url = 's3://course-snowflakes/sample/'
  credentials = (aws_key_id='$$$$',
                aws_secret_key='$$$$'); 

 SELECT  a.$1, a.$2, a.$3, a.$4, a.$5, a.$6, a.$7, a.$8, a.$9 FROM  @s3_data/music/Track.csv a LIMIT 10;    
 
 list @s3_data/music;               

copy into playlist
from @s3_data/music/Playlist.csv
file_format = classic_csv;

copy into album
from @s3_data/music/Album.csv
file_format = classic_csv;

copy into artist
from @s3_data/music/Artist.csv
file_format = classic_csv;

copy into genre
from @s3_data/music/Genre.csv
file_format = classic_csv;

copy into mediatype
from @s3_data/music/MediaType.csv
file_format = classic_csv;

copy into playlisttrack
from @s3_data/music/PlaylistTrack.csv
file_format = classic_csv;

copy into track
from @s3_data/music/Track.csv
file_format = error_csv
ON_ERROR = "CONTINUE" ;
