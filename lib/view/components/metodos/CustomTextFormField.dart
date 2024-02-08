import 'package:flutter/material.dart';

/*
r'^
  (?=.*[A-Z])       // should contain at least one upper case
  (?=.*[a-z])       // should contain at least one lower case
  (?=.*?[0-9])      // should contain at least one digit
  (?=.*?[!@#\$&*~]) // should contain at least one Special character
  .{8,}             // Must be at least 8 characters in length
$

bool isPasswordCompliant(String password, [int minLength = 6]) {
  if (password == null || password.isEmpty) {
    return false;
  }

  bool hasUppercase = password.contains(new RegExp(r'[A-Z]'));
  bool hasDigits = password.contains(new RegExp(r'[0-9]'));
  bool hasLowercase = password.contains(new RegExp(r'[a-z]'));
  bool hasSpecialCharacters = password.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  bool hasMinLength = password.length > minLength;

  return hasDigits & hasUppercase & hasLowercase & hasSpecialCharacters & hasMinLength;
}
**/
class CustomText {
  int? typeText;
  final passwordRegExp = RegExp(r"^.{5,}$");
  final nameRegExp = RegExp(r"^(?=.*[a-zA-Z]).{5,}$");
  final numberRegExp = RegExp(r"^(?=.*[0-9])");
  final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z]+\.[a-zA-Z]+");
  final userNameRegExp = RegExp(r"^.{5,}$");

  String? isValidEmail(String? value) {
    /*!RegExp(r'\S+@\S+\.\S+'*/
    if (value!.isEmpty) {
      return 'Este campo es requerido';
    } else if (!emailRegExp.hasMatch(value)) {
      return "Porfavor ingresa un Email valido";
    }
    return null;
  }

  String? isValidName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo es requerido';
    } else if (value.length < 5) {
      return "Este campo requiere mas de 5 caracteres";
    } else if (!nameRegExp.hasMatch(value)) {
      return "Solo se admiten caracter alfabeticos";
    }
    return null;
  }

  String? isValidNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo es requerido';
    } else if (int.tryParse(value.toString())! < 0) {
      return "Mayor a 0";
    } else if (!numberRegExp.hasMatch(value)) {
      return "Solo se admiten caracteres numericos";
    }
    return null;
  }

  String? isValidUserName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo es requerido';
    } else if (value.length < 5) {
      return "Este campo requiere mas de 5 caracteres";
    } else if (!userNameRegExp.hasMatch(value)) {
      return "Solo se admiten caracter alfabeticos";
    }
    return null;
  }

  String? isValidPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo es requerido';
    } else if (!passwordRegExp.hasMatch(value)) {
      return "Este campo requiere mas de 5 caracteres";
    }
    return null;
  }

  String? isValidPasswordRepeat(String? value) {
    if (value == null || value.isEmpty) {
      return 'Este campo es requerido';
    } else if (!passwordRegExp.hasMatch(value)) {
      return "Este campo requiere mas de 5 caracteres";
    }
    return null;
  }
}
