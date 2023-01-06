import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/link.dart';

import '../component/site_text_field.dart';

final urlTextControllerProvider = Provider.autoDispose<TextEditingController>((ref) {
  return TextEditingController(text: "");
});

final wordSearchControllerProvider = Provider.autoDispose<TextEditingController>((ref) {
  return TextEditingController(text: "");
});

final uriStateProvider = StateProvider<Uri>((ref) {
  return Uri();
});

class SiteSearchPage extends ConsumerWidget {
  const SiteSearchPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("サイトの検索"),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.60,
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Flexible(
                    child: SiteTextField(
                      stateProvider: urlTextControllerProvider,
                      hintText: 'URLを入力',
                    ),
                  ),
                  const Divider(),
                  Flexible(
                    child: SiteTextField(
                      stateProvider: wordSearchControllerProvider,
                      hintText: '検索ワードを入力',
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            Link(
              uri: ref.watch(uriStateProvider),
              target: LinkTarget.blank,
              builder: (BuildContext ctx, FollowLink? openLink) {
                return Container(
                  margin: const EdgeInsets.only(top: 30),
                  height: 50,
                  width: 200,
                  child: ElevatedButton(
                    onPressed: openLink,
                    child: const Text("検索"),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
