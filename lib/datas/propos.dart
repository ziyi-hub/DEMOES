class Location {
  const Location({
    required this.id,
    required this.title,
    required this.adresse,
    required this.description,
    required this.imglink,
    required this.icon,
  });

  final int id;
  final String title;
  final String adresse;
  final String description;
  final String imglink;
  final String icon;
}

const urlPrefix =
    'https://docs.flutter.dev/cookbook/img-files/effects/parallax';

var locations = [
  Location(
    id: 0,
    title: 'Université Lorraine',
    adresse: '',
    description: "Université publique",
    imglink: '$urlPrefix/01-mount-rushmore.jpg',
    icon: "assets/icon/logoUL.png",
  ),
  Location(
    id: 1,
    title: 'CharlyLab',
    adresse: '',
    description: "Espace de créativité et de travail collaboratif",
    imglink: '$urlPrefix/02-singapore.jpg',
    icon: "assets/icon/logoCL.png",
  ),
  Location(
    id: 2,
    title: 'PLEIADES',
    adresse: '23 Bd Albert 1er, 54000 Nancy',
    description: "Projet Lorrain d’Environnement numérIque",
    imglink: '$urlPrefix/03-machu-picchu.jpg',
    icon: "assets/icon/logoUL.png",
  ),
];
