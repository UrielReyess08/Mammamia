<%-- 
    Document   : reportes
    Created on : 8 feb. 2024, 23:38:27
    Author     : daiko
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.Usuario, model.DetallePedido, model.Producto, conexion.Conexion, dao.ReportesDao, java.util.*" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Ropa+Sans&display=swap" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <link rel="stylesheet" href="<%=request.getContextPath()%>/estilos/index.css">
        <title>Reportes | Sistema Mammamía</title>
    </head>
    <body>
        <%
            // Obtener la sesión
            HttpSession sesion = request.getSession(false);
    
            // Verificación de inicio de sesión
            if (sesion == null || sesion.getAttribute("usuario") == null) {
                System.out.println("Sesión inválida o usuario no presente");
                response.sendRedirect(request.getContextPath() + "/customer/login.jsp");
                return;
            }
    
            //Variable para el nombre del rol
            String nombreRol = (String) ((Usuario) sesion.getAttribute("usuario")).getRol();
               
            
            
            List<Producto> producto = ReportesDao.obtenerInventario();
            request.setAttribute("list", producto);
            
            int ClientesRegistrados = new ReportesDao().obtenerCantidadClienteRegistrados();
            
            int PedClientesRegistrados = new ReportesDao().obtenerCantidadPedidoClientesRegistrados();
            
            int PedClientesInvitados = new ReportesDao().obtenerCantidadPedidoClientesInvitados();
            
            int ingresosAnuales = new ReportesDao().obtenerInformeFinanciero(2024);
            
            ReportesDao reportesDao = new ReportesDao();
            DetallePedido productoMasVendido = reportesDao.obtenerProductoMasVendido(2024);
            
            String fecha = request.getParameter("fechaPedido");
            Integer cantidadPedidos = (Integer) request.getAttribute("cantidadPedidos");
            int cantidadPedidosValue = 0;
            if (cantidadPedidos != null){
                cantidadPedidosValue = cantidadPedidos.intValue();
            }
        %>

        <header class="p-3">
            <nav class="navbar navbar-expand-sm navbar-dark text-light">
                <div class="container-fluid">
                    <span class="">SISTEMA DE REPORTES</span>

                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#collapsibleNavbar">
                        <span class="navbar-toggler-icon"></span>
                    </button>

                    <div class="collapse navbar-collapse justify-content-end" id="collapsibleNavbar">
                        <ul class="navbar-nav">
                            <li class="">
                                <span class="pe-3">Bienvenido, <%= nombreRol %>‎</span>
                            </li>
                            <li class="">
                                <a class="ps-3 text-light" href="${pageContext.request.contextPath}/customer/logout.jsp">Cerrar Sesión</a>
                            </li>
                        </ul>
                    </div>

                </div>
            </nav>
        </header>

        <main class="container my-4">
            <article>
                <h1 class="text-center">Reportes del Sistema</h1>
                <section class="row justify-content-between">
                    <div class="col-sm-6 my-3">
                        <div class="card border-0 shadow">
                            <div class="card-body bg-white rounded-3">
                                <h6 class="card-subtitle mb-3 text-muted">INFORME FINANCIERO 2024</h6>
                                <h4 class="card-title text-center fw-bold m-0">Ingresos Actuales</h4>
                                <p class="card-text text-center text-success fw-bold">
                                    <span class="fs-5">‎S/.</span>
                                    <span class="fs-1"><%= ingresosAnuales %></span>
                                </p>
                            </div>
                        </div>
                    </div>

                    <div class="col-sm-6 my-3">
                        <div class="card border-0 shadow">
                            <div class="card-body bg-white rounded-3">
                                <h6 class="card-subtitle mb-3 text-muted">PRODUCTO MÁS POPULAR DEL AÑO</h6>
                                <%
                                if(productoMasVendido != null) {%>
                                <h4 class="card-title text-center fw-bold m-0"><%= productoMasVendido.getNombreProducto() %></h4>
                                <p class="card-text text-center text-success fw-bold">
                                    <span class="fs-1"><%= productoMasVendido.getTotalVenta() %></span>
                                    <span class="fs-5">‎ ventas</span>
                                </p>
                                <% } else { %>
                                No se encontró ningún producto popular.
                                <% } %>
                            </div>
                        </div>
                    </div>
                </section>

                <section class="row justify-content-between">
                    <div class="col-sm-4 my-3">
                        <div class="card border-0 shadow">
                            <div class="card-body bg-white rounded-3">
                                <h6 class="card-subtitle mb-3 text-muted">CLIENTES REGISTRADOS EN EL SISTEMA</h6>
                                <h4 class="card-title text-center fw-bold m-0">Clientes con Cuentas</h4>
                                <p class="card-text text-center text-info fw-bold">
                                    <span class="fs-1"><%= ClientesRegistrados %></span>
                                </p>
                            </div>
                        </div>
                    </div>

                    <div class="col-sm-4 my-3">
                        <div class="card border-0 shadow">
                            <div class="card-body bg-white rounded-3">
                                <h6 class="card-subtitle mb-3 text-muted">VENTAS DE CLIENTES INVITADOS</h6>
                                <h4 class="card-title text-center fw-bold m-0">Pedidos por Invitados</h4>
                                <p class="card-text text-center text-info fw-bold">
                                    <span class="fs-1"><%= PedClientesInvitados %></span>
                                </p>
                            </div>
                        </div>
                    </div>

                    <div class="col-sm-4 my-3">
                        <div class="card border-0 shadow">
                            <div class="card-body bg-white rounded-3">
                                <h6 class="card-subtitle mb-3 text-muted">VENTAS DE CLIENTES REGISTRADOS</h6>
                                <h4 class="card-title text-center fw-bold m-0">Pedidos por Registrados</h4>
                                <p class="card-text text-center text-info fw-bold">
                                    <span class="fs-1"><%= PedClientesRegistrados %></span>
                                </p>
                            </div>
                        </div>
                    </div>
                </section>

                <section class="row text-center">
                    <div class="col-sm-12 my-3">
                        <div class="card border-0 shadow">
                            <div class="card-body bg-white rounded-3">
                                <h4 class="card-title text-center fw-bold mb-3">Cantidad de Pedidos por Fechas</h4>
                                <form action="${pageContext.request.contextPath}/controlReportes" method="POST" class="mb-3 px-5 d-flex justify-content-center">
                                    <input type="date" name="fechaPedido" class="form-control mx-2">

                                    <input type="submit" value="Buscar" class="btn btn-primary py-1 mx-2">
                                </form>

                                <% if(cantidadPedidosValue !=  0) { %>
                                <p class="fw-bold">
                                    <span class="fs-4">Fecha: </span>
                                    <span class="fs-4 text-warning"><%= fecha != null ? fecha : "-"%></span><br>

                                    <span class="fs-4">Cantidad: </span>
                                    <span class="fs-4 text-warning"><%= cantidadPedidosValue %></span>
                                </p>
                                <% } else { %>
                                <p class="fw-bold">
                                    <span class="fs-4">Fecha: </span>
                                    <span class="fs-4 text-warning"><%= fecha != null ? fecha : "-"%></span><br>

                                    <span class="fs-4">Cantidad: </span>
                                    <span class="fs-4 text-warning"><%= cantidadPedidosValue %></span>
                                </p>
                                <% } %>
                            </div>
                        </div>
                    </div>
                </section>

                <section class="text-center my-3">
                    <%-- Impresion de Errores --%>
                    <c:if test="${empty list}">
                        <p class="mt-4">No hay productos disponibles.</p>
                    </c:if>
                    <%-- --%>

                    <%-- TABLA GENERAL --%>
                    <c:if test="${not empty list}">
                        <h4 class="fw-bold mb-3">Estado del Inventario</h4> 

                        <div class="table-responsive-md">
                            <table class="table table-bordered container" border="1">
                                <thead class="table-dark">
                                    <tr>
                                        <th>ID</th>
                                        <th>NOMBRE</th>
                                        <th>STOCK</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${list}" var="prod">
                                        <tr>
                                            <td>${prod.getIdProducto()}</td>
                                            <td>${prod.getNombre()}</td>
                                            <td>${prod.getStock()}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:if>
                </section>
            </article>
        </main>

        <footer class="footer mt-auto py-3">
            <div class="container">
                <p class="m-0">Copyright@Todos los derechos reservados | Sistema Mammamía</p>
            </div>
        </footer>
    </body>
</html>
