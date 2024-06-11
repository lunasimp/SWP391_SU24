package controllers;

import dal.SemesterDAO;
import model.Semester;
import utils.ParseUtils;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/manager")
public class ManagerController extends HttpServlet {

    private SemesterDAO semesterDao;

    @Override
    public void init() {
        semesterDao = new SemesterDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "viewAllSemesters";

        try {
            switch (action) {
                case "viewAllSemesters":
                    viewAllSemesters(request, response);
                    break;
                case "showCreateSemesterForm":
                    showCreateSemesterForm(request, response);
                    break;
                case "showEditSemesterForm":
                    showEditSemesterForm(request, response);
                    break;
                case "deleteSemester":
                    deleteSemester(request, response);
                    break;
                case "hideSemester":
                    hideSemester(request, response);
                    break;
                default:
                    viewAllSemesters(request, response);
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "viewAllSemesters";

        try {
            switch (action) {
                case "createSemester":
                    createSemester(request, response);
                    break;
                case "updateSemester":
                    updateSemester(request, response);
                    break;
                default:
                    viewAllSemesters(request, response);
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    private void viewAllSemesters(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        List<Semester> semesters = semesterDao.getAllSemesters();
        request.setAttribute("semesters", semesters);
        request.getRequestDispatcher("manager/view-semesters.jsp").forward(request, response);
    }

    private void showCreateSemesterForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("manager/create-semester.jsp").forward(request, response);
    }

    private void showEditSemesterForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Semester semester = semesterDao.getSemesterById(id);
        request.setAttribute("semester", semester);
        request.getRequestDispatcher("manager/edit-semester.jsp").forward(request, response);
    }

    private void createSemester(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        String description = request.getParameter("description");
        LocalDate startDate = LocalDate.parse(request.getParameter("startDate"));
        LocalDate endDate = LocalDate.parse(request.getParameter("endDate"));

        Semester semester = new Semester();
        semester.setDescription(description);
        semester.setStartDate(startDate);
        semester.setEndDate(endDate);

        semesterDao.createSemester(semester);
        response.sendRedirect("manager?action=viewAllSemesters");
    }

    private void updateSemester(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String description = request.getParameter("description");
        LocalDate startDate = LocalDate.parse(request.getParameter("startDate"));
        LocalDate endDate = LocalDate.parse(request.getParameter("endDate"));

        Semester semester = new Semester();
        semester.setId(id);
        semester.setDescription(description);
        semester.setStartDate(startDate);
        semester.setEndDate(endDate);

        semesterDao.updateSemester(semester);
        response.sendRedirect("manager?action=viewAllSemesters");
    }

    private void deleteSemester(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        semesterDao.deleteSemester(id);
        response.sendRedirect("manager?action=viewAllSemesters");
    }

    private void hideSemester(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        semesterDao.hideSemester(id);
        response.sendRedirect("manager?action=viewAllSemesters");
    }
}
