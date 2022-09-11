import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;

public class Main {

    public static void main(String... args) throws IOException {
            Tabla viveros = new Tabla(new File("viveros.csv"), "vivero");
            Tabla empleados = new Tabla(new File("empleados.csv"), "empleado");
            Tabla plantas = new Tabla(new File("plantas.csv"), "planta");
          
            viveros.saveTable();
            empleados.saveTable();
            plantas.saveTable();
        
    }


    public static String arrayListToString(ArrayList<String> arr) {
        StringBuilder rstr = new StringBuilder();
        for (String s: arr) {
            rstr.append(s);
            rstr.append(" - ");
        }
        rstr.delete(rstr.length()-3, rstr.length());
        return rstr.toString();
    }
    public static ArrayList<String> stringToArrayList(String str) {
        ArrayList<String> arr = new ArrayList<>();
        arr.addAll(Arrays.asList(str.split("/s[-]/s")));
        return arr;
    }
}
