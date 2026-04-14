import 'package:flutter/material.dart';
import 'diccionarioempleado.dart';

class VerEmpleados extends StatelessWidget {
  const VerEmpleados({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Directorio de Empleados', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent.shade700,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: datosEmpleado.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.folder_open, size: 80, color: Colors.grey.shade400),
                  const SizedBox(height: 20),
                  Text(
                    'No hay empleados registrados',
                    style: TextStyle(fontSize: 20, color: Colors.grey.shade600, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12.0),
              itemCount: datosEmpleado.length,
              itemBuilder: (context, index) {
                final id = datosEmpleado.keys.elementAt(index);
                final empleado = datosEmpleado[id]!;
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue.shade100,
                      foregroundColor: Colors.blue.shade900,
                      radius: 30,
                      child: Text(
                        '${empleado.id}',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                    ),
                    title: Text(
                      empleado.nombre,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black87),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.work, size: 16, color: Colors.grey),
                              const SizedBox(width: 5),
                              Text(empleado.puesto, style: const TextStyle(fontSize: 15)),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.attach_money, size: 16, color: Colors.green),
                              const SizedBox(width: 5),
                              Text(
                                '\$${empleado.salario.toStringAsFixed(2)}',
                                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.green),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
