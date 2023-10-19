import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> getLoadingMessages(){
      final messages = <String>[
    'Paciencia amigazo',
    'Dale un toque que ya carga',
    'Puto el que lee',
    'Aguanta perri no es tan rapido',
    'Banca no es tan rapido xd',
  ]; 
    return Stream.periodic(const Duration(milliseconds: 1200), (step){
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10,),
          const CircularProgressIndicator(strokeWidth: 2,),
          const SizedBox(height: 10,),

          StreamBuilder(
            stream: getLoadingMessages(),
             builder: (context, snapshot) {
               if(!snapshot.hasData) return const Text('Cargando...');
               return Text(snapshot.data!);
             },
            )
        ],
      ),
    );
  }
}