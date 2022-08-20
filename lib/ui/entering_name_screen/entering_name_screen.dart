import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/user_info_provider.dart';
import '../../router/customed_router_delegate.dart';
import '../../shared/shared.dart';
import '../popups/m3_popup.dart';

class EnteringNameScreen extends StatefulWidget {
  const EnteringNameScreen({Key? key}) : super(key: key);

  @override
  State<EnteringNameScreen> createState() => _EnteringNameScreenState();
}

class _EnteringNameScreenState extends State<EnteringNameScreen> {
  late TextEditingController _nameController;

  @override
  void initState() {
    _nameController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMaximunHeight = MediaQuery.of(context).size.width >= 500;
    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: 350,
                minHeight: 500,
                maxWidth: 500,
                maxHeight: isMaximunHeight ? 700 : double.infinity,
              ),
              child: Container(
                height:
                    isMaximunHeight ? null : MediaQuery.of(context).size.height,
                decoration: isMaximunHeight
                    ? BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      )
                    : null,
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'entering_name_screen.title'.tr(),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          height: 1.2,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'entering_name_screen.sub_title'.tr(),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Spacer(),
                    M3TextField(
                      controller: _nameController,
                      labelText: 'entering_name_screen.name'.tr(),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: M3LockedButton(
                        onPressed: () async {
                          if (_nameController.text.trim().isEmpty) {
                            await showM3Popup(
                              context,
                              title: 'popup.warning'.tr(),
                              descriptions: 'popup.not_entered_your_name'.tr(),
                            );
                          } else {
                            await context.read<UserInfoProvider>().createName(
                                  context,
                                  name: _nameController.text,
                                );
                          }
                        },
                        title: 'entering_name_screen.done'.tr(),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
