package dao;

import model.CategoryModel;

import java.util.List;

public interface ICategoryDao {
    List<CategoryModel> findAll();
}
