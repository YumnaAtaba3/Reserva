// class AttractionsTypes {
//     int status;
//     Data data;
//     String message;

//     AttractionsTypes({
//         required this.status,
//         required this.data,
//         required this.message,
//     });

// }

// class Data {
//     List<AttractionsType> attractionsTypes;

//     Data({
//         required this.attractionsTypes,
//     });

// }

// class AttractionsType {
//     int id;
//     String attractionTypeName;

//     AttractionsType({
//         required this.id,
//         required this.attractionTypeName,
//     });

// }
// class AttractionTypes {
//   int id;
//   String attractionTypeName;

//   AttractionTypes({required this.id, required this.attractionTypeName});

//   factory AttractionTypes.fromJson(Map<String, dynamic> json) {
//     return AttractionTypes(
//       id: json['id'],
//       attractionTypeName: json['attraction_type_name'],
//     );
//   }
// }

// class AttractionsTypesResponse {
//   int status;
//   List<AttractionTypes> attractionsTypes;
//   String message;

//   AttractionsTypesResponse({required this.status, required this.attractionsTypes, required this.message});

//   factory AttractionsTypesResponse.fromJson(Map<String, dynamic> json) {
//   var data = json['data'];
//   var attractionsTypesData = data['attractions_types'] as List;

//   List<AttractionTypes> attractionsTypes =
//       attractionsTypesData.map((e) => AttractionTypes.fromJson(e)).toList();

//   return AttractionsTypesResponse(
//     status: json['status'],
//     attractionsTypes: attractionsTypes,
//     message: json['message'],
//   );
// }
// }

// class AttractionsType {
//   int status;
//   Data data;
//   String message;

//   AttractionsType({
//     required this.status,
//     required this.data,
//     required this.message,
//   });

//   factory AttractionsType.fromJson(Map<String, dynamic> json) {
//     return AttractionsType(
//       status: json['status'],
//       data: Data.fromJson(json['data']),
//       message: json['message'],
//     );
//   }
// }

// class Data {
//   List<AttractionsTypeElement> attractionsTypes;

//   Data({
//     required this.attractionsTypes,
//   });

//   factory Data.fromJson(Map<String, dynamic> json) {
//     List<dynamic> list = json['attractions_types'];
//     List<AttractionsTypeElement> attractionsTypes = list.map((item) => AttractionsTypeElement.fromJson(item)).toList();

//     return Data(attractionsTypes: attractionsTypes);
//   }
// }

// class AttractionsTypeElement {
//   int id;
//   String attractionTypeName;

//   AttractionsTypeElement({
//     required this.id,
//     required this.attractionTypeName,
//   });

//   factory AttractionsTypeElement.fromJson(Map<String, dynamic> json) {
//     return AttractionsTypeElement(
//       id: json['id'],
//       attractionTypeName: json['attractionTypeName'],
//     );
//   }
// }
