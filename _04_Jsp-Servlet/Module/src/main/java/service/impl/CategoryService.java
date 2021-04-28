package service.impl;

import dao.ICategoryDao;
import dao.impl.CategoryDao;
import model.CategoryModel;
import service.ICategoryService;

import javax.inject.Inject;
import java.util.List;

public class CategoryService implements ICategoryService {

    private ICategoryDao iCategoryDao;
    public CategoryService(){
        iCategoryDao = new CategoryDao();
    }
    @Override
    public List<CategoryModel> findAll() {
        return iCategoryDao.findAll();
    }
}
