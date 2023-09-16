UPDATE owner
SET parking = CASE WHEN RAND() > 0.5 THEN 'Yes' ELSE 'No' END;