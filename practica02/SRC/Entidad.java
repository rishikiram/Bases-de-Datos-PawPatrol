
/**
 *
 * Clase abstracta que representa a los tipos de entidades
 *
 * @version 1.0 Septiembre 2022
 * @author Paw Patrols
 * @since Fundamentos de Bases de Datos
 *
 */
public abstract class Entidad {
    int llave;
    public abstract String[] toArray();
    public abstract String[] getAtributos();
}
