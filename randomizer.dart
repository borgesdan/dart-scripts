import 'dart:math';

///Enumera se a letra é minúscula, maiúscula ou indiferente.
enum LetterType{
  lowerCase,
  upperCase,
  any
}

///Providência acesso a geração de sequêcias aleatórias.
class Randomizer{

  Random _random;   

  //Cria um novo gerador de sequências aleatórias.
  Randomizer(){
    _random = Random();    
  }

  ///Cria um novo gerador de sequências aleatórias informando o [seed].
  Randomizer.seed(int seed){
    _random = Random(seed);
  } 

//-------------------------------------------//
//                  FUNÇÕES                  //
//-------------------------------------------//

  int _sortLetters(int start, int end){
    int number = next(start, end + 1);
    
    //91 [, 92 \, 93 ],
    //94 ^, 95 _, 96 `
    if(number >= 91 && number <= 96){
      number = _sortLetters(start, end);
    }    
    return number;
  }  

  ///Obtém um inteiro não-negativo informando o número minímo e máximo (exclusivo).
  ///
  ///[min]: define o número minímo entre 0 e [max].
  ///[max]: define o número máximo a ser retornado, excluíndo esse.
  int next(int min, int max){
    return min + _random.nextInt(max - min);
  }  

  ///Retorna uma sequência númerica de inteiros não-negativos.
  ///
  ///[digits]: define a quantidade de dígitos da sequência.
  ///Retorna -1 caso ocorra algum erro.
  int getOnlyNumbers(int digits){    
    try{
      //$digits = 2
      //10 ^ 2 = 100
      int max = pow(10, digits);    
      //10 ^ (2 - 1)
      int min = pow(10, digits - 1);
      //next entre 10 e 99    
      int number = next(min, max);
      return number;
    }catch (e) {
      print(e);
      return -1;
    }    
  }

  ///Retorna uma sequência de letras maiúsculas, minúsculas ou ambas.
  ///
  ///[count]: define a quantidade de letras da sequência.
  ///[type]: define o tipo da sequência de letras.
  String getOnlyLetters(int count, LetterType type){
    //de A até Z 65 - 90
    //de a até z 97 - 122
    int start = "A".codeUnits.first; //65
    int end = "z".codeUnits.last; //122        
    //excluir
    //91 [, 92 \, 93 ],
    //94 ^, 95 _, 96 `

    switch(type){
      case LetterType.any:
        start = "A".codeUnits.first;
        end = "z".codeUnits.last;        
      break;
      case LetterType.lowerCase:
        start = "a".codeUnits.first;
        end = "z".codeUnits.last;
      break;
      case LetterType.upperCase:
        start = "A".codeUnits.first;
        end = "Z".codeUnits.last;
      break;
    }

    List<int> chars = new List();

    for(int i = 0; i < count; i++){
      int c = _sortLetters(start, end);
      chars.add(c);
    }

    return String.fromCharCodes(chars);
  }
}