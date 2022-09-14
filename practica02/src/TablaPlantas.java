import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Scanner;

public class TablaPlantas extends Tabla {
    public TablaPlantas(File Archivo) throws IOException {
        this.inicializar(Archivo);
    }

    @Override
    public Entidad instantiateEntidad(ArrayList<String> atributos){
        try {
            return (new Planta(atributos));
        } catch (Exception e) {
            return null;
        }   
    }

    @Override
    public Entidad getEntidadModificadaDesdeMenu(String[] atributos){

        Scanner sc = new Scanner(System.in);

        Integer llave = null, precio = null, cantidad = null;
        String nombre = null, genero = null, cuidados = null, sustrato = null, luz = null, fechaGerminacion = null, riegaFrecuencia = null;

        if(Planta.atributosSonValidos(atributos)){
            llave = Integer.parseInt(atributos[0]);
            precio = Integer.parseInt(atributos[1]);
            cantidad = Integer.parseInt(atributos[2]);
            nombre = atributos[3];
            genero = atributos[4];
            cuidados = atributos[5];
            sustrato = atributos[6];
            luz = atributos[7];
            fechaGerminacion = atributos[8];
            riegaFrecuencia = atributos[9];
        }

        llave = this.inputNewLlaveParameter(sc, llave);
        precio = this.inputIntParameter(sc, "el precio de la planta", precio);
        cantidad = this.inputIntParameter(sc, "la cantidad de plantas", cantidad);
        nombre = this.inputStringParameter(sc, "el nombre de la planta", nombre);
        genero = this.inputStringParameter(sc, "el genero de la planta", genero);
        cuidados = this.inputStringParameter(sc, "los cuidados de la planta", cuidados);
        sustrato = this.inputStringParameter(sc, "el sustrato de la planta", sustrato);
        luz = this.inputStringParameter(sc, "la luz de la planta", luz);
        fechaGerminacion = this.inputStringParameter(sc, "la fecha de germinacion de la planta", fechaGerminacion);
        riegaFrecuencia = this.inputStringParameter(sc, "la frecuencia de riego de la planta", riegaFrecuencia);
        

        return new Planta(llave, precio, cantidad, nombre, genero, cuidados, sustrato, luz, fechaGerminacion, riegaFrecuencia);
    }

    @Override
    public String getNombre(){
        return "Plantas";
    }
}