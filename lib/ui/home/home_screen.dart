import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'components/components.dart';
import 'components/resuming_item_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();

  static bool isHorizontalLayout(BuildContext context) =>
      MediaQuery.of(context).size.height <= 66 + 120 + 400 + 24 * 4 &&
      MediaQuery.of(context).size.width >= 380 * 2;
}

class _HomeScreenState extends State<HomeScreen> {
  late bool isShowingFriends, isShowingNotifications;

  final itemConstrants = const BoxConstraints(
    maxHeight: 120,
    maxWidth: 490,
    minWidth: 320,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    if (mounted) setState(() {});
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(builder: (context, constraints) {
        final isHorizontalLayout = HomeScreen.isHorizontalLayout(context);
        final screenWidth = MediaQuery.of(context).size.width;
        final itemWidth = isHorizontalLayout
            ? (screenWidth - 24 * 2) / 2
            : screenWidth - 24 * 2;

        return SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${'home_screen.hello'.tr()}, Mork',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                TitleWidget(
                  title: 'home_screen.continuing_podcast'.tr(),
                ),
                const ResumingItemWidget(),
                const SizedBox(
                  height: 28,
                ),
                TitleWidget(
                  title: 'home_screen.made_for_you'.tr(),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      const MusicWidget(),
                      const MusicWidget(),
                      const MusicWidget(),
                      const MusicWidget(),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 28,
                ),
                TitleWidget(
                  title: 'home_screen.trending'.tr(),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      const MusicWidget(),
                      const MusicWidget(),
                      const MusicWidget(),
                      const MusicWidget(),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 28,
                ),
                TitleWidget(
                  title: 'home_screen.explore'.tr(),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      const MusicWidget(),
                      const MusicWidget(),
                      const MusicWidget(),
                      const MusicWidget(),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 28,
                ),
                TitleWidget(
                  title: 'home_screen.channels_for_you'.tr(),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      const ChannelWidget(),
                      const ChannelWidget(),
                      const ChannelWidget(),
                      const ChannelWidget(),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 28,
                ),
                TitleWidget(
                  title: 'home_screen.topics'.tr(),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 16),
                        child: const Text('Chủ đề 1'),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 16),
                        child: const Text('Chủ đề 2'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      const MusicWidget(),
                      const MusicWidget(),
                      const MusicWidget(),
                      const MusicWidget(),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 100,
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}

class MusicWidget extends StatelessWidget {
  const MusicWidget({
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
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(20)),
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
            'Watermenlon',
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
