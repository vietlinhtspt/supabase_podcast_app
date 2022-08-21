import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/providers.dart';
import '../../shared/music_widget.dart';
import '../navigation_screen/components/qr_info_navigation_bar.dart';
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
                      // ignore: lines_longer_than_80_chars
                      '${'home_screen.hello'.tr()} ${context.watch<UserInfoProvider>().userInfo?.name ?? ''}',
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
                  child: Consumer<PodcastProvider>(
                      builder: (context, provider, child) {
                    return Row(
                      children:
                          provider.podcast.map((e) => MusicWidget(e)).toList(),
                    );
                  }),
                ),
                const SizedBox(
                  height: 28,
                ),
                TitleWidget(
                  title: 'home_screen.trending'.tr(),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Consumer<PodcastProvider>(
                      builder: (context, provider, child) {
                    return Row(
                      children:
                          provider.podcast.map((e) => MusicWidget(e)).toList(),
                    );
                  }),
                ),
                const SizedBox(
                  height: 28,
                ),
                TitleWidget(
                  title: 'home_screen.explore'.tr(),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Consumer<PodcastProvider>(
                      builder: (context, provider, child) {
                    return Row(
                      children:
                          provider.podcast.map((e) => MusicWidget(e)).toList(),
                    );
                  }),
                ),
                // const SizedBox(
                //   height: 28,
                // ),
                // TitleWidget(
                //   title: 'home_screen.channels_for_you'.tr(),
                // ),
                SizedBox(
                  height:
                      context.watch<AudioProvider>().currentPodcastModel != null
                          ? QRInfoNavigationBar.HEIGHT + 75
                          : QRInfoNavigationBar.HEIGHT,
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
