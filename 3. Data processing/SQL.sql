select * from `da`.`brighttv`.`viewership` limit 100;
SELECT  UserID,
        Channel2,
        RecordDate2,
        `Duration 2`,
        Name,
        Surname,
        Race,
        Age,
        Province,
        Gender,
        `Social Media Handle`
        From `da`.`brighttv`.`viewership` As A
        Left Join `da`.`brighttv`.`user_profile` AS B 
        ON A.userid4 = B.userid;
-------------------------------------------------------------------------------------------------------
---CHECKING DISTINCT RACES,PROVINCE AND CHANNEL FROM BRIGHTTV
-------------------------------------------------------------------------------------------------------
SELECT DISTINCT Race 
From `da`.`brighttv`.`viewership` As A
Left Join `da`.`brighttv`.`user_profile` AS B 
  ON A.userid4 = B.userid;

SELECT  DISTINCT Province 
From `da`.`brighttv`.`viewership` As A
        Left Join `da`.`brighttv`.`user_profile` AS B 
        ON A.userid4 = B.userid;

SELECT DISTINCT Channel2
From `da`.`brighttv`.`viewership` As A
Left Join `da`.`brighttv`.`user_profile` AS B 
ON A.userid4 = B.userid;
--------------------------------------------------------------------------------------------------
---CHECKING DATEDIFF
--------------------------------------------------------------------------------------------------
SELECT Channel2,
SUM(DATEDIFF(RecordDate2,`Duration 2`)) AS Total_Duration
From `da`.`brighttv`.`viewership` AS A
LEFT JOIN `da`. `brighttv`.`user_profile` AS B
ON A.userid4 = B.userid
GROUP BY Channel2
ORDER BY Total_Duration DESC;
--------------------------------------------------------------------------------------------
---MIN and MAX OF DURATION
--------------------------------------------------------------------------------------------
SELECT MIN(`Duration 2`) AS Min_Duration,
       MAX(`Duration 2`) AS Max_Duration
       From `da`.`brighttv`.`user_profile` AS B
       LEFT JOIN `da`.`brighttv`.`viewership` AS A
ON A.userid4 = B.userid;
---------------------------------------------------------------------------------------------
---CHECKING MIN AND MAX AGE
---------------------------------------------------------------------------------------------
SELECT MIN(Age) AS Min_Age,
       Max(Age) AS Max_Age
 From `da`.`brighttv`.`user_profile` AS B
       LEFT JOIN `da`.`brighttv`.`viewership` AS A
ON A.userid4 = B.userid;
---------------------------------------------------------------------------------------------
---CHECKING TO THE NUMBER OF VIEWERSHIP PER DAY
---------------------------------------------------------------------------------------------
SELECT DISTINCT DAYNAME(RecordDate2) AS Day,
COUNT(RecordDate2) AS Total_Viewership
From `da`.`brighttv`.`viewership` AS A
LEFT JOIN `da`.`brighttv`.`user_profile` AS B
ON A.userid4 = B.userid
GROUP BY Day
ORDER BY Total_Viewership DESC;
-----------------------------------------------------------------------------------------------
---CHECK TOTAL VIEWERSHIP PER PROVINCE
-----------------------------------------------------------------------------------------------
SELECT Province,
COUNT(Province) AS Total_Viewership
From `da`.`brighttv`.`viewership` AS A
LEFT JOIN `da`.`brighttv`.`user_profile` AS B
ON A.userid4 = B.userid
GROUP BY Province
ORDER BY Total_viewership ASC;

