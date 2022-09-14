import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Scanner;

public class TablaEmpleados extends Tabla {
    public TablaEmpleados(File Archivo) throws IOException {
        this.inicializar(Archivo);
    }

    @Override
    public Entidad instantiateEntidad(ArrayList<String> atributos){
        try {
            return (new Empleado(atributos));
        } catch (Exception e) {
            return null;
        }   
    }

    @Override
    public Entidad getEntidadModificadaDesdeMenu(String[] atributos){

        Scanner sc = new Scanner(System.in);
        Integer llave = null;
        String nombre = null, direccion = null, correos = null, telefonos = null, fechaNacimiento = null;
        Integer salario = null;
        String rol = null;

        if(Empleado.atributosSonValidos(atributos)){
            llave = Integer.parseInt(atributos[0]);
            nombre = atributos[1];
            direccion = atributos[2];
            correos = atributos[3];
            telefonos = atributos[4];
            fechaNacimiento = atributos[5];
            salario = Integer.parseInt(atributos[6]);
            rol = atributos[7];
        }

        llave = this.inputNewLlaveParameter(sc, llave);
        nombre = this.inputStringParameter(sc, "el nombre del empleado", nombre);
        ArrayList<String> nombreArray = Main.stringToArrayList(nombre);
        direccion = this.inputStringParameter(sc, "la(s) direccione(s) (separadas por guiones)", direccion);
        ArrayList<String> direccionArray = Main.stringToArrayList(direccion);
        correos = this.inputEmailParameters(sc, correos);
        ArrayList<String> correosArray = Main.stringToArrayList(correos);
        telefonos = this.inputPhoneParameters(sc, telefonos);
        ArrayList<String> telefonosArray = Main.stringToArrayList(telefonos);
        fechaNacimiento = this.inputDateParameter(sc, "nacimiento", fechaNacimiento);
        salario = this.inputIntParameter(sc, "el salario mensual", salario);
        rol = this.inputRoleParameters(sc, rol);

        return new Empleado(llave, nombreArray, direccionArray, correosArray, telefonosArray, fechaNacimiento, salario, rol);
    }

    @Override
    public String getNombre(){
        return "Empleados";
    }
}