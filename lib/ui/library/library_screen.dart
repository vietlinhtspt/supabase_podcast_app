import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../providers/providers.dart';
import '../../shared/shared.dart';
import '../home/components/resuming_item_widget.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: 40,
            automaticallyImplyLeading: false,
            pinned: true,
            floating: false,
            systemOverlayStyle: SystemUiOverlayStyle(
              systemNavigationBarColor:
                  Theme.of(context).colorScheme.primaryContainer,
              systemNavigationBarIconBrightness: Brightness.light,
              statusBarColor: Colors.transparent,
              statusBarIconBrightness:
                  isDarkMode ? Brightness.light : Brightness.dark,
              statusBarBrightness:
                  !isDarkMode ? Brightness.light : Brightness.dark,
            ),
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            leading: const SizedBox.shrink(),
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.zero,
              expandedTitleScale: 1,
              title: SafeArea(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                      width: double.infinity,
                    ),
                    const LogoWidget(),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (Responsive.isMobile(context))
                    Image.asset('assets/icons/library/ic_customed_line.png'),
                  Text(
                    'LIBRARY',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
                children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/library/ic_clock.svg',
                              width: 18,
                              height: 18,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              height: 18,
                              width: 2,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                            Text(
                              'History',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ] +
                    context
                        .watch<PodcastProvider>()
                        .podcastHistory
                        .map(
                          (e) => ResumingItemWidget(
                            podcastHistoryModel: e,
                          ),
                        )
                        .toList()),
          )
        ],
      ),
    );
  }
}
