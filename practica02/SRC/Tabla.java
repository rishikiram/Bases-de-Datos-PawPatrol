import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Scanner;
import java.util.stream.Collectors;

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

public class Tabla {

    public Tabla(File Archivo, String tipo) throws IOException {
        archivo = Archivo;
        if (!archivo.exists()) {
            archivo.createNewFile();
        }
        clase = tipo;
    }

    // ¡éditeme!
    public ArrayList<Entidad> entidades = new ArrayList<>();
    public File archivo;
    public String clase;

    /* Loads all entidades from file associatd with an Entidad */
    public void loadTable() throws FileNotFoundException {
        Scanner scanner = new Scanner(archivo);
        ArrayList<String> atributos = new ArrayList<>();
        while (scanner.hasNextLine()) {
            String line = scanner.nextLine();
            atributos.clear();
            atributos.addAll(Arrays.asList(line.split("\s*[,]\s*")));
            entidades.add(instanciateEntidad(atributos));
        }

    }
    /**
    Añadir entidad a entidades,
    return true si es exitosa
    * */
    public Entidad instanciateEntidad(ArrayList<String> atributos) {
        switch (clase) {
            case "vivero":
                return (new Vivero(atributos));
                break;
            case "planta":
                return (new Planta(atributos));
                break;
            case "empleado":
                return (new Empleado(atributos));
                break;
            default:
                // PARA HACER error
        }
        return null;
    }
    // PARA HACER

    /* */
    public Boolean addEntidad() {
        return false;
    }

    // PARA HACER
    public Boolean deleteEntidad() {
        return false;
    }

    // PARA HACER
    public Boolean editEntidad() {
        return false;
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
    public void saveTableAux() throws IOException {
        Scanner sc = new Scanner(System.in);
        Scanner scan = new Scanner(System.in);

        System.out.println("Ingrese el ID Vivero");
        int id = scan.nextInt();
        String idAux = Integer.toString(id);

        System.out.println("Ingrese el nombre");
        String nombre = sc.nextLine();

        System.out.println("Ingrese la direccion"); // creo que aquí puedes poner que meta más
        String direccion = sc.nextLine();
        ArrayList<String> direccionAux = new ArrayList<String>(Arrays.asList(direccion.split(",")));

        System.out.println("Ingrese los telefonos"); // creo que aquí puedes poner que meta más
        String telefonos = sc.nextLine();
        ArrayList<String> telefonosAux = new ArrayList<String>(Arrays.asList(telefonos.split(",")));

        System.out.println("Ingrese la fecha de apertura");
        String fecha = sc.nextLine();

        System.out.println("Ingrese el tipo de vivero");
        String tipo = sc.nextLine();

        ArrayList<String> atributos = new ArrayList<>();
        atributos.add(idAux);
        atributos.add(nombre);
        atributos.addAll(direccionAux);
        atributos.addAll(telefonosAux);
        atributos.add(fecha);
        atributos.add(tipo);

    }
}
