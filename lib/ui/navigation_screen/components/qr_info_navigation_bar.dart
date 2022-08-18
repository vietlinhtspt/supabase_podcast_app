import 'package:flutter/material.dart';

import 'm3_navbar_item_widget.dart';

class QRInfoNavigationBar extends StatefulWidget {
  const QRInfoNavigationBar({
    Key? key,
    required this.items,
    required this.centerItemText,
    required this.notchedShape,
    required this.onTabSelected,
    required this.isVertical,
    required this.screenIndex,
  }) : super(key: key);

  final List<QRInfoNavigationBarItem> items;
  final String centerItemText;
  final bool isVertical;
  final int screenIndex;
  final NotchedShape notchedShape;
  final ValueChanged<int> onTabSelected;

  static const HEIGHT = 120.0;

  @override
  State<QRInfoNavigationBar> createState() => _QRInfoNavigationBarState();
}

class _QRInfoNavigationBarState extends State<QRInfoNavigationBar> {
  int _selectedIndex = 0;

  late bool isVertical;

  @override
  void initState() {
    isVertical = widget.isVertical;
    _selectedIndex = widget.screenIndex;
    super.initState();
  }

  void _updateIndex(int index) {
    widget.onTabSelected(index);
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void didUpdateWidget(covariant QRInfoNavigationBar oldWidget) {
    isVertical = widget.isVertical;
    _selectedIndex = widget.screenIndex;
    if (mounted) setState(() {});
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    final items = List.generate(widget.items.length, (int index) {
      return _buildTabItem(
        item: widget.items[index],
        index: index,
        onPressed: _updateIndex,
      );
    });

    return LayoutBuilder(builder: (context, constraints) {
      return SizedBox(
          width: isVertical ? QRInfoNavigationBar.HEIGHT : constraints.maxWidth,
          height: isVertical
              ? constraints.maxHeight
              : QRInfoNavigationBar.HEIGHT +
                  MediaQuery.of(context).padding.bottom,
          child: Stack(
            alignment: AlignmentDirectional.centerStart,
            children: [
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                right: 0,
                child: CustomPaint(
                  size: const Size(
                    double.infinity,
                    double.infinity,
                  ),
                  painter: isVertical
                      ? NavBarVerticalCustomPainter(context: context)
                      : NavBarHorizontalCustomPainter(context: context),
                ),
              ),
              Positioned(
                left: 0,
                top: isVertical ? 0 : 40,
                bottom: 0,
                right: isVertical ? 40 : 0,
                child: Center(
                  child: SizedBox(
                    height: isVertical ? 80 * 4 : null,
                    child: AnimatedList(
                      scrollDirection:
                          widget.isVertical ? Axis.vertical : Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index, animation) {
                        return items[index];
                      },
                      initialItemCount: items.length,
                    ),
                  ),
                ),
              ),
            ],
          ));
    });
  }

  Widget _buildTabItem({
    required QRInfoNavigationBarItem item,
    required int index,
    required ValueChanged<int> onPressed,
  }) {
    final isSelected = _selectedIndex == index;

    final iconPath = isSelected ? item.iconPathSelected : item.iconPath;

    final widthScreen = MediaQuery.of(context).size.width;

    return M3NavbarItemWidget(
      isSelected: isSelected,
      context: context,
      iconPath: iconPath,
      onPressed: () => onPressed(index),
      title: item.text,
      width: isVertical ? 80 : widthScreen / 4,
      height: 80,
    );
  }
}

class NavBarHorizontalCustomPainter extends CustomPainter {
  final BuildContext context;

  NavBarHorizontalCustomPainter({
    required this.context,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Theme.of(context).colorScheme.primaryContainer
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, 40); // Start

    path.lineTo(
      size.width,
      40,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 20);
    canvas.drawShadow(path, Theme.of(context).colorScheme.onSurface, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class NavBarVerticalCustomPainter extends CustomPainter {
  final BuildContext context;

  NavBarVerticalCustomPainter({
    required this.context,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Theme.of(context).colorScheme.primaryContainer
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(size.width - 40, 0); // Start

    path.lineTo(size.width - 40, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
