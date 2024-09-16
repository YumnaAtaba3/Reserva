
class LastAttraction {
    String attractionName;
    String city;
    String attractionType;

    LastAttraction({
        required this.attractionName,
        required this.city,
        required this.attractionType,
    });

    factory LastAttraction.fromJson(Map<String, dynamic> json) => LastAttraction(
        attractionName: json["attraction_name"],
        city: json["city"],
        attractionType: json["attraction_type"],
    );

    // Map<String, dynamic> toJson() => {
    //     "attraction_name": attractionName,
    //     "city": city,
    //     "attraction_type": attractionType,
    // };
}

class LastClient {
    String name;
    String email;
    String phone;
    String gender;

    LastClient({
        required this.name,
        required this.email,
        required this.phone,
        required this.gender,
    });

    factory LastClient.fromJson(Map<String, dynamic> json) => LastClient(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        gender: json["gender"],
    );

    // Map<String, dynamic> toJson() => {
    //     "name": name,
    //     "email": email,
    //     "phone": phone,
    //     "gender": gender,
    // };
}

class LastFlight {
    String airwayName;
    String fromCity;
    String toCity;
    int seatsNum;

    LastFlight({
        required this.airwayName,
        required this.fromCity,
        required this.toCity,
        required this.seatsNum,
    });

    factory LastFlight.fromJson(Map<String, dynamic> json) => LastFlight(
        airwayName: json["airway_name"],
        fromCity: json["from_city"],
        toCity: json["to_city"],
        seatsNum: json["seats_num"],
    );

    // Map<String, dynamic> toJson() => {
    //     "airway_name": airwayName,
    //     "from_city": fromCity,
    //     "to_city": toCity,
    //     "seats_num": seatsNum,
    // };
}

class LastHotel {
    String hotelName;
    String city;
    String description;
    int stars;
    int numberOfRooms;

    LastHotel({
        required this.hotelName,
        required this.city,
        required this.description,
        required this.stars,
        required this.numberOfRooms,
    });

    factory LastHotel.fromJson(Map<String, dynamic> json) => LastHotel(
        hotelName: json["hotel_name"],
        city: json["city"],
        description: json["description"],
        stars: json["stars"],
        numberOfRooms: json["number_of_rooms"],
    );

    // Map<String, dynamic> toJson() => {
    //     "hotel_name": hotelName,
    //     "city": city,
    //     "description": description,
    //     "stars": stars,
    //     "number_of_rooms": numberOfRooms,
    // };
}

class NewCompanies {
    int newCompanies;

    NewCompanies({
        required this.newCompanies,
    });

    factory NewCompanies.fromJson(Map<String, dynamic> json) => NewCompanies(
        newCompanies: json["new companies:"],
    );

    // Map<String, dynamic> toJson() => {
    //     "new companies:": newCompanies,
    // };
}

class NewUsers {
    int newClients;

    NewUsers({
        required this.newClients,
    });

    factory NewUsers.fromJson(Map<String, dynamic> json) => NewUsers(
        newClients: json["new clients"],
    );

    // Map<String, dynamic> toJson() => {
    //     "new clients": newClients,
    // };
}

class TotalReservations {
    int totalFlightReservations;

    TotalReservations({
        required this.totalFlightReservations,
    });

    factory TotalReservations.fromJson(Map<String, dynamic> json) => TotalReservations(
        totalFlightReservations: json["total flight reservations:"],
    );

    // Map<String, dynamic> toJson() => {
    //     "total flight reservations:": totalFlightReservations,
    // };
}
