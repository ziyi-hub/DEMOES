import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_wiki_2/components/navBar/flipBoxBarPlus.dart';

const kGoogleApiKey = "AIzaSyB7noULujCymE-32A5auy10hE1060P-zSw";

class PoiDetailsState extends State<PoiDetailsWidget> {
  int id;
  String? title;
  String? description;
  String? adresse;
  double? latitude;
  double? longitude;
  String? site;
  final List<dynamic>? carousel;

  PoiDetailsState({
    required this.id,
    required this.title,
    required this.description,
    required this.adresse,
    required this.latitude,
    required this.longitude,
    required this.site,
    required this.carousel,
  });

  final Map<String, Marker> _markers = {};

  //Fetch data from json
  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _markers.clear();

      final marker = Marker(
        markerId: MarkerId(title!),
        position: LatLng(latitude!, longitude!),
        infoWindow: InfoWindow(
          title: title!,
          snippet: adresse!,
        ),
      );
      _markers[title!] = marker;
    });
  }

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                FlipBoxBar(
                  selectedIndex: selectedIndex,
                  id: id,
                  title: title!,
                  description: description!,
                  adresse: adresse!,
                  latitude: (latitude as num).toDouble(),
                  longitude: (longitude as num).toDouble(),
                  site: site!,
                  carousel: carousel!,
                ),
                Container(
                  height: 500,
                  child: GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(latitude!, longitude!),
                      zoom: 13,
                    ),
                    markers: _markers.values.toSet(),
                    myLocationEnabled: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PoiDetailsWidget extends StatefulWidget {
  final int id;
  final String title;
  final String description;
  final String adresse;
  final double latitude;
  final double longitude;
  final String site;
  final List<dynamic> carousel;

  PoiDetailsWidget({
    Key? key,
    required this.id,
    required this.title,
    required this.description,
    required this.adresse,
    required this.latitude,
    required this.longitude,
    required this.site,
    required this.carousel,
  });

  @override
  PoiDetailsState createState() => new PoiDetailsState(
        id: id,
        title: title,
        description: description,
        adresse: adresse,
        latitude: latitude,
        longitude: longitude,
        site: site,
        carousel: carousel,
      );
}

class PoiDetailsWidget_Info extends StatelessWidget {
  final int id;
  final String title;
  final String description;
  final String adresse;
  final double latitude;
  final double longitude;
  final String site;
  final List<dynamic> carousel;

  PoiDetailsWidget_Info({
    Key? key,
    required this.id,
    required this.title,
    required this.description,
    required this.adresse,
    required this.latitude,
    required this.longitude,
    required this.site,
    required this.carousel,
  });

  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                FlipBoxBar(
                  selectedIndex: selectedIndex,
                  id: id,
                  title: title,
                  description: description,
                  adresse: adresse,
                  latitude: (latitude as num).toDouble(),
                  longitude: (longitude as num).toDouble(),
                  site: site,
                  carousel: carousel,
                ),
                //Informations
                Padding(
                  //padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  padding: EdgeInsets.all(0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Carousel(
                          carousel: carousel,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 30.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: IconButton(
                                    icon: Icon(Icons.account_balance),
                                    onPressed: () {},
                                  ),
                                  flex: 1),
                              Expanded(child: Text(title), flex: 3)
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 30.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: IconButton(
                                    icon: Icon(Icons.info),
                                    onPressed: () {},
                                  ),
                                  flex: 1),
                              Expanded(child: Text(description), flex: 3)
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 30.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: IconButton(
                                    icon: Icon(Icons.location_on_outlined),
                                    onPressed: () {},
                                  ),
                                  flex: 1),
                              Expanded(child: Text(adresse), flex: 3)
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 30.0, bottom: 30.0),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: IconButton(
                                    icon: Icon(Icons.web),
                                    onPressed: () {},
                                  ),
                                  flex: 1),
                              Expanded(
                                child: InkWell(
                                  child: Text(site,
                                      style: TextStyle(
                                        color: Colors.blue,
                                        decoration: TextDecoration.underline,
                                      )),
                                  onTap: () => {launch(site)},
                                ),
                                flex: 3,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Image carousel

class Carousel extends StatefulWidget {
  final List<dynamic> carousel;
  Carousel({required this.carousel});

  @override
  State<Carousel> createState() => _CarouselState(images: carousel);
}

class _CarouselState extends State<Carousel> {
  final List<dynamic> images;
  _CarouselState({required this.images});
  late PageController _pageController;

  //List<String> images = carousel;

  int activePage = 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8, initialPage: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 200,
          child: PageView.builder(
              itemCount: images.length,
              pageSnapping: true,
              controller: _pageController,
              onPageChanged: (page) {
                setState(() {
                  activePage = page;
                });
              },
              itemBuilder: (context, pagePosition) {
                bool active = pagePosition == activePage;
                return slider(images, pagePosition, active);
              }),
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: indicators(images.length, activePage))
      ],
    );
  }
}

AnimatedContainer slider(images, pagePosition, active) {
  double margin = active ? 10 : 20;

  return AnimatedContainer(
    duration: Duration(milliseconds: 500),
    curve: Curves.easeInOutCubic,
    margin: EdgeInsets.all(margin),
    decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(images[pagePosition]))),
  );
}

imageAnimation(PageController animation, images, pagePosition) {
  return AnimatedBuilder(
    animation: animation,
    builder: (context, widget) {
      print(pagePosition);

      return SizedBox(
        width: 200,
        height: 200,
        child: widget,
      );
    },
    child: Container(
      margin: EdgeInsets.all(10),
      child: Image.network(images[pagePosition]),
    ),
  );
}

List<Widget> indicators(imagesLength, currentIndex) {
  return List<Widget>.generate(imagesLength, (index) {
    return Container(
      margin: EdgeInsets.all(3),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
          color: currentIndex == index ? Colors.black : Colors.black26,
          shape: BoxShape.circle),
    );
  });
}
