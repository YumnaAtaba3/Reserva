import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reserva/cubits/company_owner/hotel/show/show_hotel_photos/cubit/show_hotel_photos_cubit.dart';
import 'package:reserva/models/comany_owner/hotel/my_hotel.dart';

class ImagesGrid extends StatelessWidget {
  ImagesGrid({super.key, required this.data});
  final List<HotelPhotos> data;
  List items = [
    {
      "image": "images/im6.jpg",
    },
    {
      "image": "images/im7.jpg",
    },
    {
      "image": "images/im8.jpg",
    },
    {
      "image": "images/im9.jpg",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisExtent: 200),
        itemCount: data.length,
        itemBuilder: (context, i) {
          return InkWell(
            onTap: () {
              // Navigator.of(context)
              //     .push(MaterialPageRoute(builder: (context) => (Details())));
            },
            child: Stack(alignment: Alignment.bottomCenter, children: [
              Container(
                padding: const EdgeInsets.all(10),
                //width: 100,
                color: Colors.grey[200],
                child: Image.network(
                  data[i].photo != null
                      ? data[i].photo!
                      : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQJKCzrgue_9Sr-OTUVGvzwhaJ_p3I36iAqwHGRY4Tm5OPRXWWc9jpvb3C4LXN1SCVjME&usqp=CAU",
                  height: 200,
                  width: 400,
                  fit: BoxFit.cover,
                ),
              ),
              IconButton(
                  onPressed: () {
                    BlocProvider.of<ShowHotelPhotosCubit>(context)
                        .deletePhoto(id: data[i].id.toString());
                  },
                  icon: Icon(Icons.delete, color: Colors.white))
            ]),
          );
        });
  }
}
