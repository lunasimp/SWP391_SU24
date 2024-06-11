package dal;

import model.Semester;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SemesterDAO extends MyDAO {

    // Method to get all semesters
    public List<Semester> getAllSemesters() throws SQLException {
        List<Semester> semesters = new ArrayList<>();
        String query = "SELECT * FROM Semesters";
        try {
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();

            while (rs.next()) {
                Semester semester = new Semester();
                semester.setId(rs.getInt("id"));
                semester.setDescription(rs.getString("description"));
                semester.setStartDate(rs.getDate("startDate").toLocalDate());
                semester.setEndDate(rs.getDate("endDate").toLocalDate());
                semesters.add(semester);
            }
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
        }
        return semesters;
    }

    // Method to create a new semester
    public void createSemester(Semester semester) throws SQLException {
        String query = "INSERT INTO Semesters (description, startDate, endDate) VALUES (?, ?, ?)";
        try {
            ps = con.prepareStatement(query);
            ps.setString(1, semester.getDescription());
            ps.setDate(2, Date.valueOf(semester.getStartDate()));
            ps.setDate(3, Date.valueOf(semester.getEndDate()));
            ps.executeUpdate();
        } finally {
            if (ps != null) ps.close();
        }
    }

    // Method to update an existing semester
    public void updateSemester(Semester semester) throws SQLException {
        String query = "UPDATE Semesters SET description = ?, startDate = ?, endDate = ? WHERE id = ?";
        try {
            ps = con.prepareStatement(query);
            ps.setString(1, semester.getDescription());
            ps.setDate(2, Date.valueOf(semester.getStartDate()));
            ps.setDate(3, Date.valueOf(semester.getEndDate()));
            ps.setInt(4, semester.getId());
            ps.executeUpdate();
        } finally {
            if (ps != null) ps.close();
        }
    }

    // Method to delete a semester
    public void deleteSemester(int semesterId) throws SQLException {
        String query = "DELETE FROM Semesters WHERE id = ?";
        try {
            ps = con.prepareStatement(query);
            ps.setInt(1, semesterId);
            ps.executeUpdate();
        } finally {
            if (ps != null) ps.close();
        }
    }

    // Method to hide a semester (assuming hiding means setting a flag)
    public void hideSemester(int semesterId) throws SQLException {
        String query = "UPDATE Semesters SET hidden = 1 WHERE id = ?";
        try {
            ps = con.prepareStatement(query);
            ps.setInt(1, semesterId);
            ps.executeUpdate();
        } finally {
            if (ps != null) ps.close();
        }
    }

    // Method to get a semester by ID
    public Semester getSemesterById(int semesterId) throws SQLException {
        String query = "SELECT * FROM Semesters WHERE id = ?";
        try {
            ps = con.prepareStatement(query);
            ps.setInt(1, semesterId);
            rs = ps.executeQuery();
            if (rs.next()) {
                Semester semester = new Semester();
                semester.setId(rs.getInt("id"));
                semester.setDescription(rs.getString("description"));
                semester.setStartDate(rs.getDate("startDate").toLocalDate());
                semester.setEndDate(rs.getDate("endDate").toLocalDate());
                return semester;
            }
        } finally {
            if (rs != null) rs.close();
            if (ps != null) ps.close();
        }
        return null;
    }
}
