// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'anime_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AnimeStore on _AnimeStore, Store {
  final _$animeListAtom = Atom(name: '_AnimeStore.animeList');

  @override
  AnimeList get animeList {
    _$animeListAtom.reportRead();
    return super.animeList;
  }

  @override
  set animeList(AnimeList value) {
    _$animeListAtom.reportWrite(value, super.animeList, () {
      super.animeList = value;
    });
  }

  final _$similarsListsMapAtom = Atom(name: '_AnimeStore.similarsListsMap');

  @override
  Map<int, RecomendationList> get similarsListsMap {
    _$similarsListsMapAtom.reportRead();
    return super.similarsListsMap;
  }

  @override
  set similarsListsMap(Map<int, RecomendationList> value) {
    _$similarsListsMapAtom.reportWrite(value, super.similarsListsMap, () {
      super.similarsListsMap = value;
    });
  }

  final _$successAtom = Atom(name: '_AnimeStore.success');

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_AnimeStore.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$scrapperTypeAtom = Atom(name: '_AnimeStore.scrapperType');

  @override
  ParserType get scrapperType {
    _$scrapperTypeAtom.reportRead();
    return super.scrapperType;
  }

  @override
  set scrapperType(ParserType value) {
    _$scrapperTypeAtom.reportWrite(value, super.scrapperType, () {
      super.scrapperType = value;
    });
  }

  final _$anilibriaAnimeUrlAtom = Atom(name: '_AnimeStore.anilibriaAnimeUrl');

  @override
  String get anilibriaAnimeUrl {
    _$anilibriaAnimeUrlAtom.reportRead();
    return super.anilibriaAnimeUrl;
  }

  @override
  set anilibriaAnimeUrl(String value) {
    _$anilibriaAnimeUrlAtom.reportWrite(value, super.anilibriaAnimeUrl, () {
      super.anilibriaAnimeUrl = value;
    });
  }

  final _$anivostAnimeUrlAtom = Atom(name: '_AnimeStore.anivostAnimeUrl');

  @override
  String get anivostAnimeUrl {
    _$anivostAnimeUrlAtom.reportRead();
    return super.anivostAnimeUrl;
  }

  @override
  set anivostAnimeUrl(String value) {
    _$anivostAnimeUrlAtom.reportWrite(value, super.anivostAnimeUrl, () {
      super.anivostAnimeUrl = value;
    });
  }

  final _$gogoAnimeUrlAtom = Atom(name: '_AnimeStore.gogoAnimeUrl');

  @override
  String get gogoAnimeUrl {
    _$gogoAnimeUrlAtom.reportRead();
    return super.gogoAnimeUrl;
  }

  @override
  set gogoAnimeUrl(String value) {
    _$gogoAnimeUrlAtom.reportWrite(value, super.gogoAnimeUrl, () {
      super.gogoAnimeUrl = value;
    });
  }

  final _$isSearchingAtom = Atom(name: '_AnimeStore.isSearching');

  @override
  bool get isSearching {
    _$isSearchingAtom.reportRead();
    return super.isSearching;
  }

  @override
  set isSearching(bool value) {
    _$isSearchingAtom.reportWrite(value, super.isSearching, () {
      super.isSearching = value;
    });
  }

  final _$getLinksForAnimeAsyncAction =
      AsyncAction('_AnimeStore.getLinksForAnime');

  @override
  Future<void> getLinksForAnime(Anime anime) {
    return _$getLinksForAnimeAsyncAction
        .run(() => super.getLinksForAnime(anime));
  }

  final _$getAnimesAsyncAction = AsyncAction('_AnimeStore.getAnimes');

  @override
  Future<dynamic> getAnimes() {
    return _$getAnimesAsyncAction.run(() => super.getAnimes());
  }

  final _$refreshAnimesAsyncAction = AsyncAction('_AnimeStore.refreshAnimes');

  @override
  Future<dynamic> refreshAnimes() {
    return _$refreshAnimesAsyncAction.run(() => super.refreshAnimes());
  }

  final _$querrySImilarItemsAsyncAction =
      AsyncAction('_AnimeStore.querrySImilarItems');

  @override
  Future<RecomendationList> querrySImilarItems(int itemDataId) {
    return _$querrySImilarItemsAsyncAction
        .run(() => super.querrySImilarItems(itemDataId));
  }

  final _$getAnimeLinksAsyncAction = AsyncAction('_AnimeStore.getAnimeLinks');

  @override
  Future<List<AnimeVideo>> getAnimeLinks(String animeId, int episodeNum) {
    return _$getAnimeLinksAsyncAction
        .run(() => super.getAnimeLinks(animeId, episodeNum));
  }

  final _$getAnimeIdAsyncAction = AsyncAction('_AnimeStore.getAnimeId');

  @override
  Future<String> getAnimeId(Anime anime) {
    return _$getAnimeIdAsyncAction.run(() => super.getAnimeId(anime));
  }

  final _$_AnimeStoreActionController = ActionController(name: '_AnimeStore');

  @override
  void initialize() {
    final _$actionInfo = _$_AnimeStoreActionController.startAction(
        name: '_AnimeStore.initialize');
    try {
      return super.initialize();
    } finally {
      _$_AnimeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void handleSearchStart() {
    final _$actionInfo = _$_AnimeStoreActionController.startAction(
        name: '_AnimeStore.handleSearchStart');
    try {
      return super.handleSearchStart();
    } finally {
      _$_AnimeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearAnimesUrls() {
    final _$actionInfo = _$_AnimeStoreActionController.startAction(
        name: '_AnimeStore.clearAnimesUrls');
    try {
      return super.clearAnimesUrls();
    } finally {
      _$_AnimeStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
animeList: ${animeList},
similarsListsMap: ${similarsListsMap},
success: ${success},
isLoading: ${isLoading},
scrapperType: ${scrapperType},
anilibriaAnimeUrl: ${anilibriaAnimeUrl},
anivostAnimeUrl: ${anivostAnimeUrl},
gogoAnimeUrl: ${gogoAnimeUrl},
isSearching: ${isSearching}
    ''';
  }
}
