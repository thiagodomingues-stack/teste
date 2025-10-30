import 'dart:math';

final aleatorio = Random();

//Manipulação de String no console
String pad(String s, int w) =>
    (s.length >= w) ? s.substring(0, w) : s + '' * (w - s.length);

//Formatador de casas decimais
String fmt(num x, {int frac = 1}) => x.toStringAsFixed(frac);

//Extração de número do map de forma segura
double asDouble(Map<String, dynamic> m, String k) => (m[k] as num).toDouble();

//Modelar Sensores com Estado Inicial
final List<Map<String, dynamic>> sensores = [
  {
    'nome': 'Temperatura',
    'unidade': 'C',
    'valor': 26.0,
    'min': 18.0,
    'max': 30.0,
    'ativo': true,
    'critico': false,
    'estado': 'OK',
  },
  {
    'nome': 'Umidade',
    'unidade': '%',
    'valor': 55.0,
    'min': 35.0,
    'max': 75.0,
    'ativo': true,
    'critico': false,
    'estado': 'OK',
  },
  {
    'nome': 'Pressão',
    'unidade': 'hPa',
    'valor': 1013.0,
    'min': 990.0,
    'max': 1030.0,
    'ativo': true,
    'critico': false,
    'estado': 'OK',
  },
  {
    'nome': 'Luz',
    'unidade': 'lm',
    'valor': 400.0,
    'min': 100.0,
    'max': 800.0,
    'ativo': true,
    'critico': false,
    'estado': 'OK',
  },
];

//Definir o enum de estados
enum Estado { inativo, ok, atencao, alerta, critico }

Estado estadoFromString(String s) {
  switch (s) {
    case 'INATIVO':
      return Estado.inativo;
    case 'ATENCAO':
      return Estado.atencao;
    case 'ALERTA':
      return Estado.alerta;
    case 'CRITICO':
      return Estado.critico;
    default:
      return Estado.ok;
  }
}

String estadoToString(Estado e) {
  switch (e) {
    case Estado.inativo:
      return 'INATIVO';
    case Estado.ok:
      return 'OK';
    case Estado.atencao:
      return 'ATENCAO';
    case Estado.alerta:
      return 'ALERTA';
    case Estado.critico:
      return 'CRITICO';
  }
}

String nivel(Map<String, dynamic> sensor){
  final valor = asDouble(sensor, 'valor');
  final min = asDouble(sensor, 'min');
  final max = asDouble(sensor, 'max');

  final banda = max - min;
  final margem = banda * 0.10;
  final histerese = banda * 0.02;

  final atual = estadoFromString(sensor['estado'] as String);

  if(valor < min || valor > max) return 'ALERTA';
  if(valor < min - margem || valor > max + margem) return 'CRITICA';

  if(
      atual == Estado.alerta ||
      atual == Estado.critico ||
      atual == Estado.atencao) {
    final okComHisterese =
        (valor >= min + histerese && valor <= max - histerese);
      return okComHisterese ? 'OK' : 'ATENCAO';
    }

  return 'OK';
}

//FSM: decidir o próximo estado a partir do
// estado atual + nivel + ativo
Estado proximoEstado(Estado atual, String nv, {required bool ativo}){
  if(!ativo) return Estado.inativo;
  switch(atual){
    
    case Estado. inativo;
      ativo ? Estado.ok : Estado.inativo

  }
}
void main() {}
