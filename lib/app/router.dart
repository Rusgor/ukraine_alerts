import 'package:go_router/go_router.dart';
import '../features/alerts/presentation/screens/home_screen.dart';
import '../features/alerts/presentation/screens/alerts_map_screen.dart';
import '../features/alerts/presentation/screens/region_alerts_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(path: '/map', builder: (context, state) => const AlertsMapScreen()),
    GoRoute(
      path: '/region',
      builder: (context, state) => const RegionAlertsScreen(),
    ),
  ],
);
