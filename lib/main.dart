import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scan_to_excel/bloc/feed_back_bloc.dart';
import 'package:scan_to_excel/data/service.dart';
import 'package:scan_to_excel/app_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => FeedBackBloc(
                  service: FormService(),
                )),
      ],
      child: MaterialApp(
        title: 'Send Data To Google Sheets',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const AppControllerPage(),
      ),
    );
  }
}
