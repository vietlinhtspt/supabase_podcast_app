import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
              child: MaterialButton(
            onPressed: () => Provider.of<AuthProvider>(
              context,
              listen: false,
            ).logout(),
            child: const Text('logout'),
          )),
        ),
      ],
    );
  }
}
