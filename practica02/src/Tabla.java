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
     *  Loads all entidades from the file 'archivos' into 'entidades'
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

    /**
     * inicializa el archivo si no existe
     * @param archivo   File object de la .csv
     * */
    public void inicializar(File archivo) throws IOException{
        this.archivo = archivo;
        if (!archivo.exists()) {
            System.out.println("Creando archivo '"+archivo.getPath()+"'...");
            archivo.createNewFile();
        }else{
            System.out.println("Leyendo archivo '"+archivo.getPath()+"'...");
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
            System.out.println("Hubo un error al agregar la entidad");
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
     * Busca una entidad de la tabla y return lo
     * @param llave La llave de la entidad a buscar
     * @return la entidad o null
     */
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
            for(int i=0; i<this.entidades.size(); i++){
                if (this.entidades.get(i).getLlave() == entidadEditada.getLlave()){
                    this.entidades.set(i, entidadEditada);
                    return true;
                }
            }
            return false;
        } catch (Exception e) {
            System.out.println("Hubo un error al editar la entidad");
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
            System.out.println(String.join(",   ", e.toArray()));
        }
        if (collect.length() > 0) {
            writer.write(collect.toString());
        }
        writer.close();
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
                e.printStackTrace();                
            }
        }while(!chosen);

        return eleccion;
    }

    /**
     * Recibe del usuario un valor entero para ser usado como un nuevo ID
     * @param in Scanner de donde está ingresando información el usuario
     * @param valorOriginal Valor actual del ID (para el caso en que se esté editando un ID), puede ser null si no se está editando ningún valor
     * @return El valor que el usuario eligió
     */
    protected int inputNewLlaveParameter(Scanner in, Integer valorOriginal){
        int eleccion=0;
        boolean chosen = false;
        String prompt = "Ingresa la llave";
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
                        if(this.getEntidadPorLlave(eleccion)!=null){
                            System.out.println("La llave ya se encuentra en la tabla, vuelve a intentar");
                        }else{
                            chosen=true;
                        }
                    }catch(NumberFormatException e){
                        System.out.println("Necesitas ingresar un número entero, vuelve a intentar");
                    }
                }    
            } catch (Exception e) {
                System.out.println("Hubo un error al registrar tu eleccion, vuelve a intentar por favor");
                e.printStackTrace();                
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
        String eleccion;
        boolean chosen = false;
        do{
            eleccion=this.inputStringParameter(in, "uno o más teléfono(s) (separados por guiones '-')", valorOriginal);

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

    /**
     * Recibe del usuario una fecha
     * @param in Scanner de donde está ingresando información el usuario
     * @param label El concepto de la fecha (se mostrará "la fecha de <label>")
     * @param valorOriginal Valor actual del parámetro solicitado, puede ser null si no tiene un valor actual
     * @return El valor que el usuario eligió
     */
    protected String inputDateParameter(Scanner in, String label, String valorOriginal){
        String eleccion;
        boolean chosen = false;
        do{
            eleccion=this.inputStringParameter(in, "la fecha de " + label + " (dd/mm/aaaa)", valorOriginal);

            ArrayList<String> telefonos = Main.stringToArrayList(eleccion);
            boolean validos = true;
            for(String t:telefonos){
                if(!Main.esFechaValida(t)){
                    validos=false;
                }
            }
            if(validos){
                chosen=true;
            }else{
                System.out.println("La fecha ingresada no es válida, vuelva a intentar");
            }
        }while(!chosen);

        return eleccion;
    }

    /**
     * Funcion que recibe del usuario un conjunto de uno o más correos electrónicos separados por guiones
     * @param in Scanner de entrada
     * @param valorOriginal Valor actual del parámetro solicitado, puede ser null si no tiene un valor actual
     * @return La cadena con los correos ingresados por el usuario
     */
    protected String inputEmailParameters(Scanner in, String valorOriginal){
        String eleccion;
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

    /**
     * Funcion que recibe del usuario un rol para un empelado de un vivero
     * @param in Scanner de entrada
     * @param valorOriginal Valor actual del parámetro solicitado, puede ser null si no tiene un valor actual
     * @return La cadena con el rol seleccionado por el usuario
     */
    protected String inputRoleParameters(Scanner in, String valorOriginal){
        String rol = null;
        int eleccion;
        boolean chosen= false;
        boolean willEdit = true;
        if(valorOriginal!=null){
            do {
                System.out.println("¿Deseas editar el rol del empleado (valor actua: <"+valorOriginal+">)?\n"
                    +"1) Sí\n"
                    +"2 o Enter) No"
                );
                String line = in.nextLine();
                if(line.isEmpty() || line.equals("2")){
                    chosen=true;
                    willEdit=false;
                    break;
                }else if(line.equals("1")){
                    chosen=true;
                }else{
                    System.out.println("Elección inválida, favor de volver a intentar '"+line+"'");
                }
            }while(!chosen);
        }
        

        chosen=false;
        if(willEdit){do {
            System.out.println(
                "Seleccione un rol para el empleado:\n"
                +"1) Gerente\n"
                +"2) Cuidador de plantas\n"
                +"3) Encargado de mostrar plantas a los clientes\n"
                +"4) Cajero"
            );
            eleccion = Main.readInt(in);
            switch (eleccion) {
                case 1:
                    rol = "Gerente";
                    chosen=true;
                    break;
                case 2:
                    rol = "Cuidador de plantas";
                    chosen=true;
                    break;
                case 3:
                    rol = "Encargado de mostrar plantas a los clientes";
                    chosen=true;
                    break;
                case 4:
                    rol = "Cajero";
                    chosen=true;
                    break;
                default:
                    System.out.println("Elección inválida, vuelve a ingresar por favor");
                    chosen=false;
                    break;
            }
        } while (!chosen);}

        return rol;
    }

    /** Función que regresa el nombre de las entidades que contiene la tabla 
    * @return El nombre de las entidades que contiene la tabla 
    */
    public abstract String getNombre();

    /**
     * Muestra todas las entidades contenidas en una tabla
     */
    public void mostrarEntidades(){
        if (entidades.size() == 0) {
            System.out.println("No hay datos en el archivo.");
        }
        else {
            System.out.println(String.join(",\t", entidades.get(0).getAtributos()));
            for (Entidad e : this.entidades) {
                System.out.println(String.join(",\t", e.toArray()));
            }
        }
    }
}
