import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../shared/shared.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 35,
      width: double.infinity,
      child: Stack(children: [
        if (Responsive.isMobile(context))
          Image.asset('assets/icons/home/ic_customed_line.png'),
        Positioned(
          top: 7,
          left: 0,
          right: 0,
          child: Row(
            children: [
              Text(
                title,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).primaryColor),
              ),
              const Spacer(),
              Text(
                'home_screen.explain'.tr(),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SvgPicture.asset(
                  'assets/icons/home/ic_explain.svg',
                  height: 16,
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
}
