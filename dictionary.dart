import 'dart:convert';
import 'package:http/http.dart' as http;

//Acesso a API do site dicionario-aberto.net através de um código dart

class Dictionary
{
  String _baseUrl = "https://api.dicionario-aberto.net/";      
  //Retorna a palavra em destaque
  //String _kHighlighted = "wotd";
  //Token para requisitar uma palavra aleatória.
  final String _kRandom = "random";
  //Token para requisitar uma palavra através de uma chave "word/chave"
  final String _kWord = "word/";  

  Dictionary();

  ///Obtém uma requesição do site em formato json.
  ///[key] é a chave a ser adicionada após a url base. Ex.: https://api.dicionario-aberto.net/[$key]
  Future<dynamic> getResponse(String key) async {
    http.Response response = await http.get(_baseUrl + key);
    String body = utf8.decode(response.bodyBytes);
    return json.decode(body);
  }

  ///Obtém um verbete aleatório.
  ///
  ///map { wid, sense, word }
  Future<dynamic> getRandom() async {    
    dynamic body = await _getResponse(_kRandom);    
    return body;
  }

  ///Obtém uma lista de entradas correspondentes ao verbete procurado.
  ///[word] é a palavra desejada a ser buscada.
  ///
  ///(index){
  /// map { word, deletor, revision_id, moderador, xml,
  /// deleted, last_revision, sense, creator, timestamp,
  /// normalized, derived_from, word_id }
  /// }
  Future<dynamic> getWord(String word) async{
    dynamic body = await _getResponse(_kWord + word);
    return body;
  }
}
