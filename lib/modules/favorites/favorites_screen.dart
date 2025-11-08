import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:rick_hub/constants/image_paths.dart';
import 'package:rick_hub/modules/characters/models/character.dart';
import 'package:rick_hub/modules/favorites/bloc/favorites_bloc.dart';
import 'package:rick_hub/modules/favorites/bloc/favorites_event.dart';
import 'package:rick_hub/modules/favorites/bloc/favorites_state.dart';
import 'package:rick_hub/widgets/character_widget.dart';
import 'package:rick_hub/widgets/custom_app_bar.dart';
import 'package:rick_hub/widgets/custom_progress_indicator.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Favorites',
        widget: _buildSortButton(context),
      ),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesInitial) {
            return CustomProgressIndicator();
          } else if (state is FavoritesLoaded) {
            if (state.favorites.isEmpty) {
              return _buildEmptyState();
            }
            return _buildFavoritesList(state.favorites);
          } else if (state is FavoritesError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildSortButton(BuildContext context) {
    return PopupMenuButton<SortType>(
      icon: Icon(Icons.sort, color: Colors.white),
      onSelected: (SortType type) {
        context.read<FavoritesBloc>().add(SortFavoritesEvent(sortType: type));
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          value: SortType.name,
          child: Text('By Name'),
        ),
        PopupMenuItem(
          value: SortType.status,
          child: Text('By Status'),
        ),
      ],
    );
  }

  Widget _buildFavoritesList(List favorites) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        final favorite = favorites[index];
        final character = Character(
          id: favorite.id,
          name: favorite.name,
          imageUrl: favorite.imageUrl,
          status: favorite.status,
          species: favorite.species,
          gender: favorite.gender,
          originName: favorite.originName,
          locationName: favorite.locationName,
        );

        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: CharacterWidget(character: character),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            ImagePaths.rickBelch,
            width: 200,
            height: 200,
          ),
          SizedBox(height: 20),
          Text(
            'No favorite characters',
            style: GoogleFonts.rubik(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
