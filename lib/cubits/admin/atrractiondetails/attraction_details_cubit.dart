import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:reserva/helper/api.dart';
import 'package:reserva/models/admin/attraction_model.dart';
import 'package:reserva/models/admin/details_Attraction.dart';
import 'package:reserva/models/admin/review.dart';


part 'attraction_details_state.dart';

class AttractionDetailsCubit extends Cubit<AttractionDetailsState> {
  AttractionDetailsCubit() : super(AttractionDetailsInitial());
    
// void fetchAttractions(int id) async {
//   emit(AttractionDetailsLoadingState());

//   try {
//     String base_url = Api().base_url;

//     final response = await Api().get(url: '$base_url/showDetails/$id');
//     print('Fetching attraction details...');
//     print(response.body);

//     if (response.statusCode == 200) {
//       final jsonResponse = jsonDecode(response.body);

//       final attractionsDetails = AttractionDetails.fromJson(jsonResponse);
//       emit(AttractionDetailsLoadedState(attractionsDetails));
//     } else {
//       emit(AttractionDetailsErrorState('Invalid response format'));
//     }
//   } catch (e) {
//     print('Error occurred: $e');
//     emit(AttractionDetailsErrorState('An error occurred'));
//   }
// }
  void fetchreview( int id) async {
    emit(AttractionDetailsLoadingState());

  
    try {
      String base_url = Api().base_url;

      final response = await Api().get(url: '$base_url/showReviews/$id');
      print('.....................attraction  review   .........................');
      print(response.body);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        
        if (jsonResponse is List) {
          final reviews = jsonResponse.map((reviewJson) {
            final review = Review.fromJson(reviewJson);
            return review;
          }).toList();
          
          emit(reviewDetailsLoadedState(reviews));
        } else {
          emit(AttractionDetailsErrorState('Now data review'));
        }
      } else {
        emit(AttractionDetailsErrorState('Failed to fetch all review'));
      }
    } catch (e) {
      print('Error occurred: $e');
      emit(AttractionDetailsErrorState('An error occurred'));
    }
  }



void fetchAttractionDetailsAndReviews(int id) async {
  emit(AttractionDetailsLoadingState());

  try {
    String base_url = Api().base_url;

    // Fetch attraction details
    final detailsResponse = await Api().get(url: '$base_url/showDetails/$id');
    print('Fetching attraction details...');
    print(detailsResponse.body);

    // Fetch reviews
    final reviewsResponse = await Api().get(url: '$base_url/showReviews/$id');
    print('Fetching attraction reviews...');
    print(reviewsResponse.body);

    if (detailsResponse.statusCode == 200 && reviewsResponse.statusCode == 200) {
      final detailsJson = jsonDecode(detailsResponse.body);
      final reviewsJson = jsonDecode(reviewsResponse.body);

      final attractionDetails = AttractionDetails.fromJson(detailsJson);

      if (reviewsJson is List) {
        final reviews = reviewsJson.map((reviewJson) {
          final review = Review.fromJson(reviewJson);
          return review;
        }).toList();

        emit(AttractionDetailsLoadedStateWithReviews(attractionDetails, reviews));
      } else {
        emit(AttractionDetailsErrorState('Now data review'));
      }
    } else {
      emit(AttractionDetailsErrorState('Failed to fetch attraction details and reviews'));
    }
  } catch (e) {
    print('Error occurred: $e');
    emit(AttractionDetailsErrorState('An error occurred'));
  }
}
}
