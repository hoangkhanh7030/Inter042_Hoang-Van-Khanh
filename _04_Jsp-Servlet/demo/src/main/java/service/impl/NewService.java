package service.impl;

import model.NewModel;
import service.INewService;

import javax.inject.Inject;
import java.util.List;

public class NewService implements INewService {
    @Inject
    private INewService newService;
    @Override
    public List<NewModel> findNewsByCategoryId(Long categoryId) {
        return newService.findNewsByCategoryId(categoryId);
    }
}
