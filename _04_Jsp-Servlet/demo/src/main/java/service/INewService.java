package service;

import model.NewModel;

import java.util.List;

public interface INewService {
    List<NewModel> findNewsByCategoryId(Long categoryId);
}
