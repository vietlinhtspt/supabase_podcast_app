import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:async/async.dart';
import 'package:provider/provider.dart';

import '../../models/podcast_model.dart';
import '../../providers/providers.dart';
import '../../shared/shared.dart';
import '../navigation_screen/components/qr_info_navigation_bar.dart';

class SearchingScreen extends StatefulWidget {
  const SearchingScreen({Key? key}) : super(key: key);

  @override
  State<SearchingScreen> createState() => _SearchingScreenState();
}

class _SearchingScreenState extends State<SearchingScreen> {
  late ScrollController _scrollController;
  late TextEditingController _textEditingController;
  final _searchedPodcast = <PodcastModel>[];

  CancelableOperation? _cancelableOperation;

  @override
  void initState() {
    _scrollController = ScrollController();
    _textEditingController = TextEditingController();

    _textEditingController.addListener(() {
      _cancelableOperation?.cancel();
      _cancelableOperation = CancelableOperation.fromFuture(
              Future.delayed(const Duration(seconds: 1)))
          .then((p0) => mounted && _textEditingController.text.trim().isNotEmpty
              ? context.read<PodcastProvider>().search(
                  context,
                  column: 'title',
                  searchingText: [_textEditingController.text.trim()],
                ).then((value) {
                  _searchedPodcast.clear();
                  _searchedPodcast.addAll(value);
                  if (mounted) setState(() {});
                })
              : _textEditingController.text.trim().isEmpty
                  ? _searchedPodcast.clear()
                  : null);

      if (mounted) setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _textEditingController.dispose();

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
            collapsedHeight: 140,
            expandedHeight: 140,
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
                    const SizedBox(height: 10),
                    const LogoWidget(),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: M3TextField(
                        controller: _textEditingController,
                        labelText: 'searching_screen.enter_searching_text'.tr(),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 6),
                          child: SvgPicture.asset(
                            'assets/icons/friends/ic_search.svg',
                            fit: BoxFit.fitHeight,
                            height: 30,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (_textEditingController.text.trim().isEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'searching_screen.type_something_to_search'.tr(),
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
            ),
          if (_textEditingController.text.trim().isNotEmpty &&
              (_cancelableOperation?.isCompleted ?? false) &&
              _searchedPodcast.isEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'searching_screen.no_results_found'.tr(),
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
            ),
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200.0,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 1.0,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return MusicWidget(_searchedPodcast[index]);
              },
              childCount: _searchedPodcast.length,
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: context.watch<AudioProvider>().currentPodcastModel != null
                  ? QRInfoNavigationBar.HEIGHT + 75
                  : QRInfoNavigationBar.HEIGHT,
            ),
          )
        ],
      ),
    );
  }
}
