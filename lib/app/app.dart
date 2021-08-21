// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:authentication/authentication.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:siemens_hackathon_safety_marker/app/global/app_bloc/app_bloc.dart';
import 'package:siemens_hackathon_safety_marker/app/global/util/size_config.dart';
import 'package:siemens_hackathon_safety_marker/app/routes/app_pages.dart';
import 'package:siemens_hackathon_safety_marker/l10n/l10n.dart';

import 'modules/home/home.dart';
import 'modules/login/login.dart';

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
      child: BlocProvider(
        create: (_) =>
            AppBloc(authenticationRepository: _authenticationRepository),
        child: const AppView(),
      ),
    );
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
            return child!;
          },
          // initialRoute: state.status == AppStatus.authenticated
          //     ? AppPages.INITIAL
          //     : Routes.LOGIN,
          home: FlowBuilder<AppStatus>(
            state: context.select((AppBloc bloc) => bloc.state.status),
            onGeneratePages: (AppStatus state, List<Page<dynamic>> pages) {
              switch (state) {
                case AppStatus.authenticated:
                  return [HomePage.page()];
                case AppStatus.unauthenticated:
                default:
                  return [LoginPage.page()];
              }
            },
          ),
          routes: AppPages.routes,
          onGenerateRoute: (settings) {
            /// Sets the transition for page navigation to a
            /// custom [FadeTransition]
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
          },
        );
      },
    );
  }
}
