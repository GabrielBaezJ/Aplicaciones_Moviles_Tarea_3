class LugarModel {
  final String id;
  final String nombre;
  final String descripcion;
  final String ubicacion;
  final List<String> imagenes;

  //constructor
  LugarModel({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.ubicacion,
    required this.imagenes,
  });
}
