package ex02;

import java.util.Scanner;

public class a {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        GIA[] gias = GIA.values();
        int n=0;
        int number =0;
        while (true){
            System.out.println("====================MENU=================");
            System.out.println("                  1.Cafe");
            System.out.println("                  2.Cam Vắt");
            System.out.println("                  3.Nước ép Cà rốt");
            System.out.println("                  4.Nước ép Cà Chua");
            System.out.println("                  5.Nước Lọc");
            System.out.println("                  6.Nước dừa");
            System.out.println("                  7.Thoát Gọi Món");
            System.out.println("========================================");
            System.out.println("Nhập Thức Uống muốn gọi");
             n = sc.nextInt();
            switch (n){
                case 1:
                    System.out.println("Giá của Cafe là :" + gias[n-1].getValue() + "K");
                    System.out.println("--------------------");
                    System.out.println("Nhập Số Lượng Muốn Mua");
                     number = sc.nextInt();
                    System.out.println("--------------------");
                    System.out.println("Tổng Tiền là :" + gias[n-1].getValue()*number + "K");
                    break;
                case 2:
                    System.out.println("Giá của Cam Vắt là :" + gias[n-1].getValue() + "K");
                    System.out.println("--------------------");
                    System.out.println("Nhập Số Lượng Muốn Mua");
                    number = sc.nextInt();
                    System.out.println("--------------------");
                    System.out.println("Tổng Tiền là :" + gias[n-1].getValue()*number + "K");
                    break;
                case 3:
                    System.out.println("Giá của Nước Ép Cà RỐt là :" + gias[n-1].getValue() + "K");
                    System.out.println("--------------------");
                    System.out.println("Nhập Số Lượng Muốn Mua");
                    number = sc.nextInt();
                    System.out.println("--------------------");
                    System.out.println("Tổng Tiền là :" + gias[n-1].getValue()*number + "K");
                    break;
                case 4:
                    System.out.println("Giá của Nước Ép Cà Chua là :" + gias[n-1].getValue() + "K");
                    System.out.println("--------------------");
                    System.out.println("Nhập Số Lượng Muốn Mua");
                    number = sc.nextInt();
                    System.out.println("--------------------");
                    System.out.println("Tổng Tiền là :" + gias[n-1].getValue()*number + "K");
                    break;
                case 5:
                    System.out.println("Giá của Nước Dừa là :" + gias[n-1].getValue() + "K");
                    System.out.println("--------------------");
                    System.out.println("Nhập Số Lượng Muốn Mua");
                    number = sc.nextInt();
                    System.out.println("--------------------");
                    System.out.println("Tổng Tiền là :" + gias[n-1].getValue()*number + "K");
                    break;
                case 6:
                    System.out.println("Giá của nước Lọc là :" + gias[n-1].getValue() + "K");
                    System.out.println("--------------------");
                    System.out.println("Nhập Số Lượng Muốn Mua");
                    number = sc.nextInt();
                    System.out.println("--------------------");
                    System.out.println("Tổng Tiền là :" + gias[n-1].getValue()*number + "K");
                    break;
                case 7:
                    System.exit(0);
            }
        }
    }


}
enum GIA{
    CAFE("10"),
    CAM("20"),
    CAROT("15"),
    CACHUA("12"),
    LOC("5"),
    DUA("14");
    private String value;
    private GIA(String value){
        this.value=value;
    }
    public int getValue(){
        return Integer.parseInt(value);
    }
}
