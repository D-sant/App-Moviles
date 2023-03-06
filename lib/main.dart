import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multi-Herramienta'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Center(
                child: Text(
                  'Menú',
                  style: TextStyle(fontSize: 45),
                ),
              ),
            ),
            ListTile(
              title: const Text(
                'Adivina tu género',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AdivinaGenero()),
                );
              },
            ),
            ListTile(
              title: const Text(
                'Adivina tu edad',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AdivinaEdad()),
                );
              },
            ),
            ListTile(
              title: const Text(
                'Universidades',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const Universidades()),
                );
              },
            ),
            ListTile(
              title: const Text(
                'Clima RD',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ClimaRD()),
                );
              },
            ),
            ListTile(
              title: const Text(
                'Acerca de',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AcercaDe()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(65),
              child: Image.network(
                'https://promart.vteximg.com.br/arquivos/ids/6693889-1000-1000/15699.jpg?v=638098340662430000',
                width: 350,
                height: 350,
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              'Aplicacion',
              style: TextStyle(fontSize: 35),
              textAlign: TextAlign.center,
            ),
            const Text(
              'Multi-Herramientas',
              style: TextStyle(fontSize: 35),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

//ADIVINA EL GENERO
class AdivinaGenero extends StatefulWidget {
  const AdivinaGenero({Key? key}) : super(key: key);

  @override
  _AdivinaGeneroState createState() => _AdivinaGeneroState();
}

class _AdivinaGeneroState extends State<AdivinaGenero> {
  String _name = '';
  String _gender = '';

  void _onNameChanged(String value) {
    setState(() {
      _name = value;
    });
  }

  void _fetchGender() async {
    final response =
        await http.get(Uri.parse('https://api.genderize.io/?name=$_name'));
    final responseData = json.decode(response.body);

    setState(() {
      _gender = responseData['gender'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adivina tu género'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              onChanged: _onNameChanged,
              decoration: const InputDecoration(
                labelText: 'Ingresa tu nombre',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _name.isEmpty ? null : _fetchGender,
              child: const Text('Adivinar género'),
            ),
            const SizedBox(height: 16),
            if (_gender.isNotEmpty)
              Expanded(
                child: Container(
                  color: _gender == 'male' ? Colors.blue : Colors.pink,
                  child: Center(
                    child: Text(
                      _gender,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

//ADIVINA EDAD
class AdivinaEdad extends StatelessWidget {
  const AdivinaEdad({Key? key}) : super(key: key);

  Future<Map<String, dynamic>> _getAge(String name) async {
    final response =
        await http.get(Uri.parse('https://api.agify.io/?name=$name'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  String _getMessage(int? age) {
    if (age != null) {
      if (age < 18) {
        return 'Eres joven, disfruta la vida!';
      } else if (age >= 18 && age < 60) {
        return 'Eres adult@, sigue adelante!';
      } else {
        return 'Eres ancian@, disfruta de la vida!';
      }
    } else {
      return 'No pude adivinar tu edad';
    }
  }

  Widget _getImage(int? age) {
    if (age != null) {
      if (age < 18) {
        return Image.network(
            'https://images.pexels.com/photos/91227/pexels-photo-91227.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1');
      } else if (age >= 18 && age < 60) {
        return Image.network(
            'https://images.pexels.com/photos/1043474/pexels-photo-1043474.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1');
      } else {
        return Image.network(
            'https://images.pexels.com/photos/1729931/pexels-photo-1729931.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1');
      }
    } else {
      return Image.network(
          'https://i.pinimg.com/564x/9a/41/30/9a4130c1c186f0f470b1827855886c9f.jpg');
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Adivina tu edad'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Ingresa tu nombre',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                final response = await _getAge(controller.text);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _getImage(response['age']),
                          const SizedBox(height: 16.0),
                          Text(
                            _getMessage(response['age']),
                            style: const TextStyle(fontSize: 18.0),
                            textAlign: TextAlign.center,
                          ),
                          if (response['age'] != null)
                            const SizedBox(height: 16.0),
                          if (response['age'] != null)
                            Text(
                              'Edad: ${response['age']}',
                              style: const TextStyle(fontSize: 18.0),
                              textAlign: TextAlign.center,
                            ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: const Text('Adivinar edad'),
            ),
          ],
        ),
      ),
    );
  }
}

//UNIVERSIDADES
class Universidades extends StatelessWidget {
  const Universidades({Key? key}) : super(key: key);

  Future<List<Universidad>> _buscarUniversidades(String pais) async {
    final response = await http.get(
      Uri.parse('http://universities.hipolabs.com/search?country=$pais'),
    );

    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.body) as List<dynamic>;
      return jsonList.map((e) => Universidad.fromJson(e)).toList();
    } else {
      throw Exception('Error al buscar universidades');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Universidades'),
      ),
      body: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
              labelText: 'Ingresa el nombre del país en inglés',
              hintText: 'Por ejemplo: Dominican Republic',
              contentPadding:
                  EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              labelStyle: TextStyle(fontSize: 18.0),
              hintStyle: TextStyle(fontSize: 18.0),
            ),
            onSubmitted: (value) async {
              try {
                final universidades = await _buscarUniversidades(value);
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) =>
                      UniversidadesList(universidades: universidades),
                ));
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content:
                      Text('No se encontraron universidades para ese país.'),
                ));
              }
            },
          ),
        ],
      ),
    );
  }
}

