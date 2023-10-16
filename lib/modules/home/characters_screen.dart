import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rick_hub/constants/Palette.dart';
import 'package:rick_hub/modules/home/bloc/character_bloc.dart';
import 'package:rick_hub/modules/home/bloc/character_event.dart';
import 'package:rick_hub/modules/home/bloc/character_state.dart';
import 'package:rick_hub/modules/home/models/character.dart';
import 'package:rick_hub/modules/home/services/character_repository.dart';
import 'package:rick_hub/widgets/item_widget.dart';
import 'package:rick_hub/widgets/search_input.dart';

class CharactersScreen extends StatelessWidget {
  final CharactersRepository charactersRepository = CharactersRepository();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CharactersBloc>(
      create: (context) => CharactersBloc(charactersRepository: context.read<CharactersRepository>()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildSearch(),
            _buildLogo(),
            Expanded(
              child: _buildCharacters(),
            )
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Palette.appBarGreen,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(18)),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.arrow_back_ios),
              ),
              Text('Characters'),
            ],
          ),
          Icon(Icons.account),
        ],
      ),
      // automaticallyImplyLeading: true,
      centerTitle: true,
    );
  }

  Widget _buildSearch() {
    return BlocBuilder<CharactersBloc, CharactersState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 30,
          ),
          child: SearchInput(
            onChanged: (value) => context.read<CharactersBloc>().add(CharactersSearchChangedEvent(searchString: value)),
          ),
        );
      },
    );
  }

  Widget _buildLogo() {
    final String logoText = ('rick hub').toUpperCase();

    return Column(
      children: [
        Container(
          height: 45,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: ShapeDecoration(
            color: Palette.brushGreen,
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 1, color: Palette.borderGreen),
              borderRadius: BorderRadius.circular(36),
            ),
            shadows: [
              BoxShadow(
                color: Color(0xA56E980B),
                blurRadius: 19,
                offset: Offset(0, 5),
                spreadRadius: 0,
              )
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                logoText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 31,
                  fontFamily: 'Rubik Bubbles',
                  fontWeight: FontWeight.w400,
                  height: 0,
                  letterSpacing: -0.27,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCharacters() {
    return BlocBuilder<CharactersBloc, CharactersState>(
      builder: (context, state) {
        return SmartRefresher(
          controller: RefreshController(initialRefresh: true),
          onRefresh: () => context.read<CharactersBloc>().add(CharactersPulledToRefreshEvent()),
          enablePullUp: true,
          child: ListView.builder(
            itemCount: state.loadedCharacters.length,
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(top: 20),
                child: _buildItem(state.loadedCharacters[index]),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildItem(Character character) {
    return CharacterWidget(character: character);
  }
}
