import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

public class Tabla {

    public Tabla(File Archivo) throws IOException {
        archivo = Archivo;
        if (!archivo.exists()){
            archivo.createNewFile();
        }
    }
    //¡éditeme!
    public ArrayList<Entidad> entidades = new ArrayList<>();
    public File archivo;
    /* Loads all entidads from file associatd with an Entidad*/

    //PARA HACER

    public void loadTable(Entidad ent) {

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
