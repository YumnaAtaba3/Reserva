import 'package:flutter/material.dart';

class RoomsGrid extends StatefulWidget {
  const RoomsGrid({super.key});

  @override
  State<RoomsGrid> createState() => _ImagesGridState();
}

class _ImagesGridState extends State<RoomsGrid> {
  List items = [
    {
      "image": "images/im2.jpg",
    },
    {
      "image": "images/im3.jpg",
    },
    {
      "image": "images/im4.jpg",
    },
    {
      "image": "images/im5.jpg",
    }
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisExtent: 200),
        itemCount: items.length,
        itemBuilder: (context, i) {
          return InkWell(
            onTap: () {
              /*   Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => (Details(
                                data: items[i],
                              ))));*/
            },
            child: Stack(alignment: Alignment.bottomCenter, children: [
              Container(
                padding: const EdgeInsets.all(10),
                //width: 100,
                color: Colors.grey[200],
                child: Image.asset(
                  items[i]["image"],
                  height: 200,
                  width: 400,
                  fit: BoxFit.cover,
                ),
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.delete, color: Colors.white))
            ]),
          );
        });
  }
}
