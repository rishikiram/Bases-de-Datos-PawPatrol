import java.util.ArrayList;

public class Vivero{
    public Vivero (int Llave, String Nombre, String Direccion, ArrayList<String> Telefonos, String FechaApertura) {
        llave = Llave;
        nombre = Nombre;
        direccion = Direccion;
        telefonos = Telefonos;
        fechaApertura = FechaApertura;
    }

    int llave;
    String nombre;
    String direccion;
    ArrayList<String> telefonos;
    String fechaApertura;
    public static String[] atributos;

    public String[] toArray(){
      /*  return String[] de
          [llave, nombre, direccion, telefonos, fechaApertura]
      */
        String teleStr = Main.arrayListToString(telefonos);
        return new String[] {Integer.toString(llave), nombre, direccion, teleStr.toString(),
                fechaApertura};
    }
    public String[] getAtributos(){
      return atributos;
    }

}
