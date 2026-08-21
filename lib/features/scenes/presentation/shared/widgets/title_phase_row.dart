import 'package:flutter/material.dart';

class TitlePhaseRow extends StatelessWidget {
  final String title;

  final String phase;
  const TitlePhaseRow({super.key, required this.title, required this.phase});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Colors.white,
            fontFamily: 'Gocake',
          ),
        ),
        Text(
          phase,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Colors.white,
            fontFamily: 'Gocake',
          ),
        ),
        SizedBox(),
      ],
    );
  }
}
