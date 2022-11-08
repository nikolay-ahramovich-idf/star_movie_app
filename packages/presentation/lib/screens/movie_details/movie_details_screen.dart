import 'package:domain/entities/base_movie_entity.dart';
import 'package:flutter/material.dart';
import 'package:presentation/bloc/base/bloc_screen.dart';
import 'package:presentation/extensions/string.dart';
import 'package:presentation/navigation/base_arguments.dart';
import 'package:presentation/navigation/base_page.dart';
import 'package:presentation/screens/movie_details/movie_details_bloc.dart';
import 'package:presentation/screens/movie_details/widgets/desktop_movie_details_widget.dart';
import 'package:presentation/screens/movie_details/widgets/mobile_movie_details_widget.dart';
import 'package:presentation/utils/responsive.dart';

class MovieDetailsScreenArguments extends BaseArguments {
  final BaseMovieEntity movieDetails;

  MovieDetailsScreenArguments({
    required this.movieDetails,
    Function(dynamic value)? result,
  }) : super(result: result);
}

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({super.key});

  static const _routeName = '/MovieDetailsScreen';
  static String get routeName => _routeName;

  static BasePage page(MovieDetailsScreenArguments arguments) => BasePage(
        key: const ValueKey(_routeName),
        name: _routeName,
        builder: (_) => const MovieDetailsScreen(),
        arguments: arguments,
      );

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState
    extends BlocScreenState<MovieDetailsScreen, MovieDetailsBloc> {
  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    if (isDesktop) {
      return DesktopMovieDetailsWidget(bloc);
    }
    return MobileMovieDetailsWidget(bloc);
  }
}

String getGenresPresentation(Iterable<String> genres) {
  return genres.map((genre) => genre.capitalize()).join(', ');
}
