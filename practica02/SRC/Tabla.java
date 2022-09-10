import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.lang.reflect.Array;
import java.lang.reflect.InvocationTargetException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Scanner;

public class Tabla {

    public Tabla(File Archivo, String tipo) throws IOException {
        archivo = Archivo;
        if (!archivo.exists()){
            archivo.createNewFile();
        }
        clase = tipo;
    }
    //¡éditeme!
    public ArrayList<Entidad> entidades = new ArrayList<>();
    public File archivo;
    public String clase;
    /* Loads all entidads from file associatd with an Entidad*/

    //PARA HACER

    public void loadTable() {
        try {
            Scanner scanner = new Scanner(archivo) ;
            ArrayList<String> atributos = new ArrayList<>();
            while (scanner.hasNextLine()) {
                String line = scanner.nextLine();
                atributos.addAll(Arrays.asList(line.split("/s[,]/s")));
                switch (clase){
                    case "viveros":
                        entidades.add(new Vivero(atributos));
                        break;
                    case "planta":
                        entidades.add(new Planta(atributos));
                        break;
                    case "empleado":
                        entidades.add(new Empleado(atributos));
                        break;
                    default:
                        //PARA HACER error
                }
                atributos.clear();
            }
        } catch (FileNotFoundException e) {
            //PARA HACER
        }

    }
    //PARA HACER
    /* */
    public Boolean addEntidad(){
        return false;
    }
    //PARA HACER
    public Boolean deleteEntidad(){
        return false;
    }
    //PARA HACER
    public Boolean editEntidad(){
        return false;
    }

    /* Saves all entidads into file asociaed with */
    public Boolean saveTable(){
        return false;
    }

}
