import 'package:domain/entities/movie_character_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:presentation/bloc/base/bloc_screen.dart';
import 'package:presentation/navigation/base_arguments.dart';
import 'package:presentation/navigation/base_page.dart';
import 'package:presentation/screens/cast_crew/cast_crew_bloc.dart';
import 'package:presentation/screens/cast_crew/data/cast_crew_data.dart';
import 'package:presentation/screens/movie_details/widgets/shimmer_loader_widget.dart';
import 'package:presentation/utils/colors.dart';
import 'package:presentation/utils/dimensions.dart';
import 'package:presentation/screens/cast_crew/widgets/cast_crew_widget.dart';

class CastCrewScreenArguments extends BaseArguments {
  final List<MovieCharacterEntity> castAndCrew;

  CastCrewScreenArguments({
    required this.castAndCrew,
    Function(dynamic value)? result,
  }) : super(result: result);
}

class CastCrewScreen extends StatefulWidget {
  const CastCrewScreen({super.key});

  static const _routeName = '/CastCrewScreen';
  static String get routeName => _routeName;

  static BasePage page(CastCrewScreenArguments arguments) => BasePage(
        key: const ValueKey(_routeName),
        name: _routeName,
        builder: (_) => const CastCrewScreen(),
        arguments: arguments,
      );

  @override
  State<CastCrewScreen> createState() => _CastCrewScreenState();
}

class _CastCrewScreenState
    extends BlocScreenState<CastCrewScreen, CastCrewBloc> {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        title: Text(appLocalizations.castAndCrewHeaderLabel),
        backgroundColor: AppColors.primaryColor,
      ),
      body: StreamBuilder<CastCrewData?>(
          stream: bloc.stream,
          builder: (context, snapshot) {
            final data = snapshot.data;

            if (data != null) {
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.screensHorizontalPadding,
                ),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: AppColors.dividersColor,
                      width: AppSizes.size1,
                    ),
                  ),
                  color: AppColors.primaryColor,
                ),
                child: CastCrewWidget(data.cast ?? []),
              );
            } else {
              return const ShimmerLoaderWidget();
            }
          }),
    );
  }
}
