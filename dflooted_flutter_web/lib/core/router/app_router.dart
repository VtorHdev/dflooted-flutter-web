import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/screens/home/home_screen.dart';

final navigationKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: navigationKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
    // Aquí añadiremos más rutas después
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text(
        'Error: Ruta ${state.uri} no encontrada',
        style: Theme.of(context).textTheme.titleLarge,
      ),
    ),
  ),
);
