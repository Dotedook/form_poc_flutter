import 'package:flutter/material.dart';
import 'package:form_poc/form.controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Login Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late FormController controller;
  final formKey = GlobalKey<FormState>();

  void _saveForm() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      controller.formNotifier.save();
    }
  }

  @override
  void initState() {
    controller = FormController();

    super.initState();
  }

  Widget buildErrorMessage() {
    return ValueListenableBuilder(
      valueListenable: controller.errorMessage,
      builder: (context, errorMessage, child) =>
          errorMessage.isNotEmpty ? Text(errorMessage) : Container(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        automaticallyImplyLeading: false,
      ),
      body: Form(
        key: formKey,
        child: Container(
          margin: const EdgeInsets.only(
            left: 10.0,
            right: 10.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                initialValue: controller.formNotifier.value.user,
                validator: controller.isEmpty,
                decoration: const InputDecoration(
                  label: Text('Usuário'),
                  contentPadding: EdgeInsets.all(20.0),
                ),
                onSaved: (newValue) => controller.formNotifier.user = newValue!,
              ),
              const SizedBox(height: 10),
              TextFormField(
                initialValue: controller.formNotifier.value.password,
                validator: controller.isEmpty,
                decoration: const InputDecoration(
                  label: Text('Senha'),
                  contentPadding: EdgeInsets.all(20.0),
                ),
                onSaved: (newValue) =>
                    controller.formNotifier.password = newValue!,
              ),
              const SizedBox(height: 20),
              buildErrorMessage(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _saveForm,
                    child: const Text('Enviar Formulário'),
                  )
                ],
              ),
              ValueListenableBuilder(
                  valueListenable: controller.formNotifier,
                  builder: ((context, value, child) {
                    if (value.password.isNotEmpty && value.user.isNotEmpty) {
                      return Column(
                        children: [
                          Text(value.user),
                          Text(value.password),
                        ],
                      );
                    } else {
                      return const Text('AINDA NÃO TEM USER');
                    }
                  }))
            ],
          ),
        ),
      ),
    );
  }
}
