import 'package:pmf_admin/core/utils/customs/appbar_content.dart';
import 'package:flutter/material.dart';

var appBar = AppBar(
  bottom: PreferredSize(
    preferredSize: const Size.fromHeight(0.0),
    child: Container(
      color: Colors.grey,
      height: 1,
    ),
  ),
  toolbarHeight: 30,
  backgroundColor: Colors.white,
  title: const CustomAppbarContent(),
);
