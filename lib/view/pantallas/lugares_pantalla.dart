import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/lugar_model.dart';
import '../../view_model/lugar_viewmodel.dart';

class LugaresPantalla extends StatelessWidget {
  const LugaresPantalla({super.key});

  @override
  Widget build(BuildContext context) {
    //para visualizar el view model en la pantalla
    final vm = context.watch<LugarViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lugares Turísticos'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12.0),
        itemCount: vm.lugares.length,
        itemBuilder: (context, index) {
          final LugarModel lugar = vm.lugares[index];
          final esFav = vm.esFavorito(lugar.id);

          return Card(
            elevation: 4.0,
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              //paso de parametros y navegacion al detalle
              onTap: () {
                vm.seleccionarLugar(lugar);
                //rutas
                Navigator.pushNamed(
                  context,
                  '/detalle',
                  arguments: lugar,
                );
              },
              // Gesto 1: Doble toque para agregar o quitar de favoritos
              child: GestureDetector(
                onDoubleTap: () {
                  vm.toggleFavorito(lugar.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: const Duration(milliseconds: 900),
                      backgroundColor: Colors.deepPurple,
                      content: Text(
                        esFav
                            ? '${lugar.nombre} eliminado de favoritos'
                            : '${lugar.nombre} añadido a favoritos ❤️',
                      ),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Image.network(
                          lugar.imagenes.first,
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            height: 180,
                            color: Colors.deepPurple.shade100,
                            child: const Center(
                              child: Icon(Icons.broken_image, size: 50, color: Colors.deepPurple),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: CircleAvatar(
                            backgroundColor: Colors.white.withValues(alpha: 0.85),
                            child: IconButton(
                              icon: Icon(
                                esFav ? Icons.favorite : Icons.favorite_border,
                                color: esFav ? Colors.red : Colors.deepPurple,
                              ),
                              onPressed: () {
                                vm.toggleFavorito(lugar.id);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    ListTile(
                      title: Text(
                        lugar.nombre,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Text(
                        lugar.ubicacion,
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.deepPurple,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                      child: Text(
                        lugar.descripcion,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.grey.shade800),
                      ),
                    ),
                    const SizedBox(height: 8.0),
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
