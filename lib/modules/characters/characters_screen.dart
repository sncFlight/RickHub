import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rick_hub/modules/characters/bloc/character_event.dart';
import 'package:rick_hub/modules/characters/bloc/characters_bloc.dart';
import 'package:rick_hub/modules/characters/bloc/characters_state.dart';
import 'package:rick_hub/modules/characters/models/character.dart';
import 'package:rick_hub/modules/characters/services/character_repository.dart';
import 'package:rick_hub/widgets/character_widget.dart';
import 'package:rick_hub/widgets/custom_app_bar.dart';
import 'package:rick_hub/widgets/custom_progress_indicator.dart';
import 'package:rick_hub/widgets/empty_state_widget.dart';

class CharactersScreen extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CharactersBloc>(
      create: (context) =>
          CharactersBloc(charactersRepository: CharactersRepository()),
      child: Scaffold(
        appBar: CustomAppBar(title: 'Characters', widget: Container()),
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 8),
              Expanded(
                child: _buildCharacters(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCharacters() {
    return BlocBuilder<CharactersBloc, CharactersState>(
      builder: (context, state) {
        if (state.formStatus == CharactersStatus.initial) {
          callRefresh(context);
          return SizedBox.shrink();
        } else if (state.formStatus == CharactersStatus.loading) {
          return Center(child: CustomProgressIndicator());
        } else if (state.formStatus == CharactersStatus.empty ||
            state.formStatus == CharactersStatus.error) {
          return EmptyStateWidget(text: 'No Characters');
        }

        return NotificationListener<ScrollNotification>(
          onNotification: (notification) {
            if (notification is ScrollEndNotification &&
                notification.metrics.extentAfter == 0) {
              callLoadMore(context);
            }
            return false;
          },
          child: RefreshIndicator(
            onRefresh: () => callRefresh(context),
            child: Scrollbar(
              controller: _scrollController,
              thumbVisibility: false,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: state.loadedCharacters.length + 1,
                padding: EdgeInsets.symmetric(horizontal: 16),
                physics: BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  if (index == state.loadedCharacters.length) {
                    if (state.loadedCharacters.isNotEmpty) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: Center(
                          child: CustomProgressIndicator(size: 140),
                        ),
                      );
                    }

                    return SizedBox.shrink();
                  }

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: _buildItem(state.loadedCharacters[index]),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildItem(Character character) {
    return CharacterWidget(character: character);
  }

  Future<void> callLoadMore(BuildContext context) async {
    context.read<CharactersBloc>().add(CharactersLoadedMoreEvent());
  }

  Future<void> callRefresh(BuildContext context) async {
    context.read<CharactersBloc>().add(CharactersPulledToRefreshEvent());
  }
}
