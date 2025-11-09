import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:rick_hub/modules/characters/models/character.dart';
import 'package:rick_hub/modules/favorites/bloc/favorites_bloc.dart';
import 'package:rick_hub/modules/favorites/bloc/favorites_event.dart';
import 'package:rick_hub/modules/favorites/bloc/favorites_state.dart';
import 'package:rick_hub/widgets/character_widget.dart';
import 'package:rick_hub/widgets/custom_app_bar.dart';
import 'package:rick_hub/widgets/custom_progress_indicator.dart';
import 'package:rick_hub/widgets/empty_state_widget.dart';

class FavoritesScreen extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Favorites',
        widget: _buildSortButton(context),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 8),
            Expanded(
              child: _buildFavorites(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSortButton(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        final currentSort =
            state is FavoritesLoaded ? state.sortType : SortType.name;

        return PopupMenuButton<SortType>(
          icon: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.sort, color: Colors.white, size: 20),
                SizedBox(width: 4),
                Icon(Icons.arrow_drop_down, color: Colors.white, size: 20),
              ],
            ),
          ),
          offset: Offset(0, 50),
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          onSelected: (SortType type) {
            context
                .read<FavoritesBloc>()
                .add(SortFavoritesEvent(sortType: type));
          },
          itemBuilder: (BuildContext context) => [
            PopupMenuItem(
              value: SortType.name,
              child: _buildMenuItem(
                icon: Icons.sort_by_alpha,
                title: 'By Name',
                subtitle: 'A to Z',
                isSelected: currentSort == SortType.name,
              ),
            ),
            PopupMenuDivider(height: 1),
            PopupMenuItem(
              value: SortType.status,
              child: _buildMenuItem(
                icon: Icons.info_outline,
                title: 'By Status',
                subtitle: 'Alive, Dead, Unknown',
                isSelected: currentSort == SortType.status,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isSelected,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      decoration: BoxDecoration(
        color: isSelected
            ? Color(0xFF11B0C8).withValues(alpha: 0.1)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isSelected ? Color(0xFF11B0C8) : Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 20,
              color: isSelected ? Colors.white : Color(0xFF6E7B8A),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.rubik(
                    fontSize: 15,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.rubik(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF9E9E9E),
                  ),
                ),
              ],
            ),
          ),
          if (isSelected)
            Icon(
              Icons.check_circle,
              color: Color(0xFF11B0C8),
              size: 20,
            ),
        ],
      ),
    );
  }

  Widget _buildFavoritesList(List favorites) {
    return Scrollbar(
      controller: _scrollController,
      thumbVisibility: false,
      child: ListView.builder(
        controller: _scrollController,
        padding: EdgeInsets.symmetric(horizontal: 16),
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
            padding: const EdgeInsets.only(bottom: 12),
            child: CharacterWidget(character: character),
          );
        },
      ),
    );
  }

  Widget _buildFavorites() {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        if (state is FavoritesInitial) {
          return CustomProgressIndicator();
        } else if (state is FavoritesLoaded) {
          if (state.favorites.isEmpty) {
            return EmptyStateWidget(text: 'No Favorites');
          }

          return _buildFavoritesList(state.favorites);
        } else if (state is FavoritesError) {
          return Center(child: Text('Error: ${state.message}'));
        }
        return SizedBox.shrink();
      },
    );
  }
}
