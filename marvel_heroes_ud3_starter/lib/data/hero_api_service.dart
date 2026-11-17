import 'package:http/http.dart' as http;
import '../model/hero_extra.dart';

class HeroApiService {
  HeroApiService({http.Client? client, String? projectUrl, String? publishableKey})
      : _client = client ?? http.Client(),
        projectUrl = projectUrl ?? const String.fromEnvironment('SUPABASE_URL'),
        publishableKey = publishableKey ??
            const String.fromEnvironment('SUPABASE_PUBLISHABLE_KEY');
  final http.Client _client;

  final String projectUrl;
  final String publishableKey;
  static const useSample = bool.fromEnvironment('USE_SAMPLE_API');

  // Solo para ensayar la interfaz durante una incidencia; la API real ya está preparada.
  static const _sample = <String, HeroExtra>{
    'capitan_america': HeroExtra(heroId: 'capitan_america', team: 'Vengadores', extraInfo: 'Lidera al equipo.'),
    'iron_man': HeroExtra(heroId: 'iron_man', team: 'Vengadores', extraInfo: 'Diseña su propia armadura.'),
    'hulk': HeroExtra(heroId: 'hulk', team: 'Vengadores', extraInfo: 'Combina ciencia y fuerza.'),
    'viuda_negra': HeroExtra(heroId: 'viuda_negra', team: 'Vengadores', extraInfo: 'Especialista en inteligencia.'),
    'thor': HeroExtra(heroId: 'thor', team: 'Vengadores', extraInfo: 'Portador del trueno.'),
    'gamora': HeroExtra(heroId: 'gamora', team: 'Guardianes', extraInfo: 'Forma parte de los Guardianes.'),
  };

  // RETO UD3 A2: petición HTTPS real, código, JSON y validación del ID.
  Future<HeroExtra> fetch(String heroId) async {
    if (useSample) {
      return _sample[heroId] ?? (throw StateError('Héroe sin muestra'));
    }
    throw StateError('RETO UD3 A2: completar consulta HTTPS a Supabase');
  }

  void close() => _client.close();
}
