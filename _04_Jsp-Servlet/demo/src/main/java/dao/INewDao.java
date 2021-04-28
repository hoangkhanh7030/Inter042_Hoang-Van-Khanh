package dao;

import model.CategoryModel;
import model.NewModel;

import java.util.List;

public interface INewDao {
    List<NewModel> findNewsByCategoryId(Long categoryId);
}
