import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;
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
                top: 10,
              ),
              child: const Divider(thickness: 2),
            ),
            BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                return Expanded(
                  child: ListView.builder(
                      itemCount: state.disasters.length,
                      itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(8),
                            child: DisasterCard(
                              alert: state.disasters[index],
                            ),
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
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, Routes.RECENT_DISASTER,
          arguments: alert),
      child: Card(
        elevation: 10,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.unitHeight * 28,
              child: Stack(
                children: [
                  if (alert.images != null && alert.images!.isNotEmpty)
                    Container(
                        height: double.infinity,
                        // width: SizeConfig.unitWidth * 15,
                        width: double.infinity,
                        foregroundDecoration: const BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.transparent, Colors.black87],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter)),
                        child: Image.network(alert.images!.first,
                            fit: BoxFit.cover)),

                  /// Active stamp
                  if (alert.active)
                    Opacity(
                      opacity: .3,
                      child: Center(
                        child: Transform.rotate(
                          angle: -pi / 12.0,
                          child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.red, width: 3),
                                  borderRadius: BorderRadius.circular(8)),
                              child: const Text(
                                'ACTIVE NOW',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 35,
                                    fontWeight: FontWeight.w900),
                              )),
                        ),
                      ),
                    ),

                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        alert.title ?? '',
                        style: Theme.of(context).primaryTextTheme.headline6,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SizeConfig.unitWidth * 5,
                  vertical: SizeConfig.unitHeight * 3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    alert.description ?? '',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    timeago.format(alert.time),
                    style: Theme.of(context).textTheme.caption,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
