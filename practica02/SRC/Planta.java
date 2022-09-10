public class Planta{

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