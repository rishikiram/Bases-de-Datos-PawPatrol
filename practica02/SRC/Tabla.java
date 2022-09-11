import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Scanner;

/**
 *
 * Clase que implementa los métodos para poder agregar, consultar, editar y
 * eliminar información de las entidades
 *
 * @version 1.0 Septiembre 2022
 * @author Paw Patrols
 * @since Fundamentos de Bases de Datos
 *
 */

public abstract class Tabla {

    // ¡éditeme!
    public ArrayList<Entidad> entidades = new ArrayList<>();
    public File archivo;
//    public String clase;

    /* Loads all entidades from file associatd with an Entidad */
    public void loadTable() throws FileNotFoundException {
        Scanner scanner = new Scanner(archivo);
        ArrayList<String> atributos = new ArrayList<>();
        while (scanner.hasNextLine()) {
            String line = scanner.nextLine();
            atributos.clear();
            atributos.addAll(Arrays.asList(line.split("\\s*[,]\\s*")));
            entidades.add(instantiateEntidad(atributos));
        }
        scanner.close();
    }


     /* Regresa una entidad correspondiente al tipo de la tabla con los atributos dados
     * @param atributos Atributos de la entidad
     * @return Nueva entidad
     */
    public abstract Entidad instantiateEntidad(ArrayList<String> atributos);

    /**
     * Muestra un menú para crear una nueva entidad y la regresa al terminar su ejecución.
     * @return La entidad creada
     */
    public Entidad getEntidadNuevaDesdeMenu(){
        return this.getEntidadModificadaDesdeMenu(null);
    }
    
    /**
     * Método que implementa un menú para crear una nueva entidad y la regresa.
     * @param atributos Los atributos de la entidad a editar. Si es null se crea la entidad desde cero
     * @return La entidad creada con el menú.
     */
    public abstract Entidad getEntidadModificadaDesdeMenu(String[] atributos);
    
    /**
     * Agrega una entidad nueva después de preguntarle al usuario los datos de la entidad
     * @return True si se pudo agregar la entidad, False de lo contrario
     */
    public Boolean addEntidad() {
        try {
            Entidad entidadNueva = this.getEntidadNuevaDesdeMenu();
            for(Entidad e : this.entidades){
                if (e.getLlave() == e.getLlave()){
                    System.out.println("La llave ya existe en la tabla, no se puede agregar la entidad.");
                    return false;
                }
            }
            this.entidades.add(entidadNueva);
            return true;
        } catch (Exception e) {
            System.out.println("Hubo un error al agregar la entidad"); // TODO: Mejorar manejo de excepción
            return false;
        }
    }

    /**
     * Elimina una entidad de la tabla
     * @param llave La llave de la entidad a borrar
     * @return True si sí se borró una entidad, False de lo contrario
     */
    public Boolean deleteEntidad(int llave) {
        for(Entidad e : this.entidades){
            if(e.getLlave()==llave){
                this.entidades.remove(e);
                return true;
            }
        }
        return false;
    }

    /**
     * Edita una entidad en la tabla después de preguntarle al usuario lo que quiere editar.
     * @return True si se pudo editar una entidad, False de lo contrario
     */
    public Boolean editEntidad(Entidad entidadAEditar) {
        try {
            Entidad entidadEditada = this.getEntidadModificadaDesdeMenu(entidadAEditar.getAtributos());
            for(Entidad e : this.entidades){
                if (e.getLlave() == e.getLlave()){
                    System.out.println("La llave ya existe en la tabla, no se pueden guardar los cambios a la entidad.");
                    return false;
                }
            }
            this.entidades.add(entidadEditada);
            return true;
        } catch (Exception e) {
            System.out.println("Hubo un error al editar la entidad"); // TODO: Mejorar manejo de excepción
            return false;
        }
    }

    // Escribe información en list entidades en el archivo
    public void saveTable() throws IOException {

        FileWriter writer = new FileWriter(archivo, false);
        StringBuilder collect = new StringBuilder();

        for (Entidad e : entidades) {
            collect.append(String.join(",   ", e.toArray()));
            collect.append("\n");

        }
        writer.write(collect.toString());
        writer.close();


        /* old version
        ArrayList<String> atributos = new ArrayList<>();
        atributos.add("esto");
        atributos.add("es");
        atributos.add("solo");
        atributos.add("un ejemplo");
        FileWriter writer = new FileWriter(archivo, true);
        String collect = atributos.stream().collect(Collectors.joining(","));

        switch (clase) {
            case "vivero":
                writer.write(collect);
                writer.write("\n");
                writer.close();
                break;
            case "planta":
                writer.write(collect);
                writer.write("\n");
                writer.close();
                break;
            case "empleado":
                writer.write(collect);
                writer.write("\n");
                writer.close();
                break;
            default:
                System.out.println("Parece que algo salío mal");
        }
        atributos.clear();
        */
    }

    // Así más o menos pensé que podian meter los datos
    // Ejemplo con vivero
    // public void saveTableAux() throws IOException {
    //     Scanner sc = new Scanner(System.in);
    //     Scanner scan = new Scanner(System.in);

    //     System.out.println("Ingrese el ID Vivero");
    //     int id = scan.nextInt();
    //     String idAux = Integer.toString(id);

    //     System.out.println("Ingrese el nombre");
    //     String nombre = sc.nextLine();

    //     System.out.println("Ingrese la direccion"); // creo que aquí puedes poner que meta más
    //     String direccion = sc.nextLine();
    //     ArrayList<String> direccionAux = new ArrayList<String>(Arrays.asList(direccion.split(",")));

    //     System.out.println("Ingrese los telefonos"); // creo que aquí puedes poner que meta más
    //     String telefonos = sc.nextLine();
    //     ArrayList<String> telefonosAux = new ArrayList<String>(Arrays.asList(telefonos.split(",")));

    //     System.out.println("Ingrese la fecha de apertura");
    //     String fecha = sc.nextLine();

    //     System.out.println("Ingrese el tipo de vivero");
    //     String tipo = sc.nextLine();

    //     ArrayList<String> atributos = new ArrayList<>();
    //     atributos.add(idAux);
    //     atributos.add(nombre);
    //     atributos.addAll(direccionAux);
    //     atributos.addAll(telefonosAux);
    //     atributos.add(fecha);
    //     atributos.add(tipo);

    //     sc.close();
    //     scan.close();
    // }
}
