class Banda {
  final String name;
  final int votos;
  final String id;

  Banda({
    required this.name,
    required this.votos,
    required this.id,
  });

  factory Banda.fromMap(Map<String, dynamic> map) => Banda(
        id: map['id'],
        name: map['name'],
        votos: map['votos'],
      );

  Banda.fromMapa(Map<String, dynamic> mapa)
      : id = mapa['id'] ?? '0',
        name = mapa['name'] ?? 'sin nombre',
        votos = mapa['votos'] ?? 0;
}
