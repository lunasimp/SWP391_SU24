/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Category;
import model.Course;
import model.Semester;

/**
 *
 * @author Acer
 */
public class CourseDAO extends MyDAO {

    private static final String searchCourseQuery
            = "from Courses c "
            + "inner join Categories cat on c.CategoryID = cat.CategoryID "
            + "inner join Semesters s on c.SemesterID = s.SemesterID "
            + "where (N'' = ? or c.Title like ?) "
            + "and (-1 = ? or c.CategoryID = ?) "
            + "and (-1 = ? or c.SemesterID = ?) "
            + "and (0 = ? or c.DurationInSeconds > ?) "
            + "and (0 = ? or c.DurationInSeconds <= ?) ";

    /**
     * This method searches for courses based on various criteria such as search
     * query, category ID, semester ID, duration, page number, and page size. It
     * retrieves a list of courses that match the specified criteria.
     *
     * @param searchQuery The search query used to filter courses by their
     * title.
     * @param categoryId The ID of the category to filter courses by. Set to -1
     * to ignore this filter.
     * @param semesterID The ID of the semester to filter courses by. Set to -1
     * to ignore this filter.
     * @param page The page number of the results to retrieve.
     * @param pageSize The number of courses per page.
     * @return A list of Course objects that match the specified criteria.
     * @throws SQLException If an error occurs while executing the SQL query
     */
    public List<Course> searchCourses(
            String searchQuery, int categoryId, int semesterID, int durationLow, int durationHigh, boolean showHiddenCourses,
            String sortName, String sortDuration, String sortPublishDate,
            int page, int pageSize) throws SQLException {
        xSql = "select * " + searchCourseQuery
                + (showHiddenCourses ? " " : " and c.IsDiscontinued = 0 and c.PublishDate is not null ")
                + "order by " + getSortQuery(sortName, sortDuration, sortPublishDate) + " "
                + "offset ? rows fetch next ? rows only";

        int offset = page * pageSize;

        ps = con.prepareStatement(xSql);
        ps.setString(1, searchQuery);
        ps.setString(2, "%" + searchQuery + "%");
        ps.setInt(3, categoryId);
        ps.setInt(4, categoryId);
        ps.setInt(5, semesterID);
        ps.setInt(6, semesterID);
        ps.setInt(7, durationLow);
        ps.setInt(8, durationLow);
        ps.setInt(9, durationHigh);
        ps.setInt(10, durationHigh);
        ps.setInt(11, offset);
        ps.setInt(12, pageSize);
        rs = ps.executeQuery();

        List<Course> results = new ArrayList<>();
        while (rs.next()) {
            results.add(fromResultSet(rs));
        }
        return results;
    }

    /**
     * This method get the count of Searches the count of courses based on the
     * provided search query, category ID, semester ID, duration,
     *
     * @param searchQuery The search query used to filter courses by their
     * title.
     * @param categoryId The ID of the category to filter courses by. Set to -1
     * to ignore this filter.
     * @param semesterID The ID of the semester to filter courses by. Set to -1
     * to ignore this filter.
     * @param durationLow The maximum duration of the courses to filter by.
     * Specify "00:00:00.00" to ignore this filter.
     * @param durationHigh
     * @return
     * @throws SQLException
     */
    public int searchCoursesCount(String searchQuery, int categoryId, int semesterID, int durationLow, int durationHigh, boolean showHiddenCourses)
            throws SQLException {
        xSql = "select count(*) " + searchCourseQuery
                + (showHiddenCourses ? "" : " and IsDiscontinued = 0 and PublishDate is not null ");
        ps = con.prepareStatement(xSql);
        ps.setString(1, searchQuery);
        ps.setString(2, "%" + searchQuery + "%");
        ps.setInt(3, categoryId);
        ps.setInt(4, categoryId);
        ps.setInt(5, semesterID);
        ps.setInt(6, semesterID);
        ps.setInt(7, durationLow);
        ps.setInt(8, durationLow);
        ps.setInt(9, durationHigh);
        ps.setInt(10, durationHigh);
        rs = ps.executeQuery();

        rs.next();
        return rs.getInt(1);
    }

    public Course getCourseById(int id) throws SQLException {
        xSql = "Select * from Courses c "
                + "inner join Categories cat on c.CategoryID = cat.CategoryID "
                + "inner join Semesters s on c.SemesterID = s.SemesterID "
                + " where CourseID = ?";
        ps = con.prepareStatement(xSql);
        ps.setInt(1, id);
        rs = ps.executeQuery();
        if (!rs.next()) {
            return null;
        }
        return fromResultSet(rs);
    }

    private String getSortQuery(String sortName, String sortDuration, String sortPublishDate) {
        List<String> sorter = new ArrayList<String>();
        if (sortName != null) {
            switch (sortName) {
                case "asc":
                    sorter.add("c.Title asc");
                    break;
                case "desc":
                    sorter.add("c.Title desc");
                    break;
            }
        }

        if (sortDuration != null) {
            switch (sortDuration) {
                case "asc":
                    sorter.add("c.DurationInSeconds asc");
                    break;
                case "desc":
                    sorter.add("c.DurationInSeconds desc");
                    break;
            }
        }

        if (sortPublishDate != null) {
            switch (sortPublishDate) {
                case "asc":
                    sorter.add("c.PublishDate asc");
                    break;
                case "desc":
                    sorter.add("c.PublishDate desc");
                    break;
            }
        }

        sorter.add("c.CourseId desc");
        return String.join(", ", sorter);
    }

    public Course fromResultSet(ResultSet rs) throws SQLException {
        // Must join with category and semester
        Semester semester = new Semester(rs.getInt("SemesterID"), rs.getString("SemesterDescription"));
        Category cat = new Category(rs.getInt("CategoryID"), rs.getString("CategoryDescription"));
        Course c = new Course(rs.getInt("CourseID"), rs.getString("Title"), rs.getString("CourseDescription"), rs.getString("CourseBannerImage"), rs.getDate("PublishDate"), rs.getBoolean("IsDiscontinued"), rs.getInt("NewVersionID"), rs.getString("Lecturer"), semester, cat, rs.getInt("DurationInSeconds"));
        return c;
    }
}
