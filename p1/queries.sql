-- 1.Retrive details of all books in the library i.e ID,Tile,name of publisher,authors,no. of copies etc in each branch.

SELECT *
FROM BOOK B
JOIN BOOK_AUTHORS A ON A.BOOK_ID = B.BOOK_ID
JOIN BOOK_COPIES C ON C.BOOK_ID = B.BOOK_ID
JOIN LIBRARY_BRANCH L ON L.BRANCH_ID = C.BRANCH_ID 
WHERE (C.BRANCH_ID, C.BOOK_ID) IN (
        SELECT BRANCH_ID, BOOK_ID
        FROM BOOK_COPIES
        GROUP BY BRANCH_ID, BOOK_ID
    )
ORDER BY C.BRANCH_ID;

-- 2.Get the particulars of borrowers who have borrowed more than 3 books but from Jan 2017 to JUN 2017

SELECT *
FROM BOOK_LENDING
WHERE CARD_NO IN (
    SELECT CARD_NO
    FROM BOOK_LENDING
    GROUP BY CARD_NO
    HAVING COUNT(CARD_NO) > 3
) AND DATE_OUT BETWEEN '01-JAN-17' AND '30-JUN-17';

-- 3.Delete a book in book table.Update the contents of other tables to reflect this data manipulation operation.

-- 4.Partition the book table based on year of publication.Demostrate its working with a simple query.

-- 5.Create a view all books and its no. of copies that are currently available in the library.