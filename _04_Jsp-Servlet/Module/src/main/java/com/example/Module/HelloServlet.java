package com.example.Module;

import service.ICategoryService;
import service.impl.CategoryService;

import java.io.*;
import javax.inject.Inject;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet(urlPatterns = {"/trang-chu"})
public class HelloServlet extends HttpServlet {
    private ICategoryService categoryService;
    public HelloServlet(){
        categoryService = new CategoryService();
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        request.setAttribute("categoryList",categoryService.findAll());


        RequestDispatcher requestDispatcher=request.getRequestDispatcher("/views/list.jsp");
        requestDispatcher.forward(request,response);



    }


}