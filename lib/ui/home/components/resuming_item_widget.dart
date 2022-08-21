import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../models/podcast_history_model.dart';
import '../../../providers/providers.dart';

class ResumingItemWidget extends StatelessWidget {
  const ResumingItemWidget({
    Key? key,
    required this.podcastHistoryModel,
  }) : super(key: key);

  final PodcastHistoryModel podcastHistoryModel;

  @override
  Widget build(BuildContext context) {
    final listenedDuration = Duration(
        seconds: context
                .watch<PodcastProvider>()
                .podcast
                .firstWhere(
                    (element) => element.id == podcastHistoryModel.podcastId)
                .historyDetail
                ?.listened ??
            0);
    final podcastModel = context
        .watch<PodcastProvider>()
        .podcast
        .firstWhere((element) => element.id == podcastHistoryModel.podcastId);
    return GestureDetector(
      onTap: () => context.read<AudioProvider>().play(podcastModel),
      child: Container(
        margin: const EdgeInsets.only(top: 8, left: 16),
        height: 90,
        child: Row(
          children: [
            SizedBox(
              height: 90,
              width: 90,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(20)),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: podcastModel.imgPath ??
                      'https://vcdtzzxxfqnbehzlyfne.supabase.co/storage/v1/object/sign/logos/melior_logo.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJsb2dvcy9tZWxpb3JfbG9nby5wbmciLCJpYXQiOjE2NjA5ODA0NzUsImV4cCI6MTk3NjM0MDQ3NX0.134_hv90KOVS4dWCLCqquvP5afwRGQ63FQx7yyWWwB0',
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat('EEEE, dd/MM/yyyy')
                        .format(DateTime.parse(podcastHistoryModel.createdAt!)),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  Text(
                    podcastModel.title ?? '',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    // ignore: lines_longer_than_80_chars
                    'Start from ${listenedDuration.inMinutes}\' ${listenedDuration.inSeconds.remainder(60)}s',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).colorScheme.onSurface.mix(
                          Theme.of(context).colorScheme.primaryContainer, 0.4),
                    ),
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
