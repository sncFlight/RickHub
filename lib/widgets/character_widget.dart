import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:rick_hub/modules/characters/models/character.dart';
import 'package:rick_hub/modules/favorites/bloc/favorites_bloc.dart';
import 'package:rick_hub/modules/favorites/bloc/favorites_event.dart';
import 'package:rick_hub/modules/favorites/bloc/favorites_state.dart';
import 'package:rick_hub/modules/favorites/models/favorite_character.dart';

class CharacterWidget extends StatelessWidget {
  final Character character;

  const CharacterWidget({required this.character});

  @override
  Widget build(BuildContext context) {
    final Color statusColor = _getStatusColor(character.status);

    return Card(
      elevation: 0,
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white24
              : Color(0xFFE0E0E0),
          width: 1,
        ),
      ),
      margin: EdgeInsets.zero,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              _buildImage(statusColor),
              SizedBox(width: 12),
              Expanded(
                child: _buildContent(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage(Color statusColor) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            character.imageUrl,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 100,
                height: 100,
                color: Colors.grey[300],
                child: Icon(Icons.person, size: 40, color: Colors.grey[600]),
              );
            },
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 24,
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Center(
              child: Text(
                character.status.toUpperCase(),
                style: GoogleFonts.rubik(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                character.name,
                style: GoogleFonts.rubik(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            _buildFavoriteButton(),
          ],
        ),
        SizedBox(height: 4),
        Text(
          '${character.species}, ${character.gender}',
          style: GoogleFonts.rubik(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: Color(0xFF6E7B8A),
          ),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.location_on, size: 14, color: Color(0xFF11B0C8)),
            SizedBox(width: 4),
            Expanded(
              child: Text(
                character.originName,
                style: GoogleFonts.rubik(
                  fontSize: 12,
                  color: Color(0xFF6E7B8A),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Row(
          children: [
            Icon(Icons.navigation, size: 14, color: Color(0xFF97CE4C)),
            SizedBox(width: 4),
            Expanded(
              child: Text(
                character.locationName,
                style: GoogleFonts.rubik(
                  fontSize: 12,
                  color: Color(0xFF6E7B8A),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFavoriteButton() {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        final isFavorite =
            context.read<FavoritesBloc>().isFavorite(character.id);

        return GestureDetector(
          onTap: () => _toggleFavorite(context, isFavorite),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 200),
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: isFavorite
                  ? Color(0xFFFFF3E0)
                  : Colors.grey.withValues(
                      alpha: 0.1,
                    ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isFavorite ? Icons.star : Icons.star_border,
              color: isFavorite ? Color(0xFFFFA726) : Color(0xFF9E9E9E),
              size: 20,
            ),
          ),
        );
      },
    );
  }

  void _toggleFavorite(BuildContext context, bool isFavorite) {
    if (isFavorite) {
      context.read<FavoritesBloc>().add(
            RemoveFromFavoritesEvent(characterId: character.id),
          );
    } else {
      final favoriteCharacter = FavoriteCharacter(
        id: character.id,
        name: character.name,
        imageUrl: character.imageUrl,
        status: character.status,
        species: character.species,
        gender: character.gender,
        originName: character.originName,
        locationName: character.locationName,
      );
      context
          .read<FavoritesBloc>()
          .add(AddToFavoritesEvent(character: favoriteCharacter));
    }
  }

  Color _getStatusColor(String status) {
    if (status.toLowerCase().contains('alive')) {
      return Color(0xFF4CAF50);
    } else if (status.toLowerCase().contains('unknown')) {
      return Color(0xFF9E9E9E);
    } else {
      return Color(0xFFE53935);
    }
  }
}