class UniversidadesList extends StatelessWidget {
  final List<Universidad> universidades;

  const UniversidadesList({Key? key, required this.universidades})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Universidades'),
      ),
      body: ListView.builder(
        itemCount: universidades.length,
        itemBuilder: (context, index) {
          final universidad = universidades[index];
          return ListTile(
            title: Text(universidad.nombre),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Dominio: ${universidad.dominio}'),
                Text('Página web: ${universidad.paginaWeb}'),
              ],
            ),
          );
        },
      ),
    );
  }
}

class Universidad {
  final String nombre;
  final String dominio;
  final String paginaWeb;

  Universidad({
    required this.nombre,
    required this.dominio,
    required this.paginaWeb,
  });

  factory Universidad.fromJson(Map<String, dynamic> json) {
    return Universidad(
      nombre: json['name'] as String,
      dominio: json['domains'][0] as String,
      paginaWeb: json['web_pages'][0] as String,
    );
  }
}

//CLIMA
class ClimaRD extends StatefulWidget {
  const ClimaRD({Key? key}) : super(key: key);

  @override
  _ClimaRDState createState() => _ClimaRDState();
}

class _ClimaRDState extends State<ClimaRD> {
  String temperatura = "";
  String descripcion = "";
  String ciudad = "";
  String icono = "";
  String api = "a0713f09f40d09a7859cd5179c1d9031";
  Future<dynamic> obtenerClima() async {
    String url =
        "http://api.weatherstack.com/current?access_key=$api&query=Dominican%20Republic";
    http.Response response = await http.get(Uri.parse(url));
    var datos = jsonDecode(response.body);
    setState(() {
      temperatura = "${datos["current"]["temperature"]}°C";
      descripcion = datos["current"]["weather_descriptions"][0];
      ciudad = datos["request"]["query"];
      icono = datos["current"]["weather_icons"][0];
    });
  }

  @override
  void initState() {
    super.initState();
    obtenerClima();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clima RD'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              ciudad,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Image.network(icono, height: 100, width: 100),
            const SizedBox(height: 10),
            Text(
              descripcion,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            Text(
              temperatura,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

//AcercaDE
class AcercaDe extends StatelessWidget {
  const AcercaDe({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acerca de'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(65),
              child: Image.asset(
                'img/perfil.jpeg',
                width: 350,
                height: 350,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Juan Pablo Mora Santiago',
              style: TextStyle(fontSize: 25),
            ),
            const SizedBox(height: 10),
            const Text(
              'Correo',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 3),
            const Text(
              'juanpablomorasantiago@gmail.com',
              style: TextStyle(fontSize: 22),
            ),
            const SizedBox(height: 10),
            const Text(
              'Contacto',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 3),
            const Text(
              '(829) 870-9623',
              style: TextStyle(fontSize: 22),
            ),
          ],
        ),
      ),
    );
  }
}
