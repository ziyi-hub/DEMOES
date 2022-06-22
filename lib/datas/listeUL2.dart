const urlPrefix =
    'https://docs.flutter.dev/cookbook/img-files/effects/parallax';

var datas = [
  {
    "id": 0,
    "longitude": 6.172229,
    "latitude": 48.6971757,
    "altitude": 20.0,
    "description":
        "L’Institut européen de cinéma et d’audiovisuel est une des rares structures universitaires et publiques en France à dispenser un Master Cinéma et Audiovisuel ouvert à tout étudiant détenteur d’une Licence (ou d’un diplôme équivalent) en formation initiale, et dans le cadre de la formation continue, aux salariés et aux personnes à la recherche d’un emploi dès lors que leur formation antérieure est jugée éligible.",
    "name": 'IECA',
    "adresse": '10 Rue Michel Ney, 54000 Nancy',
    "image": 'https://i.ytimg.com/vi/1OaBoi9kRzw/maxresdefault.jpg',
    "site": "http://ieca.univ-lorraine.fr/",
    "carousel": [
      "https://ieca.univ-lorraine.fr/files/2022/04/Bannie%CC%80re-site-JACES.png",
      "https://ieca.univ-lorraine.fr/files/2022/05/VpourV_FB.jpg",
      "https://ieca.univ-lorraine.fr/files/2022/04/Snowpiercer_FB.jpg"
    ],
    "icon": "assets/icon/ieca.png",
  },
  {
    "id": 1,
    "longitude": 6.1625817,
    "latitude": 49.1211936,
    "altitude": 20.0,
    "description":
        "L’UFR Arts, lettres et langues – Metz est le siège des études artistiques, des formations littéraires et de la spécialisation en langues vivantes. Elle se compose de 10 départements pédagogiques, assurant une offre de formation et de recherche diversifiée : « arts » (« arts plastiques » ou « arts du spectacle »), « musique », « lettres classiques », « lettres modernes », « allemand », « franco-allemand », « anglais », « espagnol », « LEA » (« Langues Étrangères Appliquées ») ou « FLE » (« Français comme Langue Étrangère »).",
    "name": 'UFR ALL-METZ',
    "adresse": 'Prom. du Saulcy, 57000 Metz',
    "image":
        'https://lh5.googleusercontent.com/p/AF1QipPGOku-UZdJ_u0hzW8wHB3IgJJCTFbIw8z6iC-_=s957-k',
    "site": "http://all-metz.univ-lorraine.fr/",
    "carousel": [
      "https://lh5.googleusercontent.com/p/AF1QipO-3kcnNX-iiU1UrpzSK6tIZRJCpUCSImo0V3ZQ=s890-k",
      "https://lh5.googleusercontent.com/p/AF1QipN6fVCnFks2Fuhq6fqPUxQ2qBu5VwDy3nw88tQo=s854-k-no",
      "https://lh5.googleusercontent.com/p/AF1QipON19ogCmB5E0QzDzKmn1te9JR6vN0o82U6qH0K=s773-k-no"
    ],
    "icon": "assets/icon/ufr-all-metz.png",
  },
  {
    "id": 2,
    "longitude": 6.1656114,
    "latitude": 48.6953523,
    "altitude": 20.0,
    "description":
        "L’UFR Arts, Lettres et Langues (UFR ALL-Nancy) est une composante de l’Université de Lorraine créée en 2013. Située au coeur de Nancy, sur le Campus Lettres et Sciences Humaines, elle accueille chaque année 4000 étudiants environ en présentiel et à distance. Soucieuse de promouvoir la connaissance des langues, histoires et cultures européennes et méditerranéennes, le bilinguisme, le trilinguisme et la diversité culturelle et linguistique des nombreux pays qui la composent et avec lesquels elle est en relation, l’UFR propose : 16 licences, 2 licences professionnelles, 11 masters, 5 masters Métiers de l’Enseignement, de l’Éducation et de la Formation (MEEF) et 2 Diplômes universitaires ainsi que des préparations à l’Agrégation, autour des arts, des lettres modernes et classiques et des langues et cultures étrangères (anglais, allemand, arabe, espagnol, italien, russe, polonais).",
    "name": 'UFR ALL-NANCY',
    "adresse": '23 Bd Albert 1er, 54000 Nancy',
    "image":
        'https://lh3.ggpht.com/p/AF1QipO0LdBBrT7jEw49wKo-wffkSALVqDTpRt4DFv1w=s1024',
    "site": "http://all-nancy.univ-lorraine.fr/",
    "carousel": [
      "https://lh5.googleusercontent.com/p/AF1QipO1YO04QHoiAbMWVDaqx3f-qSDxNGaBVfElt19V=s901-k-no",
      "https://lh5.googleusercontent.com/p/AF1QipMKVWFcME-8_XunMq08D00LrVqieoNCec5Oa3tL=s823-k",
      "https://lh5.googleusercontent.com/p/AF1QipOKq7ffzJyMXDsT_YoDJpS_uraMHJJs1B7Kbx8s=w312-h228-p-k-no"
    ],
    "icon": "assets/icon/ufr-all-nancy.png",
  },
  {
    "id": 3,
    "longitude": 6.1763212,
    "latitude": 48.6935585,
    "altitude": 20.0,
    "description":
        "Le Centre européen universitaire est né il y a plus de soixante ans, alors que l’Union européenne émergeait. Le Centre Européen Universitaire de Nancy compte parmi les plus anciennes formations à vocation européenne. Une des valeurs premières du CEU est d’être et d’avoir toujours été un lieu de brassage entre l’Europe de l’Est et de l’Europe de l’Ouest.",
    "name": 'CEU',
    "adresse": '15 Pl. Carnot, 54042 Nancy',
    "image": 'http://ceu.univ-lorraine.fr/files/2018/02/MG_0005.jpg',
    "site": "http://ceu.univ-lorraine.fr/",
    "carousel": [
      "https://lh5.googleusercontent.com/p/AF1QipOldKgEr2naBMRU0QXuaF1pHqfp5Y9ISS0sxeCm=w748-h298-k",
      "http://ceu.univ-lorraine.fr/files/2018/03/BDE-2016.jpg",
      "https://lh5.googleusercontent.com/p/AF1QipNtJPt8cTa51-xpiwWIFZzeOfdxHGWRawtGVMl8=w203-h203-k"
    ],
    "icon": "assets/icon/ceu.png",
  },
  {
    "id": 4,
    "longitude": 6.1612186,
    "latitude": 49.120847,
    "altitude": 20.0,
    "description":
        "Avec près de 3.000 étudiants sur le site principal de Metz et le site délocalisé de Sarreguemines, la Faculté de droit, économie et administration de Metz connaît une constante augmentation de ses effectifs grâce à une équipe dynamique composée dune cinquantaine d’enseignants-chercheurs, impliquée dans le domaine pédagogique et active dans le domaine de la recherche, et grâce à des services administratifs, dévoués et compétents, composés dune vingtaine d’agents.",
    "name": 'FACULTÉ DE DROIT, ÉCONOMIE ET ADMINISTRATION DE METZ',
    "adresse": 'Ile du Saulcy, 57000 Metz',
    "image":
        'https://lh5.googleusercontent.com/p/AF1QipNaBBF3isEAIXntEtsgm_TT3hpnl2ndEzOEqPv4=s775-k',
    "site": "http://fac-droit-economie-administration.univ-lorraine.fr/",
    "carousel": [
      "https://lh5.googleusercontent.com/p/AF1QipPO77a3PPzyFW2-1gOxGi2oWG6CqVEhiJfRFvbL=s773-k",
      "https://lh5.googleusercontent.com/p/AF1QipMNGLjRoMFsHvzK2Ob2MV4eClj6Iy33knFPQxto=s1242-k",
      "https://lh5.googleusercontent.com/p/AF1QipNrElgQ2AO68tXPvfvXskNq3GQSTMJhXOmdiYe5=s870-k"
    ],
    "icon": "assets/icon/faculte-de-droit-metz.png",
  },
  {
    "id": 5,
    "longitude": 6.1767028,
    "latitude": 48.693109,
    "altitude": 20.0,
    "description":
        "Fondée en 1582 à Pont-à-Mousson, transférée à Nancy en 1768, fermée en 1792, notre Faculté fut restaurée par l’Empereur Napoléon III le 9 janvier 1864. Fière de son histoire, forte de ses 4800 étudiants, bénéficiant dune identité culturelle affirmée, la Faculté de droit, Sciences économiques et gestion de Nancy allie recherche de l’excellence et volonté de professionnalisation de ses enseignements. Offrant une large gamme de formations ouvrant sur les carrières judiciaires, le droit des affaires, le droit du travail, le droit public, la finance ou l’économie, la Faculté est résolument tournée vers l’avenir.",
    "name": 'FACULTÉ DE DROIT, SCIENCES ÉCONOMIQUES ET GESTION - NANCY',
    "adresse": '13 Pl. Carnot, 54000 Nancy',
    "image":
        'https://lh5.googleusercontent.com/p/AF1QipOA8KF0bP6WZkNLnKGQKKwGOu2qaTWvLaTzZ40I=w408-h306-k-no',
    "site": "https://fac-droit.univ-lorraine.fr/",
    "carousel": [
      "https://lh5.googleusercontent.com/p/AF1QipOA8KF0bP6WZkNLnKGQKKwGOu2qaTWvLaTzZ40I=s901-k-no",
      "https://lh5.googleusercontent.com/p/AF1QipM4fFo9IhFOEDdUwEIaYCy-m2X3r5_EhKDeFhAO=s870-k",
      "https://lh5.googleusercontent.com/p/AF1QipO5aBP1Edb-Aw0KKPR1T-jm_Oae4urbL2JAk0Rn=s773-k"
    ],
    "icon": "assets/icon/faculte-de-droit-nancy.png",
  },
  {
    "id": 6,
    "longitude": 6.1756424,
    "latitude": 48.6930183,
    "altitude": 20.0,
    "description":
        "L’Institut de préparation à l’administration générale – IPAG – prépare aux concours administratifs par la licence et le master 1 d’Administration Publique, ainsi que par les filières externes et internes non diplômantes aux concours A et B de la fonction publique.",
    "name": 'IPAG Nancy',
    "adresse": '4 Rue de la Ravinelle, 54000 Nancy',
    "image":
        'https://lh5.googleusercontent.com/p/AF1QipM7_HoC1RinFm_YF_7vBfx_hp9sQo0WDMsvG27H=s773-k',
    "site": "http://ipag.univ-lorraine.fr/",
    "carousel": [
      "https://lh5.googleusercontent.com/p/AF1QipMvaCDPtQKGyDnzk6FAfjyUx12w3sCHbTVeFBtf=s991-k",
      "https://lh5.googleusercontent.com/p/AF1QipM7_HoC1RinFm_YF_7vBfx_hp9sQo0WDMsvG27H=s773-k",
      "https://lh5.googleusercontent.com/p/AF1QipO8KFsLSheQtpAlF72S0dmuMjCOMZ1gNWBKSdq7=s901-k"
    ],
    "icon": "assets/icon/ipag-1.png",
  },
  {
    "id": 7,
    "longitude": 6.1597459,
    "latitude": 48.6970022,
    "altitude": 20.0,
    "description":
        "Institut régional du travail : “Les instituts du travail ont pour mission la formation et la recherche en sciences sociales du travail. Dans ce cadre, ils contribuent à la formation des membres des organisations syndicales, des organismes du secteur de l’économie sociale et des associations” (Décret n° 89-266 du 25 avril 1989 relatif aux Instituts du Travail.)",
    "name": 'INSTITUT RÉGIONAL DU TRAVAIL',
    "adresse": '54000 Nancy',
    "image":
        'https://lh5.googleusercontent.com/p/AF1QipNmGpzsM2186uDxU4fMQPUbJHYDMyhjE4LQr-Wp=s773-k',
    "site": "http://irt.univ-lorraine.fr/",
    "carousel": [
      "https://lh5.googleusercontent.com/p/AF1QipO2nq1n5H6NBxVkxZ57IyLdTNN5vTRszw-A3ARY=s901-k",
      "https://lh5.googleusercontent.com/p/AF1QipP8WH7iS_K_xsxDyK3d3P2MRqUoAui81GIB9nhX=s773-k",
      "https://lh5.googleusercontent.com/p/AF1QipNRH0DPN5_THf2WyZ-77rrjWvPOJE88Jq1yR4EW=s1014-k"
    ],
    "icon": "assets/icon/irt.png",
  },
  {
    "id": 8,
    "longitude": 6.1638692,
    "latitude": 48.7041168,
    "altitude": 20.0,
    "description":
        "L’Institut National Supérieur du Professorat et de l’Éducation, composante universitaire du collegium INTERFACE, se consacre principalement à la formation initiale des étudiants se destinant aux métiers de l’enseignement, de l’éducation et de la formation. L’INSPÉ de Lorraine participe à la formation des enseignants du supérieur et contribue à la formation continue de tous les enseignants quel que soit leur niveau d’enseignement. L’INSPÉ investit aussi le champ de la recherche disciplinaire et pédagogique en éducation et développe des actions de coopération internationale.",
    "name":
        "INSTITUT NATIONAL SUPÉRIEUR DU PROFESSORAT ET DE L'ÉDUCATION Nancy",
    "adresse": '54b Bd de Scarpone, 54000 Nancy',
    "image":
        'https://lh5.googleusercontent.com/p/AF1QipONkl2j6G1CH7LkrIEg-7KXd47YAJG8q-OwflML=s870-k',
    "site": "http://inspe.univ-lorraine.fr/",
    "carousel": [
      "https://streetviewpixels-pa.googleapis.com/v1/thumbnail?output=thumbnail&cb_client=maps_sv.tactile.gps&panoid=xrj2bbpf1TLaZPwl-vtFNw&w=1177&h=580&thumb=2&yaw=71.83403&pitch=0",
      "https://lh5.googleusercontent.com/p/AF1QipONkl2j6G1CH7LkrIEg-7KXd47YAJG8q-OwflML=s870-k"
    ],
    "icon": "assets/icon/inspe-de-lorraine.png",
  },
  {
    "id": 9,
    "longitude": 6.1648232,
    "latitude": 48.7098925,
    "altitude": 20.0,
    "description":
        "L’Institut National Supérieur du Professorat et de l’Éducation, composante universitaire du collegium INTERFACE, se consacre principalement à la formation initiale des étudiants se destinant aux métiers de l’enseignement, de l’éducation et de la formation. L’INSPÉ de Lorraine participe à la formation des enseignants du supérieur et contribue à la formation continue de tous les enseignants quel que soit leur niveau d’enseignement. L’INSPÉ investit aussi le champ de la recherche disciplinaire et pédagogique en éducation et développe des actions de coopération internationale.",
    "name":
        "INSTITUT NATIONAL SUPÉRIEUR DU PROFESSORAT ET DE L'ÉDUCATION Maxéville",
    "adresse": '5 Rue Paul Richard, 54320 Maxéville',
    "image":
        'https://lh5.googleusercontent.com/p/AF1QipMoC6ukDi3DlttdV4SjpwTnu7qY-AvnWzTbNtFb=s773-k-no',
    "site": "http://inspe.univ-lorraine.fr/",
    "carousel": [
      "https://lh5.googleusercontent.com/p/AF1QipMbOlD_QlPbRgPilvOhTLDRVKo3yAfVk43aIkL2=s879-k-no",
      "https://lh5.googleusercontent.com/p/AF1QipMCBDJja-jotQDOW2KYDAwaT5m-ExqEqRcMM2w9=s870-k-no",
      "https://lh5.googleusercontent.com/p/AF1QipM_RYgtl_R9Fh3hTh3aOOBTkQHBdepI4G9UcooK=s901-k-no"
    ],
    "icon": "assets/icon/inspe-de-lorraine.png",
  },
  {
    "id": 10,
    "longitude": 6.2304682,
    "latitude": 49.0942539,
    "altitude": 20.0,
    "description":
        "Institut supérieur franco-allemand de techniques, d’économie et de sciences : Premier cursus intégré franco-allemand de l’enseignement supérieur lISFATES fut créé en 1978 par décision intergouvernementale. Soutenus depuis 2005 par l’Université Franco allemande www.dfh-ufa.org,en particulier par l’attribution de bourses de mobilité, les cursus de l’ISFATES délivrent des diplômes conjoints de licence et master avec la Hochschule für Technik und Wirtschaft des Saarlandes (HTW) www.htwsaar.de . Les filières transversales franco-allemandes de l’ISFATES s’appuient sur les formations réseau d’UFR couvrant différents domaines de formation et cycles d’études.",
    "name":
        "INSTITUT SUPÉRIEUR FRANCO-ALLEMAND DE TECHNIQUES, D'ÉCONOMIE ET DE SCIENCES",
    "adresse": 'Rue Augustin Fresnel, 57073 Metz',
    "image":
        'https://lh3.ggpht.com/p/AF1QipM6rBuvo0Q_TFYW02hzyca7KQLJwRdWnoMBmm1W=s1024',
    "site": "http://www.isfates-dfhi.eu/",
    "carousel": [
      "https://lh5.googleusercontent.com/p/AF1QipMc4OX5Umsj9DHo1JO_79agF_HHum5OyDgEEMg7=w312-h228-p-k-no",
      "https://lh5.googleusercontent.com/p/AF1QipMeEo8BG_TYlLkl5neT8q_OCQGb6dm8zgiBpxWK=s773-k-no",
      "https://lh5.googleusercontent.com/p/AF1QipNexgXUTTZxPFpfcSaYcWqQv7YEcObGPdQprpI7=s901-k-no"
    ],
    "icon": "assets/icon/isfates.png",
  },
  {
    "id": 11,
    "longitude": 6.1648048,
    "latitude": 49.1210973,
    "altitude": 20.0,
    "description":
        "L’UFR Lansad assure la formation en langues étrangères et en français langue étrangère des usagers spécialistes d’autres disciplines au sein de l’Université de Lorraine.",
    "name": 'UFR LANSAD METZ',
    "adresse":
        "Bâtiment A de l'ex-ISGMP Bureau 111 - 1er étage île du Saulcy, 57045 METZ",
    "image":
        'https://lh5.googleusercontent.com/p/AF1QipN6fVCnFks2Fuhq6fqPUxQ2qBu5VwDy3nw88tQo=s854-k-no',
    "site": "https://lansad.univ-lorraine.fr/",
    "carousel": [
      "https://lh5.googleusercontent.com/p/AF1QipOJ_3h2jVwrrQejjNh08HsOAOfN4jVvS5DJaBw=s773-k-no",
      "https://lh5.googleusercontent.com/p/AF1QipPGOku-UZdJ_u0hzW8wHB3IgJJCTFbIw8z6iC-_=s957-k-no",
      "https://lh5.googleusercontent.com/p/AF1QipPjrO2imDsyqFjamUby1ltyvX3hvFWUz9wfonDo=s1264-k-no"
    ],
    "icon": "assets/icon/ufr-lansad.png",
  },
  {
    "id": 12,
    "longitude": 6.1934152,
    "latitude": 48.6955015,
    "altitude": 20.0,
    "description":
        "L’EEIGM – Ecole Européenne d’Ingénieurs en Génie des Matériaux est une école en 3 ou 5 ans. Ingénieurs avec double compétence : génie des matériaux et langues étrangères. Scolarité dans 6 universités : Nancy, Barcelone, Sarrebruck, Luleå, Valence, Moscou. Filière classique et par apprentissage.",
    "name": "ÉCOLE EUROPÉENNE D'INGÉNIEURS EN GÉNIE DES MATÉRIAUX (EEIGM)",
    "adresse": '6 Rue Bastien-Lepage, 54000 Nancy',
    "image":
        'https://lh5.googleusercontent.com/p/AF1QipOzWY3av579OOLXG14C1MuMzdYqb8lSCJ0f0SYP=s534-k-no',
    "site": "http://eeigm.univ-lorraine.fr/",
    "carousel": [
      "https://streetviewpixels-pa.googleapis.com/v1/thumbnail?output=thumbnail&cb_client=maps_sv.tactile.gps&panoid=UUX0hkOsdEJfMF2UtUssUg&w=1177&h=580&thumb=2&yaw=39.89766&pitch=0",
      "https://lh3.ggpht.com/p/AF1QipOzWY3av579OOLXG14C1MuMzdYqb8lSCJ0f0SYP=s1024",
    ],
    "icon": "assets/icon/eeigm.png",
  },
  {
    "id": 13,
    "longitude": 6.2274714,
    "latitude": 49.0924854,
    "altitude": 20.0,
    "description":
        "L’ENIM – Ecole Nationale d’Ingénieurs de Metz est née en 1961 en même temps que ses “”soeurs”” de Tarbes, Saint-Etienne et Brest, l’ENIM est le fruit de deux volontés conjointes : celle de l’Etat, qui veut alors déconcentrer et structurer l’enseignement technique supérieur, et celle de l’industrie qui, dans un contexte de forte expansion économique, redoute une pénurie d’ingénieurs.",
    "name": "ÉCOLE NATIONALE D'INGÉNIEURS DE METZ",
    "adresse": "1 Rte d'Ars Laquenexy, 57078 Metz",
    "image":
        'https://lh5.googleusercontent.com/p/AF1QipNBrGiF6FZfFw5MBwnOPRyD58WJqVwVBaheGIk=s968-k-no',
    "site": "http://enim.univ-lorraine.fr/",
    "carousel": [
      "https://lh5.googleusercontent.com/p/AF1QipPMpOzZyDDAG_7jZQFR9JgorTeD3Sb2dGGd6I45=s1033-k-no",
      "https://lh5.googleusercontent.com/p/AF1QipNv4PByOkjXxmccasQHM1PqJLT2PdkyUSYMOgL9=s870-k-no",
      "https://lh5.googleusercontent.com/p/AF1QipNBrGiF6FZfFw5MBwnOPRyD58WJqVwVBaheGIk=s968-k-no"
    ],
    "icon": "assets/icon/enim.png",
  },
  {
    "id": 14,
    "longitude": 6.147208,
    "latitude": 48.6518191,
    "altitude": 20.0,
    "description":
        "L’ENSAIA : Ecole Nationale Supérieure en Agronomie et Industries Alimentaires est un école délivrant 3 diplômes d’ingénieur en 3 ans : “”Agronomie””, “”Industries Alimentaires””, “”Production agro-alimentaire””, cette 3e filière étant accessible uniquement par voie d’apprentissage.",
    "name":
        "ÉCOLE NATIONALE SUPÉRIEURE D'AGRONOMIE ET DES INDUSTRIES ALIMENTAIRES",
    "adresse": '2 Av. de la Forêt de Haye, 54505 Vandœuvre-lès-Nancy',
    "image":
        'https://lh5.googleusercontent.com/p/AF1QipMigNhDQm7eJVbY7PKg68MbvW_gvpmVXsob7zhK=s879-k-no',
    "site": "http://ensaia.univ-lorraine.fr/",
    "carousel": [
      "https://lh5.googleusercontent.com/p/AF1QipOQgBZ9Utbfae6IWj-4jOFN9-gcJN1vMrqWoIsi=w397-h298-k-no",
      "https://lh5.googleusercontent.com/p/AF1QipNpqtapaWmHDeMQF4-V3M75J524o1kQqeJp-wA_=s773-k-no",
      "https://streetviewpixels-pa.googleapis.com/v1/thumbnail?output=thumbnail&cb_client=maps_sv.tactile.gps&panoid=onsq0LIES-S-ajYPH99tSg&w=1177&h=580&thumb=2&yaw=339.5428&pitch=0"
    ],
    "icon": "assets/icon/ensaia.png",
  },
  {
    "id": 15,
    "longitude": 6.1473745,
    "latitude": 48.6518424,
    "altitude": 20.0,
    "description":
        "L’ENSEM : Ecole Nationale Supérieure d’Electricité et Mécanique est une Ecole d’ingénieurs généraliste en 3 ans. Formation pluriscientifique en génie électrique, mécanique, énergie, ingénierie des systèmes automatisés, technologies embarquées et formation spécialisée en ingénierie des systèmes numériques.",
    "name": "ÉCOLE NATIONALE SUPÉRIEURE D'ÉLECTRICITÉ ET DE MÉCANIQUE",
    "adresse": "2 Av. de la Forêt de Haye, 54500 Vandœuvre-lès-Nancy",
    "image":
        'https://scontent-cdt1-1.xx.fbcdn.net/v/t31.18172-8/1237303_555016407890835_1438454865_o.jpg?_nc_cat=103&ccb=1-5&_nc_sid=e3f864&_nc_ohc=pfxaRLY89c8AX8x8wBH&_nc_ht=scontent-cdt1-1.xx&oh=00_AT8BsLuPuaea3QYhOOe4APyN-q1ESYmlcQ-wJRcuNFqIwg&oe=6295C4A1',
    "site": "https://ensem.univ-lorraine.fr/",
    "carousel": [
      "https://streetviewpixels-pa.googleapis.com/v1/thumbnail?panoid=onsq0LIES-S-ajYPH99tSg&cb_client=search.gws-prod.gps&w=408&h=240&yaw=339.42722&pitch=0&thumbfov=100",
      "https://scontent-cdt1-1.xx.fbcdn.net/v/t39.30808-6/278735092_661230155189430_6133418018911943160_n.jpg?_nc_cat=109&ccb=1-5&_nc_sid=730e14&_nc_ohc=8J6qXnGtB8gAX9YatN8&_nc_ht=scontent-cdt1-1.xx&oh=00_AT_aDk20PKP1z6cQuDFIFgygmW16a6G7JfvRYvAcXzN_JA&oe=6276639A",
      "https://scontent-cdt1-1.xx.fbcdn.net/v/t1.18169-9/1374957_562477223811420_1871962886_n.jpg?_nc_cat=103&ccb=1-5&_nc_sid=cdbe9c&_nc_ohc=r73cylIaITEAX8BQq1Q&_nc_oc=AQkS3slikco8mYNH8PqwW79luNjdhP5wYoN12cwiadx__q31v9TczcB4psgGzAWt4JY&_nc_ht=scontent-cdt1-1.xx&oh=00_AT8jDdpJMb7BiLQlkG67wFlWlkI1K5rPpcjmRomKhCXKAw&oe=629714FE"
    ],
    "icon": "assets/icon/ENSEM.png",
  },
  {
    "id": 16,
    "longitude": 6.1492879,
    "latitude": 48.6534173,
    "altitude": 20.0,
    "description":
        "L’ENSG : Ecole Nationale Supérieure de Géologie est la grande école française de référence en géosciences. Ingénieurs à double compétence : observation naturaliste et maîtrise de la physique et la chimie de la Terre et de l’Eau. Géotechnique, Matières premières minérales, Matières premières énergétiques, Eau, Environnement.",
    "name": "ÉCOLE NATIONALE SUPÉRIEURE DE GÉOLOGIE",
    "adresse": '2 Rue du doyen Marcel Roubault, 54518 Vandœuvre-lès-Nancy',
    "image":
        'https://lh5.googleusercontent.com/p/AF1QipMS4qbOnKfQbjnAvBaHHn7pwL2-9QYxCVGA3i1y=w397-h298-k-no',
    "site": "http://www.ensg.univ-lorraine.fr/",
    "carousel": [
      "https://lh5.googleusercontent.com/p/AF1QipOrOkEieSiJqBkfd_vOHcdPQ5Thy39K5AAPGzN9=w1200-h900-p-k-no",
      "https://lh5.googleusercontent.com/p/AF1QipNF1KJ-8yAqdDYM5fNeWCN3fZ-lgmAcRiP--12f=s1031-k-no",
      "https://lh5.googleusercontent.com/p/AF1QipNqHGr94jujNCgp7_Agiki-_QiOvswWXSnCTHEU=s1031-k-no"
    ],
    "icon": "assets/icon/ensg.png",
  },
  {
    "id": 17,
    "longitude": 6.1800651,
    "latitude": 48.6997235,
    "altitude": 20.0,
    "description":
        "L’École Nationale Supérieure des Industries Chimiques propose une formation d’ingénieurs polyvalents en 3 ans, d’envergure internationale en sciences, ingénierie et management dans les secteurs d’activités de l’énergie, l’environnement, le développement durable, la pharmacie, cosmétologie, les biotechnologies, les procédés de production et produits et systèmes à haute valeur technologique.",
    "name": 'ÉCOLE NATIONALE SUPÉRIEURE DES INDUSTRIES CHIMIQUES',
    "adresse": "1 Rue Grandville, 54000 Nancy",
    "image":
        'https://ensic.univ-lorraine.fr/sites/ensic.univ-lorraine.fr/files/users/actualites/documents/image_resultats_admis_i2c_2020_1.jpg',
    "site": "http://ensicprocess.ensic.univ-lorraine.fr/",
    "carousel": [
      "https://ensic.univ-lorraine.fr/sites/ensic.univ-lorraine.fr/files/users/images/ecole/bu-ensic.jpg",
      "https://ensic.univ-lorraine.fr/sites/ensic.univ-lorraine.fr/files/users/actualites/photos/image_resultats_admissibles_2020.jpg",
      "https://ensic.univ-lorraine.fr/sites/ensic.univ-lorraine.fr/files/users/images/ensic-rentree.jpg"
    ],
    "icon": "assets/icon/ensic.png",
  },
  {
    "id": 18,
    "longitude": 6.4653358,
    "latitude": 48.194249,
    "altitude": 20.0,
    "description":
        "L’ENSTIB : Ecole Nationale Supérieure des Technologies et Industries du Bois est l’unique grande École publique d’ingénieurs spécialisée dans les industries de transformation industrielle du bois et de ses dérivés. Formation scientifique, technologique et managériale en 3 ans. Une dominante : l’Eco-construction. 4 orientations : production-logistique / matériaux biosourcés / construction / énergie et environnement. Au sein du Campus Fibres, partenariats R et D, transfert de technologie.",
    "name": "ÉCOLE NATIONALE SUPÉRIEURE DES TECHNOLOGIES ET INDUSTRIES DU BOIS",
    "adresse": '27 Rue Philippe Séguin, 88000 Épinal',
    "image":
        "https://lh5.googleusercontent.com/p/AF1QipOFLH-WQ0YqhYgweIzUHL4tcy4TGQCxisDNbtH6=s869-k-no",
    "site": "https://www.enstib.univ-lorraine.fr/",
    "carousel": [
      "https://lh5.googleusercontent.com/p/AF1QipOwe1MNPhXpgtK_P9i3F9vDBMsZqaE5FuMCC8E9=s1014-k-no",
      "https://lh5.googleusercontent.com/p/AF1QipO1GNd3H9XTDJQ-Ur1JMJ23voLCvkf7IFHhMJqi=s869-k-no",
      "https://lh5.googleusercontent.com/p/AF1QipMdSsDIjkkreQzBsRB5g1m1E7WGTW5pLZuGqokm=s869-k-no"
    ],
    "icon": "assets/icon/ENSTIB.png",
  },
  {
    "id": 19,
    "longitude": 6.4653358,
    "latitude": 48.194249,
    "altitude": 20.0,
    "description":
        "L’ENSGSI : Ecole Nationale Supérieure en Génie des Systèmes et de l’Innovation est une école d’ingénieurs généraliste en 3 ou 5 ans. Formation scientifique et managériale. Innovation au service du développement des entreprises. Parcours internationaux personnalisés. Débouchés dans tous secteurs d’activités.",
    "name":
        "ÉCOLE NATIONALE SUPÉRIEURE EN GÉNIE DES SYSTÈMES ET DE L'INNOVATION",
    "adresse": "27 Rue Philippe Séguin, 88000 Épinal",
    "image":
        'https://lh5.googleusercontent.com/p/AF1QipP42ZBRPRB1s2AjD-lzDKxkYNawiebSSxCRLkKR=s760-k-no',
    "site": "https://www.enstib.univ-lorraine.fr/",
    "carousel": [
      "https://lh5.googleusercontent.com/p/AF1QipMHVc2-jj6E7Q2ETFJqhkt6g4t6XnQ0qXu-aUnx=s1160-k-no-pi0-ya97.739975-ro0-fo100",
      "https://lh5.googleusercontent.com/p/AF1QipOA1oy0BlajEjaqLvUr2FiQgwxxK-YkyThqOeQp=s750-k-no",
      "https://lh5.googleusercontent.com/p/AF1QipNjyqvDZ2Y4__MfK-UV-BXZ6qfndyhoN9nrowoS=s1160-k-no-pi0-ya231.8287-ro0-fo100"
    ],
    "icon": "assets/icon/ensgsi.png",
  },
  {
    "id": 20,
    "longitude": 6.1535542,
    "latitude": 48.6558011,
    "altitude": 20.0,
    "description":
        "Rejoignez La prépa des INP avec un Bac scientifique ou technologique. La prépa des INP, c’est deux ans de scolarité validés en contrôle continu avec une pré-spécialisation et un stage en entreprise ou en laboratoire pour choisir et intégrer sans concours une des 31 Ecoles dIngénieurs du réseau INP (Lorraine Toulouse Grenoble Bordeaux).  La prépa des INP, c’est un autre style de Prépa.",
    "name": "CPP - La Prépa des INP",
    "adresse": "2 Rue du Doyen Marcel Roubault, 54500 Vandœuvre-lès-Nancy",
    "image":
        'https://lh5.googleusercontent.com/p/AF1QipO5kd5pf-ykra8wCi97u12tsG4_TDb19CqbquIi=s1354-k-no',
    "site": "http://www.la-prepa-des-inp.fr/",
    "carousel": [
      "https://streetviewpixels-pa.googleapis.com/v1/thumbnail?output=thumbnail&cb_client=maps_sv.tactile.gps&panoid=LxD-xR7_A1KVe1HJb3AmUQ&w=1177&h=580&thumb=2&yaw=94.39351&pitch=0",
      "https://scontent-cdg2-1.xx.fbcdn.net/v/t39.30808-6/279029366_2348573591964147_371779963298291530_n.jpg?_nc_cat=104&ccb=1-5&_nc_sid=730e14&_nc_ohc=jPwmFJJkLR8AX-HPW8v&_nc_oc=AQm8RA_6SgWqgCQlJ8UmZOu21V0LF6ZfMdvjxfaxf87CI8EMVnjO2Ya-cpUCN1whPtg&_nc_ht=scontent-cdg2-1.xx&oh=00_AT8EN_DdtLUvIetnU2yGpO32P8ubMDlPLP_IZ6P7zjz7vA&oe=6276B738",
    ],
    "icon": "assets/icon/LaPrepadesINP.png",
  },
  {
    "id": 21,
    "longitude": 6.1702775,
    "latitude": 48.6729956,
    "altitude": 20.0,
    "description":
        "MINES Nancy forme des ingénieurs appelés à devenir des leaders, dont la performance intellectuelle et scientifique, la créativité, la responsabilité et l’exigence éthique, leur permettent d’appréhender le monde et d’évoluer en acteurs agiles et efficients des entreprises et des organisations. Ses enseignements sont tournés vers l’international, l’innovation et l’humain et elle développe une pédagogie par l’action fortement ancrée dans les entreprises, et organisée dans un environnement inter-culturel et transdisciplinaire.",
    "name": "MINES NANCY",
    "adresse": "Campus Artem - CS 14 234, 92 Rue Sergent Blandan, 54042 Nancy",
    "image":
        'https://lh5.googleusercontent.com/p/AF1QipPK50u4rIS57n8-wE5zkgmnhA3IeaUlmu4zNSH7=s1354-k-no',
    "site": "http://www.mines-nancy.univ-lorraine.fr/",
    "carousel": [
      "https://lh5.googleusercontent.com/p/AF1QipP9C449SCFvoFOztn2KGKhPVwpA9N9-NTOO9PN9=s870-k-no",
      "https://lh5.googleusercontent.com/p/AF1QipONw8jgEfQGsDW8x36n-qq61R75LkAgf20HmLxf=s1160-k-no-pi0-ya0-ro0-fo100",
      "https://lh5.googleusercontent.com/p/AF1QipO-f2dOoUSNi4kaQrP2-TTZDqK9dZ5Mq1Nu8MOF=s870-k-no"
    ],
    "icon": "assets/icon/mines-nancy.png",
  },
  {
    "id": 22,
    "longitude": 6.1883149,
    "latitude": 48.6597371,
    "altitude": 20.0,
    "description":
        "Polytech Nancy est une école d’ingénieurs en 5 ans, membre du Réseau Polytech. Elle a formé depuis 1960 plus de 5 300 ingénieurs qui travaillent dans tous les secteurs d’activité (Énergie, Transport, Technologies de l’information, BTP, Éco industrie…). L’école regroupe 900 élèves ingénieurs, 80 enseignants permanents, une centaine d’intervenants extérieurs et une quarantaine de personnels administratifs et techniques.",
    "name": "POLYTECH NANCY",
    "adresse": "2 Rue Jean Lamour, 54519 Vandœuvre-lès-Nancy",
    "image":
        'https://lh5.googleusercontent.com/p/AF1QipMBsfKFMwQNURfIRbDoVkr4pCU7xby8f2EaPeoQ=s904-k-no',
    "site": "http://www.polytech-nancy.univ-lorraine.fr/",
    "carousel": [
      "https://lh5.googleusercontent.com/p/AF1QipPN7K9_c5vG5LADMYyuydBS_Lw9uWYJvATBk8ez=s904-k-no",
      "https://lh5.googleusercontent.com/p/AF1QipOgCnXo2nSFhjo4F54b4EA6OHFU_HGbmBpVWXgd=s904-k-no",
      "https://lh5.googleusercontent.com/p/AF1QipNHlRATdYYkA1m5NYx8EwIY-qF0Mus2O-LJYxfT=s775-k-no"
    ],
    "icon": "assets/icon/polytech-nancy.png",
  },
  {
    "id": 23,
    "longitude": 6.155318,
    "latitude": 48.6691262,
    "altitude": 20.0,
    "description":
        "École d’ingénieurs généralistes en 3 ans. Associée de l’Institut Mines-Télécom, l’école forme des ingénieurs en informatique et sciences du numérique. Dominantes : Systèmes d’information – Ingénierie du logiciel – Gestion de projets – Imagerie numérique – Logiciels embarqués Réseaux – Services – Management.",
    "name": "TELECOM NANCY",
    "adresse": "193 Av. Paul Muller, 54602 Villers-lès-Nancy",
    "image":
        'https://lh5.googleusercontent.com/p/AF1QipPm3-aI5IoL7PWzGNSdA3T3Uiyyw87U8Ohxd_mD=s1031-k-no',
    "site": "http://www.telecomnancy.eu/",
    "carousel": [
      "https://lh5.googleusercontent.com/p/AF1QipPm3-aI5IoL7PWzGNSdA3T3Uiyyw87U8Ohxd_mD=s1031-k-no",
      "https://lh5.googleusercontent.com/p/AF1QipP26XLl8WNWOek7hyXrSKACevsYzpcMmCI89R-h=s1029-k-no",
    ],
    "icon": "assets/icon/telecom.png",
  },
  {
    "id": 24,
    "longitude": 6.230503,
    "latitude": 49.094328,
    "altitude": 20.0,
    "description":
        "L’IAE Metz School of management, membre du réseau national des Instituts d’Administration des Entreprises, propose un ensemble de formations diplômantes professionnalisant adossé à une recherche forte de haut niveau dans le domaine des sciences de gestion. Sa vocation est d’accueillir à l’Université des étudiants et des auditeurs de formation continue venus se former aux métiers du Management.",
    "name": "IAE METZ - SCHOOL OF MANAGAMENT",
    "adresse": "1 Rue Augustin Fresnel, 57070 Metz",
    "image":
        'https://lh5.googleusercontent.com/p/AF1QipMDb7efLxSL4iPARap0kw71lsiSwUX9n8Ph_eEu=s871-k-no',
    "site": "http://iaemetz.univ-lorraine.fr/",
    "carousel": [
      "https://streetviewpixels-pa.googleapis.com/v1/thumbnail?output=thumbnail&cb_client=maps_sv.tactile.gps&panoid=F-l1ritloeO0_Lnd8aMkFA&w=1177&h=580&thumb=2&yaw=100.18836&pitch=0",
      "https://lh5.googleusercontent.com/p/AF1QipM7BWt8CvvuN0x5IjLdLz8T3D17C1AHBGZidwIM=s1013-k-no",
      "https://lh5.googleusercontent.com/p/AF1QipMc4OX5Umsj9DHo1JO_79agF_HHum5OyDgEEMg7=w800-h298-k-no"
    ],
    "icon": "assets/icon/iae-metz-school-of-managament.png",
  },
  {
    "id": 25,
    "longitude": 6.1718112,
    "latitude": 48.697458,
    "altitude": 20.0,
    "description":
        "L’IAE Nancy – School of management, né en 2010 de la fusion de l’Institut d’Administration des Entreprises, de l’UFR Administration Économique et Sociale et de l’Institut Commercial de Nancy, constitue aujourd’hui le premier pôle public lorrain d’enseignement supérieur et de recherche en gestion avec une offre couvrant l’éventail des formations ouvertes aux métiers du management, de la gestion et de l’administration, en formation initiale et en formation continue.",
    "name": "IAE NANCY School of Management - Campus Manufacture",
    "adresse": "13 Rue Michel Ney, 54000 Nancy",
    "image":
        'https://lh5.googleusercontent.com/p/AF1QipPejS7QqAw69vIvx_0ZsHeLBBUIG0sC2lk7m-OQ=s1031-k',
    "site": "http://iae-nancy.univ-lorraine.fr/",
    "carousel": [
      "https://lh5.googleusercontent.com/p/AF1QipPejS7QqAw69vIvx_0ZsHeLBBUIG0sC2lk7m-OQ=s1031-k",
      "https://streetviewpixels-pa.googleapis.com/v1/thumbnail?output=thumbnail&cb_client=maps_sv.tactile.gps&panoid=-um2nXpENt8oa21GSLNg-w&w=1177&h=580&thumb=2&yaw=276.11548&pitch=0",
      "https://lh5.googleusercontent.com/p/AF1QipMOpQr6G4n9K49LrxI7l5GjhccXN4Gx2crwBgQl=s773-k"
    ],
    "icon": "assets/icon/iae-nancy.png",
  },
  {
    "id": 26,
    "longitude": 6.1718112,
    "latitude": 48.697458,
    "altitude": 20.0,
    "description":
        "L’Institut des Sciences du Digital, Management et Cognition propose des formations aux Sciences Numériques et Cognitives en Licence et en Master. Après une première année de Licence MIASHS – Mathématiques et Informatique Appliquées aux Sciences Humaines et Sociales – à caractère fortement pluridisciplinaire, les étudiants ont le choix entre deux parcours professionnalisants MIAGE ou Sciences Cognitives. Ces deux parcours mènent à une carrière de décideur (chef de projet informatique, ingénieur en design de linteraction, ).",
    "name": "INSTITUT DES SCIENCES DU DIGITAL, MANAGEMENT & COGNITION",
    "adresse": "Pôle Herbert Simon, 13 Rue Michel Ney, 54000 Nancy",
    "image":
        'https://lh5.googleusercontent.com/p/AF1QipNRiYK1r4jkTzRCqi8pwOx6hc25HYg0DKShGpFl=s1031-k-no',
    "site": "http://idmc.univ-lorraine.fr/",
    "carousel": [
      "https://lh5.googleusercontent.com/p/AF1QipNFfvcMIsFw67Sfx18a9EaxOEA0qYhhgdrQQEkB=s1031-k-no",
      "https://streetviewpixels-pa.googleapis.com/v1/thumbnail?output=thumbnail&cb_client=maps_sv.tactile.gps&panoid=-um2nXpENt8oa21GSLNg-w&w=1177&h=580&thumb=2&yaw=276.11548&pitch=0",
      "https://lh5.googleusercontent.com/p/AF1QipNRiYK1r4jkTzRCqi8pwOx6hc25HYg0DKShGpFl=s1031-k-no"
    ],
    "icon": "assets/icon/idmc.png",
  },
  {
    "id": 27,
    "longitude": 6.142356,
    "latitude": 48.6504732,
    "altitude": 20.0,
    "description":
        "Première école dentaire publique de France (crée en 1901), la faculté d’odontologie de Lorraine prodigue un enseignement de pointe sur les différentes disciplines et pratiques de l’odontologie au profit des étudiants de formation initiale (100 chirurgiens-dentistes par an issus essentiellement des académies de Nancy-Metz, de Dijon et du Luxembourg) et des praticiens en formation professionnelle continue (5 diplômes d’université, 2 certificats d’études supérieures, 20 formations courtes par an, 1 cursus dentiste-ingénieur). Le cursus des études est de cinq années après une première année commune des études de santé (PASS, L.AS) et la réussite au concours classant. Partant du contexte que l’innovation en odontologie et plus globalement les interactions entre santé et ingénierie sont balbutiantes, la faculté d’odontologie ambitionne, grâce à l’environnement de l’Université de Lorraine, de créer le premier pôle d’ingénierie et d’innovation dentaires en Europe. En outre, elle propose à ses étudiants dès la 4e année de compléter leur diplôme d’État de docteur en chirurgie dentaire avec le diplôme d’ingénieur des Mines de Nancy via une passerelle nommée « ODONTO+ ». Cette formation, unique en Europe, est également déclinée en formation professionnelle continue et permet aux praticiens déjà diplômé d’obtenir un véritable diplôme d’ingénieur.",
    "name": "FACULTÉ D'ODONTOLOGIE",
    "adresse": "7 Av. de la Forêt de Haye, 54500 Vandœuvre-lès-Nancy",
    "image":
        'https://lh3.ggpht.com/p/AF1QipODKunt4qmJ8-DDZ9iBAKJaUNgb1f-82PdIqafS=s1024',
    "site": "http://odonto.univ-lorraine.fr/",
    "carousel": [
      "https://lh3.ggpht.com/p/AF1QipODKunt4qmJ8-DDZ9iBAKJaUNgb1f-82PdIqafS=s1024",
      "https://lh5.googleusercontent.com/p/AF1QipPDGxusFdm7oNVpNfU9PRT18BR9BHj_DZIxfoJC=s1746-k-no-pi0-ya180-ro0-fo100",
      "https://lh5.googleusercontent.com/p/AF1QipOfGc4Opryf0tUzFowDBlIXCw-wcgwsCAvmYohl=s1682-k-no-pi-20-ya194.25-ro0-fo100"
    ],
    "icon": "assets/icon/faculte-d-odontologie.png",
  },
  {
    "id": 28,
    "longitude": 6.1411494,
    "latitude": 48.6495535,
    "altitude": 20.0,
    "description":
        "Créée en 1592, la Faculté de Médecine de Nancy est l’héritière dune histoire prestigieuse commencée il y a plus de 4 siècles. Son histoire, son potentiel d’innovations scientifique et technologique et sa vitalité pédagogique la positionnent comme un partenaire majeur dun Pôle Santé nancéien dont l’attractivité transcende le territoire régional. Pour les 1er et 2e cycles des études médicales, la Faculté de Médecine délivre les diplômes suivants : le Diplôme de Formation Générale en Sciences Médicales (sanctionne le 1er cycle) et le Diplôme de Formation Approfondie en Sciences Médicales (sanctionne le 2e cycle). Elle délivre également la Licence Sciences pour la Santé, le Master Biosciences et Ingénierie de la Santé (BSIS), le Master Éthique de la Santé et Médecine Légale et le Master Santé publique et Environnement (SPE).",
    "name": "FACULTÉ DE MÉDECINE, MAÏEUTIQUE ET MÉTIERS DE LA SANTÉ À NANCY",
    "adresse": "9 Av. de la Forêt de Haye, 54500 Vandœuvre-lès-Nancy",
    "image":
        'https://lh5.googleusercontent.com/p/AF1QipMyFTQlxOtVcQropi-eyVKAssIfoeev_my7nFU=s1031-k-no',
    "site": "http://www.medecine.univ-lorraine.fr/",
    "carousel": [
      "https://lh5.googleusercontent.com/p/AF1QipOH0FePMDLMmREITFsU4OkSVAKrr0rJWuU591M=s773-k-no",
      "https://lh5.googleusercontent.com/p/AF1QipPmbDiVOYyNQHrBzT9o4qVXDDFyM3LO_B4-aAM=s901-k-no",
      "https://lh5.googleusercontent.com/p/AF1QipOiD99fHMamotAgGAbKlPmxkT8ABpBO8w797qk=s870-k-no"
    ],
    "icon": "assets/icon/faculte-medecine-seul.png",
  },
  {
    "id": 29,
    "longitude": 6.1425132,
    "latitude": 48.6507452,
    "altitude": 20.0,
    "description":
        "Créée en 1872, La Faculté de Pharmacie de Nancy, composante de l’Université de Lorraine, est l’une des 24 Facultés de Pharmacie de France. A la pointe de la technique et de l’innovation, Son objectif principal est la formation des futurs professionnels du médicament et acteurs de santé, les pharmaciens.",
    "name": "FACULTÉ DE PHARMACIE",
    "adresse": "7 Av. de la Forêt de Haye, 54500 Vandœuvre-lès-Nancy",
    "image":
        'https://lh5.googleusercontent.com/p/AF1QipNEtu6V7Rg9iYSfch4XI5Xdo7xChP4G8ojzjPJU=s1016-k-no',
    "site": "http://pharma.univ-lorraine.fr/",
    "carousel": [
      "https://lh5.googleusercontent.com/p/AF1QipOfGc4Opryf0tUzFowDBlIXCw-wcgwsCAvmYohl=s1682-k-no-pi-20-ya194.25-ro0-fo100",
      "https://lh5.googleusercontent.com/p/AF1QipNQlEnEC6GWKr-G_9dl1YHEw4f-jYeqiXPrca-r=s1702-k-no-pi0-ya189.5-ro0-fo100"
    ],
    "icon": "assets/icon/faculte-de-pharmacie.png",
  },
  {
    "id": 30,
    "longitude": 6.1565599,
    "latitude": 48.6675376,
    "altitude": 20.0,
    "description":
        "La Faculté des sciences du sport de l’Université de Lorraine propose des formations universitaires diversifiées et professionnalisées aux métiers de l’enseignement et de l’encadrement des activités physiques et sportives.",
    "name": "FACULTÉ DES SCIENCES DU SPORT",
    "adresse": "30 Rue du Jardin-Botanique, 54600 Villers-lès-Nancy",
    "image":
        'https://lh5.googleusercontent.com/p/AF1QipP7xMmkqAvQozDWF5WsumS-7Dn87TqJDUsUa6R-=s1031-k-no',
    "site": "https://staps-nancy.univ-lorraine.fr/",
    "carousel": [
      "https://streetviewpixels-pa.googleapis.com/v1/thumbnail?output=thumbnail&cb_client=maps_sv.tactile.gps&panoid=aRVhPWRQR-DjosoYKKm_Fg&w=1177&h=580&thumb=2&yaw=303.0411&pitch=0",
      "https://lh5.googleusercontent.com/p/AF1QipP7xMmkqAvQozDWF5WsumS-7Dn87TqJDUsUa6R-=s1031-k-no",
    ],
    "icon": "assets/icon/faculte-des-sciences-du-sport.png",
  },
  {
    "id": 31,
    "longitude": 6.1565599,
    "latitude": 48.6675376,
    "altitude": 20.0,
    "description":
        "L’UFR Sciences humaines et sociales – Metz est organisé de la façon suivante : les 8 départements pédagogiques de l’UFR SHS – Metz (Géographie, Histoire, Information et communication, Philosophie, Psychologie, Sciences du langage, Sociologie, Théologie) offrent un large programme de formations qui concilie exigences théoriques, ouverture culturelle et applications professionnelles. les cours généralistes prodigués s’appuient sur le travail de recherche et de publication des enseignants, réalisé au sein de nos six centres de recherche et de la Maison des Sciences de l’Homme de Lorraine. La production et la diffusion de savoirs nouveaux enrichissent ainsi les cours. les cours professionnalisants sont assurés par de nombreux intervenants extérieurs (dont une partie d’anciens étudiants) qui viennent vous faire profiter de leurs compétences acquises. De plus, nombre de licences intègrent des stages obligatoires en entreprise. l’ouverture au monde est favorisée via l’enseignement des langues étrangères dans tous les cursus, via l’encouragement à la mobilité à l’étranger, par des programmes d’échange comme le célèbre Erasmus, et par l’attribution de bourses de mobilité (informations auprès des secrétariats pédagogiques et du service des relations internationales).",
    "name": "UFR SCIENCES HUMAINES ET SOCIALES - METZ",
    "adresse": "30 Rue du Jardin-Botanique, 54600 Villers-lès-Nancy",
    "image":
        'https://lh5.googleusercontent.com/p/AF1QipPDLjYpdBgDijyVktaN1xPcsIfCEC8z3HM7jsId=s775-k-no',
    "site": "https://staps-nancy.univ-lorraine.fr/",
    "carousel": [
      "https://lh5.googleusercontent.com/p/AF1QipP4SxY9i71_yGiKJnhb4IDJhu3TeBDAojucNE-6=s773-k-no",
      "https://lh5.googleusercontent.com/p/AF1QipN7DfIa9UXz68-9ybSRptRj9dVPuuiDMQnpwJpi=s775-k-no",
      "https://lh5.googleusercontent.com/p/AF1QipMh-uyHNKO5XFEfYnfZ7MN1RqUVHgBpSnwaVM2q=s1054-k-no"
    ],
    "icon": "assets/icon/ufr-shs-metz.png",
  },
  {
    "id": 32,
    "longitude": 6.1660106,
    "latitude": 48.6956049,
    "altitude": 20.0,
    "description":
        "L’Unité de Formation et de Recherche Sciences humaines et Sociales de Nancy (UFR SHS-Nancy) est une composante de l’Université de Lorraine. Implantée sur le Campus Lettres et Sciences Humaines de Nancy, elle accueille chaque année plus de 4 500 étudiants. L’UFR SHS-Nancy possède une composante sœur sur le campus de Metz qui propose des formations similaires à quelques exceptions près. Les deux composantes forment le Collegium Sciences humaines et sociales.",
    "name": "UFR SCIENCES HUMAINES ET SOCIALES - NANCY",
    "adresse": "23 Bd Albert 1er, 54000 Nancy",
    "image":
        "https://lh3.ggpht.com/p/AF1QipO0LdBBrT7jEw49wKo-wffkSALVqDTpRt4DFv1w=s1024",
    "site": "http://campus-lettres.univ-lorraine.fr/",
    "carousel": [
      "https://lh5.googleusercontent.com/p/AF1QipO1YO04QHoiAbMWVDaqx3f-qSDxNGaBVfElt19V=s901-k-no",
      "https://lh5.googleusercontent.com/p/AF1QipMKVWFcME-8_XunMq08D00LrVqieoNCec5Oa3tL=s823-k",
      "https://lh5.googleusercontent.com/p/AF1QipOKq7ffzJyMXDsT_YoDJpS_uraMHJJs1B7Kbx8s=w312-h228-p-k-no"
    ],
    "icon": "assets/icon/ufr-shs-nancy.png",
  },
  {
    "id": 33,
    "longitude": 6.1611247,
    "latitude": 48.6651218,
    "altitude": 20.0,
    "description":
        "La Faculté des Sciences et Technologies comprend 3 secteurs scientifiques : Mathématiques ; Informatique, Automatique, Électronique ; Physique, Géosciences, Chimie, Mécanique Biologie",
    "name": "FACULTÉ DES SCIENCES ET TECHNOLOGIES",
    "adresse": "Campus, Bd des Aiguillettes, 54506 Vandœuvre-lès-Nancy",
    "image":
        'https://lh5.googleusercontent.com/p/AF1QipM-J9KFTqatWm6ogYWmbwJ-1A_ihivjlc9BOPc=s933-k-no',
    "site": "http://fst.univ-lorraine.fr/",
    "carousel": [
      "https://lh5.googleusercontent.com/p/AF1QipMal6eObSPO73VBz188tU4zt_RA_-C-TuXtHMU=w448-h298-k-no",
      "https://lh5.googleusercontent.com/p/AF1QipNQO8M1I_BG7jT7kMwL7UpU_F-92HqW6kwEu_ro=s773-k-no",
      "https://lh5.googleusercontent.com/p/AF1QipObvDckxJgutnqZRfMRr2nwpfVwCpWRo9R69syU=w397-h298-k-no"
    ],
    "icon": "assets/icon/faculte-des-sc-et-technologies.png",
  },
  {
    "id": 34,
    "longitude": 6.2298812,
    "latitude": 49.094834,
    "altitude": 20.0,
    "description":
        "L’UFR Mathématiques, Informatique, Mécanique et Automatique est structurée en 3 départements : Mathématiques, Informatique et Sciences pour l’ingénieur. Elle propose des formations dans les domaines suivants : Mathématiques, Informatique, Sciences Pour lIngénieur, Matériaux, Génie Civil, Logistique, Hydraulique et Automatique.",
    "name": "UFR DE MATHÉMATIQUES, INFORMATIQUE, MÉCANIQUE",
    "adresse": "3 Rue Augustin Fresnel, 57070 Metz",
    "image":
        'https://lh5.googleusercontent.com/p/AF1QipMVbbAiLpnv0adP1WkUS1EbtjXKt_J8F_SseMhI=s1031-k-no',
    "site": "http://mim.univ-lorraine.fr/",
    "carousel": [
      "https://lh5.googleusercontent.com/p/AF1QipMSZx1YKHx9N-0Roj50j4FT5PXXDxs89quhOx0X=s1031-k-no",
      "https://lh5.googleusercontent.com/p/AF1QipPRPzs9IBrtsfXuvDvKA3PzC2gqq3LbPTAHsrCz=s1031-k-no",
      "https://lh5.googleusercontent.com/p/AF1QipM7ymnINKwYjnnKKfU6pw91dgnc5jYw_rJ_rCRK=s1031-k-no"
    ],
    "icon": "assets/icon/ufr-mim.png",
  },
  {
    "id": 35,
    "longitude": 6.2142785,
    "latitude": 49.1163857,
    "altitude": 20.0,
    "description":
        "L’UFR SciFA (Unité de Formation et de Recherche en Sciences Fondamentales et Appliquées) accueille sur ses sites plus de 2 000 étudiants et développe son activité de formation autour de 4 départements (Chimie, Physique-Électronique, Sciences de la Vie et de la Terre, et STAPS) et de laboratoires de recherche présents sur le site messin (IJL, LCOMS, LCP-A2MC, LEM3, LGIPM, LIEC, LMOPS, SRSMC, URAFPA).",
    "name": "UFR SCIENCES FONDAMENTALES ET APPLIQUÉES",
    "adresse": "Campus Bridoux, Rue du Général Delestraint, 57070 Metz",
    "image":
        'https://lh5.googleusercontent.com/p/AF1QipN9p_GKOsZ587yBy_JuRpwdjTSlWHCN3VMijl8N=s1031-k-no',
    "site": "https://scifa.univ-lorraine.fr/",
    "carousel": [
      "https://lh5.googleusercontent.com/p/AF1QipMcgcVRVUEqQsqSkhzsrQTKz0p0EqtUiQN0kcsy=s1031-k-no",
      "https://lh5.googleusercontent.com/p/AF1QipN9mAidSXiPG2MW85IPu0nPp52ZnGgX8PBtKoSK=s1354-k-no",
      "https://lh5.googleusercontent.com/p/AF1QipNj8kvUPNpejvy5_YX2_OyybX53vNv0b_cmdh73=s1031-k-no"
    ],
    "icon": "assets/icon/ufr-scifa.png",
  },
  {
    "id": 36,
    "longitude": 6.1637997,
    "latitude": 49.1202126,
    "altitude": 20.0,
    "description":
        "Créé en 1967, l’IUT de Metz propose 6 DUT aujourd’hui semestrialisés, et 17 spécialités de Licence Professionnelle sur les sites du Saulcy et du Technopole. En parallèle de cette formation initiale classique, il existe aussi la possibilité de préparer et d’obtenir ces diplômes en formation continue, par le biais de la Validation des Acquis de l’Expérience, ou encore en alternance sous statut d’apprenti. Dans le cadre de l’apprentissage, notamment, l’IUT propose 5 DUT et 14 spécialités de Licence Professionnelle, dautres ouvertures en LP en alternance sont prévues à court terme.",
    "name": "IUT DE METZ",
    "adresse": "57000 Metz",
    "image":
        'https://lh5.googleusercontent.com/p/AF1QipO_XVIKmy3kbaWrp53Yy1ThBWzduHstdInSyTy7=s773-k-no',
    "site": "http://www.iut-metz.univ-lorraine.fr/",
    "carousel": [
      "https://lh3.ggpht.com/p/AF1QipNc6cg8SO5SnnwipkpHGgD0DnpU17VT6x-XR4U=s1024",
      "https://lh5.googleusercontent.com/p/AF1QipNiU8P2A_vVorLviDslzxlC4FNuOVzrih88U-mb=s901-k-no",
      "https://lh5.googleusercontent.com/p/AF1QipNPO8O9Fjf4QWdJFjmR6UUcUTPc9_N7UigUADep=s903-k-no"
    ],
    "icon": "assets/icon/iut-de-metz.png",
  },
  {
    "id": 37,
    "longitude": 7.0715045,
    "latitude": 49.114248,
    "altitude": 20.0,
    "description":
        "L’IUT de Moselle-Est dispose d’implantations à Saint-Avold, Forbach et Sarreguemines et accueille environ 450 étudiants chaque année. L’IUT participe ainsi à l’aménagement du territoire en offrant aux jeunes des formations universitaires de proximité et en développant un partenariat étroit avec de nombreuses entreprises de la région en particulier au travers de sa plateforme de transfert de Technologie PLASTINNOV labellisée par le Ministère de l’Enseignement Supérieur.",
    "adresse": "7 Rue Alexandre de Geiger, 57200 Sarreguemines",
    "name": "IUT DE MOSELLE-EST",
    "image":
        "http://iut-moselle-est.univ-lorraine.fr/sites/default/files/styles/bandeau_accueil/public/2017-12/B%C3%A2timent%20SAR.jpeg?itok=DHzbXn2f",
    "site": "http://iut-moselle-est.univ-lorraine.fr/",
    "carousel": [
      "http://iut-moselle-est.univ-lorraine.fr/sites/default/files/styles/bandeau_accueil/public/2017-12/FOR.JPG?itok=V_0Qc6w8",
      "https://streetviewpixels-pa.googleapis.com/v1/thumbnail?output=thumbnail&cb_client=maps_sv.tactile.gps&panoid=NidAQJ5EA--BWQ8jLltcBw&w=1177&h=580&thumb=2&yaw=213.09663&pitch=0",
      "http://iut-moselle-est.univ-lorraine.fr/sites/default/files/styles/bandeau_accueil/public/2017-12/sta.jpg?itok=mD3q6uGY"
    ],
    "icon": "assets/icon/iut-de-moselle-est.png",
  },
  {
    "id": 38,
    "longitude": 6.9422293,
    "latitude": 48.2899606,
    "altitude": 20.0,
    "description":
        "L’IUT de Saint-Dié-des-Vosges est né en 1993 dans le cadre du schéma «Université 2000 » de politique d’aménagement du territoire. Situé dans un cadre de verdure, à mi-chemin entre Nancy et Strasbourg, il accueille des étudiants pour les former aux services et technologies de l’information et de la communication sous leurs multiples aspects.",
    "name": "IUT DE SAINT-DIÉ-DES-VOSGES",
    "adresse": "11 Rue de l'Université, 88100 Saint-Dié-des-Vosges",
    "image":
        'https://lh5.googleusercontent.com/p/AF1QipOssDFQnSLLxSaqT3yh6HJZshq-Q2femeMU86J8=s866-k-no',
    "site": "http://www.iutsd.univ-lorraine.fr/",
    "carousel": [
      "https://streetviewpixels-pa.googleapis.com/v1/thumbnail?output=thumbnail&cb_client=maps_sv.tactile.gps&panoid=rTX0uLVARUGubKImol66Vg&w=1177&h=580&thumb=2&yaw=266.65817&pitch=0",
      "https://pbs.twimg.com/media/D3S-HBbW4AAZLrZ?format=jpg&name=900x900"
    ],
    "icon": "assets/icon/iut-de-saint-die-des-vosges.png",
  },
  {
    "id": 39,
    "longitude": 6.1738387,
    "latitude": 49.3501138,
    "altitude": 20.0,
    "description":
        "Le site universitaire de Thionville-Yutz a été créé en 1995 sur l’espace Cormontaigne de l’Agglomération de Thionville-Yutz. Cette agglomération est située à proximité de la zone des Trois Frontières (France, Luxembourg, Allemagne). De ce fait, c’est un lieu privilégié d’échanges transfrontaliers, économiques et humains. L’IUT Thionville-Yutz assume sa mission en formation initiale et continue : recherche et valorisation scientifique et technique ; orientation et insertion professionnelle ; diffusion de la culture et de l’information scientifique et technique ; coopération internationale.",
    "name": "IUT DE THIONVILLE-YUTZ",
    "adresse": "Imp. Alfred Kastler, 57970 Yutz",
    "image":
        'https://lh5.googleusercontent.com/p/AF1QipNV9SrCNvxmhceQznpe7hfi0fykbA5Bx_z1HDgc=s828-k-no',
    "site": "http://iut-thionville-yutz.univ-lorraine.fr/",
    "carousel": [
      "https://lh5.googleusercontent.com/p/AF1QipMx7-FUWXQxIW2UTC8r8EMMT1SqH2N4O3RgsWXp=s1354-k-no",
      "https://lh5.googleusercontent.com/p/AF1QipPh3IONRbRqNSAQLiA1NJdHElmtZzCLeti-V9NQ=s901-k-no",
      "https://lh5.googleusercontent.com/p/AF1QipMM1ajsnKZb2QZIjjC7toPphsgAbm3CKJyYaW1L=s1160-k-no-pi0-ya200-ro0-fo100"
    ],
    "icon": "assets/icon/iut-de-thionville-yutz.png",
  },
  {
    "id": 40,
    "longitude": 49.5272481,
    "latitude": 49.5272481,
    "altitude": 20.0,
    "description":
        "L’Institut Universitaire de Technologie Henri Poincaré de Longwy, composante de l’Université de Lorraine, est l’un des sept IUT lorrains. Implanté dans un écrin de verdure, aux frontières de la Belgique et du Luxembourg, il accueille des étudiants depuis 1969, dans une structure à la fois fonctionnelle et aux dimensions humaines. L’IUT Henri Poincaré se compose de trois départements: Génie Electrique et Informatique Industrielle (GEII), Génie Thermique et Energie (GTE) et Gestion des Entreprises et des Administrations (GEA).",
    "name": "IUT HENRI POINCARÉ - LONGWY",
    "adresse": "186 Rue de Lorraine, 54400 Cosnes-et-Romain",
    "image":
        'https://lh5.googleusercontent.com/p/AF1QipM-Q35lYaA51USLCQKCg-idj_Z5w5V0QeBZBcn7=s1031-k-no',
    "site": "http://www.iut-longwy.univ-lorraine.fr/",
    "carousel": [
      "https://streetviewpixels-pa.googleapis.com/v1/thumbnail?output=thumbnail&cb_client=maps_sv.tactile.gps&panoid=SbRGuPp68_dHXeXne7eZdg&w=1177&h=580&thumb=2&yaw=96.978294&pitch=0",
      "https://lh3.ggpht.com/p/AF1QipMZKQ_UQBJE2J0LWPyr3mO9lBYZnhD7kpjO3xWa=s1024",
      "https://lh5.googleusercontent.com/p/AF1QipP9TdEiwoG4D2Iy_k4cyiY5M5OH7EpURw-PlfGR=s773-k-no"
    ],
    "icon": "assets/icon/iut-henri-poincare-longwy.png",
  },
  {
    "id": 41,
    "longitude": 6.4528284,
    "latitude": 48.1681596,
    "altitude": 20.0,
    "description":
        "L’IUT Épinal – Hubert Curien propose une offre de formation multiple et variée tant au niveau tertiaire que secondaire. Ses 3 DUT et 6 licences professionnelles permettent aux étudiants vosgiens de bénéficier d’un enseignement adapté aux besoins des entreprises vosgiennes avec lesquelles l’institut a tissé de nombreuses relations. En formation initiale ou continue, en apprentissage ou contrat de professionnalisation, l’IUT est en mesure de répondre aux exigences de nombreux publics.",
    "name": "IUT HUBERT CURIEN - EPINAL",
    "adresse": "7 Rue Fusillés Résistance 88000 Épinal",
    "image":
        'https://lh5.googleusercontent.com/p/AF1QipNKpIpUWm7uqX8z09_7cjlLv2TjQoPP5CLavgDh=s812-k-no',
    "site": "https://iut-epinal.univ-lorraine.fr/",
    "carousel": [
      "https://iut-epinal.univ-lorraine.fr/sites/iut-epinal.univ-lorraine.fr/files/users/images/inscription.jpg",
      "https://streetviewpixels-pa.googleapis.com/v1/thumbnail?output=thumbnail&cb_client=maps_sv.tactile.gps&panoid=sSBAig4oFgxg9GVs7G6qyw&w=1177&h=580&thumb=2&yaw=54.3832&pitch=0",
      "http://iut-epinal.univ-lorraine.fr/sites/iut-epinal.univ-lorraine.fr/files/users/images/dut_techniques_de_commercialisation_tc_0.jpg"
    ],
    "icon": "assets/icon/iut-hubert-curien-epinal.png",
  },
  {
    "id": 42,
    "longitude": 6.1513846,
    "latitude": 48.6588883,
    "altitude": 20.0,
    "description":
        "Composante de l’Université de Lorraine, l’IUT Nancy-Brabois forme depuis plus de 50 ans les techniciens supérieurs et cadres moyens de demain. Il propose des formations à BAC+3  (LP et BUT) à l’issue desquelles les étudiants peuvent intégrer directement le marché du travail ou poursuivre leurs études. Ses formations sont reconnues par les entreprises grâce à leur qualité et leur lien direct avec le monde professionnel.",
    "name": "IUT NANCY-BRABOIS",
    "adresse":
        "Lieu-dit Le Montet, Rue du Doyen Urion, 54600 Villers-lès-Nancy",
    "image":
        'https://lh5.googleusercontent.com/p/AF1QipNYsZq8usDkHx50LtN4G9n8UkiR-GyipV4q_t1T=s901-k-no',
    "site": "http://iutnb.univ-lorraine.fr/",
    "carousel": [
      "https://lh5.googleusercontent.com/p/AF1QipMOOGoJrhvILdcH6TVkKJWm4IPIMcUOi3BS06AI=s870-k-no",
      "https://lh5.googleusercontent.com/p/AF1QipPUj1YOY6I38atpcrK7jOO4uevMj-J6GtVVEJeQ=s812-k-no",
      "https://lh5.googleusercontent.com/p/AF1QipPiVjXYHIGVZevMKyscBouWXCguBKL2xpVzSK_u=s773-k-no"
    ],
    "icon": "assets/icon/iut-nancy-brabois.png",
  },
  {
    "id": 43,
    "longitude": 6.1616104,
    "latitude": 48.6835098,
    "altitude": 20.0,
    "description":
        "L'Institut Universitaire de Technologie Nancy-Charlemagne (souvent abrégé en IUT Nancy-Charlemagne) est un IUT créé en 1967. Il est une composante de l'Université de Lorraine.",
    "name": "IUT NANCY-CHARLEMAGNE",
    "adresse": "2Ter Bd Charlemagne, 54000 Nancy",
    "image":
        'https://iut-charlemagne.univ-lorraine.fr/wp-content/uploads/2018/11/IUT_SLIDER1_GENERIQUE_06.jpg',
    "site": "http://iut-charlemagne.univ-lorraine.fr/",
    "carousel": [
      "https://iut-charlemagne.univ-lorraine.fr/wp-content/uploads/2018/11/IUT_SLIDER1_GENERIQUE_24.jpg",
      "https://iut-charlemagne.univ-lorraine.fr/wp-content/uploads/2018/11/IUT_SLIDER1_GENERIQUE_13.jpg",
      "https://iut-charlemagne.univ-lorraine.fr/wp-content/uploads/2018/11/IUT_SLIDER1_GENERIQUE_09.jpg",
      "https://iut-charlemagne.univ-lorraine.fr/wp-content/uploads/2018/11/IUT_SLIDER1_GENERIQUE_01-1.jpg",
      "https://iut-charlemagne.univ-lorraine.fr/wp-content/uploads/2018/11/IUT_SLIDER1_GENERIQUE_22.jpg",
      "https://iut-charlemagne.univ-lorraine.fr/wp-content/uploads/2018/12/iut_slider2_exterieur_08.jpg",
      "https://iut-charlemagne.univ-lorraine.fr/wp-content/uploads/2018/12/iut_slider2_1_02.jpg",
      "https://iut-charlemagne.univ-lorraine.fr/wp-content/uploads/2018/12/iut_slider2_divers_04.jpg"
    ],
    "icon": "assets/icon/iut-nancy-charlemagne.png",
  },
];
