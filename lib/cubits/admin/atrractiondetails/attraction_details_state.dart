part of 'attraction_details_cubit.dart';

@immutable
sealed class AttractionDetailsState {}

final class AttractionDetailsInitial extends AttractionDetailsState {}
class AttractionDetailsLoadingState extends AttractionDetailsState {}
class editattractionLoadedState extends AttractionDetailsState {
  
}

class AttractionDetailsLoadedState extends AttractionDetailsState {
  final AttractionDetails attraction;
 //final List<Review>  review;
  AttractionDetailsLoadedState(this.attraction,
  //this.review
  );
}
class AttractionDetailsLoadedStateWithReviews extends AttractionDetailsState {
  final AttractionDetails attraction;
 final List<Review>  review;
 AttractionDetailsLoadedStateWithReviews(this.attraction,
  this.review
  );
}

class reviewDetailsLoadedState extends AttractionDetailsState {
  final List<Review>  review;

  reviewDetailsLoadedState(this.review);
}

class AttractionDetailsErrorState extends AttractionDetailsState {
  final String errorMessage;

  AttractionDetailsErrorState(this.errorMessage);
}