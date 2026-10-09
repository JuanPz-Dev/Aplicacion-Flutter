import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'features/movies/presentation/movies_controller.dart';
import 'features/movies/presentation/screens/movies_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  runApp(const CineLogApp());
}

class CineLogApp extends StatelessWidget {
  const CineLogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MoviesController()..loadMovies(),
      child: MaterialApp(
        title: 'CineLog',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorSchemeSeed: Colors.indigo,
          useMaterial3: true,
        ),
        home: const MoviesScreen(),
      ),
    );
  }
}