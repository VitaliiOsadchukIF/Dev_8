INSERT INTO roles (id_owner, roles)
SELECT
  id,
  CASE
    WHEN id BETWEEN 1 AND 1 THEN 'Head of management'
    WHEN id BETWEEN 2 AND 10 THEN 'Employee'
    ELSE 'Member'
  END AS roles
FROM owner
WHERE id <= 120;