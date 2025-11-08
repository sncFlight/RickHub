import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rick_hub/constants/image_paths.dart';
import 'package:rick_hub/modules/characters/models/character.dart';
import 'package:rick_hub/modules/favorites/bloc/favorites_bloc.dart';
import 'package:rick_hub/modules/favorites/bloc/favorites_event.dart';
import 'package:rick_hub/modules/favorites/bloc/favorites_state.dart';
import 'package:rick_hub/modules/favorites/models/favorite_character.dart';
import 'package:rick_hub/widgets/location_widget.dart';

class CharacterWidget extends StatelessWidget {
  final Character character;

  const CharacterWidget({required this.character});

  @override
  Widget build(BuildContext context) {
    final String fullName = character.name;
    final String gender = character.gender.toLowerCase();
    final String status = character.status;
    final String originName = character.originName;
    final String locationName = character.locationName;
    final String imageUrl = character.imageUrl;
    final String species = character.species;
    const double imageSideLength = 100;

    final Color statusColor;

    if (status.toLowerCase().contains('alive')) {
      statusColor = Colors.green;
    } else if (status.toLowerCase().contains('unknown')) {
      statusColor = Colors.grey;
    } else {
      statusColor = Colors.red;
    }

    return Container(
      height: imageSideLength,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: Colors.white,
        shadows: [
          BoxShadow(
            color: Color(0x335B8911),
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
          BoxShadow(
            color: Color(0x59298E3E),
            offset: Offset(4, -4),
          )
        ],
      ),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                width: imageSideLength,
                child: Image.network(imageUrl),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  height: 16,
                  width: imageSideLength,
                  color: statusColor,
                  child: Center(
                    child: Text(
                      status.toUpperCase(),
                      style: GoogleFonts.rubik(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          fullName,
                          style: GoogleFonts.rubik(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      BlocBuilder<FavoritesBloc, FavoritesState>(
                        builder: (context, state) {
                          final isFavorite = context.read<FavoritesBloc>().isFavorite(character.id);
                          
                          return IconButton(
                            icon: Icon(
                              isFavorite ? Icons.star : Icons.star_border,
                              color: isFavorite ? Colors.amber : Colors.grey,
                              size: 24,
                            ),
                            onPressed: () {
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
                                context.read<FavoritesBloc>().add(
                                  AddToFavoritesEvent(character: favoriteCharacter),
                                );
                              }
                            },
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                          );
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      species + ', ' + gender,
                      style: GoogleFonts.rubik(
                        textStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 1),
                            child: SvgPicture.asset(ImagePaths.location),
                          ),
                          Expanded(child: LocationWidget(location: originName)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: SvgPicture.asset(ImagePaths.arrow),
                          ),
                          Expanded(child: LocationWidget(location: locationName)),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
