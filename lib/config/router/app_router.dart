import 'package:clientes_app/config/router/app_router_notifier.dart';
import 'package:clientes_app/features/auth/presentations/providers/auth_provider.dart';
import 'package:clientes_app/presentation/screens/bussiness_availability_screen.dart';
import 'package:clientes_app/presentation/screens/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentations/screens/index.dart';

final appRouterProvider = Provider((ref) {
  final goRouterNotifier = ref.read(goRouterNotifierProvider);

  return GoRouter(
    refreshListenable: goRouterNotifier,
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const CheckAuthStatusScreen(),
      ),
      //* Auth Routes
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      //* Bussiness Routes
      GoRoute(
        path: '/',
        builder: (context, state) => HomeScreen(),
      ),
      // todo necesito que el availability, solo pide el bussID
      GoRoute(
        path: '/bussiness/ava/:id',
        builder: (context, state) => BussinessAvailabilityScreen(
            bussID: state.pathParameters['id'] ?? 'no-id'),
      )
    ],
    redirect: (context, state) {
      // este redirect siempre se pasa por aca, antes de moverse a alguna ruta. el context es el mismo de siempre, y el state es el estado del router. home default ....etc
      // para utilizar este redirect, cada vez que se actualiza el state, fue que construimos el ChangeNotifier
      final isGoingTo = state.fullPath;
      final authStatus = goRouterNotifier.authStatus;
      if (isGoingTo == '/splash' && authStatus == AuthStatus.checking) {
        return null;
      }
      if (authStatus == AuthStatus.notAuthenticated) {
        if (isGoingTo == '/login' || isGoingTo == '/register') return null;
        return '/login';
      }
      if (authStatus == AuthStatus.authenticated) {
        if (isGoingTo == '/login' ||
            isGoingTo == '/register' ||
            isGoingTo == '/splash') {
          return '/';
        }
      }
      return null;
    },
  );
});
