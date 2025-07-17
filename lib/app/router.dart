import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:imdb_app/data/model/movie_model.dart';
import 'package:imdb_app/features/home/auth/create_account_page.dart';
import 'package:imdb_app/features/home/auth/forgot_password_page.dart';
import 'package:imdb_app/features/home/auth/reset_password_page.dart';
import 'package:imdb_app/features/home/auth/sign_in_page.dart';
import 'package:imdb_app/features/home/auth/verify_email.dart';
// import 'package:imdb_app/features/home/cast_page.dart';
import 'package:imdb_app/features/home/most_popular_page.dart';
import 'package:imdb_app/features/home/movie_page.dart';
import 'package:imdb_app/screens/browser.dart';
import 'package:imdb_app/screens/discover.dart';
import 'package:imdb_app/features/home/home.dart';
import 'package:imdb_app/screens/profile.dart';

class AppRoutes {
  AppRoutes._();
  static const String home = '/';
  static const String mostPopularMovies = "/most_popular_movies";
  static const String movie = "/movie/:id";
  static const String cast = "/cast";
  static const String browser = '/browser';
  static const String discover = '/discover';
  static const String profile = '/profile';
  static const String login = '/login';
  static const String createAccount = '/create-account';
  static const String verifyEmail = '/verify-email';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';
}

final appRoutes = GoRouter(
  initialLocation:
      '/', //Uygulama başlatıldığında varsayılan başlangıç konumunu temsil eder.
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          bottomNavigationBar: _bottomNavBar(context, state),
          body: child,
        );
      },
      routes: [
        GoRoute(
          name: "home",
          path: AppRoutes.home,
          pageBuilder: (context, state) {
            return const MaterialPage(child: HomePage());
          },
        ),
        GoRoute(
          name: "most-popular-movies",
          path: AppRoutes.mostPopularMovies,
          pageBuilder: (context, state) {
            final List<MovieModel> allMovies = state.extra as List<MovieModel>;
            return MaterialPage(child: MostPopularPage(allMovies: allMovies));
          },
        ),
        GoRoute(
          name: "movie",
          path: AppRoutes.movie,
          pageBuilder: (context, state) {
            final movieId = state.pathParameters['id']!;
            return MaterialPage(child: MoviePage(movieId: int.parse(movieId)));
          },
        ),
        // GoRoute(
        //   name: "cast",
        //   path: AppRoutes.cast,
        //   pageBuilder: (context, state) {
        //     final List<Actor> cast = state.extra as List<Actor>;
        //     return MaterialPage(child: CastPage(cast: cast));
        //   },
        // ),
        GoRoute(
          name: "browser",
          path: AppRoutes.browser,
          pageBuilder: (context, state) {
            return const MaterialPage(child: BrowserPage());
          },
        ),
        GoRoute(
          name: "discover",
          path: AppRoutes.discover,
          pageBuilder: (context, state) {
            return const MaterialPage(child: DiscoverPage());
          },
        ),
        GoRoute(
          name: "profile",
          path: AppRoutes.profile,
          pageBuilder: (context, state) {
            return const MaterialPage(child: ResetPasswordPage());
          },
        ),
        GoRoute(
          name: "login",
          path: AppRoutes.login,
          pageBuilder: (context, state) {
            return const MaterialPage(child: SignInPage());
          },
        ),
        GoRoute(
          name: "crate-account",
          path: AppRoutes.createAccount,
          pageBuilder: (context, state) {
            return const MaterialPage(child: CreateAccountPage());
          },
        ),
        GoRoute(
          name: "verify-email",
          path: AppRoutes.verifyEmail,
          pageBuilder: (context, state) {
            return const MaterialPage(child: VerifyEmailPage());
          },
        ),
        GoRoute(
          name: "forgot-password",
          path: AppRoutes.forgotPassword,
          pageBuilder: (context, state) {
            return const MaterialPage(child: ForgotPasswordPage());
          },
        ),
        GoRoute(
          name: "reset-password",
          path: AppRoutes.resetPassword,
          pageBuilder: (context, state) {
            return const MaterialPage(child: ResetPasswordPage());
          },
        ),
      ],
    ),
  ],
);

BottomNavigationBar _bottomNavBar(BuildContext context, GoRouterState state) {
  final String location = state.uri.toString();
  int currentIndex = 0;
  if (location == '/browser') {
    currentIndex = 1;
  } else if (location == '/discover') {
    currentIndex = 2;
  } else if (location == '/profile') {
    currentIndex = 3;
  }

  return BottomNavigationBar(
    type: BottomNavigationBarType.fixed, // Bunu ekleyin
    currentIndex: currentIndex,
    onTap: (index) {
      switch (index) {
        case 0:
          GoRouter.of(context).go('/');
          break;
        case 1:
          GoRouter.of(context).go('/browser');
          break;
        case 2:
          GoRouter.of(context).go('/discover');
          break;
        case 3:
          GoRouter.of(context).go('/profile');
          break;
      }
    },
    unselectedItemColor: Theme.of(context).colorScheme.surface,
    selectedItemColor: Theme.of(context).colorScheme.primary,
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined),
        activeIcon: Icon(Icons.home),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.analytics_outlined),
        activeIcon: Icon(Icons.analytics_rounded),
        label: 'Browser',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.play_arrow_outlined),
        activeIcon: Icon(Icons.play_arrow_rounded),
        label: 'Discover',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.search),
        activeIcon: Icon(Icons.search_rounded),
        label: 'Profile',
      ),
    ],
  );
}

AppBar topNavBar(BuildContext context, String? title) {
  return AppBar(
    automaticallyImplyLeading: true, // Geri butonunu gerektiğinde gösterir
    toolbarHeight: 60,
    title: Text(title ?? ""),
    titleTextStyle: TextStyle(
      color: Theme.of(context).colorScheme.secondary.withAlpha(220),
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    centerTitle: true,
    leading: (Navigator.of(context).canPop())
        ? BackButton(color: Theme.of(context).colorScheme.secondary)
        : Image.asset("assets/img/imdb-logo.png"),
    actions: [
      Container(
        margin: EdgeInsets.only(right: 10),
        child: Icon(
          Icons.notifications,
          size: 24,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    ],
    backgroundColor: Theme.of(context).colorScheme.primary,
  );
}
