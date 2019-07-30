import 'package:flutter/material.dart';
import 'package:pokedex/screens/pokemon_list/pokedex_cover.dart';

class PokemonListAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final double minHeight;

  PokemonListAppBar({this.expandedHeight, this.minHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: <Widget>[
        Positioned(
          top: 0,
          child: Container(
            height: expandedHeight,
            child: PokedexTopPanel(topBarHeight: expandedHeight),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
