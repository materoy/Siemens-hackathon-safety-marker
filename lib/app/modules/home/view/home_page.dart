import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siemens_hackathon_safety_marker/app/global/util/size_config.dart';
import 'package:siemens_hackathon_safety_marker/app/global/widgets/bottom_navigation_bar.dart';
import 'package:siemens_hackathon_safety_marker/app/modules/alert/alert.dart';
import 'package:siemens_hackathon_safety_marker/app/modules/home/cubit/home_cubit.dart';
import 'package:siemens_hackathon_safety_marker/app/routes/app_pages.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: HomePage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
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
      appBar: AppBar(
        title: const Text('Safety Marker'),
        centerTitle: true,
        leading: Container(),
      ),
      bottomNavigationBar: const MarkerBottomNavigationBar(),
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(
                    left: SizeConfig.unitWidth * 10,
                    top: SizeConfig.unitHeight * 4),
                child: Text('Recent disasters',
                    style: Theme.of(context).textTheme.headline6),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: SizeConfig.unitWidth * 6,
                right: SizeConfig.unitWidth * 10,
              ),
              child: const Divider(thickness: 2),
            ),
            SizedBox(height: SizeConfig.unitHeight * 4),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                return Expanded(
                  child: ListView.builder(
                      itemCount: state.disasters.length,
                      itemBuilder: (context, index) => DisasterCard(
                            alert: state.disasters[index],
                          )),
                );
              },
            ),
            Opacity(
              opacity: .1,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.ALERT_RESPONSE);
                },
                child: const Text('Respond to alert'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DisasterCard extends StatelessWidget {
  const DisasterCard({Key? key, required this.alert}) : super(key: key);

  final Alert alert;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      children: [Text(alert.title.toString())],
    ));
  }
}
