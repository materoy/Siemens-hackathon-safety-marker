import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:siemens_hackathon_safety_marker/app/global/util/size_config.dart';
import 'package:siemens_hackathon_safety_marker/app/modules/alert/alert.dart';

class RecentDisasterPage extends StatelessWidget {
  const RecentDisasterPage({Key? key, required this.alert}) : super(key: key);

  final Alert alert;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.red),
              borderRadius: BorderRadius.circular(20)),
          child: alert.active
              ? Text(
                  'Active',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(color: Colors.red),
                )
              : const SizedBox(),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: SizeConfig.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: SizeConfig.unitHeight * 2),
              Text(
                alert.title ?? '',
                style: Theme.of(context).textTheme.headline4,
              ),
              if (alert.type != null)
                Text(
                  alert.type!,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              const Spacer(),
              SizedBox(
                height: SizeConfig.unitHeight * 50,
                child: ListView.builder(
                  padding: EdgeInsets.only(left: SizeConfig.unitWidth * 8),
                  scrollDirection: Axis.horizontal,
                  itemCount: alert.images != null ? alert.images!.length : 0,
                  itemBuilder: (context, index) {
                    return Container(
                        // width: SizeConfig.unitWidth * 80,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: Image.network(
                          alert.images![index],
                          fit: BoxFit.cover,
                        ));
                  },
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: SizeConfig.unitWidth * 5),
                  child: Text(
                    alert.description ?? '',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: SizeConfig.unitWidth * 5),
                  child: Text(
                    timeago.format(alert.time, locale: 'en'),
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
              ),
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}
