/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dal.CategoryDAO;
import dal.CourseDAO;
import dal.SemesterDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Course;
import utils.ParseUtils;

/**
 *
 * @author Acer
 */
public class TeacherController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AdminController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int pageSize = 5;
        int page = ParseUtils.parseIntWithDefault(request.getParameter("page"), 1) - 1;
        int category = ParseUtils.parseIntWithDefault(request.getParameter("category"), -1);
        int semester = ParseUtils.parseIntWithDefault(request.getParameter("semester"), -1);
        String duration = ParseUtils.defaultIfEmpty(request.getParameter("duration"), "0-0");

        String[] parts = duration.split("-");
        int low = ParseUtils.parseIntWithDefault(parts[0], 0);
        int high = 0;
        if (parts.length >= 2) {
            high = ParseUtils.parseIntWithDefault(parts[1], 0);
        }

        String search = request.getParameter("search");
        if (search == null) {
            search = "";
        }
        String sortName = request.getParameter("sortName");
        String sortDuration = request.getParameter("sortDuration");
        String sortPublishDate = request.getParameter("sortPublishDate");

        CourseDAO cd = new CourseDAO();
        CategoryDAO catDao = new CategoryDAO();
        SemesterDAO semesterDao = new SemesterDAO();
        try {
            List<Course> list = cd.searchCourses(search, category, semester, low, high, true, sortName, sortDuration, sortPublishDate, page, pageSize);
            int listCount = cd.searchCoursesCount(search, category, semester, low, high, false);
            int pageCount = (int) Math.ceil(listCount / (float) pageSize);

            request.setAttribute("courseData", list);
            request.setAttribute("pageCount", pageCount);
            request.setAttribute("listCount", listCount);
            request.setAttribute("categories", catDao.getAllCategories());
            request.setAttribute("semesters", semesterDao.getAllSemesters());
            request.getRequestDispatcher("teacher/teacher.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(HomeController.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
