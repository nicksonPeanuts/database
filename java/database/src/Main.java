
/*

    PROGRAMMA JAVA PER LA GESTIONE E LA COMUNICAZIONE CON IL DATABASE

 */

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Main
{
    public static void main(String[] args)
    {
        Connection conn = null;
        try{
            conn = DriverManager.getConnection("jdbc:mysql://localhost/" + "classicmodels" + "user=admin" + "password=codelyoko");



        }catch (SQLException e){
            /**/
        }

    }
}