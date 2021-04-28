package dao.impl;

import dao.ICategoryDao;
import model.CategoryModel;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoryDao implements ICategoryDao {
    public Connection getConnection(){
        try {
            Class.forName("com.mysql.jdbc.Driver");
            String url ="jdbc:mysql://localhost:3306/newservlet";
            String user="root";
            String password="123456";
            return DriverManager.getConnection(url,user,password);
        }
        catch (ClassNotFoundException | SQLException e){
            return  null;
        }

    }

    @Override
    public List<CategoryModel> findAll() {
        List<CategoryModel> result = new ArrayList<>();
        String sql ="SELECT * FROM category";
        Connection connection = getConnection();
        PreparedStatement statement = null;
        ResultSet resultSet=null;
        if(connection!= null){
            try {
                statement = connection.prepareStatement(sql);
                resultSet= statement.executeQuery();
                while (resultSet.next()){
                    CategoryModel categoryModel= new CategoryModel();
                    categoryModel.setId(resultSet.getLong("id"));
                    categoryModel.setCode(resultSet.getString("code"));
                    categoryModel.setName(resultSet.getString("name"));
                    result.add(categoryModel);
                }

                return result;
            } catch (SQLException throwables) {
                return null;
            }finally {
                try {
                    if (connection != null){
                        connection.close();
                    }if (statement!=null){
                        statement.close();
                    }if(resultSet != null){
                        resultSet.close();
                    }
                }catch (SQLException e){
                    return null;
                }
            }
        }
        return null;


    }
}
