import java.util.ArrayList;

public class Vivero {
  int llave;
  String nombre;
  ArrayList<String> direccion;
  ArrayList<String> telefonos;
  String fechaApertura;

  public Vivero(int Llave, String Nombre, ArrayList<String> Direccion, ArrayList<String> Telefonos, String FechaApertura) {
    llave = Llave;
    nombre = Nombre;
    direccion = Direccion;
    telefonos = Telefonos;
    fechaApertura = FechaApertura;
  }

  public static String[] atributos;

  public String[] toArray() {
    /*
     * return String[] de
     * [llave, nombre, direccion, telefonos, fechaApertura]
     */
    String teleStr = Main.arrayListToString(telefonos);
    String dirStr = Main.arrayListToString(direccion);
    return new String[] { Integer.toString(llave), nombre, dirStr, teleStr,
        fechaApertura };
  }

  public String[] getAtributos() {
    return atributos;
  }

}
