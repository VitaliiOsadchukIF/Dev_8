UPDATE owner
SET email = CONCAT(SUBSTRING_INDEX(name, ' ', 1), '_', SUBSTRING_INDEX(SUBSTRING_INDEX(name, ' ', -2), ' ', -1), '_', SUBSTRING_INDEX(name, ' ', -1), '_', id, '@gmail.com')
WHERE id BETWEEN 1 AND 120;