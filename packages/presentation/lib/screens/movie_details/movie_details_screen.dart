import 'package:domain/entities/base_movie_entity.dart';
import 'package:flutter/material.dart';
import 'package:presentation/navigation/base_arguments.dart';
import 'package:presentation/navigation/base_page.dart';

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

  static BasePage page(MovieDetailsScreenArguments arguments) => BasePage(
        key: const ValueKey(_routeName),
        name: _routeName,
        builder: (_) => const MovieDetailsScreen(),
        arguments: arguments,
      );

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Movie Details Screen'));
  }
}
