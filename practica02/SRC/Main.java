import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;

public class Main {
<<<<<<< HEAD
    public static void main(String... args) throws IOException {
        //try {
           // Tabla viveros = new Tabla(new File("viveros.csv"), "vivero");
           // Tabla empleados = new Tabla(new File("./archivos/empleados.csv"), "empleado");
          //  Tabla plantas = new Tabla(new File("./archivos/plantas.csv"), "planta");
      //  } catch( IOException io) {
            //PARA HACER
       // }
=======
    public static void main(String... args) {
        try {
            Tabla viveros = new Tabla(new File("./archivos/viveros.csv"), "vivero");
            Tabla empleados = new Tabla(new File("./archivos/empleados.csv"), "empleado");
            Tabla plantas = new Tabla(new File("./archivos/plantas.csv"), "planta");
        } catch( IOException io) {
            //PARA HACER
        }

>>>>>>> 3ff7dd55cb63145e033f8a9b7b27f1bad1e7c7c4

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
