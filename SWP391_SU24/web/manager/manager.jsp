<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:set var="semester" value="${empty param.semester ? -1 : param.semester}"></c:set>
<!DOCTYPE html>

<style>
    .filter-btn {
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .filter-button {
        background-color: #eaeaea;
        color: #333333;
        border: none;
        padding: 10px 20px;
        margin: 5px;
        cursor: pointer;
    }

    .filter-button:hover {
        background-color: #d4d4d4;
    }

    .filter-button.selected {
        background-color: #333333;
        color: #ffffff;
    }

    .title {
        display: flex;
        align-content: flex-start;
        align-items: center;
        justify-content: space-between;
    }
    
    .title a{
        padding: 10px 20px;
        border-radius: 4px;
        background-color: #99ff66;
    }

    .table-container {
        margin-top: 20px;
    }

    .table-container table {
        width: 100%;
        border-collapse: collapse;
    }

    .table-container th, .table-container td {
        border: 1px solid #dddddd;
        text-align: left;
        padding: 8px;
    }

    .table-container th {
        background-color: #f2f2f2;
    }

    .options a {
        margin-right: 10px;
    }

</style>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="/components/headCommon.jspf" %>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">  
        <title>Manager Page</title>
    </head>
    <body>
        <%@include file="/components/header.jspf" %>
        <div class="grid">
            <div class="admin-sidebar">
            </div>
            <div class="admin-content">
                <div class="form-container">
                    <div class="title">
                        <h1>Courses</h1>
                        <a href="${pageContext.request.contextPath}/manager/create-course"><i class="fa fa-plus-circle" aria-hidden="true"></i> New Course</a>
                    </div>
                    <div class="filters">
                        <form method="get" action="${pageContext.request.contextPath}/manager">
                            <div>
                                Semesters:
                                <select name="semester" value="${empty param.semester ? -1 : param.semester}" onchange="this.form.submit()">
                                    <option value="-1">All</option>
                                    <c:forEach var="item" items="${semesters}">
                                        <option value="${item.id}" ${semester == item.id ? "selected" : ''} >
                                            ${item.description}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </form>
                    </div>

                    <table>
                        <thead>
                            <tr>
                                <th class="cel-1">Courses</th>
                                <th>Options</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${courses}" var="x">
                                <tr>
                                    <td>
                                        <div class="course-inf">
                                            <img src="${x.imgUrl}" alt="courseImage"/>
                                            <div class="inf">
                                                <p>${x.title}-${x.description}</p>
                                                <small>Publish Date: ${x.publishDate}</small><br>
                                                <small>Lecturer: ${x.lecturer}</small>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="options">
                                            <a href="${pageContext.request.contextPath}/manager/view-course?courseId=${x.id}"><i class="fa-solid fa-pen-to-square"></i>View</a>
                                            <a style="background-color: beige" href="${pageContext.request.contextPath}/manager/assign-course?courseId=${x.id}"><i class="fa-solid fa-user-pen"></i>Assign</a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>

                    <div class="title">
                        <h1>Semesters</h1>
                        <a href="${pageContext.request.contextPath}/manager/create-semester"><i class="fa fa-plus-circle" aria-hidden="true"></i> New Semester</a>
                    </div>
                    <div class="table-container">
                        <table>
                            <thead>
                                <tr>
                                    <th>Name</th>
                                    <th>Start Date</th>
                                    <th>End Date</th>
                                    <th>Options</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${semesters}" var="s">
                                    <tr>
                                        <td>${s.name}</td>
                                        <td>${s.startDate}</td>
                                        <td>${s.endDate}</td>
                                        <td>
                                            <a href="${pageContext.request.contextPath}/manager/edit-semester?semesterId=${s.id}">Edit</a>
                                            <a href="${pageContext.request.contextPath}/manager/delete-semester?semesterId=${s.id}">Delete</a>
                                            <a href="${pageContext.request.contextPath}/manager/hide-semester?semesterId=${s.id}">Hide</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>

                    <div class="form-container">
                        <form action="${pageContext.request.contextPath}/manager/create-semester" method="post">
                            <h2>Create New Semester</h2>
                            <label for="name">Name:</label>
                            <input type="text" id="name" name="name" required><br><br>
                            <label for="startDate">Start Date:</label>
                            <input type="date" id="startDate" name="startDate" required><br><br>
                            <label for="endDate">End Date:</label>
                            <input type="date" id="endDate" name="endDate" required><br><br>
                            <input type="submit" value="Create Semester">
                        </form>
                    </div>
                </div>
            </div>       
        </div>
        <%@include file="/components/footer.jspf" %>
    </body>
</html>
