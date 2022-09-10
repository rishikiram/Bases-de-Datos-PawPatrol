import java.util.ArrayList;

public class Empleado extends Entidad{
    int llave;
    String nombre;
    ArrayList<String> correos;
    ArrayList<String> telefonos;
    ArrayList<String> direccion;
    String fechaNacimiento;
    int salario;

    public Empleado (int Llave, String Nombre, ArrayList<String> Direccion, ArrayList<String> Correos,
                     ArrayList<String> Telefonos, String FechaNacimiento) {
        llave = Llave;
        nombre = Nombre;
        direccion = Direccion;
        correos = Correos;
        telefonos = Telefonos;
        fechaNacimiento = FechaNacimiento;
    }

   
    static String[] atributos = {"llave", "nombre", "direccion", "correos",
        "telefonos", "fechaNacimiento", "salario"};

    public String[] toArray(){
    /*  return String[] de
        [llave, nombre, direccion, telefonos, fechaApertura]
    */
        String corStr = Main.arrayListToString(correos);
        String teleStr = Main.arrayListToString(telefonos);
        String dirStr = Main.arrayListToString(direccion);
        return new String[] {Integer.toString(llave), nombre, dirStr ,corStr,
                teleStr, fechaNacimiento, Integer.toString(salario)};
    }
    public String[] getAtributos(){
        return atributos;
    }

}