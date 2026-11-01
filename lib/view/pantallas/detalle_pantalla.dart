import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/lugar_model.dart';
import '../../view_model/lugar_viewmodel.dart';
import '../widgets/boton_personalizado.dart';

class DetallePantalla extends StatelessWidget {
  const DetallePantalla({super.key});

  // Helper para mostrar filas de informacion
  Widget dato(String titulo, String valor) {
    return ListTile(
      title: Text(
        titulo,
        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple),
      ),
      subtitle: Text(
        valor,
        style: const TextStyle(fontSize: 15),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //para visualizar el view model en la pantalla
    final vm = context.watch<LugarViewModel>();

    //recibir parametros
    final lugar = ModalRoute.of(context)!.settings.arguments as LugarModel;
    final esFav = vm.esFavorito(lugar.id);
    final indiceImagen = vm.imagenActual;

    return Scaffold(
      appBar: AppBar(
        title: Text(lugar.nombre),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(
              esFav ? Icons.favorite : Icons.favorite_border,
              color: esFav ? Colors.redAccent : Colors.white,
            ),
            onPressed: () {
              vm.toggleFavorito(lugar.id);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Gesto 2: Deslizamiento horizontal para cambiar de fotografia
            GestureDetector(
              onHorizontalDragEnd: (details) {
                if (details.primaryVelocity != null) {
                  if (details.primaryVelocity! < 0) {
                    // Deslizamiento hacia la izquierda -> siguiente imagen
                    vm.siguienteImagen();
                  } else if (details.primaryVelocity! > 0) {
                    // Deslizamiento hacia la derecha -> imagen anterior
                    vm.anteriorImagen();
                  }
                }
              },
              child: Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Image.network(
                          lugar.imagenes[indiceImagen % lugar.imagenes.length],
                          height: 250,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            height: 250,
                            color: Colors.deepPurple.shade100,
                            child: const Center(
                              child: Icon(Icons.broken_image, size: 60, color: Colors.deepPurple),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          color: Colors.black54,
                          child: Text(
                            'Foto ${indiceImagen + 1} de ${lugar.imagenes.length} (Desliza horizontalmente ↔)',
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.white, fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),

            // Informacion detallada en Card
            Card(
              elevation: 3.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    dato('Lugar', lugar.nombre),
                    const Divider(),
                    dato('Ubicación', lugar.ubicacion),
                    const Divider(),
                    dato('Descripción', lugar.descripcion),
                    const Divider(),
                    dato('Estado', esFav ? 'En tu lista de favoritos ❤️' : 'No marcado como favorito'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24.0),

            //boton de regreso:
            BotonPersonalizado(
              texto: 'Regresar',
              icono: Icons.arrow_back,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
