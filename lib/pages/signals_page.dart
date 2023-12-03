import 'package:flutter/material.dart';
import '../models/signal_model.dart';
import '../services/signals_service.dart';
import 'signal_detail_page.dart';

class SignalsPage extends StatefulWidget {
  const SignalsPage({Key? key}) : super(key: key);

  @override
  _SignalsPageState createState() => _SignalsPageState();
}

class _SignalsPageState extends State<SignalsPage> {
  bool singleRowView = true;

  @override
  Widget build(BuildContext context) {
    SignalsService signalsService = SignalsService();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 165, 36, 36),
        title: const Text('Señales de Tráfico'),
        actions: [
          IconButton(
            icon: Icon(singleRowView ? Icons.view_agenda : Icons.view_module),
            onPressed: () {
              setState(() {
                singleRowView = !singleRowView;
              });
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: signalsService.getSignals(),
        builder: (BuildContext context, AsyncSnapshot<List<Signal>> snapshot) {
          if (snapshot.hasData) {
            List<Signal>? signals = snapshot.data;

            return buildSignalList(context, signals ?? []);
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget buildSignalList(BuildContext context, List<Signal> signals) {
    if (singleRowView) {
      return ListView.builder(
        itemCount: signals.length,
        itemBuilder: (context, index) {
          Signal signal = signals[index];

          return Card(
            child: InkWell(
              onTap: () {
                // Navegar a la página de detalles cuando se hace clic
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignalDetailPage(signal: signal),
                  ),
                );
              },
              child: ListTile(
                title: Text(
                  signal.name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                subtitle: Image.asset(
                  signal.image,
                  height: 80,
                ),
              ),
            ),
          );
        },
      );
    } else {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: signals.length,
        itemBuilder: (context, index) {
          Signal signal = signals[index];

          return Card(
            child: InkWell(
              onTap: () {
                // Navegar a la página de detalles cuando se hace clic
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignalDetailPage(signal: signal),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      signal.name,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 100,
                      child: Image.asset(
                        signal.image,
                        fit: BoxFit.cover,
                        alignment: Alignment.bottomCenter,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }
}
