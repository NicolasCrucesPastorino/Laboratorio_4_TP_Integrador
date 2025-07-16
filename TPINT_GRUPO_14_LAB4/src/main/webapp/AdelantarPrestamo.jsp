<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List" %>
<%@ page import="entidad.CuotaPrestamo" %>
<%@ page import="entidad.Prestamo" %>
<%@ page import="java.text.SimpleDateFormat" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Pagar prestamo</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <h2>Cuotas del Préstamo</h2>
    
    <%
        // Obtener el ID del préstamo del parámetro
        String idPrestamoParam = request.getParameter("id");
        String mensaje = request.getParameter("mensaje");
        
        // Obtener la lista de cuotas del request (debe ser enviada por el servlet)
        List<CuotaPrestamo> cuotas = (List<CuotaPrestamo>) request.getAttribute("cuotas");
        Prestamo prestamo = (Prestamo) request.getAttribute("prestamo");
        
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
        
        if (cuotas != null && prestamo != null) {
            // Calcular cuotas pagas
            int cuotasPagas = 0;
            for (CuotaPrestamo cuota : cuotas) {
                if ("Pagada".equals(cuota.getEstado())) {
                    cuotasPagas++;
                }
            }
            
            // Verificar si el préstamo está aprobado
            boolean prestamoAprobado = "Aprobado".equalsIgnoreCase(prestamo.getEstado());
    %>
    
    <% if ("exito".equals(mensaje)) { %>
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <h4 class="alert-heading">✅ ¡Pago Exitoso!</h4>
        <p>La cuota ha sido pagada correctamente.</p>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <% } else if ("error_prestamo".equals(mensaje)) { %>
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <h4 class="alert-heading">❌ Error</h4>
        <p>El préstamo no está aprobado. No se puede procesar el pago.</p>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <% } else if ("error_cuota".equals(mensaje)) { %>
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <h4 class="alert-heading">❌ Error</h4>
        <p>La cuota ya está pagada o no existe.</p>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <% } else if ("error".equals(mensaje)) { %>
    <div class="alert alert-danger alert-dismissible fade show" role="alert">
        <h4 class="alert-heading">❌ Error</h4>
        <p>Ocurrió un error al procesar el pago. Inténtelo nuevamente.</p>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
    <% } %>
    
    <% if (!prestamoAprobado) { %>
    <div class="alert alert-warning" role="alert">
        <h4 class="alert-heading">⚠️ Préstamo Pendiente de Aprobación</h4>
        <p>Este préstamo aún no ha sido aprobado por un administrador. No es posible adelantar pagos hasta que el préstamo sea aprobado.</p>
        <hr>
        <p class="mb-0"><strong>Estado actual:</strong> <span class="badge bg-warning"><%= prestamo.getEstado() %></span></p>
    </div>
    <% } %>
    
    <section class="table-responsive">
        <table id="tablaClientes" class="table table-striped table-hover">
            <thead class="table-dark">
                <tr>
                    <th>ID Cuota</th>
                    <th>Monto pedido</th>
                    <th>Monto total</th>
                    <th>Cuotas totales</th>
                    <th>Monto por cuota</th>
                    <th>Cuotas pagas</th>
                    <th>Estado</th>
                    <th>Fecha de pedido</th>
                    <th>Fecha de autorización</th>
                    <th>Adelantar pago</th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (CuotaPrestamo cuota : cuotas) {
                %>
                <tr>
                    <td><%= cuota.getId() %></td>
                    <td>$<%= String.format("%.2f", prestamo.getMontoPedido()) %></td>
                    <td>$<%= String.format("%.2f", prestamo.getMontoTotal()) %></td>
                    <td><%= prestamo.getCantidadCuotas() %></td>
                    <td>$<%= String.format("%.2f", cuota.getMontoCuota()) %></td>
                    <td><%= cuotasPagas %></td>
                    <td>
                        <% if ("Pagada".equals(cuota.getEstado())) { %>
                            <span class="badge bg-success"><%= cuota.getEstado() %></span>
                        <% } else if ("Pendiente".equals(cuota.getEstado())) { %>
                            <span class="badge bg-warning"><%= cuota.getEstado() %></span>
                        <% } else { %>
                            <span class="badge bg-secondary"><%= cuota.getEstado() %></span>
                        <% } %>
                    </td>
                    <td><%= prestamo.getFechaPedido() != null ? sdf.format(prestamo.getFechaPedido()) : "-" %></td>
                    <td><%= prestamo.getFechaAutorizacion() != null ? sdf.format(prestamo.getFechaAutorizacion()) : "-" %></td>
                    <td>
                        <% if (!prestamoAprobado) { %>
                            <span class="text-muted">Préstamo pendiente</span>
                        <% } else if (!"Pagada".equals(cuota.getEstado())) { %>
                            <form action="CuotaPrestamo" method="post" style="display: inline;">
                                <input type="hidden" name="accion" value="pagar">
                                <input type="hidden" name="idCuota" value="<%= cuota.getId() %>">
                                <input type="hidden" name="idPrestamo" value="<%= prestamo.getId() %>">
                                <input type="submit" class="btn btn-primary btn-sm" value="Pagar Cuota">
                            </form>
                        <% } else { %>
                            <span class="text-muted">Ya pagada</span>
                        <% } %>
                    </td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
    </section>
    
    <%
        } else {
    %>
    <div class="alert alert-warning" role="alert">
        <h4 class="alert-heading">No se encontraron cuotas</h4>
        <p>No se pudieron cargar las cuotas del préstamo. Verifique que el ID del préstamo sea correcto.</p>
        <hr>
        <p class="mb-0">ID de préstamo solicitado: <%= idPrestamoParam != null ? idPrestamoParam : "No especificado" %></p>
    </div>
    <%
        }
    %>
    
    <div class="mt-3">
        <a href="Prestamos?opcion=lista" class="btn btn-secondary">Volver a la lista de préstamos</a>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>