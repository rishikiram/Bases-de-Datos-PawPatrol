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

  @Override
  public int getLlave(){
    return this.llave;
}

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
  public Vivero(int Llave, String Nombre, ArrayList<String> Direccion, ArrayList<String> Telefonos,
      String FechaApertura, String TipoVivero) {
    this.llave = Llave;
    nombre = Nombre;
    direccion = Direccion;
    telefonos = Telefonos;
    fechaApertura = FechaApertura;
    tipoVivero = TipoVivero;
  }

  /**
   * Vivero con un arreglo de atributos
   *
   * @param atributos
   */
  public Vivero(ArrayList<String> atributos) {
    this.llave = Integer.parseInt(atributos.get(0));
    nombre = atributos.get(1);
    direccion = Main.stringToArrayList(atributos.get(2));
    telefonos = Main.stringToArrayList(atributos.get(3));
    fechaApertura = atributos.get(4);
    tipoVivero = atributos.get(5);
  }



  public static String[] atributos = {"llave", "nombre", "direccion",
  "telefonos","fechaApertura","tipoVivero"};

  /**
   * Método para convertir un ArrayList a un string
   */
  public String[] toArray() {
    /*
     * return String[] de
     * [llave, nombre, direccion, telefonos, fechaApertura, tipoVivero]
     */
    String teleStr = Main.arrayListToString(telefonos);
    String dirStr = Main.arrayListToString(direccion);
    return new String[] { Integer.toString(llave), nombre, dirStr, teleStr,
        fechaApertura, tipoVivero};
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

  
  public static boolean atributosSonValidos(String[] atributos) {
    if(atributos==null){
      return false;
    }
    if(atributos.length!=6){
      return false;
    }
    return true;
  }
   
}