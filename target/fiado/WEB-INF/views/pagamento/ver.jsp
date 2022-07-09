<%@page import="java.text.NumberFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="src.main.java.modelo.Pagamento" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.time.format.DateTimeFormatter" %>
<% pageContext.setAttribute("localDateTimeFormat", DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm")); %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

	<!-- botão que ativa modal nova pagamento -->
	<div class="position-relative w-50 mx-auto mt-5">
		<button 
			type="button" 
			class="btn btn-success rounded-circle  position-absolute bottom-0 end-0 mb-3" 
			data-bs-toggle="modal" 
			data-bs-target="#newPagamento">
			+
		</button>
	</div>

	<ul class="list-group w-50 mx-auto mt-5">
		<c:forEach items="${pagamentos}" var="pagamentos">
			<li class="list-group-item d-flex justify-content-between align-items-center">
				
				<p>R$ <c:out value=" ${pagamentos.valorPago}"/></p>

				<c:forEach items="${pagamentos.compras}" var="compras">
					<p> Compra: <c:out value=" ${compras.idCompra}"/></p>
				</c:forEach>

				<p><c:out value=" ${localDateTimeFormat.format(pagamentos.dataPagto)}"/></p>
				

				<div class="d-flex gap-3">
					<a type="button" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#editaPagamento${pagamentos.dataPagto}"> <!-- USA O ID DO PAGAMENTO MANO -->
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
							<path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"></path>
							<path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z"></path>
						</svg>
					</a>
					<a type="button" class="btn btn-outline-danger" href="/fiado/pagamentos/altera?id=${pagamentos.dataPagto}"> <!-- USA O ID DO PAGAMENTO MANO -->
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-dash-circle-fill" viewBox="0 0 16 16">
							<path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM4.5 7.5a.5.5 0 0 0 0 1h7a.5.5 0 0 0 0-1h-7z"/>
						</svg>
					</a>
				</div>
			</li>
		</c:forEach>
	</ul>

	<!-- Modal nova pagamento -->
	<div class="modal fade" id="newPagamento" tabindex="-1" aria-labelledby="modal de novo pagamento" aria-hidden="true">
		<div class="modal-dialog">
		<div class="modal-content">

			<div class="modal-header">
			<h5 class="modal-title">Nova pagamento</h5>
			<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>

			<div class="modal-body">
				<form action="/fiado/pagamentos" method="post">
					<div class="mb-3">
						<label for="valor" class="form-label">valor pago</label>
						<input type="number" step="0.01" class="form-control" id="valor" name="valor" min="0.01">
					</div>
					<div class="mb-3">
						<label for="idcompra" class="form-label">ID da compra referente</label>
						<input type="number" class="form-control" id="idcompra" name="idcompra" min="1">
					</div>
					<button type="submit" class="btn btn-success">Submit</button>
				</form>
			</div>

			<div class="modal-footer">
			<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
			</div>
		</div>
		</div>
	</div>
