import 'package:flutter/material.dart';

import '../ui/auth/components/m3_text_field_icon_widget.dart';

class M3TextField extends StatefulWidget {
  const M3TextField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.obscureText,
  }) : super(key: key);

  final TextEditingController controller;
  final String labelText;
  final bool? obscureText;

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
    return TextField(
      controller: controller,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        labelText: labelText,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(
            width: 1,
            style: BorderStyle.solid,
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide(
            width: 1,
            style: BorderStyle.solid,
            color: Theme.of(context).colorScheme.outline,
          ),
        ),
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
    );
  }
}
