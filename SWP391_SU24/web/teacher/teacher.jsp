
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:set var="semester" value="${empty param.semester ? -1 : param.semester}"></c:set>
<c:set var="category" value="${empty param.category ? -1 : param.category}"></c:set>
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
    </style>

    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="/components/headCommon.jspf" %>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">  
        <title>JSP Page</title>
    </head>
    <body>
        <%@include file="/components/header.jspf" %>
        <div class="grid">
            <%@include file="/components/adminNavBar.jspf" %>
            <div class="admin-content">
                <div class="form-container">
                    <div class="title">
                        <c:choose>
                            <c:when test="${filterValue == 'assigned'}">
                                <h1>Your Courses</h1>
                            </c:when>
                            <c:otherwise>
                                <h1>All Courses</h1>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="filter-btn">
                        <button name="filterValue" value="all" onclick="selectFilter(event)" class="filter-button">All Courses</button>
                        <button name="filterValue" value="assigned" onclick="selectFilter(event)" class="filter-button">Assigned User Courses</button>
                    </div> 
                    <%@include file="/components/searchBar.jspf" %>
                    <div class="filters">
                        <div>
                            Categories:  
                            <select name="category" value="${empty param.category ? -1 : param.category}" onchange="applyFilter('category', event.target.value)">
                                <option value="-1">All</option>
                                <c:forEach var="item" items="${categories}">
                                    <option value="${item.id}" ${category == item.id ? 'selected' : ''}> ${item.description}</option>  
                                </c:forEach>
                            </select>
                        </div>
                        <div>
                            Semesters:
                            <select name="semester" value="${empty param.semester ? -1 : param.semester}" onchange="applyFilter('semester', event.target.value)">
                                <option value="-1">All</option>
                                <c:forEach var="item" items="${semesters}">
                                    <option value="${item.id}" ${semester == item.id ? "selected" : ''} >
                                        ${item.description}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <table>
                        <thead>
                            <tr>
                                <th class="cel-1">Course</th>
                                    <c:choose>
                                        <c:when test="${filterValue == 'assigned'}">
                                        <th>Option</th>
                                        </c:when>
                                    </c:choose>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${filterValue eq 'assigned'}">
                                    <c:forEach items="${designerCourses}" var="x">
                                        <tr>
                                            <td>
                                                <div class="course-inf">
                                                    <img src="${x.imgUrl}" alt="courseImage"/>
                                                    <div class="inf">
                                                        <p>${x.title}</p>
                                                        <small>Publish Date: ${x.publishDate}</small>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>
                                                <div class="options">
                                                    <a href="${pageContext.request.contextPath}/admin/edit-course?courseId=${x.id}">Edit</a>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach items="${courseData}" var="i">
                                        <tr>
                                            <td>
                                                <div class="course-inf">
                                                    <img src="${i.imgUrl}" alt="courseImage"/>
                                                    <div class="inf">
                                                        <p>${i.title}</p>
                                                        <small>Publish Date: ${i.publishDate}</small>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                    <%@include file="/components/courseListingPagination.jspf" %>
                </div>
            </div>       
        </div>

        <%@include file="/components/footer.jspf" %>
    </body>
</html>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        // Gắn sự kiện nghe (event listener) cho các phần tử filter
        const filterButtons = document.querySelectorAll('[name="filterValue"]');
        filterButtons.forEach(function (button) {
            button.addEventListener('click', selectFilter);
        });
    });

    function selectFilter(e) {
        let target = e.target;
        // Remove 'selected' class from all filter buttons
        let filterButtons = document.querySelectorAll('.filter-button');
        filterButtons.forEach(function (button) {
            button.classList.remove('selected');
        });
        // Add 'selected' class to the clicked filter button
        target.classList.add('selected');
        // Get the value of the selected filter
        let name = target.getAttribute('name');
        let value = target.getAttribute('value');
        applyFilter(name, value);
        e.preventDefault();
    }


    function applyFilter(name, value) {
        let searches = new URLSearchParams(location.search);
        searches.set(name, value);
        location.search = searches.toString();
    }


</script>