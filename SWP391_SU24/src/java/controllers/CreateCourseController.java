/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controllers;

import dal.CourseDAO;
import dal.SemesterDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.sql.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Course;
import model.Semester;

/**
 *
 * @author Thanh
 */
@WebServlet(name = "CreateCourseController", urlPatterns = {"/createCourse"})
public class CreateCourseController extends HttpServlet{

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            SemesterDAO dbSemester = new SemesterDAO();
            
            req.setAttribute("semesters", dbSemester.getAllSemesters());
            req.getRequestDispatcher("createCourse.jsp").forward(req, resp);
        } catch (SQLException ex) {
            Logger.getLogger(CreateCourseController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String imageUrl = req.getParameter("imageUrl");
        String title = req.getParameter("title");
        String description = req.getParameter("description");
        String raw_publishDate = req.getParameter("publishDate");
        String lecturer = req.getParameter("lecturer");
        String raw_semesterId = req.getParameter("semesterId");
        
        int semesterId = 0;
        Date publishDate = null;
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        try {
            semesterId = Integer.parseInt(raw_semesterId);
            publishDate = new Date(dateFormat.parse(raw_publishDate).getTime());
        } catch (Exception e) {
            log(e.getMessage());
        }
    
        CourseDAO dbCourse = new CourseDAO();
        Course course = new Course();
        course.setImgUrl(imageUrl);
        course.setTitle(title);
        course.setDescription(description);
        course.setPublishDate(publishDate);
        course.setLecturer(lecturer);
        
        Semester semester = new Semester();
        course.setSemester(semester);
        
        dbCourse.insert(course);
        req.getRequestDispatcher("index.html").forward(req, resp);
    }

    
    
}
