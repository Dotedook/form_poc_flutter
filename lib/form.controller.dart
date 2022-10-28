import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class FormNotifier extends ValueNotifier<FormProps> {
  String user = '';
  String password = '';

  FormNotifier() : super(const FormProps(user: '', password: ''));

  void save() {
    value = FormProps(user: user, password: password);
  }
}

class FormProps extends Equatable {
  final String user;
  final String password;

  const FormProps({required this.user, required this.password});

  @override
  List<Object?> get props => [user, password];
}

class FormController {
  FormNotifier formNotifier = FormNotifier();

  ValueNotifier<String> errorMessage = ValueNotifier('');

  String? isEmpty(String? value) {
    if (value == null || value.isEmpty) return 'Este campo não pode ser vazio';

    return null;
  }
}
