package controller.web;

import service.ICategoryService;
import service.INewService;
import service.impl.CategoryService;

import javax.inject.Inject;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(urlPatterns = {"/trang-chu"})
public class HomeController extends HttpServlet {

    private ICategoryService categoryService;
    public HomeController(){
        categoryService = new CategoryService();
    }
    @Inject
    private INewService newService;


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.setAttribute("categoryList",categoryService.findAll());


        RequestDispatcher requestDispatcher=request.getRequestDispatcher("/views/categoryList.jsp");
        requestDispatcher.forward(request,response);
    }


    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
