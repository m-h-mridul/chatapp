// ignore_for_file: file_names

import 'package:flutter/material.dart';

imageviewForProfile(String secondUserImage) {
  return CircleAvatar(
    radius: 20,
    backgroundColor: Colors.white70,
    backgroundImage: NetworkImage(secondUserImage),
  );
}

