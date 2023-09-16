ALTER TABLE `residents` ADD CONSTRAINT `fk_owner_residents` FOREIGN KEY (`id_apartments`) REFERENCES `owner` (`id_apartments`);
