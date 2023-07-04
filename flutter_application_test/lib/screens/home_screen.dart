import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_test/models/option_model.dart';
import 'package:flutter_application_test/widgets/alert_dialog_ok_widget.dart';
import 'package:flutter_application_test/widgets/date_time_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "MY LIFE",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => const CustomAlertDialogOK(
                      title: 'Hey Guys',
                      message: 'No one helps you but yourself.',
                    ),
                  );
                },
                child: const Text(
                  "HELP",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ))
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: options.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (index < 0) {
                      return const SizedBox(height: 15.0);
                    } else if (index == options.length) {
                      return const SizedBox(height: 100.0);
                    }
                    return Container(
                      alignment: Alignment.center,
                      margin: index == 0
                          ? const EdgeInsets.fromLTRB(10, 50.0, 10.0, 10.0)
                          : const EdgeInsets.all(10.0),
                      width: double.infinity,
                      height: 80.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: Colors.black26)),
                      child: ListTile(
                        leading: options[index].icon,
                        title: Text(
                          options[index].title,
                          style: const TextStyle(color: Colors.black),
                        ),
                        subtitle: Text(
                          options[index].subtitle,
                          style: const TextStyle(color: Colors.black),
                        ),
                        selected: index == 0 ? true : false,
                        onTap: () {
                          if (index == 0) {
                            Navigator.pushNamed(
                                context, options[index].navigate);
                          }
                        },
                      ),
                    );
                  }),
            ),
            Container(
              height: 50,
              alignment: Alignment.center,
              decoration: const BoxDecoration(color: Colors.red),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(child: ClockWidget()),
                  const Spacer(),
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        onPressed: () => exit(0),
                        child: Icon(
                          Icons.exit_to_app,
                          color: Colors.red[900],
                        )),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
