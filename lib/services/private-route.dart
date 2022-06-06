import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:my_clinic/pages/home_page.dart';
import 'package:my_clinic/pages/login_page.dart';

class ConditionalRouter extends MapMixin<String, WidgetBuilder> {
  final Map<String, WidgetBuilder> public;
  final Map<String, WidgetBuilder> private;

  ConditionalRouter({required this.public, required this.private});

  @override
  WidgetBuilder? operator [](Object? key) {
    if (public.containsKey(key)) {
      return public[key];
    }
    if (private.containsKey(key)) {
      var MyAuth;
      if (MyAuth.isUserLoggedIn) return private[key];
      // Adding next page parameter to your Login page
      // will allow you to go back to page, that user were going to
      return (context) => LoginPage();
    }
    return null;
  }

  @override
  void operator []=(key, value) {}

  @override
  void clear() {}

  @override
  Iterable<String> get keys {
    // ignore: prefer_collection_literals
    final set = Set<String>();
    set.addAll(public.keys);
    set.addAll(private.keys);
    return set;
  }

  @override
  WidgetBuilder? remove(Object? key) {
    return public[key] ?? private[key];
  }
}
