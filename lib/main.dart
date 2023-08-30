import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyWidget(),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class Place {
  final String name;
  final String category;

  Place({required this.name, required this.category});
}

List<Place> places = [
  Place(name: "Yer 1", category: "Camiler"),
  Place(name: "Yer 2", category: "Saraylar"),
  Place(name: "Yer 3", category: "Müzeler"),
  Place(name: "Yer 4", category: "Camiler"),
  Place(name: "Yer 5", category: "Müzeler"),
  Place(name: "Yer 6", category: "Parklar"),
  // Diğer öğeler
];

List<String> categories = ["Tümü", "Camiler", "Saraylar", "Müzeler", "Parklar"];
String selectedCategory = "Tümü";
List<Place> filteredPlaces = places;

void filterPlacesByCategory(String category) {
  if (category == "Tümü") {
    filteredPlaces = places;
  } else {
    filteredPlaces =
        places.where((place) => place.category == category).toList();
  }
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: 800,
      child: Column(
        children: [
          Container(
            //Filtreleme işleminin uygulayacak widget
            color: Colors.amber,
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = categories[index];
                        filterPlacesByCategory(selectedCategory);
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      alignment: Alignment.center,
                      color: selectedCategory == categories[index]
                          ? Colors.blue
                          : Colors.transparent,
                      child: Text(
                        categories[index],
                        style: TextStyle(
                          color: selectedCategory == categories[index]
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            //Tüm liste widgetı
            height: 500,
            child: ListView.builder(
              itemCount: filteredPlaces.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(filteredPlaces[index].name),
                  subtitle: Text(filteredPlaces[index].category),
                  // Diğer widget özellikleri buraya eklenebilir
                );
              },
            ),
          ),
        ],
      ),
    ));
  }
}
