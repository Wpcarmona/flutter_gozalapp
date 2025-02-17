import 'package:go_router/go_router.dart';
import 'package:gozalapp/presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/', 
  routes: [
    GoRoute(
      path: '/',
      name: TabsScreen.name,
      builder: (context, state) => const RegisterScreen(),
      ),
    GoRoute(
      path: 'auth/login',
      name: LoginScreen.name,
      builder: (context, state) => const LoginScreen(),
      ),
    GoRoute(
      path: 'auth/register',
      name: RegisterScreen.name,
      builder: (context, state) => const RegisterScreen(),
      ),
    ]
);
