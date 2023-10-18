import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rick_hub/constants/image_paths.dart';
import 'package:rick_hub/modules/characters/bloc/character_bloc.dart';
import 'package:rick_hub/modules/characters/bloc/character_event.dart';
import 'package:rick_hub/modules/characters/bloc/character_state.dart';
import 'package:rick_hub/modules/characters/models/character.dart';
import 'package:rick_hub/modules/characters/services/character_repository.dart';
import 'package:rick_hub/widgets/character_widget.dart';
import 'package:rick_hub/widgets/custom_app_bar.dart';
import 'package:rick_hub/widgets/logo_widget.dart';
import 'package:rick_hub/widgets/search_input.dart';

class CharactersScreen extends StatelessWidget {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CharactersBloc>(
      create: (context) => CharactersBloc(charactersRepository: CharactersRepository()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _buildAppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
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
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      title: 'Characters',
      widget: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
                color: Colors.white
            )
        ),
        child: SvgPicture.asset(
          ImagePaths.user,
          width: 24,
          height: 24,
        ),
      ),
    );
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.only(top: 7),
      child: BlocBuilder<CharactersBloc, CharactersState>(
        builder: (context, state) {
          return SearchInput(
            onChanged: (value) => context.read<CharactersBloc>().add(CharactersSearchChangedEvent(searchString: value)),
          );
        },
      ),
    );
  }

  Widget _buildLogo() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 12,
        right: 12,
        top: 19,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            ImagePaths.littleStar,
            width: 16,
            height: 16,
          ),
          SvgPicture.asset(
            ImagePaths.bigStar,
            width: 24,
            height: 24,
          ),
          LogoWidget(),
          SvgPicture.asset(
            ImagePaths.bigStar,
            width: 24,
            height: 24,
          ),
          SvgPicture.asset(
            ImagePaths.littleStar,
            width: 16,
            height: 16,
          ),
        ],
      ),
    );
  }


  Widget _buildCharacters() {
    return BlocBuilder<CharactersBloc, CharactersState>(
      builder: (context, state) {
        if (
          state.formStatus == CharactersStatus.loading
          && state.loadedCharacters.isEmpty
        ) {
          return SizedBox.shrink();
        }

        return NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification is ScrollEndNotification &&
                notification.metrics.extentAfter == 0) {

              onLoadedMore(context);
            }
            return false;
          },
          child: RefreshIndicator(
            onRefresh: () => onPulledToRefresh(context),
            child: ListView.builder(
              itemCount: state.loadedCharacters.length + 1,
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (BuildContext context, int index) {
                if (index == state.loadedCharacters.length) {
                  return CircularProgressIndicator();
                }

                return Padding(
                  padding: const EdgeInsets.only(top: 20,),
                  child: _buildItem(state.loadedCharacters[index]),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Future<void> onLoadedMore(BuildContext context) async {
    context.read<CharactersBloc>().add(CharactersLoadedMoreEvent());
  }

  Future<void> onPulledToRefresh(BuildContext context) async {
    context.read<CharactersBloc>().add(CharactersPulledToRefreshEvent());
  }

  Widget _buildItem(Character character) {
    return CharacterWidget(character: character);
  }
}
