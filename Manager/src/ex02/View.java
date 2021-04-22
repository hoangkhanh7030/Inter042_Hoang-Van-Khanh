package ex02;

import java.util.Arrays;
import java.util.Comparator;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.stream.Collectors;

public class View {
    public static void main(String[] args) {
        Student[] students = {
                new Student("Khanh",29,"DakLak",2.3),
                new Student("Hoang",24,"Da Nang",2.3),
                new Student("Manh",24,"Hue",2.3),
                new Student("Trung",27,"Hue",2.3),
                new Student("Noi",28,"Nghe AN",2.3)
        };

        Teacher[] teachers = {
                new Teacher("Ngoc",24,"DakLak",2000),
                new Teacher("Tram",22,"DakLak",4000),
                new Teacher("Linh",30,"DakLak",3000),
                new Teacher("Huyen",34,"DakLak",1000),
                new Teacher("Trang",40,"DakLak",5000),

        };

        List<Student> studentList= Arrays.asList(students);
        List<Teacher> teacherList= Arrays.asList(teachers);

        System.out.println("Thong tin 5 Student");
        studentList.forEach(System.out::println);
        System.out.println("==============================================================");
        System.out.println("Thong tin 5 Teacher");
        teacherList.forEach(System.out::println);
        System.out.println("==============================================================");
        System.out.println("Top 3 Teacher luong cao nhat");
        teacherList = teacherList.stream().
                sorted((a,b)->b.getSalary()-a.getSalary()).
                limit(3).
                collect(Collectors.toList());
        teacherList.forEach(System.out::println);
        System.out.println("==============================================================");
        System.out.println("Student co do tuoi nho nhat");
        studentList = studentList.stream().sorted((a,b)->a.getAge()-b.getAge()).collect(Collectors.toList());
        final int age = studentList.get(1).getAge();
       List<Student> lis = studentList.stream().filter(a-> a.getAge()==age).collect(Collectors.toList());
        lis.forEach(System.out::println);



    }
}
