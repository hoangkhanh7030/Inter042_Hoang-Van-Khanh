package Ex01;

public class Bt1 {
    public static void main(String[] args) {
        tgr(8);
    }

    private static void hcn(int n,int m){
        for(int i=0;i<n;i++){
            for (int j=0;j<m;j++){
                if(i==0 ||i==n-1||j==0||j==m-1){
                    System.out.print("*");
                }
                else
                    System.out.print(" ");
            }
            System.out.println("");
        }

    }
    private static void htg(int h ){
        for(int i=0;i<=h;i++){
            for (int j=0;j<=h;j++){
                if(i==h||j==0||i==j){
                    System.out.print("*");
                }
                else
                    System.out.print(" ");
            }
            System.out.println("");
        }
    }
    private  static void tgc(int h){
        int m=(h*2)-1;
    for(int i=0;i<h;i++){
        for(int j=0;j<=m;j++){
            if(j<=(h-i)-1||j>=(h+i)+1){
                System.out.print(" ");
            }
            else
                System.out.print("*");
        }
        System.out.println("");
    }

    }
    private static void tgr(int h){
            int m=(h*2)-1;
            for(int i=1;i<=h;i++){
                for (int j =1;j<=m;j++){
                    if(j==(h+i)-1||j==(h-i)+1||i==h){
                        System.out.print("*");
                    }
                    else System.out.print(" ");
                }
                System.out.println("");
            }
    }
}
