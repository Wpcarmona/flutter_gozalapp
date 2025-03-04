import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gozalapp/config/router/app_router_notifier.dart';
import 'package:gozalapp/presentation/providers/auth/auth_provider.dart';
import 'package:gozalapp/presentation/screens/screens.dart';

final goRouterProvider = Provider((ref) {
  final goRouterNofier = ref.read(goRouterNotifierProvider);

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: goRouterNofier, 
    routes: [
      GoRoute(
        path: '/',
        name: TabsScreen.name,
        builder: (context, state) => const TabsScreen(),
      ),
      GoRoute(
        path: '/splash',
        builder: (context, state) => const CheckAuthStatusScreen(),
      ),
      GoRoute(
          path: '/notifications',
          builder: (context, state) => const NotificationScreen(),
          routes: []),
      GoRoute(
        path: '/push-details/:messageId',
        builder: (context, state) => DetailsnotificationScreen(
            pushMessageId: state.pathParameters['messageId'] ?? ''),
      ),
      GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
          routes: []),
      GoRoute(
        path: '/auth/login',
        name: LoginScreen.name,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/auth/register',
        name: RegisterScreen.name,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/auth/reset-password',
        name: ResetPasswordScreen.name,
        builder: (context, state) => const ResetPasswordScreen(),
      ),
  ],
  redirect: (context, state) {
    final isGoinTo = state.matchedLocation;
    final authStatus = goRouterNofier.authStatus;

    if(isGoinTo == '/splash' && authStatus == AuthStatus.checking) return null;
    if(authStatus == AuthStatus.chekingOTp || authStatus == AuthStatus.chekingType){
      if(isGoinTo == '/auth/login' || isGoinTo == '/auth/register') return null;
      return '/auth/login';
    }
    if(authStatus == AuthStatus.notAuthenticated){
      if(isGoinTo == '/auth/login' || isGoinTo == '/auth/register') return null;
      return '/auth/login';
    }
    if(authStatus == AuthStatus.authenticated){
      if(isGoinTo == '/auth/login' || isGoinTo == '/auth/register' || isGoinTo == '/splash') return '/';
    }

    return null;
  },
  );
});
