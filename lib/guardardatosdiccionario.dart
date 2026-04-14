import 'claseempleado.dart';
import 'diccionarioempleado.dart';

class GuardarDatosDiccionario {
  // Id autonumérico
  static int _siguienteId = 1;

  static void guardarEmpleado({
    required String nombre,
    required String puesto,
    required double salario,
  }) {
    int id = _siguienteId++;
    Empleado nuevoEmpleado = Empleado(
      id: id,
      nombre: nombre,
      puesto: puesto,
      salario: salario,
    );
    
    // Se guarda en el diccionario
    datosEmpleado[id] = nuevoEmpleado;
  }
}
