import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;

public class Main {

    // Colores de letra
    static String red="\033[31m";
    static String green="\033[32m";
    static String yellow="\033[33m";
    static String purple="\033[35m";
    static String cyan="\033[36m";
    // Reset
    static String reset="\u001B[0m";

    public static void main(String... args) throws IOException {
        Tabla viveros = new TablaViveros(new File("viveros.csv"));
        Tabla empleados = new TablaEmpleados(new File("empleados.csv"));
        Tabla plantas = new TablaPlantas(new File("plantas.csv"));
          
        viveros.saveTable();
        empleados.saveTable();
        plantas.saveTable();


        int opc;
        Scanner in = new Scanner(System.in);
        System.out.println(purple + "\n\t*** BIENVENIDO ***" + reset);
        boolean excep;
        boolean repetir;
        do {
            repetir = false;
            excep = false;
            try {
                System.out.println("\n\t\t*** Menu ***");
                System.out.println("--------------------------------------------");
                System.out.println("1. Tabla de Viveros.");
                System.out.println("2. Tabla de Empleados.");
                System.out.println("3. Tabla de Plantas.");
                System.out.println("--------------------------------------------");
                System.out.println("Ingresa una opción del menu: ");
                opc = in.nextInt();

                switch (opc) {
                    // Viveros
                    case 1:
                        //Agregar para que en opciones maneje con la tabla viveros
                        opciones("Viveros");
                        break;
                    // Empleados
                    case 2:
                        //Agregar para que en opciones maneje con la tabla empleados
                        opciones("Empleados");
                        break;
                    // Plantas
                    case 3:
                        //Agregar para que en opciones maneje con la tabla plantas
                        opciones("Plantas");
                        break;
                    // Cuando ingrese un número pero no sea alguna opción
                    default:
                        System.out.println(yellow + "\n\tElige una opcion de menu plis :c" + reset);
                        repetir = true;
                        break;
                }
            } catch (Exception e) {
                System.out.println(red + "\n\tDebes ingresar un numero\tIntentalo de nuevo" + reset);
                in.next();
                excep = true;
            }
        } while (excep || repetir);    
    }

    /**
     * Función que despliega las opciones de las modificaciones que se pueden hacer en las distintas tablas.
     * @param tabla - Recibe un string para indicar en que tabla se va trabajar.
     */
    public static void opciones(String tabla){
        boolean repetir;
        boolean excep;
        int opc;
        Scanner in = new Scanner(System.in);
        do {
            repetir = false;
            excep = false;
            try {
                System.out.println("\n\t\t*** Menu ***");
                System.out.println( green + "Tabla: " + tabla + reset);
                System.out.println("--------------------------------------------");
                System.out.println("1. Agregar información.");
                System.out.println("2. Consultar información.");
                System.out.println("3. Editar información.");
                System.out.println("4. Eliminar información.");
                System.out.println("--------------------------------------------");
                System.out.println("Ingresa una opción del menu: ");
                opc = in.nextInt();

                switch (opc) {
                    // Agregar información
                    case 1:
                        //Agregar la función que agregue info pero conectarla con la tabla a trabajar
                        break;
                    // Consultar información
                    case 2:
                        //Agregar la función que consulte info pero conectarla con la tabla a trabajar
                        break;
                    // Editar información
                    case 3:
                        //Agregar la función que editar info pero conectarla con la tabla a trabajar
                        break;
                    // Eliminar información
                    case 4:
                        //Agregar la función que elimine info pero conectarla con la tabla a trabajar
                        break;
                    // Verificar si un elemento esta en la lista
                    default:
                        System.out.println(yellow + "\n\tElige una opcion de menu plis :c" + reset);
                        repetir = true;
                        break;
                }
            } catch (Exception e2) {
                System.out.println(red + "\n\tDebes ingresar un numero\tIntentalo de nuevo" + reset);
                in.next();
                excep = true;
            }
        } while (excep || repetir);
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
        arr.addAll(Arrays.asList(str.split("\\s*[-]\\s*")));
        return arr;
    }
}
