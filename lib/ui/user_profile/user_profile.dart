import 'package:boilerplate/models/anime/anime.dart';
import 'package:boilerplate/stores/anime/anime_store.dart';
import 'package:boilerplate/stores/user/user_store.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/anime_list_tile.dart';
import 'package:boilerplate/widgets/progress_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile>
    with TickerProviderStateMixin {
  //stores:---------------------------------------------------------------------
  late AnimeStore _animeStore;
  late UserStore _userStore;
  bool isInited = false;
  List<Anime> likedAnimes = [];
  List<Anime> laterAnimes = [];
  List<Anime> blackAnimes = [];
  static const double _LIST_TILE_HEIGHT = 150;
  late Animation<double> animation;
  late AnimationController _fabController;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _fabController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _fabController.addListener(() {
      setState(() {});
    });
    animation = Tween<double>(begin: 0, end: 1).animate(_fabController);

    _tabController = TabController(vsync: this, length: 3);
    _tabController.addListener(_handleTabSelection);
    _fabController.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!isInited) {
      _userStore = Provider.of<UserStore>(context);
      _animeStore = Provider.of<AnimeStore>(context);

      setState(() {
        likedAnimes = _animeStore.animeList.animes
            .where(
                (anime) => _userStore.user.likedAnimes.contains(anime.dataId))
            .toList();
        laterAnimes = _animeStore.animeList.animes
            .where((anime) =>
                _userStore.user.watchLaterAnimes.contains(anime.dataId))
            .toList();
        blackAnimes = _animeStore.animeList.animes
            .where((anime) =>
                _userStore.user.blackListAnimes.contains(anime.dataId))
            .toList();
        isInited = true;
      });
    }

    _userStore.initUser();
  }

  void _handleTabSelection() {
    if (_tabController.index > 0) {
      _fabController.reverse();
    } else {
      _fabController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            bottom: TabBar(
              controller: _tabController,
              tabs: [
                Tab(icon: Icon(Icons.favorite)),
                Tab(icon: Icon(Icons.watch_later)),
                Tab(
                    icon: Transform.rotate(
                        angle: math.pi, child: Icon(Icons.recommend))),
              ],
            ),
            title: Text('${_userStore.user.email}')),
        body: Stack(
          children: [
            TabBarView(
              controller: _tabController,
              children: [
                _buildFavoriteContent(),
                _buildWatchLaterContent(),
                _buildBlackListContent(),
              ],
            ),
            Observer(
                builder: (context) =>
                    (_userStore.loading || _userStore.isLoading)
                        ? CustomProgressIndicatorWidget()
                        : Container())
          ],
        ));
  }

  Widget _buildWatchLaterContent() {
    return Container(child: Observer(
      builder: (context) {
        return _userStore.isLoading
            ? CustomProgressIndicatorWidget()
            : Scaffold(
                body: Center(
                child: _buildListViewLater(),
              ));
      },
    ));
  }

  Widget _buildBlackListContent() {
    return Container(child: Observer(
      builder: (context) {
        return _userStore.isLoading
            ? CustomProgressIndicatorWidget()
            : Scaffold(
                body: Center(
                child: _buildListViewBlack(),
              ));
      },
    ));
  }

  Widget _buildFavoriteContent() {
    return Container(child: Observer(
      builder: (context) {
        return _userStore.isLoading
            ? CustomProgressIndicatorWidget()
            : Scaffold(
                floatingActionButton: Transform.scale(
                  scale: animation.value,
                  child: FloatingActionButton(
                      child: Icon(Icons.delete),
                      onPressed: _showMaterialDialog),
                ),
                body: Center(
                  child: _buildListViewLiked(),
                ));
      },
    ));
  }

  Widget _buildListViewLiked() {
    return likedAnimes.length > 0
        ? ListView.builder(
            itemCount: likedAnimes.length,
            itemBuilder: (context, position) {
              return _buildListItemLiked(position);
            },
          )
        : Center(
            child: Text(
              AppLocalizations.of(context)!.translate('home_tv_no_post_found'),
            ),
          );
  }

  Widget _buildListViewLater() {
    return laterAnimes.length > 0
        ? ListView.builder(
            itemCount: laterAnimes.length,
            itemBuilder: (context, position) {
              return _buildListItemLater(position);
            },
          )
        : Center(
            child: Text(
              AppLocalizations.of(context)!.translate('home_tv_no_post_found'),
            ),
          );
  }

  Widget _buildListViewBlack() {
    return blackAnimes.length > 0
        ? ListView.builder(
            itemCount: blackAnimes.length,
            itemBuilder: (context, position) {
              return _buildListItemBlack(position);
            },
          )
        : Center(
            child: Text(
              AppLocalizations.of(context)!.translate('home_tv_no_post_found'),
            ),
          );
  }

  deleteLaterItem(int pos) async {
    await _userStore.removeWatchLaterAnime(this.laterAnimes[pos].dataId);
    setState(() {
      laterAnimes = _animeStore.animeList.animes
          .where((anime) =>
              _userStore.user.watchLaterAnimes.contains(anime.dataId))
          .toList();
    });
  }

  _showMaterialDialog() {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new Text(AppLocalizations.of(context)!.translate('favorites_reset_title')),
              content: new Text(AppLocalizations.of(context)!.translate('favorites_reset_ask')),
              actions: <Widget>[
                TextButton(
                  child: Text(AppLocalizations.of(context)!.translate('remove')),
                  onPressed: () async {
                    await deleteFavoritesAll();
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text(AppLocalizations.of(context)!.translate('close')),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  deleteFavoritesAll() async {
    await _userStore.deleteAllUserEvents();
    setState(() {
      likedAnimes = [];
    });
  }

  Widget _buildListItemLaterButtonsBlock(int pos) {
    return IconButton(
        icon: Icon(Icons.delete), onPressed: () => deleteLaterItem(pos));
  }

  deleteBlackItem(int pos) async {
    await _userStore.removeBlackListAnime(this.blackAnimes[pos].dataId);
    setState(() {
      blackAnimes = _animeStore.animeList.animes
          .where(
              (anime) => _userStore.user.blackListAnimes.contains(anime.dataId))
          .toList();
    });
  }

  Widget _buildListItemBlackButtonsBlock(int pos) {
    return IconButton(
        icon: Icon(Icons.delete), onPressed: () => deleteBlackItem(pos));
  }

  Widget _buildListItemLiked(int position) {
    return GestureDetector(
      onLongPress: _showMaterialDialog,
      child: AnimeListTile(
          anime: likedAnimes[position],
          isLiked: true,
          height: _LIST_TILE_HEIGHT),
    );
  }

  Widget _buildListItemLater(int position) {
    return GestureDetector(
      child: AnimeListTile(
          anime: laterAnimes[position],
          isLiked: _userStore.user.isAnimeLiked(laterAnimes[position].dataId),
          buttons: _buildListItemLaterButtonsBlock(position),
          height: _LIST_TILE_HEIGHT),
    );
  }

  Widget _buildListItemBlack(int position) {
    return GestureDetector(
      child: AnimeListTile(
          anime: blackAnimes[position],
          isLiked: _userStore.user.isAnimeLiked(blackAnimes[position].dataId),
          buttons: _buildListItemBlackButtonsBlock(position),
          height: _LIST_TILE_HEIGHT),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
