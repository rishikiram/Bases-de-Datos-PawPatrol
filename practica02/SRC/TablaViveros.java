import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

public class TablaViveros extends Tabla {
    public TablaViveros(File Archivo) throws IOException {
        archivo = Archivo;
        if (!archivo.exists()) {
            archivo.createNewFile();
        }
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
        return null; //TODO: Implementar
    }
}