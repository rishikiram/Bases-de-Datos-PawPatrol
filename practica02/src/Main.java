import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Scanner;
import java.util.regex.Pattern;

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
        Tabla viveros = new TablaViveros(new File("src/viveros.csv"));
        Tabla empleados = new TablaEmpleados(new File("src/empleados.csv"));
        Tabla plantas = new TablaPlantas(new File("src/plantas.csv"));
          
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
                        opciones(viveros);
                        break;
                    // Empleados
                    case 2:
                        //Agregar para que en opciones maneje con la tabla empleados
                        opciones(empleados);
                        break;
                    // Plantas
                    case 3:
                        //Agregar para que en opciones maneje con la tabla plantas
                        opciones(plantas);
                        break;
                    // Cuando ingrese un número pero no sea alguna opción
                    default:
                        System.out.println(yellow + "\n\tElige una opcion de menu :c" + reset);
                        repetir = true;
                        break;
                }
            } catch (Exception e) {
                System.out.println(red + "\n\tDebes ingresar un numero\tIntentalo de nuevo" + reset);
                in.next();
                excep = true;
            }
        } while (excep || repetir);    
        in.close();
    }

    /**
     * Función que despliega las opciones de las modificaciones que se pueden hacer en las distintas tablas.
     * @param tabla - Recibe un string para indicar en que tabla se va trabajar.
     */
    public static void opciones(Tabla tabla){
        boolean repetir;
        boolean excep;
        int opc;
        Scanner in = new Scanner(System.in);
        do {
            repetir = false;
            excep = false;
            try {
                System.out.println("\n\t\t*** Menu ***");
                System.out.println( green + "Tabla: " + tabla.getNombre() + reset);
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
                        tabla.addEntidad();
                        break;
                    // Consultar información
                    case 2:
                        tabla.mostrarEntidades();
                        break;
                    // Editar información
                    case 3:
                        tabla.editEntidad(setLlave());
                        break;
                    // Eliminar información
                    case 4:
                        tabla.deleteEntidad(setLlave());
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
        in.close();
        try{
            tabla.saveTable();
        }catch(IOException e){
            System.out.println("No se pudo guardar la tabla en el archivo");
        }
        
    }

    /**
     * Función para pedir al usuario la llave con la que se buscará en la tabla y haremos la modificación
     * @return la llave de busqueda
     */
    public static int setLlave(){
        int llave;
        Scanner scanner = new Scanner(System.in);

        System.out.println("Ingresa la llave:");
        llave = scanner.nextInt();

        return llave;
    }

    /**
     * Convierte un ArrayList<String> a un String de formato
     * "cosa1 - cosa2 - cosa3 - ...
     * @param arr       array de strings(como multivaluados)
     * @return      string de formato: "cosa1 - cosa2 - cosa3 - ..."
     * */
    public static String arrayListToString(ArrayList<String> arr) {
        StringBuilder rstr = new StringBuilder();
        for (String s: arr) {
            rstr.append(s);
            rstr.append(" - ");
        }
        rstr.delete(rstr.length()-3, rstr.length());
        return rstr.toString();
    }
    /**
     * Convierte un String que arrayListToString() returns
     * a un ArrayList<String> seperado de " - "
     * @param str       string de arrayListToString()
     * @return          ArrayList split de los " - "
     * */
    public static ArrayList<String> stringToArrayList(String str) {
        ArrayList<String> arr = new ArrayList<>();
        arr.addAll(Arrays.asList(str.split("\\s*[-]\\s*")));
        return arr;
    }
    public static boolean esTelefonoValido(String s){
        String patron=  "^(\\+\\d{1,3}( )?)?((\\(\\d{1,3}\\))|\\d{1,3})[- .]?\\d{3,4}[- .]?\\d{4}$"; // https://stackoverflow.com/questions/42104546/java-regular-expressions-to-validate-phone-numbers
        if(s==null || s.isEmpty()){
            return false;
        }
        return Pattern.compile(patron).matcher(s).matches();
    }
    public static boolean esCorreoValido(String s){
        String patron=  "^[\\w!#$%&'*+/=?`{|}~^-]+(?:\\.[\\w!#$%&'*+/=?`{|}~^-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,6}$";// https://howtodoinjava.com/java/regex/java-regex-validate-email-address/
        if(s==null || s.isEmpty()){
            return false;
        }
        return Pattern.compile(patron).matcher(s).matches();
    }
}
