import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter_initializers_20220229',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Initializers 20220229'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with TickerProviderStateMixin {
  int _counter = 0;
  bool selected = false;

  late final AnimationController _fadeController = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);

  late final Animation<double> _fadeAnimation = CurvedAnimation(
    parent: _fadeController,
    curve: Curves.easeIn,
  );

  late final AnimationController _slideController = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);

  late final Animation<Offset> _slideAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(1.5, 0.0),
  ).animate(CurvedAnimation(
    parent: _slideController,
    curve: Curves.elasticIn,
  ));

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          Positioned( //Widgets RichText en la esquina superior derecha.
            right: 25,
            child: RichText(
              text: const TextSpan(
                text: 'Esta página',
                style: TextStyle(
                  color: Color.fromARGB(255, 207, 110, 188), // Letra color negro
                  fontStyle: FontStyle.italic, // Letra estilo cursiva
                ),
                children: <TextSpan>[
                  TextSpan(text: ' esta hecha por'),
                  TextSpan(
                    text: ' YAKSI.',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[ //widget para imprimir texto.
                const Text(
                  'Has presionado el botón tantas veces:',
                ),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),

                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Icon(
                      Icons.favorite,
                      color: Color.fromARGB(255, 215, 88, 213),
                      size: 20,
                      semanticLabel: 'Text to announce in accessibility modes',
                    ),
                    Icon(
                      Icons.audiotrack,
                      color: Color.fromARGB(255, 158, 68, 169),
                      size: 20,
                    ),
                    Icon(
                      Icons.beach_access,
                      color: Color.fromARGB(255, 144, 16, 179),
                      size: 20,
                    ),
                  ],
                ),

                //Widgets: añade espacio entre el texto y la imagen
                const SizedBox(height: 0), 

                // Widgets para agregar una imagen en el centro.
                const Image(
                  height: 50,
                  image: NetworkImage(
                    'https://circuloplussanborns.imgix.net/single_image/2020/08/7622/bt21.png?w=1110&h=550&fit=crop&crop=faces',
                  ),
                ),

                // Widgets AnimatedAlign, esto nos proporciona animar una imagen.
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selected = !selected;
                    });
                  },
                  child: SizedBox( //widgets
                    width: 80,
                    height: 80,
                    child: AnimatedAlign(
                      alignment: selected
                          ? Alignment.topRight
                          : Alignment.bottomLeft,
                      duration: const Duration(seconds: 2),
                      curve: Curves.fastOutSlowIn,
                      child: Image.network(
                        'https://www.soundpark.news/__export/1639018463915/sites/debate/img/2021/12/08/jimin_x1x_x1x.jpg_423682103.jpg',
                        width: 80,
                        height: 80,
                      ),
                    ),
                  ),
                ),

                // Widgets FadeTransition para animar la imagen. Esto hace que aparezca y desaparezca.
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Image.network(
                      'https://pbs.twimg.com/media/EV7498rXsAY1VZ-.jpg',
                      width: 80,
                      height: 80,
                    ),
                  ),
                ),

                // Widgets SlideTransition
                SlideTransition(
                  position: _slideAnimation,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRZ0nuv1orgvNMGu6GsclkxsYWpFCz299SYwA&usqp=CAU',
                      width: 80,
                      height: 80,
                    ),
                  ),
                ),
                // Widgets Checkbox.
                  ColoredBox(
                    color: const Color.fromARGB(255, 209, 176, 234),
                    child: Material(
                      child: CheckboxListTile(
                        tileColor: const Color.fromARGB(255, 253, 128, 193),
                        title: const Text('CheckboxListTile'),
                        value: true,
                        onChanged:(bool? value) { },
                      ),
                  ),
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Campo de Texto'),
                ),
                
                OutlinedButton(
                  onPressed: () {
                    print('Botón Contorneado Presionado');
                  },
                  child: const Text('Botón Contorneado'),
                ),

                Switch(
                  value: true,
                  onChanged: (value) {
                    print('Interruptor Cambiado: $value');
                  },
                ),

              ],
              
            ),
          ),

          // Widgets RichText en la esquina inferior izquierda.
          Positioned(
            left: 10,
            bottom: 15,
            child: RichText( 
              text: const TextSpan(
                text: '¡Te amo -',
                style: TextStyle(
                  color: Color.fromARGB(255, 207, 110, 188), // Letra color negro.
                  fontStyle: FontStyle.italic, // Letra estilo cursiva
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: ' Tame -',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: ' Love u!'),
                ],
              ),
            ),
          ),
          ListTile(
                  title: const Text('Elemento de Lista'),
                  leading: const Icon(Icons.list),
                  onTap: () {
                    print('Elemento de Lista Presionado');
                  },
                ),
        ],
      ),
    
      
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Incrementar',
        child: const Icon(Icons.add),
      ),
    );
  }
}