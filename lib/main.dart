import 'package:flutter/material.dart';
import 'package:government_app/routes/routes.dart';
import 'package:government_app/screens/home/views/home_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Homeprovider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
          ),
          textTheme: const TextTheme(),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.green.shade600,
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: Colors.green.shade600,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade600,
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
                foregroundColor: Colors.black.withAlpha(200)),
          ),
        ),
        // darkTheme: ThemeData.dark().copyWith(
        //   // scaffoldBackgroundColor: Colors.blue,
        //   appBarTheme: const AppBarTheme(
        //     backgroundColor: Colors.blue,
        //   ),
        //   textTheme: const TextTheme(
        //     bodyMedium: TextStyle(
        //         color: Colors.white,
        //         fontSize: 40,
        //         fontWeight: FontWeight.bold,
        //         // fontStyle: FontStyle.italic,
        //         fontFamily: 'poppins'),
        //   ),
        //   floatingActionButtonTheme: const FloatingActionButtonThemeData(
        //     backgroundColor: Colors.blue,
        //   ),
        //   elevatedButtonTheme: ElevatedButtonThemeData(
        //     style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
        //   ),
        // ),
        routes: AppRoutes.allRoutes,
      ),
    );
  }
}
