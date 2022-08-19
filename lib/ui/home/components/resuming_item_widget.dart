import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';

class ResumingItemWidget extends StatelessWidget {
  const ResumingItemWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                imageUrl:
                    'https://cdn.pixabay.com/photo/2016/11/23/00/43/audio-1851517_960_720.jpg',
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
                  'Mon, 02/08/2022',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                Text(
                  'Watermenlon',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const Spacer(),
                Text(
                  'Tiếp tục từ 15 phút 30 giây',
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
    );
  }
}
