import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

/// Receptor simple, preparado por el docente; activo solo al abrir la pantalla.
class PeerService {
  HttpServer? _server;
  final http.Client _client = http.Client();

  Future<String> start(void Function(String) onHero) async {
    _server = await HttpServer.bind(InternetAddress.anyIPv4, 8765);
    _server!.listen((request) async {
      request.response.headers.contentType = ContentType.json;
      try {
        if (request.method != 'POST' || request.uri.path != '/hero') {
          request.response.statusCode = HttpStatus.notFound;
          request.response.write(jsonEncode({'ok': false}));
        } else {
          final body = jsonDecode(await utf8.decoder.bind(request).join());
          final id = body is Map ? body['hero_id'] : null;
          if (id is! String || !RegExp(r'^[a-z_]+$').hasMatch(id)) {
            request.response.statusCode = HttpStatus.badRequest;
            request.response.write(jsonEncode({'ok': false}));
          } else {
            onHero(id);
            request.response.write(jsonEncode({'ok': true, 'hero_id': id}));
          }
        }
      } catch (_) {
        request.response.statusCode = HttpStatus.badRequest;
        request.response.write(jsonEncode({'ok': false}));
      } finally {
        await request.response.close();
      }
    });
    final interfaces = await NetworkInterface.list(type: InternetAddressType.IPv4);
    final addresses = interfaces.expand((item) => item.addresses)
        .where((address) => !address.isLoopback).map((address) => address.address);
    return addresses.isEmpty ? 'IP no detectada; consultar Wi-Fi' : addresses.join(' / ');
  }

  // RETO UD3 A3: enviar JSON a la IPv4 de B y comprobar respuesta.
  Future<String> send(String ip, String heroId) async {
    throw StateError('RETO UD3 A3: completar emisor Wi-Fi');
  }

  Future<void> close() async {
    await _server?.close(force: true);
    _client.close();
  }
}
