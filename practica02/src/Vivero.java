import java.util.ArrayList;

/**
 *
 * Clase que implementa los elementos de un vivero
 *
 * @version 1.0 Septiembre 2022
 * @author Paw Patrols
 * @since Fundamentos de Bases de Datos
 *
 */

public class Vivero extends Entidad {
    /* Atributos */
    int llave;
    String nombre;
    ArrayList<String> direccion;
    ArrayList<String> telefonos;
    String fechaApertura;
    String tipoVivero;

    //Arreglo de atributos del vivero
    public static String[] atributos = {"llave", "nombre", "direccion",
            "telefonos","fechaApertura","tipoVivero"};


    /**
     * Constuctor de un vivero
     *
     * @param Llave         ID único del vivero
     * @param Nombre        del vivero
     * @param Direccion     donde se encuentra localizado
     * @param Telefonos     del vivero
     * @param FechaApertura fecha en que fue abierto
     * @param TipoVivero    puede ser de plantas africanas o cactus
     */
    public Vivero(int Llave, String Nombre, ArrayList<String> Direccion, ArrayList<String> Telefonos, String FechaApertura, String TipoVivero) {
        this.llave = Llave;
        nombre = Nombre;
        direccion = Direccion;
        telefonos = Telefonos;
        fechaApertura = FechaApertura;
        tipoVivero = TipoVivero;
    }

    /**
     * Constructor de una vivero con ArrayList.
     *
     * @param atributos - ArrayList que contendrá los atributos del vivero.
     */
    public Vivero(ArrayList<String> atributos) {
        this.llave = Integer.parseInt(atributos.get(0));
        nombre = atributos.get(1);
        direccion = Main.stringToArrayList(atributos.get(2));
        telefonos = Main.stringToArrayList(atributos.get(3));
        fechaApertura = atributos.get(4);
        tipoVivero = atributos.get(5);
    }

    /**
     * Método para convertir un ArrayList a un string.
     */
    public String[] toArray() {
        String teleStr = Main.arrayListToString(telefonos);
        String dirStr = Main.arrayListToString(direccion);
        return new String[] { Integer.toString(llave), nombre, dirStr, teleStr,
            fechaApertura, tipoVivero};
    }

    @Override
    public int getLlave(){
        return this.llave;
    }

    /* Método para obtener los atributos */
    public String[] getAtributos() {
        return atributos;
    }

    /** Opcional solo lo puse para ver como imprimia */
    @Override
    public String toString() {
        return "Vivero [direccion=" + Main.arrayListToString(direccion) + ", fechaApertura=" + fechaApertura + ", llave=" + llave + ", nombre="
            + nombre + ", telefonos=" + Main.arrayListToString(telefonos) + ", tipoVivero=" + tipoVivero + "]";
    }

    /**
     * Método que verifica si los atributos del vivero son válidos.
     * @param atributos - Arreglos de atributos del vivero.
     * @return True si son los 6 atributos, False si falta algun atributo.
     */
    public static boolean atributosSonValidos(String[] atributos) {
        if(atributos==null){
          return false;
        }
        return atributos.length == 6;
    }

}