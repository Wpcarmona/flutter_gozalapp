import 'package:go_router/go_router.dart';
import 'package:gozalapp/presentation/screens/screens.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [
  GoRoute(
    path: '/',
    name: TabsScreen.name,
    builder: (context, state) => const TabsScreen(),
    routes: [
      
    ]),
]);
