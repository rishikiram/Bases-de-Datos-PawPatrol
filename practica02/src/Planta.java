import java.util.ArrayList;

/**
 *
 * Clase que implementa un tipo de planta en el vivero
 *
 * @version 1.0 Septiembre 2022
 * @author Paw Patrols
 * @since Fundamentos de Bases de Datos
 *
 */

public class Planta extends Entidad {

    /* Atributos */
    int llave;
    int precio, cantidad;
    String nombre, genero, cuidados, sustrato, luz, fechaGerminacion, riegaFrequencia;

    /* Arreglo de atributos de una planta */
    public static String[] atributos = { "precio", "cantidad",
            "nombre", "genero", "cuidados", "sustrato",
            "luz", "fechaGerminacion", "riegaFrequencia" };

    /**
     * Constructor de una planta
     *
     * @param Llave            ID único de la planta
     * @param Precio           costo de la planta
     * @param Cantidad         número de plantas en el invernadero
     * @param Nombre           de la planta
     * @param Genero           que tipo de planta es
     * @param Cuidados         asistencia que la planta necesita
     * @param Sustrato         tipo de sustrato
     * @param Luz              si es de sol o sombre
     * @param FechaGerminacion de la planta
     * @param RiegaFrequencia  cada cuanto se riega
     */
    public Planta(int Llave, int Precio, int Cantidad, String Nombre,
            String Genero, String Cuidados, String Sustrato, String Luz,
            String FechaGerminacion, String RiegaFrequencia) {
        llave = Llave; 
        precio = Precio;
        cantidad = Cantidad;
        nombre = Nombre;
        genero = Genero;
        cuidados = Cuidados;
        sustrato = Sustrato;
        luz = Luz;
        fechaGerminacion = FechaGerminacion;
        riegaFrequencia = RiegaFrequencia;
    }

    /**
     * Constructor de una planta con ArrayList
     *
     * @param atributos
     */
    public Planta(ArrayList<String> atributos) {
        llave = Integer.parseInt(atributos.get(0));
        precio = Integer.parseInt(atributos.get(1));
        cantidad = Integer.parseInt(atributos.get(2));
        nombre = atributos.get(3);
        genero = atributos.get(4);
        cuidados = atributos.get(5);
        sustrato = atributos.get(6);
        luz = atributos.get(7);
        fechaGerminacion = atributos.get(8);
        riegaFrequencia = atributos.get(9);
    }

    /**
     * Método para convertir un ArrayList a un string
     */
    public String[] toArray() {
        return new String[] { Integer.toString(llave), Integer.toString(precio), Integer.toString(cantidad), nombre,
                genero, cuidados, sustrato, luz, fechaGerminacion, riegaFrequencia };
    }

    /**
     * Método que regresa la llave de la planta.
     * @return Llave de la planta.
     */
    public int getLlave(){
        return this.llave;
    }

    /**
     * Método que regresa los atributos.
     * @return Arreglo con los atributos de la planta.
     */
    public String[] getAtributos() {
        return atributos;
    }

    public static boolean atributosSonValidos(String[] atributos){

        return !(atributos == null || atributos.length != 10);
    }

}
