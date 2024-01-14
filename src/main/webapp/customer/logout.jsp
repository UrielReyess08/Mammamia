<%-- 
    Document   : logout
    Created on : 11 ene. 2024, 11:55:21
    Author     : daiko
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="jakarta.servlet.http.HttpSession" %>
<%@page import="jakarta.servlet.http.HttpServletRequest" %>
<%@page import="jakarta.servlet.http.HttpServletResponse" %>
<%@page import="java.io.IOException" %>
<!DOCTYPE html>
<%
    HttpSession sesion = request.getSession(false);
    if(sesion != null){
        sesion.invalidate();
    }
    response.sendRedirect("login.jsp");
%>
