-- 1.List the titles of all movies directed by hitch cock.

-- 2.Find the movie names where one or more actors acted in two ormore movies.

-- 3. List all actors who acted in a movie before 2000 and also in a movie after 2015. (Use JOIN operator).

-- 4.Find the title of movies and no. of stars for each movie that has atleast one rating and find the highest no. of stars that movie received. Sort the result by movie titkle.

SELECT M.MOV_TITLE, MAX(R.REV_STARS) 
FROM MOVIES M,RATING R
WHERE M.MOV_ID=R.MOV_ID 
    AND M.MOV_ID IN (
        SELECT MOV_ID
        FROM RATING
        GROUP BY MOV_ID, REV_STARS 
        HAVING REV_STARS > 0 
    )
GROUP BY M.MOV_TITLE 
ORDER BY M.MOV_TITLE;


-- 5.Update ratings of all movies directed by STEVEN SPIELBERG.
