import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';

class M3PopupPupupWidget extends StatefulWidget {
  final String? title;
  final String? descriptions;
  final Widget? child;
  final List<String>? textActions;
  final Function(String value)? onTapAction;

  const M3PopupPupupWidget({
    Key? key,
    this.title,
    this.descriptions,
    this.textActions,
    this.child,
    this.onTapAction,
  })  : assert(
          descriptions != null || child != null,
          'Hộp thoại BK phải có một con hoặc mô tả',
        ),
        assert(
          !(descriptions != null && child != null),
          'Hộp thoại BK phải có một con hoặc mô tả',
        ),
        super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<M3PopupPupupWidget> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  Widget contentBox(context) {
    return Container(
      color: Colors.transparent,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(top: 28),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Theme.of(context).primaryColor.mix(
                    Theme.of(context).colorScheme.primaryContainer,
                    0.95,
                  ),
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 25),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (widget.title != null)
                        Text(
                          widget.title ?? '',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      if (widget.title != null)
                        const SizedBox(
                          height: 8,
                        ),
                      if (widget.descriptions != null)
                        Container(
                          constraints: const BoxConstraints(
                            minHeight: 60,
                            maxHeight: double.infinity,
                          ),
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            widget.descriptions!,
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onPrimaryContainer,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                    ],
                  ),
                ),
                buildActionContainer(context),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildActionContainer(context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: (widget.textActions ?? ['Đồng ý'])
            .map((value) => TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    if (widget.onTapAction != null) {
                      widget.onTapAction!(value);
                    }
                  },
                  child: Text(
                    value,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
