import 'package:flutter/material.dart';
import '../data/heroes.dart';
import '../data/peer_service.dart';

class PeerScreen extends StatefulWidget {
  const PeerScreen({super.key});
  @override
  State<PeerScreen> createState() => _PeerScreenState();
}

class _PeerScreenState extends State<PeerScreen> {
  final PeerService service = PeerService();
  final TextEditingController ip = TextEditingController();
  String selected = heroes.first.id;
  String myIp = 'Iniciando receptor…';
  String received = 'Aún no se ha recibido ningún héroe.';
  String result = '';

  @override
  void initState() {
    super.initState();
    service.start((id) {
      if (mounted) setState(() => received = 'Recibido: $id');
    }).then((value) {
      if (mounted) setState(() => myIp = value);
    }).catchError((Object error) {
      if (mounted) setState(() => myIp = 'Receptor no disponible: $error');
    });
  }

  @override
  void dispose() {
    service.close();
    ip.dispose();
    super.dispose();
  }

  Future<void> send() async {
    setState(() => result = 'Enviando…');
    try {
      final confirmation = await service.send(ip.text, selected);
      if (mounted) setState(() => result = confirmation);
    } catch (error) {
      if (mounted) setState(() => result = 'Sin confirmación: $error');
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Intercambio Wi-Fi')),
    body: SafeArea(child: ListView(padding: const EdgeInsets.all(20), children: [
      const Text('Conecta ambos móviles a la misma Wi-Fi. En el receptor deja abierta esta pantalla.'),
      const SizedBox(height: 12),
      SelectableText('IP de este móvil: $myIp'),
      Text(received, key: const ValueKey('received-hero')),
      const Divider(height: 32),
      TextField(controller: ip, keyboardType: TextInputType.number,
        decoration: const InputDecoration(labelText: 'IPv4 del receptor', hintText: '192.168.1.20')),
      DropdownButton<String>(value: selected, isExpanded: true,
        items: [for (final hero in heroes) DropdownMenuItem(value: hero.id, child: Text(hero.name))],
        onChanged: (value) => setState(() => selected = value ?? selected)),
      FilledButton(onPressed: send, child: const Text('Enviar héroe')),
      Text(result, key: const ValueKey('send-result')),
    ])),
  );
}
