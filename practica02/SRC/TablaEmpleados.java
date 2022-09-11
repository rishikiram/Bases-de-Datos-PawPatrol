import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

public class TablaEmpleados extends Tabla {
    public TablaEmpleados(File Archivo) throws IOException {
        archivo = Archivo;
        if (!archivo.exists()) {
            archivo.createNewFile();
        }
    }

    @Override
    public Entidad instanciateEntidad(ArrayList<String> atributos){
        try {
            return (new Empleado(atributos));
        } catch (Exception e) {
            return null;
        }   
    }

    @Override
    public Entidad getEntidadModificadaDesdeMenu(String[] atributos){
        return null; //TODO: Implementar
    }
}