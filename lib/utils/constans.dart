import 'package:flutter/material.dart';

class AppColors {
  static const primaryColor = Color(0xFF365486);
  static const secondaryColor = Color(0xFF7FC7D9);
  static const backgroundColor = Color(0xFFDCF2F1);
  static const accentColor = Color(0xFF0F1035);
  static const textColor = Color(0xFF0F1035);
}

class AppText {
  static const appName = 'Split Bill';
  static const addBillTitle = 'Tambah Tagihan';
  static const billNameHint = 'Nama Tagihan';
  static const billAmountHint = 'Jumlah';
  static const saveButton = 'Simpan';
}

class AppStyles {
  static const appBarTitleStyle = TextStyle(color: Colors.white, fontSize: 20);
  static const inputLabelStyle = TextStyle(color: AppColors.textColor);
  static const buttonTextStyle = TextStyle(color: Colors.white, fontSize: 16);
}