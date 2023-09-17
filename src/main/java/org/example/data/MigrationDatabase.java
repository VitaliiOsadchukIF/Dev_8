package org.example.data;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.flywaydb.core.Flyway;

import static org.example.Config.*;

public class MigrationDatabase {

    private static final Logger logger = LogManager.getLogger(OsbbCRUD.class);

    public MigrationDatabase() {
    }

    public void fmMigration() {

        logger.debug("Flyway migration execute");

        Flyway.configure()
                .dataSource(jdbcUrl, userNane, password)
                .locations("classpath:flyway/scripts")
                .load()
                .migrate();

        logger.info("Flyway migration completed");
    }

}
