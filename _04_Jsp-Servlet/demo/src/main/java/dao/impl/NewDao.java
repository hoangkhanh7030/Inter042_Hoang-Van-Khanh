package dao.impl;

import dao.INewDao;
import model.CategoryModel;
import model.NewModel;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class NewDao implements INewDao {
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
    public List<NewModel> findNewsByCategoryId(Long categoryId) {
        List<NewModel> result = new ArrayList<>();
        String sql ="SELECT * FROM news WHERE categoryid = ?";
        Connection connection = getConnection();
        PreparedStatement statement = null;
        ResultSet resultSet=null;
        if(connection!= null){
            try {
                statement = connection.prepareStatement(sql);
                statement.setLong(1,categoryId);
                resultSet= statement.executeQuery();
                while (resultSet.next()){
                    NewModel newModel = new NewModel();
                    newModel.setId(resultSet.getLong("id"));
                    newModel.setTitle(resultSet.getString("title"));

                    result.add(newModel);
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

