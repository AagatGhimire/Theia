import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theia/theme/theme_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/theia.png',
          fit: BoxFit.cover,
          // height: 30,
          filterQuality: FilterQuality.high,
        ),
        centerTitle: true,
        // button to change theme
        actions: [
          BlocBuilder<ThemeBloc, ThemeMode>(
            builder: (context, state) {
              final isDark = state == ThemeMode.dark;
              return IconButton(
                onPressed: () {
                  context.read<ThemeBloc>().add(ThemeChanged(!isDark));
                },
                icon: context.read<ThemeBloc>().state == ThemeMode.dark
                    ? const Icon(Icons.brightness_7) // Light theme icon
                    : const Icon(Icons.brightness_4), // Dark theme icon
              );
            },
          )
        ],
      ),
    );
  }
}
