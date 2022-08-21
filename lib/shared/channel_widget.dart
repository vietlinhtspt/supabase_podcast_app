import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ChannelWidget extends StatelessWidget {
  const ChannelWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 120,
            width: 120,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl:
                    'https://cdn.pixabay.com/photo/2015/05/07/11/02/guitar-756326_1280.jpg',
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'Channel',
            style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          )
        ],
      ),
    );
  }
}
