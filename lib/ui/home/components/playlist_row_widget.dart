import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../models/podcast_info_model.dart';
import '../../../shared/music_widget.dart';
import 'title_widget.dart';

class PlaylistRowWidget extends StatelessWidget {
  const PlaylistRowWidget({
    Key? key,
    required this.titleCode,
    required this.podcasts,
  }) : super(key: key);

  final String titleCode;
  final List<PodcastInfoModel?>? podcasts;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 28,
        ),
        TitleWidget(
          title: 'home_screen.$titleCode'.tr(),
        ),
        const SizedBox(
          height: 8,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: (podcasts?.map(
                      (e) =>
                          e != null ? MusicWidget(e) : const SizedBox.shrink(),
                    ) ??
                    [])
                .toList(),
          ),
        ),
      ],
    );
  }
}
