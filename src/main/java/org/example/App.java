package org.example;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.example.data.Member;
import org.example.data.OsbbCRUD;

import java.io.IOException;
import java.sql.SQLException;

public class App {

    private static final Logger logger = LogManager.getLogger(App.class);


    public static void main(String[] args) {
        logger.info("The program has started");

        try (OsbbCRUD crud = new OsbbCRUD()
                .init()) {

            for (Member member : crud.getMembersWithAutoNotAllowed()) {
                final StringBuffer sb = new StringBuffer();
                sb.append(member.getId())
                        .append(" : ")
                        .append(member.getName())
                        .append(" : ")
                        .append("\r\n");
                System.out.println(sb);
            }

        } catch (SQLException | IOException e) {
            logger.fatal(e);
        }


    }
}
