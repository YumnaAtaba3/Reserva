part of 'attraction_cubit.dart';

@immutable
sealed class AttractionState {}

final class AttractionInitial extends AttractionState {}
class AttractionLoadingState extends AttractionState {}
class addattractionLoadedState extends AttractionState {
  
}

class AttractionLoadedState extends AttractionState {
  final List<Attraction>  attraction;
    

  AttractionLoadedState(this.attraction);
}
class CityLoadedState extends AttractionState {

 final List<City> cities;
  CityLoadedState(this.cities);
}
// class TypeLoadedState extends AttractionState {

// final   List<AttractionsTypeElement> attractionsTypes;
//   TypeLoadedState(this.attractionsTypes);
// }

class AttractionErrorState extends AttractionState {
  final String errorMessage;

  AttractionErrorState(this.errorMessage);
}