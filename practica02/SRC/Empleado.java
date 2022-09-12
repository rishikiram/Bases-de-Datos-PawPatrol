import java.util.ArrayList;

/**
 *
 * Clase que implementa un empleado del vivero los cuales almacenan
 * información relevante de cada uno
 *
 * @version 1.0 Septiembre 2022
 * @author Paw Patrols
 * @since Fundamentos de Bases de Datos
 *
 */

public class Empleado extends Entidad {

    /* Atributos */ 
    int llave;
    ArrayList<String> nombre;
    ArrayList<String> direccion;
    ArrayList<String> correos;
    ArrayList<String> telefonos;
    String fechaNacimiento;
    int salario;
    String rol;

    public int getLlave(){
        return this.llave;
    }

    /**
     * Constructor de un empleado
     *
     * @param Llave           ID único del empleado
     * @param Nombre          del empleado
     * @param Direccion       donde se encuentra localizado
     * @param Correos         del empleado
     * @param Telefonos       del empleado
     * @param FechaNacimiento del empleado
     * @param Salario         del empleado
     * @param Rol             que trabajo realiza
     */
    public Empleado(int Llave, ArrayList<String> Nombre, ArrayList<String> Direccion, ArrayList<String> Correos,
            ArrayList<String> Telefonos, String FechaNacimiento, int Salario, String Rol) {
        llave = Llave;
        nombre = Nombre;
        direccion = Direccion;
        correos = Correos;
        telefonos = Telefonos;
        fechaNacimiento = FechaNacimiento;
        salario = Salario;
        rol = Rol;
    }
    
    /**
     * Empleado con un arreglo de atributos??
     *
     * @param atributos
     */
    public Empleado(ArrayList<String> atributos) {
        llave = Integer.parseInt(atributos.get(0));
        nombre = Main.stringToArrayList(atributos.get(1));
        direccion = Main.stringToArrayList(atributos.get(2));
        correos = Main.stringToArrayList(atributos.get(3));
        telefonos = Main.stringToArrayList(atributos.get(4));
        fechaNacimiento = atributos.get(5);
        salario = Integer.parseInt(atributos.get(6));
        rol = atributos.get(7);
    }

    /* Arreglo de atributos de un empleado */
    static String[] atributos = { "llave", "nombre", "direccion", "correos",
            "telefonos", "fechaNacimiento", "salario", "rol" };

    /**
     * Método para convertir un ArrayList a un string
     */
    public String[] toArray() {
        /*
         * return String[] de
         * [llave, nombre, direccion, telefonos, fechaApertura]
         */
        String nomStr = Main.arrayListToString(nombre);
        String corStr = Main.arrayListToString(correos);
        String teleStr = Main.arrayListToString(telefonos);
        String dirStr = Main.arrayListToString(direccion);
        return new String[] { Integer.toString(llave), nomStr, dirStr, corStr,
                teleStr, fechaNacimiento, Integer.toString(salario) };
    }

    /* Método para obtener los atributos */
    public String[] getAtributos() {
        return atributos;
    }

    public static boolean atributosSonValidos(String[] atributos){
        if(atributos == null || atributos.length != 8){
            return false;
        }

        return true;
    }

}
