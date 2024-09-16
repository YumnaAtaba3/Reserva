// ignore_for_file: avoid_web_libraries_in_flutter, unused_import

import 'dart:convert';
import 'dart:html';
import 'dart:js';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:reserva/helper/api.dart';
import 'package:reserva/models/admin/attraction_model.dart';
import 'package:reserva/models/admin/atttractionType.dart';

part 'attraction_state.dart';

class AttractionCubit extends Cubit<AttractionState> {
  AttractionCubit() : super(AttractionInitial());


  
  void fetchAttractions() async {
    emit(AttractionLoadingState());

 
    try {
      String base_url = Api().base_url;

      final response = await Api().get(url: '$base_url/showAllAttraction');
      print('.....................attraction ......');
      print(response.body);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print('2000000........attraction.................');
        if (jsonResponse is List) {
          final attractions = jsonResponse.map((attractionJson) {
            final attraction =
                Attraction.fromJson(attractionJson);
            return attraction;
          }).toList();
          
          emit(AttractionLoadedState(attractions));
        } else {
          emit(AttractionErrorState('There is no attraction to show'));
        }
      } else {
        emit(AttractionErrorState(('There is no attraction to show ')));
      }
    } catch (e) {
      print('Error occurred: $e');
      emit(AttractionErrorState('An error occurred'));
    }
  }
  








void deleteAttraction(int AttractionId) async {
  emit(AttractionLoadingState());

  try {
    String base_url = Api().base_url;

    final response = await Api().get(
      url: '$base_url/deleteAttraction/$AttractionId',
    );
    print('Response body: ${response.body}');
    print('Status code: ${response.statusCode}');
    print('deleeeeeeeeeeeet');
    
    if (response.statusCode == 200) {
      if (response.body == 'attraction is deleted successfully') {
        print('Attraction deleted successfully');
        fetchAttractions(); 
        emit(AttractionLoadedState([]));
      } else {
        emit(AttractionErrorState('Failed to delete Attraction'));
      }
    } else {
      emit(AttractionErrorState('Failed to delete Attraction'));
    }
  } catch (e) {
    print("Error occurred: $e");
    emit(AttractionErrorState('An error occurred'));
  }
}

bool isSearchActive = false;

void searchAttractions(String query) {
  final currentState = state;

  if (query.isEmpty) {
    if (isSearchActive) {
      isSearchActive = false;
      fetchAttractions();
    }
    return;
  }

  final normalizedQuery = query.toLowerCase();

  if (currentState is AttractionLoadedState) {
    final filteredAttractions = currentState.attraction.where((attraction) {
      final attractionName = attraction.attractionName.toLowerCase();
      final city = attraction.city.cityName.toLowerCase();

      return attractionName.contains(normalizedQuery) || city.contains(normalizedQuery);
    }).toList();

    if (filteredAttractions.isEmpty) {
      // Emit the same state to prevent changing the current page content
      emit(AttractionLoadedState(currentState.attraction));
      isSearchActive = false;
      return;
    }

    emit(AttractionLoadedState(filteredAttractions));
    isSearchActive = true;
  }
}

// void searchAttractions(String query) {
//     final currentState = state;

//     if (query.isEmpty) {
//       fetchAttractions();
//       return;
//     }

//     final normalizedQuery = query.toLowerCase();

//     if (currentState is AttractionLoadedState) {
//       final filteredAttractions = currentState.attraction.where((attraction) {
//         final attractionName = attraction.attractionName.toLowerCase();
//         final city = attraction.city.cityName.toLowerCase();

//         return attractionName.contains(normalizedQuery) ||
//             city.contains(normalizedQuery);
//       }).toList();

//       emit(AttractionLoadedState(filteredAttractions));
//     }
//   }






}

