package ex02;

public class Teacher extends Person{
    private int Salary;

    public Teacher(int salary) {
        Salary = salary;
    }

    public Teacher(String name, int age, String address, int salary) {
        super(name, age, address);
        Salary = salary;
    }

    public int getSalary() {
        return Salary;
    }

    public void setSalary(int salary) {
        Salary = salary;
    }

    @Override
    public String toString() {
        return super.toString()+"Teacher{" +
                "Salary=" + Salary +
                '}';
    }
}