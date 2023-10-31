import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theia/theme/theme.dart';
import 'package:theia/theme/theme_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeBloc>(
      create: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeMode>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Theia',
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            // toggleable dark/light theme
            themeMode: state,
            home: const MyHomePage(title: 'Theia'),
          );
        },
      ),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              final isDark = context.read<ThemeBloc>().state == ThemeMode.dark;
              context.read<ThemeBloc>().add(ThemeChanged(!isDark));
            },
            icon: context.read<ThemeBloc>().state == ThemeMode.dark
                ? const Icon(Icons.brightness_7) // Light theme icon
                : const Icon(Icons.brightness_4), // Dark theme icon
          )
          // Switch(
          //   value: context.read<ThemeBloc>().state == ThemeMode.dark,
          //   onChanged: (value) {
          //     context.read<ThemeBloc>().add(ThemeChanged(value));
          //   },
          // )
        ],
      ),
    );
  }
}
