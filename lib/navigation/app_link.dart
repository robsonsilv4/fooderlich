class AppLink {
  AppLink({
    this.location,
    this.currentTab,
    this.itemId,
  });

  static const kHomePath = '/home';
  static const kOnboardingPath = '/onboarding';
  static const kLoginPath = '/login';
  static const kProfilePath = '/profile';
  static const kItemPath = '/item';
  static const kTabParam = 'tab';
  static const kIdParam = 'id';

  String? location;
  int? currentTab;
  String? itemId;

  static AppLink fromLocation(String? location) {
    location = Uri.decodeFull(location ?? '');
    final uri = Uri.parse(location);

    final params = uri.queryParameters;
    final currentTab = int.tryParse(params[AppLink.kTabParam] ?? '');
    final itemId = params[AppLink.kIdParam];

    return AppLink(
      location: uri.path,
      currentTab: currentTab,
      itemId: itemId,
    );
  }

  String toLocation() {
    String addKeyValuePair({
      required String key,
      String? value,
    }) =>
        value == null ? '' : '$key=$value&';

    switch (location) {
      case kLoginPath:
        return kLoginPath;
      case kOnboardingPath:
        return kOnboardingPath;
      case kProfilePath:
        return kProfilePath;
      case kItemPath:
        String loc = '$kItemPath?';
        loc += addKeyValuePair(
          key: kIdParam,
          value: itemId,
        );
        return Uri.encodeFull(loc);
      default:
        String loc = '$kHomePath?';
        loc += addKeyValuePair(
          key: kTabParam,
          value: currentTab.toString(),
        );
        return Uri.encodeFull(loc);
    }
  }
}
