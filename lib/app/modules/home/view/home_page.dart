import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siemens_hackathon_safety_marker/app/global/widgets/bottom_navigation_bar.dart';
import 'package:siemens_hackathon_safety_marker/app/modules/home/bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final l10n = context.l10n;
    return Scaffold(
      // appBar: AppBar(title: Text(l10n.counterAppBarTitle)),
      body: Container(),
      bottomNavigationBar: MarkerBottomNavigationBar(),
    );
  }
}
