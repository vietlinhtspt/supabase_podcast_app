import 'package:flutter/material.dart';

import '../ui/auth/components/m3_text_field_icon_widget.dart';
import 'custom_gradient_container.dart';

class M3TextField extends StatefulWidget {
  const M3TextField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.obscureText,
    this.prefixIcon,
  }) : super(key: key);

  final TextEditingController controller;
  final String labelText;
  final bool? obscureText;
  final Widget? prefixIcon;

  @override
  State<M3TextField> createState() => _M3TextFieldState();
}

class _M3TextFieldState extends State<M3TextField> {
  late TextEditingController controller;
  late String labelText;

  bool? obscureText;

  @override
  void initState() {
    controller = widget.controller;
    labelText = widget.labelText;
    obscureText = widget.obscureText;
    widget.controller.addListener(() {
      if (mounted) setState(() {});
    });
    super.initState();
  }

  @override
  void didUpdateWidget(covariant M3TextField oldWidget) {
    controller = widget.controller;
    labelText = widget.labelText;
    obscureText = widget.obscureText;
    widget.controller.addListener(() {
      if (mounted) setState(() {});
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return CustomGradientContainer(
      gradient: LinearGradient(colors: [
        Theme.of(context).colorScheme.secondary,
        Theme.of(context).colorScheme.primary,
      ]),
      child: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: TextField(
          cursorColor: Theme.of(context).colorScheme.onPrimaryContainer,
          controller: controller,
          obscureText: obscureText ?? false,
          decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                style: BorderStyle.solid,
                color: Colors.transparent,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
              borderSide: const BorderSide(
                width: 1,
                style: BorderStyle.solid,
                color: Colors.transparent,
              ),
            ),
            label: Container(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Text(labelText,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.w400,
                  )),
            ),
            floatingLabelStyle: TextStyle(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.w400,
            ),
            prefixIcon: widget.prefixIcon,
            hoverColor: Colors.transparent,
            fillColor: Colors.transparent,
            suffixIcon: obscureText == null && controller.text.isNotEmpty
                ? M3TextFieldIconWidget(
                    iconPath: 'assets/icons/auth/ic_remove_rounded.svg',
                    onTap: () => controller.clear(),
                  )
                : obscureText == true
                    ? M3TextFieldIconWidget(
                        iconPath: 'assets/icons/auth/ic_show_content.svg',
                        onTap: () => setState(() {
                          obscureText = !(obscureText ?? false);
                        }),
                      )
                    : obscureText == false
                        ? M3TextFieldIconWidget(
                            iconPath: 'assets/icons/auth/ic_hide_content.svg',
                            onTap: () => setState(() {
                              obscureText = !(obscureText ?? false);
                            }),
                          )
                        : null,
          ),
        ),
      ),
    );
  }
}
