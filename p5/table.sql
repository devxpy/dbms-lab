-- 4.Retrive the name of each employee who works on all the projects controlled by department no. 5.(use NOT EXISTS ) operator.

SELECT E.NAME
FROM EMPLOYEE E
WHERE 
    NOT EXISTS (
        (
            SELECT PNO
            FROM PROJECT
            WHERE DNO = 5
        ) 
        MINUS
        (
            SELECT PNO
            FROM WORKS_ON
            WHERE SSN = E.SSN
        )
    );

SELECT E.NAME
FROM EMPLOYEE E
WHERE
    NOT EXISTS (
        SELECT *
        FROM PROJECT P
        WHERE 
            P.DNO = 5
            AND
            NOT EXISTS (
                SELECT *
                FROM WORKS_ON
                WHERE 
                    SSN = E.SSN
                    AND
                    DNO = P.DNO
            )
    );

-- 5.For each department that has more than 5 employees retrieve the dno and no. of its employees who are making more than 6,00,000.

SELECT 
    E.DNO, 
    (
        SELECT COUNT(*)
        FROM EMPLOYEE
        WHERE SALARY > 600000 AND DNO = E.DNO
    ) AS NUM_EMP
FROM DEPARTMENT D
JOIN EMPLOYEE E ON E.DNO = D.DNO
GROUP BY E.DNO
HAVING COUNT(*) > 5;

---

SELECT E.DNO, COUNT(*) AS NUM_EMP
FROM DEPARTMENT D
JOIN EMPLOYEE E ON E.DNO = D.DNO
WHERE 
    E.DNO IN (
        SELECT DNO 
        FROM EMPLOYEE
        GROUP BY DNO
        HAVING COUNT(*) > 5
    ) AND 
    E.SALARY > 600000
GROUP BY E.DNO;


