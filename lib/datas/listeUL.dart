/*class UL {
  const UL({
    required this.id,
    required this.longitude,
    required this.latitude,
    required this.altitude,
    required this.description,
    required this.name,
    required this.adresse,
    required this.image,
    required this.site,
    required this.carousel,
  });

  final int id;
  final double longitude;
  final double latitude;
  final double altitude;
  final String description;
  final String name;
  final String adresse;
  final String image;
  final String site;
  final List<String> carousel;
}

const urlPrefix =
    'https://docs.flutter.dev/cookbook/img-files/effects/parallax';

var datas = [
  UL(
    id: 0,
    longitude: 6.1611247,
    latitude: 48.6651218,
    altitude: 20.0,
    description: "Établissement d'enseignement supérieur à Vandœuvre-lès-Nancy",
    name: 'Faculté des Sciences et Technologies',
    adresse: 'Campus, Bd des Aiguillettes, 54506 Vandœuvre-lès-Nancy',
    image: '$urlPrefix/02-singapore.jpg',
    site: "http://fst.univ-lorraine.fr/",
    carousel: [
      "https://images.wallpapersden.com/image/download/purple-sunrise-4k-vaporwave_bGplZmiUmZqaraWkpJRmbmdlrWZlbWU.jpg",
      "https://wallpaperaccess.com/full/2637581.jpg",
      "https://uhdwallpapers.org/uploads/converted/20/01/14/the-mandalorian-5k-1920x1080_477555-mm-90.jpg"
    ],
  ),
  UL(
    id: 1,
    longitude: 6.1616104,
    latitude: 48.6835098,
    altitude: 20.0,
    description:
        "L'Institut Universitaire de Technologie Nancy-Charlemagne (souvent abrégé en IUT Nancy-Charlemagne) est un IUT créé en 1967. Il est une composante de l'Université de Lorraine.",
    name: "L'Institut Universitaire de Technologie Nancy-Charlemagne",
    adresse: '2Ter Bd Charlemagne, 54000 Nancy',
    image: '$urlPrefix/01-mount-rushmore.jpg',
    site: "http://iut-charlemagne.univ-lorraine.fr/",
    carousel: [
      "https://images.wallpapersden.com/image/download/purple-sunrise-4k-vaporwave_bGplZmiUmZqaraWkpJRmbmdlrWZlbWU.jpg",
      "https://wallpaperaccess.com/full/2637581.jpg",
      "https://uhdwallpapers.org/uploads/converted/20/01/14/the-mandalorian-5k-1920x1080_477555-mm-90.jpg"
    ],
  ),
  UL(
    id: 2,
    longitude: 6.1660106,
    latitude: 48.6956049,
    altitude: 20.0,
    description: "Université à Nancy",
    name: 'Campus Lettres et Sciences Humaines de Nancy',
    adresse: '23 Bd Albert 1er, 54000 Nancy',
    image: '$urlPrefix/03-machu-picchu.jpg',
    site: "http://campus-lettres.univ-lorraine.fr/",
    carousel: [
      "https://images.wallpapersden.com/image/download/purple-sunrise-4k-vaporwave_bGplZmiUmZqaraWkpJRmbmdlrWZlbWU.jpg",
      "https://wallpaperaccess.com/full/2637581.jpg",
      "https://uhdwallpapers.org/uploads/converted/20/01/14/the-mandalorian-5k-1920x1080_477555-mm-90.jpg"
    ],
  ),
  UL(
    id: 3,
    longitude: 6.1660106,
    latitude: 48.6956049,
    altitude: 20.0,
    description: "Université à Nancy",
    name: 'Campus Lettres et Sciences Humaines de Nancy',
    adresse: '23 Bd Albert 1er, 54000 Nancy',
    image: '$urlPrefix/04-vitznau.jpg',
    site: "http://campus-lettres.univ-lorraine.fr/",
    carousel: [
      "https://images.wallpapersden.com/image/download/purple-sunrise-4k-vaporwave_bGplZmiUmZqaraWkpJRmbmdlrWZlbWU.jpg",
      "https://wallpaperaccess.com/full/2637581.jpg",
      "https://uhdwallpapers.org/uploads/converted/20/01/14/the-mandalorian-5k-1920x1080_477555-mm-90.jpg"
    ],
  ),
  UL(
    id: 4,
    longitude: 6.1660106,
    latitude: 48.6956049,
    altitude: 20.0,
    description: "Université à Nancy",
    name: 'Campus Lettres et Sciences Humaines de Nancy',
    adresse: '23 Bd Albert 1er, 54000 Nancy',
    image: '$urlPrefix/05-bali.jpg',
    site: "http://campus-lettres.univ-lorraine.fr/",
    carousel: [
      "https://images.wallpapersden.com/image/download/purple-sunrise-4k-vaporwave_bGplZmiUmZqaraWkpJRmbmdlrWZlbWU.jpg",
      "https://wallpaperaccess.com/full/2637581.jpg",
      "https://uhdwallpapers.org/uploads/converted/20/01/14/the-mandalorian-5k-1920x1080_477555-mm-90.jpg"
    ],
  ),
  UL(
    id: 5,
    longitude: 6.1660106,
    latitude: 48.6956049,
    altitude: 20.0,
    description: "Université à Nancy",
    name: 'Campus Lettres et Sciences Humaines de Nancy',
    adresse: '23 Bd Albert 1er, 54000 Nancy',
    image: '$urlPrefix/06-mexico-city.jpg',
    site: "http://campus-lettres.univ-lorraine.fr/",
    carousel: [
      "https://images.wallpapersden.com/image/download/purple-sunrise-4k-vaporwave_bGplZmiUmZqaraWkpJRmbmdlrWZlbWU.jpg",
      "https://wallpaperaccess.com/full/2637581.jpg",
      "https://uhdwallpapers.org/uploads/converted/20/01/14/the-mandalorian-5k-1920x1080_477555-mm-90.jpg"
    ],
  ),
  UL(
    id: 6,
    longitude: 6.1660106,
    latitude: 48.6956049,
    altitude: 20.0,
    description: "Université à Nancy",
    name: 'Campus Lettres et Sciences Humaines de Nancy',
    adresse: '23 Bd Albert 1er, 54000 Nancy',
    image: '$urlPrefix/07-cairo.jpg',
    site: "http://campus-lettres.univ-lorraine.fr/",
    carousel: [
      "https://images.wallpapersden.com/image/download/purple-sunrise-4k-vaporwave_bGplZmiUmZqaraWkpJRmbmdlrWZlbWU.jpg",
      "https://wallpaperaccess.com/full/2637581.jpg",
      "https://uhdwallpapers.org/uploads/converted/20/01/14/the-mandalorian-5k-1920x1080_477555-mm-90.jpg"
    ],
  ),
];
*/