package controlador;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import src.main.java.modelo.repositorio.ProdutoDAO;
import java.util.ArrayList;

import src.main.java.modelo.Produto;

import controlador.VerProdutoServlet;

import java.io.IOException;

public class ApagarProdutoServlet extends HttpServlet
{
	private static final long serialVersionUID = 1L;
       
    public ApagarProdutoServlet()
    {
        super();
    }
    
    protected void doGet(HttpServletRequest request,
    					 HttpServletResponse response) throws ServletException, IOException
    {

        ProdutoDAO fb = new ProdutoDAO();

        int id = Integer.parseInt(request.getParameter("id"));
        int produtos = fb.ApagarProdutos(id);

        VerProdutoServlet ver = new VerProdutoServlet();
        ver.doGet(request, response);
	}
}
