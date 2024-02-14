import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _infoText = "Informe seus dados";

  void _resetFields() {
    weightController.clear();
    heightController.clear();

    setState(() {
      _infoText = "Informe seus dados";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculateIMC() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;

      double imc = weight / (height * height);

      if (imc < 18.5) {
        _infoText =
            "Seu IMC é ${imc.toStringAsPrecision(4)}\n. Você está abaixo do peso";
      } else if (imc >= 18.5 && imc < 24.9) {
        _infoText =
            "Seu IMC é ${imc.toStringAsPrecision(4)}\n. Você está no peso ideal";
      } else if (imc >= 24.9 && imc < 29.9) {
        _infoText =
            "Seu IMC é ${imc.toStringAsPrecision(4)}\n. Você está sobrepeso";
      } else if (imc >= 29.9 && imc < 34.9) {
        _infoText =
            "Seu IMC é ${imc.toStringAsPrecision(4)}\n. Você está com obesidade grau I";
      } else if (imc >= 34.9 && imc < 39.9) {
        _infoText =
            "Seu IMC é ${imc.toStringAsPrecision(4)}\n. Você está com obesidade grau II";
      } else if (imc >= 39.9) {
        _infoText =
            "Seu IMC é ${imc.toStringAsPrecision(4)}\n. Você está com obesidade grau III";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(_resetFields);
            },
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(50, 25, 50, 0),
        child: Form(
          key: _formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            const Icon(
              Icons.person_2_outlined,
              size: 120,
              color: Colors.green,
            ),
            TextFormField(
                controller: weightController,
                validator: (value) {
                  value ??= "";
                  if (value.isEmpty) {
                    return "Insira seu Peso";
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center,
                style:
                    const TextStyle(color: Colors.greenAccent, fontSize: 25)),
            const Padding(padding: EdgeInsets.only(top: 40)),
            TextFormField(
                controller: heightController,
                validator: (value) {
                  value ??= "";
                  if (value.isEmpty) {
                    return "Insira sua Altura";
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(color: Colors.green)),
                textAlign: TextAlign.center,
                style:
                    const TextStyle(color: Colors.greenAccent, fontSize: 25)),
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 30),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _calculateIMC();
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    fixedSize: const Size(40, 50)),
                child: const Text(
                  "Calcular",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            Text(
              _infoText,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.greenAccent, fontSize: 30),
            )
          ]),
        ),
      ),
    );
  }
}
