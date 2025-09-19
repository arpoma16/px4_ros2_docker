import sys
import xml.etree.ElementTree as ET

def set_gazebo_home(lat, lon, elev, source_file="Tools/simulation/gz/worlds/default.sdf", dest_file="Tools/simulation/gz/worlds/gazebo_world_temp.sdf"):
    """
    Modifica las coordenadas en un archivo de mundo de Gazebo y lo guarda en un archivo temporal.

    Args:
        lat (float): Latitud en grados decimales.
        lon (float): Longitud en grados decimales.
        elev (float): Elevación en metros.
        source_file (str): Ruta al archivo del mundo de origen.
        dest_file (str): Nombre del archivo de destino modificado.
    """
    try:
        tree = ET.parse(source_file)
        root = tree.getroot()

        # Encuentra las coordenadas esféricas.
        # Usa el namespace para evitar errores en archivos SDF más complejos.
        ns = {'sdf': 'http://sdformat.org/spec/gazebosim/1.6/sdf.xsd'}
        spherical_coords = root.find(".//sdf:spherical_coordinates", ns)
        
        if spherical_coords is None:
            # Si no se encuentra con el namespace, intenta sin él
            spherical_coords = root.find(".//spherical_coordinates")
            if spherical_coords is None:
                print(f"Error: <spherical_coordinates> no encontrado en el archivo {source_file}.")
                return

        # Actualiza los valores de latitud, longitud y elevación.
        latitude_tag = spherical_coords.find('latitude_deg')
        if latitude_tag is not None:
            latitude_tag.text = str(lat)

        longitude_tag = spherical_coords.find('longitude_deg')
        if longitude_tag is not None:
            longitude_tag.text = str(lon)

        elevation_tag = spherical_coords.find('elevation')
        if elevation_tag is not None:
            elevation_tag.text = str(elev)

        # Guarda los cambios en un archivo temporal.
        tree.write(dest_file)
        print(f"Archivo de mundo modificado guardado en '{dest_file}'.")
        print(f"Latitud: {lat}, Longitud: {lon}, Elevación: {elev}")

    except FileNotFoundError:
        print(f"Error: No se encontró el archivo '{source_file}'.")
    except Exception as e:
        print(f"Ocurrió un error: {e}")

if __name__ == "__main__":
    if len(sys.argv) != 4:
        print("Uso: python set_gazebo_home.py <latitud> <longitud> <elevacion>")
        sys.exit(1)
    
    try:
        lat = float(sys.argv[1])
        lon = float(sys.argv[2])
        elev = float(sys.argv[3])
        set_gazebo_home(lat, lon, elev)
    except ValueError:
        print("Error: Los parámetros deben ser números.")
        sys.exit(1)