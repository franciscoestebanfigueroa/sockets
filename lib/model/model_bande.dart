class Banda {
  final String nombre;
  final int votos;
  final String id;

  Banda({
    required this.nombre,
    required this.votos,
    required this.id,
  });

  factory Banda.fromMap(Map<String, dynamic> map) => Banda(
        id: map['id'],
        nombre: map['nombre'],
        votos: map['votos'],
      );

  Banda.fromMapa(Map<String, dynamic> mapa)
      : id = mapa['id'],
        nombre = mapa['nombre'],
        votos = mapa['votos'];
}
