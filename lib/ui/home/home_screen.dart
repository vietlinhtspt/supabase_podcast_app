import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final bool isShowingFriends, isShowingNotifications;

  const HomeScreen({
    Key? key,
    required this.isShowingFriends,
    required this.isShowingNotifications,
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
    isShowingFriends = widget.isShowingFriends;
    isShowingNotifications = widget.isShowingNotifications;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    isShowingFriends = widget.isShowingFriends;
    isShowingNotifications = widget.isShowingNotifications;
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

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [Text('Children')],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
