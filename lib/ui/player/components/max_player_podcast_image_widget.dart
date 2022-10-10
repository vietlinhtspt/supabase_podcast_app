import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/providers.dart';

class MaxPlayerPodcastImageWidget extends StatelessWidget {
  const MaxPlayerPodcastImageWidget({
    Key? key,
    required this.screenWidth,
    required this.podcastImageSize,
    required this.leftPadding,
    required AnimationController controller,
    required this.controllerValueReversed,
  })  : _controller = controller,
        super(key: key);

  final double screenWidth;
  final double podcastImageSize;
  final num leftPadding;
  final AnimationController _controller;
  final double controllerValueReversed;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(
          -((screenWidth - podcastImageSize) / 2 - leftPadding) *
              _controller.value,
          -podcastImageSize * _controller.value * 1 / 3),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            10 + 10 * controllerValueReversed,
          ),
          topRight: Radius.circular(
            10 + 10 * controllerValueReversed,
          ),
          bottomLeft: Radius.circular(
            20 + 40 * controllerValueReversed,
          ),
          bottomRight: Radius.circular(
            10 + 10 * controllerValueReversed,
          ),
        ),
        child: CachedNetworkImage(
          width: podcastImageSize,
          height: podcastImageSize,
          imageUrl: context
                  .watch<AudioProvider>()
                  .currentPodcastModel
                  ?.imgPath ??
              'https://vcdtzzxxfqnbehzlyfne.supabase.co/storage/v1/object/sign/logos/melior_logo.png?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJsb2dvcy9tZWxpb3JfbG9nby5wbmciLCJpYXQiOjE2NjA5ODA0NzUsImV4cCI6MTk3NjM0MDQ3NX0.134_hv90KOVS4dWCLCqquvP5afwRGQ63FQx7yyWWwB0',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
