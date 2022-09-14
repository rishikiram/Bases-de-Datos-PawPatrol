import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Scanner;

public class TablaViveros extends Tabla {
    public TablaViveros(File Archivo) throws IOException {
        this.inicializar(Archivo);
    }

    @Override
    public Entidad instantiateEntidad(ArrayList<String> atributos){
        try {
            return (new Vivero(atributos));
        } catch (Exception e) {
            return null;
        }   
    }

    @Override
    public Entidad getEntidadModificadaDesdeMenu(String[] atributos){
        Scanner sc = new Scanner(System.in);

        Integer id=null;
        String nombre=null, direccionesString=null, telefonosString=null, fecha=null, tipo=null;
        if(Vivero.atributosSonValidos(atributos)){
            id = Integer.parseInt(atributos[0]);
            nombre = atributos[1];
            direccionesString = atributos[2];
            telefonosString = atributos[3];
            fecha = atributos[4];
            tipo = atributos[5];
        }
        
        id = this.inputNewLlaveParameter(sc, id);
        nombre = this.inputStringParameter(sc, "el nombre", nombre);
        direccionesString = this.inputStringParameter(sc, "la(s) direccione(s) (separadas por guiones)", direccionesString);
        ArrayList<String> direccionesArray = Main.stringToArrayList(direccionesString);
        telefonosString = this.inputPhoneParameters(sc, telefonosString);
        ArrayList<String> telefonosArray = Main.stringToArrayList(telefonosString);
        fecha = this.inputDateParameter(sc, "creación", fecha);
        tipo = this.inputStringParameter(sc, "el tipo de vivero", tipo);

        return new Vivero(id, nombre, direccionesArray, telefonosArray, fecha, tipo);
    }

    @Override
    public String getNombre(){
        return "Viveros";
    }
}