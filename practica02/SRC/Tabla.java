import java.io.*;
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

    public ArrayList<Entidad> entidades = new ArrayList<>();
    public File archivo;

    /**
     *  Loads all entidades from file associated with an Entidad
     *  into entidades
     *  */
    public void loadTable() throws IOException {
        ArrayList<String> atributos = new ArrayList<>();
        try(BufferedReader br = new BufferedReader(new FileReader(archivo))) {
            for(String line; (line = br.readLine()) != null; ) {
                atributos.clear();
                atributos.addAll(Arrays.asList(line.split("\\s*[,]\\s*")));
                entidades.add(instantiateEntidad(atributos));
            }

        }
    }

    public void inicializar(File archivo) throws IOException{
        this.archivo = archivo;
        if (!archivo.exists()) {
            System.out.println("Creando archivo '"+archivo.getPath()+"'...");
            archivo.createNewFile();
        }else{
            this.loadTable();
        }
    }


     /**
      * Regresa una entidad correspondiente al tipo de la tabla con los atributos dados
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
                if (e.getLlave() == entidadNueva.getLlave()){
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

    public Entidad getEntidadPorLlave(int llave){
        for(Entidad e : this.entidades){
            if(e.getLlave()==llave){
                return e;
            }
        }
        return null;
    }

    /**
     * Edita una entidad en la tabla después de preguntarle al usuario lo que quiere editar.
     * @return True si se pudo editar una entidad, False de lo contrario
     */
    public Boolean editEntidad(int llave) {
        try {
            Entidad entidadAEditar = this.getEntidadPorLlave(llave);
            if(entidadAEditar==null){
                System.out.println("No se encontró la entidad.");
                return false;
            }
            Entidad entidadEditada = this.getEntidadModificadaDesdeMenu(entidadAEditar.toArray());
            for(Entidad e : this.entidades){
                if (e.getLlave() == entidadEditada.getLlave()){
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

    /**
     * Escribe información en list entidades en el archivo
     * */
    public void saveTable() throws IOException {

        FileWriter writer = new FileWriter(archivo, false);
        StringBuilder collect = new StringBuilder();
        for (Entidad e : entidades) {
            collect.append(String.join(",   ", e.toArray()));
            collect.append("\n");

        }
        if (collect.length() > 0) {
            writer.write(collect.toString());
        }
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

    /**
     * Recibe del usuario un valor entero
     * @param in Scanner de donde está ingresando información el usuario
     * @param nombreParam Nombre del parámetro que se está solicitando
     * @param valorOriginal Valor actual del parámetro solicitado, puede ser null si no tiene un valor actual
     * @return El valor que el usuario eligió
     */
    protected int inputIntParameter(Scanner in, String nombreParam, Integer valorOriginal){
        int eleccion=0;
        boolean chosen = false;
        String prompt = "Ingresa "+nombreParam;
        if(valorOriginal!=null){
            prompt+=" (presiona enter para conservar el valor actual <"+valorOriginal.toString()+">)";
        }
        prompt+=":";
        do{
            System.out.println(prompt);
            try {
                String line = in.nextLine();
                if(line.isEmpty() && valorOriginal!=null){
                    eleccion = valorOriginal;
                    chosen=true;
                }else{
                    try{
                        eleccion = Integer.parseInt(line);
                        chosen=true;
                    }catch(NumberFormatException e){
                        System.out.println("Necesitas ingresar un número entero, vuelve a intentar");
                    }
                }    
            } catch (Exception e) {
                System.out.println("Hubo un error al registrar tu eleccion, vuelve a intentar por favor");
            }
        }while(!chosen);

        return eleccion;
    }

    /**
     * Recibe del usuario un valor string
     * @param in Scanner de donde está ingresando información el usuario
     * @param nombreParam Nombre del parámetro que se está solicitando
     * @param valorOriginal Valor actual del parámetro solicitado, puede ser null si no tiene un valor actual
     * @return El valor que el usuario eligió
     */
    protected String inputStringParameter(Scanner in, String nombreParam, String valorOriginal){
        String eleccion="";
        boolean chosen = false;
        String prompt = "Ingresa "+nombreParam;
        if(valorOriginal!=null){
            prompt+=" (presiona enter para conservar el valor actual <"+valorOriginal+">)";
        }
        prompt+=":";
        do{
            System.out.println(prompt);
            try{
                String line = in.nextLine();
                if(line.isEmpty() && valorOriginal!=null){
                    eleccion = valorOriginal;
                    chosen=true;
                }else if(line.isEmpty()){
                    System.out.println("La cadena no puede ser vacía, por favor vuelve a intentar");
                }else if(line.contains(",")){
                    System.out.println("La cadena no puede contener comas ',', favor de volver a intentar");
                }else{
                    eleccion = line;
                    chosen=true;
                }
            }catch (Exception e) {
                System.out.println("Hubo un error al registrar tu eleccion, vuelve a intentar por favor");
            }
        }while(!chosen);

        return eleccion;
    }

    /**
     * Recibe del usuario uno o varios teléfonos separados por guiones
     * @param in Scanner de donde está ingresando información el usuario
     * @param valorOriginal Valor actual del parámetro solicitado, puede ser null si no tiene un valor actual
     * @return El valor que el usuario eligió
     */
    protected String inputPhoneParameters(Scanner in, String valorOriginal){
        String eleccion="";
        boolean chosen = false;
        do{
            eleccion=this.inputStringParameter(in, "uno o más teléfono(s) (separados por guiones '-'", valorOriginal);

            ArrayList<String> telefonos = Main.stringToArrayList(eleccion);
            boolean validos = true;
            for(String t:telefonos){
                if(!Main.esTelefonoValido(t)){
                    validos=false;
                }
            }
            if(validos){
                chosen=true;
            }else{
                System.out.println("Hubo teléfono(s) inválido(s), por favor vuelva a intentar");
            }
        }while(!chosen);

        return eleccion;
    }

    protected String inputEmailParameters(Scanner in, String valorOriginal){
        String eleccion = "";
        boolean chosen= false;
        do {
            eleccion = this.inputStringParameter(in, "Uno o más correos (separados por guines '-')", valorOriginal);
            ArrayList<String> emails = Main.stringToArrayList(eleccion);
            boolean validos = true;
            for(String e : emails){
                if(!Main.esCorreoValido(e)){
                    validos = false;
                }
            }

            if(validos){
                chosen = true;
            }else{
                System.out.println("Hubo correo(s) invalidos, intente de nuevo");
            }
            
        } while (!chosen);

        return eleccion;
    }

    public abstract String getNombre();

    public void mostrarEntidades(){

        if (entidades.size() == 0) {
            System.out.println("No hay datos en el archivo.");
        }
        else {
            System.out.println(String.join(",   ", entidades.get(0).getAtributos()));
            for (Entidad e : this.entidades) {
                System.out.println(String.join(",   ", e.toArray()));
            }
        }
    }
}
