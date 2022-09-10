import java.util.ArrayList;

public class Planta extends Entidad{

    int llave;
    String nombre, genero, cuidados, sustrato, luz, fechaGerminacion, riegaFrequencia;
    int precio, cantidad;
    String trabajaVivero;


    public Planta (int Llave, int Precio, int Cantidad, String Nombre,
                   String Genero, String Cuidados, String Sustrato, String Luz,
                   String FechaGerminacion, String RiegaFrequencia) {
        llave = Llave;
        precio = Precio;
        cantidad = Cantidad;
        nombre = Nombre;
        genero = Genero;
        cuidados = Cuidados;
        sustrato = Sustrato;
        luz = Luz;
        fechaGerminacion = FechaGerminacion;
        riegaFrequencia = RiegaFrequencia;
    }
    public Planta(ArrayList<String> atributos) {
        llave = Integer.parseInt(atributos.get(0));
        precio = Integer.parseInt(atributos.get(1));
        cantidad = Integer.parseInt(atributos.get(2));
        nombre = atributos.get(3);
        genero = atributos.get(4);
        cuidados = atributos.get(5);
        sustrato = atributos.get(6);
        luz = atributos.get(7);
        fechaGerminacion = atributos.get(8);
        riegaFrequencia = atributos.get(9);
    }
    

    public static String[] atributos ={"precio", "cantidad",
            "nombre", "genero", "cuidados", "sustrato",
            "luz", "fechaGerminacion", "riegaFrequencia"};

    public String[] toArray(){
        /*  return String[] de
            {llave, precio...}
        */
        return new String[] {Integer.toString(llave), Integer.toString(precio), Integer.toString(cantidad), nombre, genero, cuidados, sustrato, luz, fechaGerminacion, riegaFrequencia};
    }
    public String[] getAtributos(){
        return atributos;
    }

}