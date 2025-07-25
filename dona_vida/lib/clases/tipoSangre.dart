class TipoSangre {
  String tipo;
  String rh;

  TipoSangre({required this.tipo, required this.rh});

  @override
  String toString() {
    return '$tipo$rh';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    final TipoSangre otherTipo = other as TipoSangre;
    return tipo == otherTipo.tipo && rh == otherTipo.rh;
  }

  @override
  int get hashCode => tipo.hashCode ^ rh.hashCode;
}