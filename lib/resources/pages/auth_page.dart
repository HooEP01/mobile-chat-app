import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';
import '/app/controllers/auth_controller.dart';

class AuthPage extends NyStatefulWidget<AuthController> {
  static const path = '/auth';

  AuthPage({super.key}) : super(path, child: _AuthPageState());
}

class _AuthPageState extends NyState<AuthPage> {
  ValueNotifier userCredential = ValueNotifier('');

  @override
  init() async {}

  /// Use boot if you need to load data before the [view] is rendered.
  // @override
  // boot() async {
  //
  // }

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Auth")),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: userCredential,
          builder: (context, value, child) {
            return (userCredential.value == '' || userCredential.value == null)
                ? Center(
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: IconButton(
                        iconSize: 40,
                        icon: Image.asset(
                          getImageAsset("google_icon.png"),
                        ),
                        onPressed: () async {
                          userCredential.value = await widget.controller.signInWithGoogle();
                          if (userCredential.value != null) print(userCredential.value.user!.email);
                        },
                      ),
                    ),
                  )
                : Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(width: 1.5, color: Colors.black54)),
                          child: Image.network(userCredential.value.user!.photoURL.toString()),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(userCredential.value.user!.displayName.toString()),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(userCredential.value.user!.email.toString()),
                        const SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              bool result = await widget.controller.signOutFromGoogle();
                              if (result) userCredential.value = '';
                            },
                            child: const Text('Logout'))
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
