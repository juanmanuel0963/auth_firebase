import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          'hola_mundo': 'Hello world',
          'loading': 'Loading...',
        },
        'es': {
          'hola_mundo': 'Hola mundo',
          'loading': 'Cargando...',
        },
        'pt': {
          'hola_mundo': 'Olá mundo',
          'loading': 'Carregando...',
        },
        'fr': {
          'hola_mundo': 'Salut monde',
          'loading': 'Chargement...',
        }
      };
}
