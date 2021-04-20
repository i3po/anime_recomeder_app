import 'package:boilerplate/models/recomendation/recomendation_list.dart';
import 'package:boilerplate/stores/language/language_store.dart';
import 'package:boilerplate/stores/anime/anime_store.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/stores/user/user_store.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/anime_grid_tile.dart';
import 'package:boilerplate/widgets/build_app_bar_buttons.dart';
import 'package:boilerplate/widgets/progress_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:boilerplate/models/anime/anime.dart';

class AnimeRecomendations extends StatefulWidget {
  @override
  _AnimeRecomendationsState createState() => _AnimeRecomendationsState();
}

class _AnimeRecomendationsState extends State<AnimeRecomendations> {
  //stores:---------------------------------------------------------------------
  late AnimeStore _animeStore;
  late ThemeStore _themeStore;
  late LanguageStore _languageStore;
  late UserStore _userStore;
  bool isInited = false;

  // Search block start
  final key = new GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = new TextEditingController();
  Icon actionIcon = new Icon(Icons.search);
  Widget appBarTitle = new Text("Recomended");
  bool _isSearching = false;
  String _searchText = "";

  RecomendationList _recomendationsList = RecomendationList(recomendations: []);

  @override
  void initState() {
    super.initState();

    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearching = true;
          _searchText = _searchQuery.text;
        });
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!isInited) {
      // initializing stores
      _languageStore = Provider.of<LanguageStore>(context);
      _themeStore = Provider.of<ThemeStore>(context);
      _userStore = Provider.of<UserStore>(context);
      _animeStore = Provider.of<AnimeStore>(context);

      isInited = true;
    }

    refreshRecs();
  }

  refreshRecs() async {
    await _userStore.initUser();
    _userStore
        .querryUserRecomendations(_userStore.user.id)
        .then((value) => setState(() {
              _recomendationsList = value;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: _buildAppBar(), body: _buildMainContent());
  }

  // app bar methods:-----------------------------------------------------------
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: appBarTitle,
      actions: _buildActions(context),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    var buttonsBlock = [];
    if (_isSearching == false)
      buttonsBlock = [
        buildThemeButton(context, _themeStore),
        buildLogoutButton(context, _userStore)
      ];

    return <Widget>[
      ...buttonsBlock,
      _buildSearchButton(),
    ];
  }

  Widget _buildSearchButton() {
    return new IconButton(
      icon: actionIcon,
      onPressed: () {
        setState(() {
          if (this.actionIcon.icon == Icons.search) {
            this.actionIcon = new Icon(Icons.close, size: 30);
            this.appBarTitle = new TextField(
              controller: _searchQuery,
              decoration: new InputDecoration(
                  prefixIcon: new Icon(Icons.search, size: 30),
                  hintText: "Search..."),
            );
            _handleSearchStart();
          } else {
            _handleSearchEnd();
          }
        });
      },
    );
  }

  void _handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.actionIcon = new Icon(
        Icons.search,
        size: 30,
      );
      this.appBarTitle = new Text("Recomended");
      _isSearching = false;
      _searchQuery.clear();
    });
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return _userStore.loading
            ? CustomProgressIndicatorWidget()
            : Material(
                child: Center(
                child: _buildGridView(),
              ));
      },
    );
  }

  Widget _buildGridView() {
    if (_recomendationsList.recomendations.isEmpty) return Container();

    if (_searchText.isEmpty) {
      _recomendationsList.cachedRecomendations =
          _recomendationsList.recomendations;
    } else {
      _recomendationsList.cachedRecomendations =
          _recomendationsList.recomendations.where((recomendation) {
        Anime element = _animeStore.animeList.animes.firstWhere(
            (anime) => anime.dataId.toString() == recomendation.item,
            orElse: () => Anime());
        if (element.id == Anime().id) return false;
        return element.nameEng
                .toLowerCase()
                .contains(_searchText.toLowerCase()) ||
            element.name.toLowerCase().contains(_searchText.toLowerCase());
      }).toList();
    }

    return _recomendationsList.recomendations.isNotEmpty
        ? RefreshIndicator(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.4,
                crossAxisSpacing: 4,
              ),
              itemCount: _recomendationsList.cachedRecomendations.length,
              itemBuilder: (context, index) {
                return _buildGridItem(index);
              },
            ),
            onRefresh: () => refreshRecs())
        : Center(
            child: Text(
              AppLocalizations.of(context)!.translate('home_tv_no_post_found'),
            ),
          );
  }

  Widget _buildGridItem(int position) {
    Anime animeItem = _animeStore.animeList.animes.firstWhere(
        (anime) =>
            anime.dataId.toString() ==
            _recomendationsList.cachedRecomendations[position].item.toString(),
        orElse: () => Anime());

    final isLiked = _userStore.isLikedAnime(animeItem.dataId);
    final isLater = _userStore.isLaterAnime(animeItem.dataId);
    final isBlack = _userStore.isBlackListedAnime(animeItem.dataId);

    return AnimeGridTile(
        anime: animeItem, isLiked: isLiked, isLater: isLater, isBlack: isBlack);
  }
}
