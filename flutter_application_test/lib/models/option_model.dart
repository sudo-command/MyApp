import 'package:flutter/material.dart';

class Option {
  Icon icon;
  String title;
  String subtitle;
  String navigate;

  Option(
      {required this.icon,
      required this.title,
      required this.subtitle,
      required this.navigate});
}

final options = [
  Option(
      icon: const Icon(Icons.note_alt_outlined, size: 40.0),
      title: 'Notepad',
      subtitle: 'Notes and To Do List',
      navigate: '/toDoList'),
  Option(
      icon: const Icon(Icons.new_releases_outlined,
          size: 40.0, color: Colors.blue),
      title: 'COMING SOON',
      subtitle: 'New Future',
      navigate: ''),
];
