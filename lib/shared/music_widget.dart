import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/podcast_info_model.dart';
import '../providers/audio_provider.dart';

class MusicWidget extends StatelessWidget {
  final PodcastInfoModel _podcastModel;

  const MusicWidget(
    PodcastInfoModel podcastModel, {
    Key? key,
  })  : _podcastModel = podcastModel,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => context.read<AudioProvider>().play(_podcastModel),
      child: SizedBox(
        width: 120,
        height: 180,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 120,
              width: 120,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(35),
                    bottomRight: Radius.circular(20)),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: _podcastModel.imgPath ??
                      'https://vcdtzzxxfqnbehzlyfne.supabase.co/storage/v1/object/sign/logos/melior_logo.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJsb2dvcy9tZWxpb3JfbG9nby5wbmciLCJpYXQiOjE2NjA5ODA0NzUsImV4cCI6MTk3NjM0MDQ3NX0.134_hv90KOVS4dWCLCqquvP5afwRGQ63FQx7yyWWwB0',
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Expanded(
              child: Text(
                _podcastModel.title ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
