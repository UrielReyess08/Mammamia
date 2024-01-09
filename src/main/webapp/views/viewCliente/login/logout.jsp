<%-- 
    Document   : logout
    Created on : 5 ene. 2024, 19:47:36
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
    response.sendRedirect("loginCliente.jsp");
%>
