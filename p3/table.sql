DROP TABLE RATING;
DROP TABLE MOVIE_CAST;
DROP TABLE MOVIES;
DROP TABLE DIRECTOR;
DROP TABLE ACTOR;

---

CREATE TABLE ACTOR(
  ACT_ID NUMBER(2),
  ACT_NAME VARCHAR(15),
  ACT_GENDER CHAR,
  CONSTRAINT PK_AID PRIMARY KEY(ACT_ID)
);

INSERT INTO ACTOR VALUES('10', 'AAYUSHMAN', 'M');
INSERT INTO ACTOR VALUES('20', 'VARUN DHAWAN', 'M');
INSERT INTO ACTOR VALUES('30', 'DEEPIKA', 'F');
INSERT INTO ACTOR VALUES('40', 'CHRIS PRATT', 'M');
INSERT INTO ACTOR VALUES('50', 'ANTHONY PERKINS', 'M');
INSERT INTO ACTOR VALUES('60', 'SHRADDHA', 'F');

---

CREATE TABLE DIRECTOR(
  DIR_ID NUMBER(2),
  DIR_NAME VARCHAR(20),
  DIR_PHONE NUMBER(10),
  CONSTRAINT PK_DID PRIMARY KEY(DIR_ID)
);

INSERT INTO DIRECTOR VALUES('11', 'SOOJITH', '1020304050');
INSERT INTO DIRECTOR VALUES('22', 'STEVEN SPIELBERG', '1122334455');
INSERT INTO DIRECTOR VALUES('33', 'DAVID', '9966443322');
INSERT INTO DIRECTOR VALUES('44', 'HITCH COCK', '1002003000');
INSERT INTO DIRECTOR VALUES('55', 'BANSALI', '9080706050');
INSERT INTO DIRECTOR VALUES('66', 'REMO', '9988776655');
---
CREATE TABLE MOVIES(
  MOV_ID NUMBER(3),
  MOV_TITLE VARCHAR(25),
  MOV_YEAR NUMBER(4),
  MOV_LANG VARCHAR(15),
  DIR_ID NUMBER(2),
  CONSTRAINT PK_MID PRIMARY KEY(MOV_ID),
  CONSTRAINT FK_DIR FOREIGN KEY(DIR_ID) REFERENCES DIRECTOR(DIR_ID) ON DELETE CASCADE
);

INSERT INTO MOVIES VALUES('111', 'ABCD2', '1999', 'HINDI', '66');
INSERT INTO MOVIES VALUES('222', 'PSYCHO', '1995', 'ENGLISH', '44');
INSERT INTO MOVIES VALUES('333', 'BAREILLI KI BURFI', '2017', 'HINDI', '11');
INSERT INTO MOVIES VALUES('444', 'RAMLEELA', '2015', 'HINDI', '55');
INSERT INTO MOVIES VALUES('555', 'MEIN TERA HERO', '2014', 'HINDI', '33');
INSERT INTO MOVIES VALUES('666', 'JURASSIC PARK', '2000', 'ENGLISH', '22');
INSERT INTO MOVIES VALUES('777', 'VICKY DONOR', '2011', 'HINDI', '11');

---

CREATE TABLE MOVIE_CAST(
  ACT_ID NUMBER(2),
  MOV_ID NUMBER(3),
  ROLE VARCHAR(20),
  CONSTRAINT CPK_AM PRIMARY KEY(ACT_ID, MOV_ID),
  CONSTRAINT FK_MA FOREIGN KEY(ACT_ID) REFERENCES ACTOR(ACT_ID) ON DELETE CASCADE,
  CONSTRAINT FK_MD FOREIGN KEY(MOV_ID) REFERENCES MOVIES(MOV_ID) ON DELETE CASCADE
);

INSERT INTO MOVIE_CAST VALUES('10', '333', 'HERO');
INSERT INTO MOVIE_CAST VALUES('20', '555', 'HERO');
INSERT INTO MOVIE_CAST VALUES('30', '444', 'HEROINE');
INSERT INTO MOVIE_CAST VALUES('40', '666', 'HERO');
INSERT INTO MOVIE_CAST VALUES('50', '222', 'VILLAIN');
INSERT INTO MOVIE_CAST VALUES('60', '333', 'HEROINE');
INSERT INTO MOVIE_CAST VALUES('60', '111', 'HEROINE');
INSERT INTO MOVIE_CAST VALUES('20', '111', 'HERO');
INSERT INTO MOVIE_CAST VALUES('10', '777', 'HERO'); 

---
CREATE TABLE RATING(
  MOV_ID NUMBER(3),
  REV_STARS NUMBER(1),
  CONSTRAINT CPK_MCT PRIMARY KEY(MOV_ID, REV_STARS),
  CONSTRAINT FK_MCD FOREIGN KEY(MOV_ID) REFERENCES MOVIES(MOV_ID) ON DELETE CASCADE
);

INSERT INTO RATING VALUES('111', '3');
INSERT INTO RATING VALUES('111', '5');
INSERT INTO RATING VALUES('222', '2');
INSERT INTO RATING VALUES('222', '3');
INSERT INTO RATING VALUES('333', '0');
INSERT INTO RATING VALUES('444', '4');
INSERT INTO RATING VALUES('444', '5');
INSERT INTO RATING VALUES('555', '3');
INSERT INTO RATING VALUES('666', '2');
INSERT INTO RATING VALUES('777', '4');


---

SELECT * FROM RATING;
SELECT * FROM MOVIE_CAST;
SELECT * FROM MOVIES;
SELECT * FROM DIRECTOR;
SELECT * FROM ACTOR;

COMMIT;
