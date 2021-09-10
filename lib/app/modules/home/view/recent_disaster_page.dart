import 'package:flutter/material.dart';
import 'package:siemens_hackathon_safety_marker/app/global/util/size_config.dart';
import 'package:siemens_hackathon_safety_marker/app/modules/alert/alert.dart';

class RecentDisasterPage extends StatelessWidget {
  const RecentDisasterPage({Key? key, required this.alert}) : super(key: key);

  final Alert alert;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            alert.title ?? '',
            style: Theme.of(context).textTheme.headline4,
          ),
          const Spacer(),
          SizedBox(
            height: SizeConfig.unitHeight * 20,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: alert.images != null ? alert.images!.length : 0,
              itemBuilder: (context, index) {
                return AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Image.network(
                        alert.images![index],
                        fit: BoxFit.cover,
                      )),
                );
              },
            ),
          ),
          const Spacer(),
          Text(alert.description ?? ''),
        ],
      ),
    );
  }
}