-------------------------------------------------------------------------------------------------
---CHECKING TOTAL VIEWERSHIP PER RACE
-------------------------------------------------------------------------------------------------
SELECT Race,
COUNT(Race) AS Total_Viewership
From `da`.`brighttv`.`viewership` AS A
LEFT JOIN `da`.`brighttv`.`user_profile` AS B
ON A.userid4 = B.userid
GROUP BY Race
ORDER BY Total_Viewership DESC;
-------------------------------------------------------------------------------------------------
---CHECKING TOTAL VIEWERSHIP PER GENDER
-------------------------------------------------------------------------------------------------
SELECT Gender,
COUNT(Gender) AS Total_Viewership
From `da`.`brighttv`.`viewership` AS A
LEFT JOIN `da`.`brighttv`.`user_profile` AS B
ON A.userid4 = B.userid
GROUP BY Gender
ORDER BY Total_Viewership DESC;
-----------------------------------------------------------------------------------------------------------
---CHECKING TOTAL VIEWERSHIP PER AGE
-----------------------------------------------------------------------------------------------------------
SELECT Age,
COUNT(*) AS Total_Viewership
From `da`.`brighttv`.`viewership` AS A
LEFT JOIN `da`.`brighttv`.`user_profile` AS B
ON A.userid4 = B.userid
GROUP BY Age
ORDER BY Total_Viewership DESC; 
---------------------------------------------------------------------------------------------------------
---CHECKING TOTAL VIEWERSHIP PER CHANNEL
---------------------------------------------------------------------------------------------------------
SELECT Channel2,
COUNT(Channel2) AS Total_Viewership
From `da`.`brighttv`.`viewership` AS A
LEFT JOIN `da`.`brighttv`.`user_profile` AS B
ON A.userid4 = B.userid
GROUP BY Channel2
ORDER BY Total_Viewership DESC;
---------------------------------------------------------------------------------------------------------
---CHECKING TOTAL VIEWERSHIP PER SOCIAL MEDIA HANDLE
---------------------------------------------------------------------------------------------------------
SELECT `Social Media Handle`,
COUNT(`Social Media Handle`) AS Total_Viewership
From `da`.`brighttv`.`viewership` AS A
LEFT JOIN `da`.`brighttv`.`user_profile` AS B
ON A.userid4 = B.userid
GROUP BY `Social Media Handle`
ORDER BY Total_Viewership DESC;
-------------------------------------------------------------------------------------------------------------
----CHECKING TOTAL VIEWERSHIP PER RECORD DATE
-------------------------------------------------------------------------------------------------------------
SELECT RecordDate2,
COUNT(RecordDate2) AS Total_Viewership
From `da`.`brighttv`.`viewership` AS A
LEFT JOIN `da`.`brighttv`.`user_profile` AS B
ON A.userid4 = B.userid
GROUP BY RecordDate2
ORDER BY Total_Viewership DESC;
------------------------------------------------------------------------------------------------------
---CHECKING VIEWERS PER CHANNEL
------------------------------------------------------------------------------------------------------
SELECT Channel2,
COUNT(Channel2) AS Total_Viewership
From `da`.`brighttv`.`viewership` AS A
LEFT JOIN `da`.`brighttv`.`user_profile` AS B
ON A.userid4 = B.userid
GROUP BY Channel2
ORDER BY Total_Viewership DESC;
---------------------------------------------------------------------------------------------------------
---CHECKING VIEWERS PER RECORD DATE
---------------------------------------------------------------------------------------------------------
SELECT RecordDate2,
COUNT(RecordDate2) AS Total_Viewership
From `da`.`brighttv`.`viewership` AS A
LEFT JOIN `da`.brighttv.user_profile AS B
ON A.userid4 = B.userid
GROUP BY RecordDate2
ORDER BY Total_Viewership DESC;
-----------------------------------------------------------------------------------------------------
---UTC TO SOUTH AFRICAN TIME
-----------------------------------------------------------------------------------------------------
SELECT RecordDate2,
 from_utc_timestamp(RecordDate2, 'Africa/Johannesburg') AS RecordDate2
From `da`.`brighttv`.`viewership` AS A
LEFT JOIN `da`.`brighttv`.`user_profile` AS B
ON A.userid4 = B.userid;
---------------------------------------------------------------------------------------------------
---COMBINING FUNCTIONS TO GET A CLEAN DATA SET
-- BrightTV Enhanced Viewership Dataset
-- Combines viewership + user profiles with all derived fields
---------------------------------------------------------------------------------------------------

SELECT

    -- ── Identifiers
    UserID0 AS UserID,

    -- ── Time dimensions
    RecordDate2 AS UTC_Timestamp,
    FROM_UTC_TIMESTAMP(RecordDate2, 'Africa/Johannesburg') AS SA_Timestamp,
    YEAR(RecordDate2) AS View_Year,
    MONTHNAME(RecordDate2) AS View_Month,
    MONTH(RecordDate2) AS View_Month_Num,
    DAYNAME(RecordDate2) AS View_Day,
    DAYOFWEEK(RecordDate2) AS View_Day_Num,

    -- ── Channel
    Channel2 AS Channel,

    -- ── Duration
    `Duration 2` AS Duration_Start,
    DATEDIFF(RecordDate2, `Duration 2`) AS Duration_Minutes,

    -- ── Viewer demographics
    Age AS Age,
    CASE
        WHEN Age BETWEEN 0  AND 17 THEN 'Under 18'
        WHEN Age BETWEEN 18 AND 24 THEN '18-24'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age BETWEEN 45 AND 54 THEN '45-54'
        WHEN Age >= 55             THEN '55+'
        ELSE 'Unknown'
    END AS Age_Group,

    Gender AS Gender,
    Race AS Race,
    Province AS Province,

CASE
        WHEN DAYOFWEEK(RecordDate2) IN (1, 7) THEN 'Weekend'
        ELSE  'Weekday'
    END AS Day_classification


From `da`.`brighttv`.`viewership` AS A
LEFT JOIN `da`.brighttv.user_profile AS B
ON A.userid4 = B.userid

ORDER BY
    RecordDate2 DESC,
    Channel2    ASC;






















