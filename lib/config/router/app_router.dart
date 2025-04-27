import 'package:cinema_app/presentation/screens/movies/home_screen.dart';
import 'package:cinema_app/presentation/screens/screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      name: HomeScreen.routeName,
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      name: MovieScreen.routeName,
      path: '/movie/:id',
      builder: (context, state) {
        final movieId = state.pathParameters['id'] ?? 'no-id';
        return MovieScreen(
          movieId: 'movieId: $movieId',
        );
      },
    ),
  ],
);
