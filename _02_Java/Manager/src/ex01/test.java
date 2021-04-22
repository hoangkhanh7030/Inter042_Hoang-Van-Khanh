package ex01;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

public class test {
    public static void main(String[] args) {






        Employee[] employees = {new Employee(2,"Hoàng","Khánh",5000),
                new Employee(3,"Hoàng","Khánh",5000),
                new Employee(4,"Hoàng","Khánh",5000),
                new Employee(5,"Hoàng","Khánh",5000),
                new Employee(6,"Hoàng","Khánh",5000),
                new Employee(7,"Hoàng","Khánh",5000),
                new Employee(8,"Hoàng","Khánh",5000),
                new Employee(9,"Hoàng","Khánh",5000),
                new Employee(10,"Hoàng","Khánh",5000),
                new Employee(1,"Hoàng","Khánh",5000)};





        List<Employee> list = Arrays.asList(employees);

        list = list.stream().sorted((a,b)->a.getId()-b.getId()).collect(Collectors.toList());
        list.forEach(System.out::println);
    }
}
