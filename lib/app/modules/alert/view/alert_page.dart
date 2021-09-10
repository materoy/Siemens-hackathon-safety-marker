import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:siemens_hackathon_safety_marker/app/global/app_bloc/app_bloc.dart';
import 'package:siemens_hackathon_safety_marker/app/global/util/size_config.dart';
import 'package:siemens_hackathon_safety_marker/app/global/widgets/bottom_navigation_bar.dart';
import 'package:siemens_hackathon_safety_marker/app/modules/alert/bloc/alert_bloc.dart';
import 'package:siemens_hackathon_safety_marker/app/modules/alert/model/alert.dart';
import 'package:siemens_hackathon_safety_marker/app/modules/alert/repository/alert_repository.dart';
import 'package:siemens_hackathon_safety_marker/app/modules/safety/safety.dart';
import 'package:siemens_hackathon_safety_marker/app/routes/app_pages.dart';

class AlertPage extends StatelessWidget {
  const AlertPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Listens for an active alert event
    /// Navigates to safety page incase of one
    return BlocListener<SafetyBloc, SafetyState>(
        listenWhen: (previous, current) =>
            previous.alert.alertId != current.alert.alertId,
        listener: (context, state) {
          if (state is ActiveSafetyAlertState) {
            Navigator.pushNamed(context, Routes.ALERT_RESPONSE);
          }
        },
        child: const AlertView());
  }
}

class AlertView extends StatelessWidget {
  const AlertView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<AlertBloc>(context),
      child: Scaffold(
        bottomNavigationBar: const MarkerBottomNavigationBar(),
        body: SafeArea(
          child: SizedBox(
            width: SizeConfig.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Spacer(),
                Text(
                  'Raise alert',
                  style: Theme.of(context).textTheme.headline3,
                ),
                const Spacer(flex: 10),
                AlertButton(
                  onPressed: () {
                    context.read<AlertBloc>().add(CreateAlertEvent(Alert(
                        time: DateTime.now(),
                        creatorId: context.read<AppBloc>().state.user.uid!)));

                    Navigator.pushNamed(context, Routes.ALERT_DETAILS);
                  },
                ),
                const Spacer(flex: 2),
                Text(
                  'incase of a disaster press the button to allert others',
                  style: Theme.of(context).textTheme.caption,
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AlertButton extends StatelessWidget {
  const AlertButton({Key? key, required this.onPressed, this.child})
      : super(key: key);

  final VoidCallback onPressed;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          width: SizeConfig.unitWidth * 60,
          height: SizeConfig.unitWidth * 60,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.red.withOpacity(.3), width: 10),
              shape: BoxShape.circle,
              color: Colors.transparent),
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                border:
                    Border.all(color: Colors.red.withOpacity(.7), width: 10),
                shape: BoxShape.circle,
                color: Colors.transparent),
            child: const CircleAvatar(
              backgroundColor: Colors.red,
            ),
          )),
    );
  }
}
