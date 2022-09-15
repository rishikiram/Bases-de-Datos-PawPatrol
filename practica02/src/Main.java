import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.InputMismatchException;
import java.util.Scanner;
import java.util.regex.Pattern;

public class Main {

    // Colores de letra
    static String red="\033[31m";
    static String green="\033[32m";
    static String yellow="\033[33m";
    static String purple="\033[35m";
    // Reset
    static String reset="\u001B[0m";

    public static void main(String... args) throws IOException {
        Tabla viveros = new TablaViveros(new File("archivos-generados/viveros.csv"));
        Tabla empleados = new TablaEmpleados(new File("archivos-generados/empleados.csv"));
        Tabla plantas = new TablaPlantas(new File("archivos-generados/plantas.csv"));

        int opc;
        int exit;
        boolean confirm;
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
                opc = Main.readInt(in);
                clearScreen();
                switch (opc) {
                    // Viveros
                    case 1:
                        //Agregar para que en opciones maneje con la tabla viveros
                        opciones(viveros);
                        confirm = true;
                        break;
                    // Empleados
                    case 2:
                        //Agregar para que en opciones maneje con la tabla empleados
                        opciones(empleados);
                        confirm = true;
                        break;
                    // Plantas
                    case 3:
                        //Agregar para que en opciones maneje con la tabla plantas
                        opciones(plantas);
                        confirm = true;
                        break;
                    // Cuando ingrese un número pero no sea alguna opción
                    default:
                        System.out.println(yellow + "\n\tElige una opción de menu :c" + reset);
                        repetir = true;
                        confirm = false;
                        break;
                }
                while(confirm){
                    System.out.println("¿Deseas hacer alguna otra modificación en las tablas?");
                    System.out.println("1. Si");
                    System.out.println("2. No");
                    exit = Main.readInt(in);
                    if (exit == 1) {
                        confirm = false;
                        repetir = true;
                        clearScreen();
                    } else if (exit == 2) {
                        System.exit(0);
                    } else {
                        System.out.println(yellow + "Ingresa una opción del menú." + reset);
                        confirm = true;
                    }
                }
            } catch (Exception e) {
                System.out.println(red + "\n\tDebes ingresar un numero\tIntentalo de nuevo" + reset);
                e.printStackTrace();
                excep = true;
            }
        } while (excep || repetir);    
    }

    /**
     * Función que despliega las opciones de las modificaciones que se pueden hacer en las distintas tablas.
     * @param tabla - Recibe un string para indicar en que tabla se va trabajar.
     */
    public static void opciones(Tabla tabla){
        boolean repetir;
        boolean excep;
        boolean edit = false;
        int opc;
        int exit;
        Scanner in = new Scanner(System.in);
        do {
            do {
                repetir = false;
                excep = false;
                try {
                    System.out.println("\n\t\t*** Menu ***");
                    System.out.println(green + "Tabla: " + tabla.getNombre() + reset);
                    System.out.println("--------------------------------------------");
                    System.out.println("1. Agregar información.");
                    System.out.println("2. Consultar información.");
                    System.out.println("3. Editar información.");
                    System.out.println("4. Eliminar información.");
                    System.out.println("--------------------------------------------");
                    System.out.println("Ingresa una opción del menu: ");
                    opc = Main.readInt(in);
                    clearScreen();
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
                        case 4 :
                            tabla.deleteEntidad(setLlave());
                            break;
                        //Si no ingresa alguna opcion del menú
                        default:
                            System.out.println(yellow + "\n\tElige una opción de menu :c" + reset);
                            repetir = true;
                            break;
                    }
                } catch (Exception e2) {
                    System.out.println(red + "\n\tDebes ingresar un numero\tIntentalo de nuevo" + reset);
                    e2.printStackTrace();
                    excep = true;
                }
            } while (excep || repetir);
            try {
                tabla.saveTable();
            } catch (IOException e) {
                System.out.println("No se pudo guardar la tabla en el archivo");
            }
            do{
                try {
                    System.out.println("¿Deseas hacer alguna modificación en esta tabla?");
                    System.out.println("1. Si");
                    System.out.println("2. No");
                    exit = Main.readInt(in);
                    if (exit == 1) {
                        clearScreen();
                        edit = true;
                        repetir = false;
                    } else if (exit == 2) {
                        edit = false;
                        repetir = false;
                        clearScreen();
                    } else {
                        System.out.println(yellow + "Ingresa una opción del menú." + reset);
                        repetir = true;
                        edit = false;
                    }
                }catch (InputMismatchException e){
                    System.out.println(red + "Ingresa únicamente números." + reset);
                    repetir = true;
                }
            }while(repetir);
        }while(edit);
    }

    /**
     * Función para pedir al usuario la llave con la que se buscará en la tabla y haremos la modificación
     * @return la llave de búsqueda
     */
    public static int setLlave(){
        int llave;
        Scanner scanner = new Scanner(System.in);

        System.out.println("Ingresa la llave:");
        llave = Main.readInt(scanner);

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

    /**
     * Indica si una cadena es un teléfono válido
     * @param s La cadena
     * @return Un booleano que indica si una cadena es un teléfono válido
     */
    public static boolean esTelefonoValido(String s){
        String patron=  "^(\\+\\d{1,3}( )?)?((\\(\\d{1,3}\\))|\\d{1,3})[- .]?\\d{3,4}[- .]?\\d{4}$"; // https://stackoverflow.com/questions/42104546/java-regular-expressions-to-validate-phone-numbers
        if(s==null || s.isEmpty()){
            return false;
        }
        return Pattern.compile(patron).matcher(s).matches();
    }

    /**
     * Indica si una cadena es una representación válida de una fecha en formato dd/mm/aaaa
     * @param s La cadena
     * @return Un booleano que indica si una cadena es una fecha válida
     */
    public static boolean esFechaValida(String s){
        String patron=  "^([0-2][0-9]||3[0-1])/(0[0-9]||1[0-2])/([0-9][0-9])?[0-9][0-9]$"; // https://stackoverflow.com/questions/8283405/what-is-the-regular-expression-for-date-format-dd-mm-yyyy
        if(s==null || s.isEmpty()){
            return false;
        }
        return Pattern.compile(patron).matcher(s).matches();
    }

    /**
     * Indica si una cadena es una representación válida de un correo electrónico
     * @param s La cadena
     * @return Un booleano que indica si una cadena es un correo electrónico válido
     */
    public static boolean esCorreoValido(String s){
        String patron=  "^[\\w!#$%&'*+/=?`{|}~^-]+(?:\\.[\\w!#$%&'*+/=?`{|}~^-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,6}$";// https://howtodoinjava.com/java/regex/java-regex-validate-email-address/
        if(s==null || s.isEmpty()){
            return false;
        }
        return Pattern.compile(patron).matcher(s).matches();
    }

    /**
     * Recibe del usuario número entero hasta que la entrada, en efecto, sea un entero.
     * @param sc El scanner
     * @return el número ingresado
     */
    public static int readInt(Scanner sc){
        Integer entrada=null;
        do{
            try{
                String line = sc.nextLine();
                entrada = Integer.parseInt(line);
            }catch(NumberFormatException e){
                System.out.println("Debes ingresar un número, favor de volver a intentar");
            }
        }while(entrada==null);
        return entrada;
    }

    /**
     * Método que limpia la consola dependiendo el sistema operativo.
     */
    public static void clearScreen(){
        try{
            String operatingSystem = System.getProperty("os.name");
            ProcessBuilder processBuilder;
            if(operatingSystem.contains("Windows")){
                processBuilder = new ProcessBuilder("cmd", "/c", "cls");
                Process startProcess = processBuilder.inheritIO().start();
                startProcess.waitFor();
            } else {
                processBuilder = new ProcessBuilder("clear");
                Process startProcess = processBuilder.inheritIO().start();
                startProcess.waitFor();
            }
        }catch(Exception e){
            System.out.println(e);
        }
    }
}
