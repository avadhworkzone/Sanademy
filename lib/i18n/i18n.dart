// ignore_for_file: equal_keys_in_map


import 'package:i18n_extension/i18n_extension.dart';
import 'package:sanademy/i18n/ku_in.dart';

import 'en_us.dart';

extension Localization on String {
  static final _t = Translations.byLocale("en") +
      {
        "en": en,
      } +
      {
        "ku": ku,
      };

  String get i18n => localize(
        this,
        _t,
      );

  String fill(List<Object> params) => localizeFill(this, params);

  String plural(int value) => localizePlural(value, this, _t);

  String version(Object modifier) => localizeVersion(modifier, this, _t);

  Map<String?, String> allVersions() => localizeAllVersions(this, _t);
}
