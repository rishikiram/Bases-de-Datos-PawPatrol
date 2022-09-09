import java.util.ArrayList;

public class Empleado{
    public Empleado (int Llave, String Nombre, String Direccion, ArrayList<String> Correos,
                     ArrayList<String> Telefonos, String FechaNacimiento) {
        llave = Llave;
        nombre = Nombre;
        direccion = Direccion;
        correos = Correos;
        telefonos = Telefonos;
        fechaNacimiento = FechaNacimiento;
    }

    int llave;
    String nombre;
    String direccion;
    ArrayList<String> correos;
    ArrayList<String> telefonos;
    String fechaNacimiento;
    int salario;
    static String[] atributos = {"llave", "nombre", "direccion", "correos",
        "telefonos", "fechaNacimiento", "salario"};

    public String[] toArray(){
    /*  return String[] de
        [llave, nombre, direccion, telefonos, fechaApertura]
    */
        String corStr = Main.arrayListToString(correos);
        String teleStr = Main.arrayListToString(telefonos);
        return new String[] {Integer.toString(llave), nombre, direccion, corStr.toString(),
                teleStr.toString(), fechaNacimiento, Integer.toString(salario)};
    }
    public String[] getAtributos(){
        return atributos;
    }

}