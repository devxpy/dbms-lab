-- 1.Make a list of all students details studying in 4th sem c-sec.

SELECT S.*
FROM STUDENT S
JOIN CLASS C ON S.USN = C.USN
JOIN SEMSEC SS ON C.SSID = SS.SSID
WHERE 
    SS.SEM = 4 AND
    SS.SEC = 'C';

-- 2.Compute the total no.of male and female students in each semester and in each sec.

SELECT SS.SEM, SS.SEC, S.GENDER, COUNT(S.GENDER)
FROM STUDENT S
JOIN CLASS C ON S.USN = C.USN
JOIN SEMSEC SS ON C.SSID = SS.SSID
GROUP BY SS.SEM, SS.SEC, S.GENDER;

-- 3.Create view of test1 marks of student 1MV15CS060 in all subjects.

DROP VIEW TEST1MARKS;

CREATE VIEW TEST1MARKS AS 
    SELECT USN, SUBCODE, TEST1
    FROM IAMARKS
    WHERE USN = '1MV15CS060';

SELECT * FROM TEST1MARKS;

-- 4.Calculate the final IA amrks and update the corresponding table for all students.

CREATE OR REPLACE PROCEDURE AVGMARKS IS
    CURSOR C_IAMARKS IS
        SELECT TEST1, TEST2, TEST3
        FROM IAMARKS
        FOR UPDATE;
    
    T1 NUMBER; 
    T2 NUMBER;
    T3 NUMBER; 
    TSUM NUMBER; 
    TAVG NUMBER; 
    
    BEGIN
        OPEN C_IAMARKS;
        LOOP
            FETCH C_IAMARKS INTO T1, T2, T3;
            EXIT WHEN C_IAMARKS%NOTFOUND; 
            
            TSUM := T1 + T2 + T3 - LEAST(T1, T2, T3); 
            TAVG := TSUM / 2; 

            UPDATE IAMARKS 
            SET FINALIA = TAVG 
            WHERE CURRENT OF C_IAMARKS;
            
            DBMS_OUTPUT.PUT_LINE(T1 || ', ' || T2 || ', ' || T3); 
            DBMS_OUTPUT.PUT_LINE('Sum of highest 2 = ' || TSUM); 
            DBMS_OUTPUT.PUT_LINE('Average = ' || TAVG);             
        END LOOP;        
        CLOSE C_IAMARKS;
    END;
/   

BEGIN
    AVGMARKS;
END;
/

SELECT * FROM IAMARKS;

-- 5.Categorise students based on the following criteria If FINALIA=17 to 20 then CAT=’OUTSTANDING’ If FINALIA=12 to 16 then CAT=’AVERAGE’
-- If FINALIA=00 to 11 then CAT=’WEAK’
-- Give these details only for 8th semester A, B and C section students. 

SELECT 
    I.USN, S.SEM, S.SEC, I.FINALIA, 
    (
        CASE
            WHEN I.FINALIA BETWEEN 17 AND 20 THEN 'OUTSTANDING'
            WHEN I.FINALIA BETWEEN 0 AND 11 THEN 'WEAK'
            WHEN I.FINALIA BETWEEN 12 AND 16 THEN 'AVERAGE'
            ELSE 'UNKNOWN'
        END
    ) AS CAT
FROM IAMARKS I
JOIN SEMSEC S ON I.SSID = S.SSID
WHERE 
    S.SEM = 8 AND
    S.SEC IN ('A', 'B', 'C');

