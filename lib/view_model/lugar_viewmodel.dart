import 'package:flutter/material.dart';
import '../model/lugar_model.dart';

class LugarViewModel extends ChangeNotifier {
  //variable
  final List<LugarModel> _lugares = [
    LugarModel(
      id: '1',
      nombre: 'Islas Galápagos',
      descripcion:
          'Un paraíso natural único en el mundo con especies endémicas y playas de aguas cristalinas.',
      ubicacion: 'Archipiélago de Galápagos, Ecuador',
      imagenes: [
        'https://images.unsplash.com/photo-1544735716-392fe2489ffa?w=800',
        'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800',
        'https://images.unsplash.com/photo-1518709268805-4e9042af9f23?w=800',
      ],
    ),
    LugarModel(
      id: '2',
      nombre: 'Baños de Agua Santa',
      descripcion:
          'La capital de la aventura, famosa por sus cascadas imponentes, aguas termales y deportes extremos.',
      ubicacion: 'Tungurahua, Ecuador',
      imagenes: [
        'https://images.unsplash.com/photo-1432405972618-c60b0225b8f9?w=800',
        'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800',
        'https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=800',
      ],
    ),
    LugarModel(
      id: '3',
      nombre: 'Volcán Cotopaxi',
      descripcion:
          'Uno de los volcanes activos más altos del mundo, rodeado de páramos andinos y lagunas.',
      ubicacion: 'Cotopaxi, Ecuador',
      imagenes: [
        'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?w=800',
        'https://images.unsplash.com/photo-1519681393784-d120267933ba?w=800',
        'https://images.unsplash.com/photo-1486870591958-9b9d0d1dda99?w=800',
      ],
    ),
    LugarModel(
      id: '4',
      nombre: 'Laguna del Quilotoa',
      descripcion:
          'Una caldera volcánica con una impresionante laguna de aguas esmeralda en medio de la cordillera.',
      ubicacion: 'Pujilí, Cotopaxi, Ecuador',
      imagenes: [
        'https://images.unsplash.com/photo-1506744038136-46273834b3fb?w=800',
        'https://images.unsplash.com/photo-1470071459604-3b5ec3a7fe05?w=800',
        'https://images.unsplash.com/photo-1501785888041-af3ef285b470?w=800',
      ],
    ),
    LugarModel(
      id: '5',
      nombre: 'Centro Histórico de Cuenca',
      descripcion:
          'Ciudad colonial Patrimonio de la Humanidad, con arquitectura clásica, catedrales y calles empedradas.',
      ubicacion: 'Azuay, Ecuador',
      imagenes: [
        'https://images.unsplash.com/photo-1513694203232-719a280e022f?w=800',
        'https://images.unsplash.com/photo-1477959858617-67f30bc75b82?w=800',
        'https://images.unsplash.com/photo-1518709268805-4e9042af9f23?w=800',
      ],
    ),
  ];

  final List<String> _favoritosIds = [];
  LugarModel? _lugarSeleccionado;
  int _imagenActual = 0;

  //metodos
  List<LugarModel> get lugares => _lugares;
  List<String> get favoritosIds => _favoritosIds;
  LugarModel? get lugarSeleccionado => _lugarSeleccionado;
  int get imagenActual => _imagenActual;

  bool esFavorito(String id) {
    return _favoritosIds.contains(id);
  }

  void toggleFavorito(String id) {
    if (_favoritosIds.contains(id)) {
      _favoritosIds.remove(id);
    } else {
      _favoritosIds.add(id);
    }
    notifyListeners();
  }

  void seleccionarLugar(LugarModel lugar) {
    _lugarSeleccionado = lugar;
    _imagenActual = 0;
    notifyListeners();
  }

  void cambiarImagen(int nuevoIndice) {
    _imagenActual = nuevoIndice;
    notifyListeners();
  }

  void siguienteImagen() {
    if (_lugarSeleccionado != null && _lugarSeleccionado!.imagenes.isNotEmpty) {
      if (_imagenActual < _lugarSeleccionado!.imagenes.length - 1) {
        _imagenActual++;
      } else {
        _imagenActual = 0; // Vuelve a la primera imagen
      }
      notifyListeners();
    }
  }

  void anteriorImagen() {
    if (_lugarSeleccionado != null && _lugarSeleccionado!.imagenes.isNotEmpty) {
      if (_imagenActual > 0) {
        _imagenActual--;
      } else {
        _imagenActual = _lugarSeleccionado!.imagenes.length - 1; // Va a la última imagen
      }
      notifyListeners();
    }
  }
}
