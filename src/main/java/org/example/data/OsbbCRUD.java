package org.example.data;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.flywaydb.core.Flyway;

import java.io.Closeable;
import java.io.IOException;
import java.sql.*;
import java.util.LinkedList;
import java.util.List;

import static org.example.Config.*;

public class OsbbCRUD implements Closeable {

    private static final Logger logger = LogManager.getLogger(OsbbCRUD.class);

    private Connection conn = null;

    private static final String sqlMembersWithAutoNotAllowedQuery = "SELECT\n" +
            "    o.name AS owner_name,\n" +
            "    o.id AS id,\n" +
            "    o.email AS owner_email,\n" +
            "    b.adress AS building_address,\n" +
            "    a.number AS apartment_number,\n" +
            "    a.area AS apartment_area\n" +
            "FROM\n" +
            "    osbb10.owner o\n" +
            "JOIN\n" +
            "    residents r ON o.id_apartments = r.id_apartments\n" +
            "JOIN\n" +
            "    osbb.apartments a ON o.id_apartments = a.id\n" +
            "JOIN\n" +
            "    osbb.buildings b ON a.id_buildings = b.id\n" +
            "WHERE\n" +
            "    o.property_rights = 'owner' -- Фільтр для власників\n" +
            "    AND o.parking = 'No' -- Фільтр для тих, хто не має права в'їзду\n" +
            "    AND (\n" +
            "        o.id IN (SELECT id_owner FROM osbb10.roles WHERE roles = 'Member') -- Власники, які є учасниками ОСББ\n" +
            "         OR a.id NOT IN (SELECT id_apartments FROM osbb10.residents) -- Квартири, в яких немає жителів\n" +
            "    )\n" +
            "GROUP BY\n" +
            "    o.id\n" +
            "HAVING\n" +
            "    COUNT(a.id) < 2; -- Власники, які мають менше двох квартир у власності";

    private void fmMigration() {

        logger.debug("Flyway migration execute");

        Flyway.configure()
                .dataSource(jdbcUrl, userNane, password)
                .locations("classpath:flyway/scripts")
                .load()
                .migrate();
    }

    public OsbbCRUD init() throws SQLException {
        logger.info("Crud has initialized");
        fmMigration();

        conn = DriverManager.getConnection(jdbcUrl, userNane, password);
        return this;
    }

    @Override
    public void close() throws IOException {
        try {
            conn.close();
            conn = null;
        } catch (SQLException e) {
            throw new IOException(e);
        }
    }

    public List<Member> getMembersWithAutoNotAllowed() throws SQLException {
        logger.trace("Call getting members with auto not allowed method");

        final List<Member> result = new LinkedList<>();
        try (PreparedStatement preparedStatement = conn.prepareStatement(sqlMembersWithAutoNotAllowedQuery)) {
            final ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next())
                result.add(
                        new Member()
                                .setId(resultSet.getInt("id"))
                                .setName(resultSet.getString("owner_name")));
        }
        return result;
    }


}
