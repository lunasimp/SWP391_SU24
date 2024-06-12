<%-- 
    Document   : insertCourse
    Created on : May 28, 2024, 10:27:46 PM
    Author     : Thanh
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form method="post" action="manager/create-course">
            <div>
                <div>
                    <p>Image URL:</p>
                </div>
                <input type="text" name="imageUrl" required>
            </div>
            <div>
                <div>
                    <p>Title:</p>
                </div>
                <input type="text" name="title" required>
            </div>
            <div>
                <div>
                    <p>Description:</p>
                </div>
                <input type="text" name="description" required>
            </div>
            <div>
                <div>
                    <p>Publish Date:</p>
                </div>
                <input type="date" name="publishDate" required>
            </div>
            <div>
                <div>
                    <p>Lecturer: </p>
                </div>
                <input type="text" name="lecturer" required>
            </div>
            <div>
                <div>
                    <p>Semester:</p>
                </div>
                <select name="semesterId" required>
                    <c:forEach items="${semesters}" var="s">
                        <option value="${s.id}">${s.description}</option>
                    </c:forEach>
                </select>
            </div>
            <br>
            <button>Create Course</button>
        </form>
    </body>
</html>
