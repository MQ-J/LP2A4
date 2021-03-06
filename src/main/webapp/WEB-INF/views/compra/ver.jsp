<%@page import="java.text.NumberFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="src.main.java.modelo.Compra" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.time.ZoneId" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% pageContext.setAttribute("localDateTimeFormat", DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm")); %>


<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

	<!-- botão que ativa modal nova compra -->
	<div class="position-relative w-50 mx-auto mt-5">
		<button 
			type="button" 
			class="btn btn-success rounded-circle  position-absolute bottom-0 end-0 mb-3" 
			data-bs-toggle="modal" 
			data-bs-target="#newCompra">
			+
		</button>
	</div>

	<ul class="list-group w-50 mx-auto mt-5 gap-5">
		<c:forEach items="${compras}" var="compras" varStatus="loop">
			<li class="list-group-item d-flex flex-column">
				<h5 class="d-flex justify-content-between">
					<p><c:out value=" ${compras.cliente.nome}"/></p>
					<p>(<c:out value="${compras.idCompra}"/>) - <c:out value=" ${localDateTimeFormat.format(compras.dataCompra)}"/></p>
					

					<div class="d-flex gap-3">
						<a type="button" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#editaCompra${compras.idCompra}">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
								<path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"></path>
								<path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5v11z"></path>
							</svg>
						</a>
						<a type="button" class="btn btn-outline-danger" href="/fiado/compras/altera?id=${compras.idCompra}">
							<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-dash-circle-fill" viewBox="0 0 16 16">
								<path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0zM4.5 7.5a.5.5 0 0 0 0 1h7a.5.5 0 0 0 0-1h-7z"/>
							</svg>
						</a>
					</div>
				</h5>

				<c:choose>
					<c:when test="${compras.valorPendente == 0 && compras.pagamentos!=null}">
						<p class="badge bg-success rounded-pill">OK</p>
					</c:when>
					<c:otherwise>
						<p class="badge bg-primary rounded-pill">Valor pendente: <c:out value=" ${compras.valorPendente}"/></p>
					</c:otherwise>
				</c:choose>
				
				<c:forEach items="${compras.produtos}" var="produtos">
					<p><c:out value=" ${produtos.nome}"/> - R$ <c:out value="${produtos.valor}"/></p>
				</c:forEach>
				
				<c:choose>
					<c:when test="${compras.pagamentos==null}">
						<p class="bg-warning rounded-pill w-25">não há pagamentos</p>
					</c:when>    
					<c:otherwise>
						<c:forEach items="${compras.pagamentos}" var="pagamentos">
							<p class="bg-success rounded-pill w-25">Valor pago: R$<c:out value=" ${pagamentos.valorPago}"/></p>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</li>

			<!-- Modal editar compra -->
			<div class="modal fade" id="editaCompra${compras.idCompra}" tabindex="-1" aria-labelledby="modal de nova compra" aria-hidden="true">
				<div class="modal-dialog">
				<div class="modal-content">

					<div class="modal-header">
					<h5 class="modal-title">Editar Compra</h5>
					<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>

					<div class="modal-body">
						<form action="/fiado/compras/altera" method="post">
							<div class="mb-3">
								<label for="idProd" class="form-label">ID Produto</label>
								<c:forEach items="${compras.produtos}" var="produtos">
									<input type="number" class="form-control" id="idProd" name="idProd" min="1" value="${produtos.id}"> <!-- quando tiver vários produtos por compra, troca o ID e NAME daqui -->
								</c:forEach>
							</div>
							<div class="mb-3">
								<label for="cpf" class="form-label">CPF</label>
								<input type="text" class="form-control" id="cpf" name="cpf" pattern="[0-9]{11}" value="${compras.cliente.cpf}">
							</div>
							<div class="mb-3">
								<label for="valor" class="form-label">valor pendente</label>
								<input type="number" step="0.01" class="form-control" id="valor" name="valor" min="0" value="${compras.valorPendente}">
							</div>

							<input type="text" class="form-control" id="id" name="id" value="${compras.idCompra}" hidden>

							<button type="submit" class="btn btn-success">Submit</button>
						</form>
					</div>

					<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
					</div>
				</div>
				</div>
			</div>
		</c:forEach>
	</ul>
  
	<!-- Modal nova compra -->
	<div class="modal fade" id="newCompra" tabindex="-1" aria-labelledby="modal de nova compra" aria-hidden="true">
		<div class="modal-dialog">
		<div class="modal-content">

			<div class="modal-header">
			<h5 class="modal-title">Nova Compra</h5>
			<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			</div>

			<div class="modal-body">
				<form action="/fiado/compras" method="post">
					<div class="mb-3">
						<label for="idProd" class="form-label">ID Produto</label>
						<input type="number" class="form-control" id="idProd" name="idProd" min="1">
					</div>
					<div class="mb-3">
						<label for="cpf" class="form-label">CPF</label>
						<input type="text" class="form-control" id="cpf" name="cpf" pattern="[0-9]{11}">
					</div>
					<div class="mb-3">
						<label for="valor" class="form-label">valor pendente</label>
						<input type="number" step="0.01" class="form-control" id="valor" name="valor" min="0">
					</div>
					<div class="mb-3">
						<label for="idCompra" class="form-label">ID Compra</label>
						<input type="number" class="form-control" id="idCompra" name="idCompra" min="1">
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
