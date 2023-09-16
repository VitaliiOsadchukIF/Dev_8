INSERT INTO residents (id_apartments, name)
SELECT id_apartments, name
FROM owner
LIMIT 90;