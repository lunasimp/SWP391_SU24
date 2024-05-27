/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Semester;

/**
 *
 * @author Acer
 */
public class SemesterDAO extends MyDAO {

    public List<Semester> getAllSemesters() throws SQLException {
        List<Semester> semesters = new ArrayList<>();

        xSql = "select SemesterID,SemesterDescription from Semesters";

        ps = con.prepareStatement(xSql);
        rs = ps.executeQuery();
        while (rs.next()) {
            int semesterID = rs.getInt("SemesterID");
            String description = rs.getString("SemesterDescription");
            Semester semester = new Semester(semesterID, description);
            semesters.add(semester);
        }

        return semesters;
    }
}
