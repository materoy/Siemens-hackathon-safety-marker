// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'dart:developer';

import 'package:authentication/authentication.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:siemens_hackathon_safety_marker/app/global/app_bloc/app_bloc.dart';
import 'package:siemens_hackathon_safety_marker/app/global/util/size_config.dart';
import 'package:siemens_hackathon_safety_marker/app/modules/alert/alert.dart';
import 'package:siemens_hackathon_safety_marker/app/modules/safety/safety.dart';
import 'package:siemens_hackathon_safety_marker/app/routes/app_pages.dart';
import 'package:siemens_hackathon_safety_marker/l10n/l10n.dart';

class App extends StatelessWidget {
  App({Key? key, AuthenticationRepository? authenticationRepository})
      : _authenticationRepository =
            authenticationRepository ?? AuthenticationRepository(),
        super(key: key);

  final AuthenticationRepository _authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: _authenticationRepository,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  AppBloc(authenticationRepository: _authenticationRepository),
            ),
            BlocProvider(
              create: (context) => SafetyBloc(),
            ),
          ],
          child: const AppView(),
        ));
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return MaterialApp(
          theme: ThemeData(
            appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
            colorScheme: ColorScheme.fromSwatch(
              accentColor: const Color(0xFF13B9FF),
            ),
          ),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          builder: (context, child) {
            SizeConfig().initialize(context);
            return BlocBuilder<SafetyBloc, SafetyState>(
              /// Listens for changes in alerts stream
              /// Navigates to alert response page incase of an active alert
              buildWhen: (previous, current) =>
                  previous.alert.alertId != current.alert.alertId,
              builder: (context, state) {
                if (state is ActiveSafetyAlertState) {
                  return const AlertResponsePage();
                } else {
                  return child!;
                }
              },
            );
          },
          key: Key('${state.status}_app_key'),
          initialRoute: state.status == AppStatus.authenticated
              ? AppPages.INITIAL
              : Routes.LOGIN,
          routes: AppPages.routes,
          onGenerateRoute: (settings) {
            /// Sets the transition for page navigation to a
            /// custom [FadeTransition]
            if (settings.name != '/') {
              return PageRouteBuilder<dynamic>(
                settings: settings,
                pageBuilder: (context, animation, secondaryAnimation) {
                  return AppPages.routes[settings.name]!(context);
                },
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
              );
            }
          },
        );
      },
    );
  }
}
