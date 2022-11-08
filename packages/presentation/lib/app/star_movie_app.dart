import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:presentation/app/app_bloc.dart';
import 'package:presentation/app/widgets/desktop_root_widget.dart';
import 'package:presentation/app/widgets/mobile_root_widget.dart';
import 'package:presentation/bloc/base/bloc_screen.dart';
import 'package:presentation/utils/responsive.dart';

class StarMovieApp extends StatefulWidget {
  final String title;

  const StarMovieApp(this.title, {super.key});

  @override
  State<StarMovieApp> createState() => _StarMovieAppState();
}

class _StarMovieAppState extends BlocScreenState<StarMovieApp, AppBloc> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: widget.title,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: StreamBuilder(
        stream: bloc.stream,
        builder: (context, snapshot) {
          final isDesktop = Responsive.isDesktop(context);

          final appData = snapshot.data;

          if (appData != null) {
            if (isDesktop) {
              return DesktopRootWidget(
                data: appData,
                bloc: bloc,
              );
            }
            return MobileRootWidget(
              data: appData,
              bloc: bloc,
            );
          }
          return Container();
        },
      ),
    );
  }
}
