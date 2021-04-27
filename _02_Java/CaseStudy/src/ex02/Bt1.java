package ex02;

import java.util.Scanner;

public class Bt1 {
    public static void main(String[] args) {
        int[] a = {1,2,3,4};
        int result=0;
        int[] b = new int[a.length];
        for (int i=0;i<a.length;i++){
             result += a[i];
            b[i]=result;
        }
        for (int j=0;j<a.length;j++){
            System.out.println(b[j]);
        }

    }


}
