select *from Songs
select *from Artists
select *from Albums
--PART-A

--1. Retrieve a unique genre of songs.
SELECT DISTINCT Genre FROM Songs;

--2. Find the top 2 albums released before 2010.
SELECT Albums_id, Album_title, Release_Year
FROM Albums
WHERE Release_Year < 2010
ORDER BY Release_Year DESC

--3. Insert data into the Songs table.
INSERT INTO Songs (Song_id, Song_title, Duration, Genre, Album_id)
VALUES (1245, 'Zaroor', 2.55, 'Feel good', 1005);

--4. Change the Genre of the song ‘Zaroor’ to ‘Happy’.
UPDATE Songs
SET Genre = 'Happy'
WHERE Song_title = 'Zaroor';

--5. Delete an artist ‘Ed Sheeran’.
DELETE FROM Artists
WHERE Artist_Name = 'Ed Sheeran';

--6. Add a new column for Rating in Songs Table.
alter table SONGS 
ADD RATING DECIMAL(3,2)

--7. Retrieve songs whose title starts with 'S'.
SELECT * 
FROM Songs
WHERE Song_title LIKE 'S%';

--8. Retrieve all songs whose title contains 'Everybody'.
SELECT *
FROM Songs
WHERE Song_title LIKE '%Everybody%';

--9. Display Artist Name in Uppercase.
SELECT UPPER(Artist_Name) AS Artist_Name_Uppercase
FROM Artists;
 
--10. Find the square root of the duration of a song ‘Good Luck’.
SELECT SQRT(Duration) AS Duration_SquareRoot
FROM Songs
WHERE Song_title = 'Good Luck';

--11. Find the current date.
SELECT GETDATE()

--12. Find the number of albums for each artist.
SELECT a.Artist_name, COUNT(b.Albums_id) AS Number_of_Albums
FROM Artists a
LEFT JOIN Albums b ON a.Artist_id = b.Artist_id
GROUP BY a.Artist_name;



--13. Retrieve the Album_id which has more than 5 songs in it.
SELECT albums.Albums_id
FROM Songs INNER join Albums
ON   SONGS.Album_id =  AlbumS.Albums_id
GROUP BY Album_id
HAVING COUNT(SONGS.Song_id) > 5;
SELECT *FROM Albums
SELECT *FROM Artists


--14. Retrieve all songs from the album 'Album1' (using Subquery).
SELECT Song_title
FROM Songs
WHERE Album_id = (SELECT Album_id 
					FROM Albums 
					WHERE Album_title = 'Album1');


--15. Retrieve all album names from the artist ‘Aparshakti Khurana’ (using Subquery).
SELECT Album_title
FROM Albums
WHERE Artist_id = (SELECT Artist_id 
					FROM Artists 
					WHERE Artist_name = 'Aparshakti Khurana');


--16. Retrieve all the song titles with their album titles.
SELECT s.Song_title, a.Album_title
FROM Songs s
JOIN Albums a ON s.Album_id = a.Albums_id;

--17. Find all the songs which are released in 2020.
SELECT Song_title
FROM Songs
WHERE Album_id IN (SELECT Album_id 
					FROM Albums 
					WHERE Release_year = 2020);


--18. Create a view called ‘Fav_Songs’ from the Songs table having songs with Song_id 101-105.
CREATE VIEW Fav_Songs AS
SELECT * FROM Songs
WHERE Song_id BETWEEN 101 AND 105;


--19. Update a song name to ‘Jannat’ of Song having Song_id 101 in Fav_Songs view.
UPDATE Fav_Songs
SET Song_title = 'Jannat'
WHERE Song_id = 101;


--20. Find all artists who have released an album in 2020.
SELECT Artists.Artist_name
FROM Artists JOIN Albums
ON Artists.Artist_id = Albums.Artist_id
WHERE Albums.Release_year = '2020'


--21. Retrieve all songs by Shreya Ghoshal and order them by duration.
SELECT s.Song_title
FROM Songs s
JOIN Artists a ON s.Album_id = a.Artist_id
WHERE a.Artist_name = 'Shreya Ghoshal'
ORDER BY s.Duration;


--Part – B Queries:

--22. Retrieve all song titles by artists who have more than one album:
SELECT s.Song_title
FROM Songs s
JOIN Albums a ON s.Album_id = a.Albums_id
WHERE a.Artist_id IN (SELECT Artist_id 
					FROM Albums GROUP BY Artist_id 
					HAVING COUNT(Albums_id) > 1);


--23. Retrieve all albums along with the total number of songs:

SELECT A.Albums_id, A.Album_title, COUNT(S.Song_id) AS Total_Songs
FROM Albums A
LEFT JOIN Songs S ON A.Albums_id = S.Album_id
GROUP BY A.Albums_id, A.Album_title;

--24. Retrieve all songs and release year, sorted by release year:
SELECT s.Song_title, a.Release_year
FROM Songs s
JOIN Albums a ON s.Album_id = a.Albums_id
ORDER BY a.Release_year;


--25. Retrieve the total number of songs for each genre, showing genres that have more than 2 songs:
SELECT S.Genre, COUNT(S.Song_id) AS Total_Songs
FROM Songs S
GROUP BY S.Genre
HAVING COUNT(S.Song_id) > 2;

--26. List all artists who have albums containing more than 3 songs:

SELECT DISTINCT A.Artist_id, AR.Artist_name
FROM Albums A
JOIN Songs S ON A.Albums_id = S.Album_id
JOIN Artists AR ON A.Artist_id = AR.Artist_id
GROUP BY A.Albums_id, A.Artist_id, AR.Artist_name
HAVING COUNT(S.Song_id) > 3;

--Part – C Queries:
--27. Retrieve albums that have been released in the same year as 'Album4':
SELECT Albums_id, Album_title
FROM Albums
WHERE Release_year = (
    SELECT Release_year
    FROM Albums
    WHERE Album_title = 'Album4'
);

--28. Find the longest song in each genre:
SELECT Genre, MAX(Duration) AS Longest_Song
FROM Songs
GROUP BY Genre;


--29. Retrieve the titles of songs released in albums that contain the word 'Album' in the title:
SELECT S.Song_title
FROM Songs S
JOIN Albums A ON S.Album_id = A.Albums_id
WHERE A.Album_title LIKE '%Album%';

--30. Retrieve the total duration of songs by each artist where total duration exceeds 15 minutes:
SELECT AR.Artist_name, SUM(S.Duration) AS Total_Duration
FROM Artists AR
JOIN Albums A ON AR.Artist_id = A.Artist_id
JOIN Songs S ON A.Albums_id = S.Album_id
GROUP BY AR.Artist_name
HAVING SUM(S.Duration) > 15;



