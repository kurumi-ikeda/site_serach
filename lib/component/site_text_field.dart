import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../generate_url.dart';

class SiteTextField extends ConsumerWidget {
  const SiteTextField({
    super.key,
    required this.stateProvider,
    required this.hintText,
  });
  final AutoDisposeProvider<TextEditingController> stateProvider;
  final String hintText;

  void _copyText(final TextEditingController inputText, final BuildContext context) {
    FlutterClipboard.copy(inputText.text).then((value) {
      _showSnackBar(context);
    });
  }

  void _pastText(final WidgetRef ref) {
    FlutterClipboard.paste().then((value) {
      ref.read(stateProvider).text = value;
    });
  }

  void _showSnackBar(final BuildContext context) {
    const snack = SnackBar(content: Text("Text copied"), duration: Duration(seconds: 2));
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(stateProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    onChanged: (text) {
                      updateUrl(ref);
                    },
                    maxLines: 1,
                    controller: controller,
                    decoration: InputDecoration(hintText: hintText),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      GestureDetector(
                        child: Row(
                          children: const [
                            Icon(
                              Icons.copy,
                              color: Colors.blue,
                              size: 32,
                            ),
                            Text(
                              "コピー",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          if (controller.text.trim() == "") {
                          } else {
                            _copyText(controller, context);
                          }
                        },
                      ),
                      GestureDetector(
                        child: Row(
                          children: const [
                            Icon(
                              Icons.content_paste,
                              color: Colors.blue,
                              size: 32,
                            ),
                            Text(
                              "ペースト",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          _pastText(ref);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
