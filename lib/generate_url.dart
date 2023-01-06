import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'page/site_search_page.dart';

///
Uri generateUrl(String siteUrl, searchWord) {
  return Uri.parse("https://www.google.com/search?q=site%3A$siteUrl+$searchWord");
}

updateUrl(final WidgetRef ref) {
  ref.read(uriStateProvider.notifier).update((state) => generateUrl(
        ref.read(urlTextControllerProvider).text,
        ref.read(wordSearchControllerProvider).text,
      ));
}
