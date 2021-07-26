import 'package:flutter/cupertino.dart';

class RodData {
  final int eixoX;
  final List<EixoY> listEixoY;
  final String descricaoEixoX;

  RodData({
    required this.eixoX,
    required this.listEixoY,
    required this.descricaoEixoX,
  });
}

class EixoY {
  final double y;
  final Color color;
  final double width;

  EixoY({required this.y, required this.color, required this.width});
}
