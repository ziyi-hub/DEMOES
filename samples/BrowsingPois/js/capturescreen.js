/* Implementation of AR-Experience (aka "World"). */
var World = {

    /*
        User's latest known location, accessible via userLocation.latitude, userLocation.longitude,
         userLocation.altitude.
     */
    userLocation: null,

    /* You may request new data from server periodically, however: in this sample data is only requested once. */
    isRequestingData: false,

    /* True once data was fetched. */
    initiallyLoadedData: false,

    /* True when world initialization is done. */
    initialized: false,

    /* Different POI-Marker assets. */
    markerDrawableIdle: null,
    markerDrawableSelected: null,
    markerDrawableDirectionIndicator: null,

    /* List of AR.GeoObjects that are currently shown in the scene / World. */
    markerList: [],

    /* the last selected marker. */
    currentMarker: null,

    locationUpdateCounter: 0,
    updatePlacemarkDistancesEveryXLocationUpdates: 10,

    /* Called to inject new POI data. */
    loadPoisFromJsonData: function loadPoisFromJsonDataFn(poiData) {

        /* Destroys all existing AR-Objects (markers & radar). */
        AR.context.destroyAll();

        /* Show radar. */
        PoiRadar.show();

        /* Empty list of visible markers. */
        World.markerList = [];

        /* Start loading marker assets. */
        World.markerDrawableIdle = new AR.ImageResource("assets/icons/marker_idle.png", {
            onError: World.onError
        });
        World.markerDrawableSelected = new AR.ImageResource("assets/icons/marker_selected.png", {
            onError: World.onError
        });
        World.markerDrawableDirectionIndicator = new AR.ImageResource("assets/icons/indi.png", {
            onError: World.onError
        });

        /* Loop through POI-information and create an AR.GeoObject (=Marker) per POI. */
    for (var currentPlaceNr = 0; currentPlaceNr < poiData.length; currentPlaceNr++) {
            var singlePoi = {
                "id": poiData[currentPlaceNr].id,
                "latitude": parseFloat(poiData[currentPlaceNr].latitude),
                "longitude": parseFloat(poiData[currentPlaceNr].longitude),
                //"altitude": parseFloat(poiData[currentPlaceNr].altitude),
                "title": poiData[currentPlaceNr].name,
                "description": poiData[currentPlaceNr].description,
                "adresse": poiData[currentPlaceNr].adresse,
                "image": poiData[currentPlaceNr].image,
                "site": poiData[currentPlaceNr].site,
                "carousel": poiData[currentPlaceNr].carousel,
            };

            World.markerList.push(new Marker(singlePoi));
        }


        /* Updates distance information of all placemarks. */
        World.updateDistanceToUserValues();

        World.updateStatusMessage(currentPlaceNr + ' places loaded');

        /* Set distance slider to 100%. */
        document.getElementById("panelRangeSliderValue").innerHTML = 100;

        World.initialized = true;
    },

    /*
        Sets/updates distances of all makers so they are available way faster than calling (time-consuming)
        distanceToUser() method all the time.
     */
    updateDistanceToUserValues: function updateDistanceToUserValuesFn() {
        for (var i = 0; i < World.markerList.length; i++) {
            World.markerList[i].distanceToUser = World.markerList[i].markerObject.locations[0].distanceToUser();
        }
    },

    /* Updates status message shown in small "i"-button aligned bottom center. */
    updateStatusMessage: function updateStatusMessageFn(message, isWarning) {
        document.getElementById("popupButtonImage").src = isWarning ? "assets/icons/warning_icon.png" : "assets/icons/info_icon.png";
        document.getElementById("popupButtonTooltip").innerHTML = message;
    },

    /*
        It may make sense to display POI details in your native style.
        In this sample a very simple native screen opens when user presses the 'More' button in HTML.
        This demoes the interaction between JavaScript and native code.
    */
    /* User clicked "More" button in POI-detail panel -> fire event to open native screen. */
    onPoiDetailMoreButtonClicked: function onPoiDetailMoreButtonClickedFn() {
        var currentMarker = World.currentMarker;
        var markerSelectedJSON = {
            action: "present_poi_details",
            id: currentMarker.poiData.id,
            title: currentMarker.poiData.title,
            description: currentMarker.poiData.description,
            adresse: currentMarker.poiData.adresse,
            image: currentMarker.poiData.image,
            latitude: currentMarker.poiData.latitude,
            longitude: currentMarker.poiData.longitude,
            site: currentMarker.poiData.site,
            carousel: currentMarker.poiData.carousel,
        };
        /*
            The sendJSONObject method can be used to send data from javascript to the native code.
        */
        AR.platform.sendJSONObject(markerSelectedJSON);
    },

    /* Location updates, fired every time you call architectView.setLocation() in native environment. */
    locationChanged: function locationChangedFn(lat, lon, alt, acc) {

        /* Store user's current location in World.userLocation, so you always know where user is. */
        World.userLocation = {
            'latitude': lat,
            'longitude': lon,
            'altitude': alt,
            'accuracy': acc
        };


        /* Request data if not already present. */
        if (!World.initiallyLoadedData) {
            World.requestDataFromJson();
            World.initiallyLoadedData = true;
        } else if (World.locationUpdateCounter === 0) {
            /*
                Update placemark distance information frequently, you max also update distances only every 10m with
                some more effort.
             */
            World.updateDistanceToUserValues();
        }

        /* Helper used to update placemark information every now and then (e.g. every 10 location upadtes fired). */
        World.locationUpdateCounter =
            (++World.locationUpdateCounter % World.updatePlacemarkDistancesEveryXLocationUpdates);
    },

    /*
        POIs usually have a name and sometimes a quite long description.
        Depending on your content type you may e.g. display a marker with its name and cropped description but
        allow the user to get more information after selecting it.
    */

    /* Fired when user pressed maker in cam. */
    onMarkerSelected: function onMarkerSelectedFn(marker) {
        World.closePanel();

        World.currentMarker = marker;

        /*
            In this sample a POI detail panel appears when pressing a cam-marker (the blue box with title &
            description), compare index.html in the sample's directory.
        */
        /* Update panel values. */
        document.getElementById("poiDetailTitle").innerHTML = marker.poiData.title;
        document.getElementById("poiDetailDescription").innerHTML = marker.poiData.description;
        document.getElementById("poiDetailImg").src = marker.poiData.image;

        /*
            It's ok for AR.Location subclass objects to return a distance of `undefined`. In case such a distance
            was calculated when all distances were queried in `updateDistanceToUserValues`, we recalculate this
            specific distance before we update the UI.
         */
        if (undefined === marker.distanceToUser) {
            marker.distanceToUser = marker.markerObject.locations[0].distanceToUser();
        }

        /*
            Distance and altitude are measured in meters by the SDK. You may convert them to miles / feet if
            required.
        */
        var distanceToUserValue = (marker.distanceToUser > 999) ?
            ((marker.distanceToUser / 1000).toFixed(2) + " km") :
            (Math.round(marker.distanceToUser) + " m");

        document.getElementById("poiDetailDistance").innerHTML = distanceToUserValue;

        /* Show panel. */
        document.getElementById("panelPoiDetail").style.visibility = "visible";
    },

    closePanel: function closePanel() {
        /* Hide panels. */
        document.getElementById("panelPoiDetail").style.visibility = "hidden";
        document.getElementById("panelRange").style.visibility = "hidden";

        if (World.currentMarker != null) {
            /* Deselect AR-marker when user exits detail screen div. */
            World.currentMarker.setDeselected(World.currentMarker);
            World.currentMarker = null;
        }
    },

    /* Screen was clicked but no geo-object was hit. */
    onScreenClick: function onScreenClickFn() {
        /* You may handle clicks on empty AR space too. */
        World.closePanel();
    },

    /* Returns distance in meters of placemark with maxdistance * 1.1. */
    getMaxDistance: function getMaxDistanceFn() {

        /* Sort places by distance so the first entry is the one with the maximum distance. */
        World.markerList.sort(World.sortByDistanceSortingDescending);

        /* Use distanceToUser to get max-distance. */
        var maxDistanceMeters = World.markerList[0].distanceToUser;

        /*
            Return maximum distance times some factor >1.0 so ther is some room left and small movements of user
            don't cause places far away to disappear.
         */
        return maxDistanceMeters * 1.1;
    },

    /* Updates values show in "range panel". */
    updateRangeValues: function updateRangeValuesFn() {

        /* Get current slider value (0..100);. */
        var slider_value = document.getElementById("panelRangeSlider").value;
        /* Max range relative to the maximum distance of all visible places. */
        var maxRangeMeters = Math.round(World.getMaxDistance() * (slider_value / 100));

        /* Range in meters including metric m/km. */
        var maxRangeValue = (maxRangeMeters > 999) ?
            ((maxRangeMeters / 1000).toFixed(2) + " km") :
            (Math.round(maxRangeMeters) + " m");

        /* Number of places within max-range. */
        var placesInRange = World.getNumberOfVisiblePlacesInRange(maxRangeMeters);

        /* Update UI labels accordingly. */
        document.getElementById("panelRangeValue").innerHTML = maxRangeValue;
        document.getElementById("panelRangePlaces").innerHTML = (placesInRange != 1) ?
            (placesInRange + " Places") : (placesInRange + " Place");
        document.getElementById("panelRangeSliderValue").innerHTML = slider_value;

        World.updateStatusMessage((placesInRange != 1) ?
            (placesInRange + " places loaded") : (placesInRange + " place loaded"));

        /* Update culling distance, so only places within given range are rendered. */
        AR.context.scene.cullingDistance = Math.max(maxRangeMeters, 1);

        /* Update radar's maxDistance so radius of radar is updated too. */
        PoiRadar.setMaxDistance(Math.max(maxRangeMeters, 1));
    },

    /* Returns number of places with same or lower distance than given range. */
    getNumberOfVisiblePlacesInRange: function getNumberOfVisiblePlacesInRangeFn(maxRangeMeters) {

        /* Sort markers by distance. */
        World.markerList.sort(World.sortByDistanceSorting);

        /* Loop through list and stop once a placemark is out of range ( -> very basic implementation ). */
        for (var i = 0; i < World.markerList.length; i++) {
            if (World.markerList[i].distanceToUser > maxRangeMeters) {
                return i;
            }
        }

        /* In case no placemark is out of range -> all are visible. */
        return World.markerList.length;
    },

    handlePanelMovements: function handlePanelMovementsFn() {
        PoiRadar.updatePosition();
    },

    /* Display range slider. */
    showRange: function showRangeFn() {
        if (World.markerList.length > 0) {
            World.closePanel();

            /* Update labels on every range movement. */
            World.updateRangeValues();
            World.handlePanelMovements();

            /* Open panel. */
            document.getElementById("panelRange").style.visibility = "visible";
        } else {

            /* No places are visible, because the are not loaded yet. */
            World.updateStatusMessage('No places available yet', true);
        }
    },

    /*
        This sample shows you how to use the function captureScreen to share a snapshot with your friends. Concept
        of interaction between JavaScript and native code is same as in the POI Detail sample.
        The "Snapshot"-button is on top right in the title bar. Once clicked the current screen is captured and
        user is prompted to share it (Handling of picture sharing is done in native code and cannot be done in
        JavaScript)
    */
    captureScreen: function captureScreenFn() {
        if (World.initialized) {
            AR.platform.sendJSONObject({
                action: "capture_screen"
            });
        }
    },
/*
    requestDataFromJson: function requestDataFromJsonFn(){

        World.isRequestingData = true;
        World.updateStatusMessage('Requesting places from web-service');

        let request = new XMLHttpRequest();
        request.open('GET', "json/etablissement.json", false);
        request.responseType = 'json';
        request.onreadystatechange = function() {
            if (request.readyState === 4) {
                World.loadPoisFromJsonData(request.response);
                World.isRequestingData = false;
            } else {
                World.updateStatusMessage("Invalid web-service response.", true);
                World.isRequestingData = false;
            }
        }
        request.send();
    },
*/

requestDataFromJson: function requestDataFromJsonFn() {
    World.isRequestingData = true;
    World.updateStatusMessage('Requesting places from web-service');
    /*let poi = [
        {
          "id": "1",
          "longitude": 6.1616104,
          "latitude": 48.6835098,
          "altitude": 20.0,
          "description":
              "L'Institut Universitaire de Technologie Nancy-Charlemagne (souvent abr??g?? en IUT Nancy-Charlemagne) est un IUT cr???? en 1967. Il est une composante de l'Universit?? de Lorraine.",
          "name": "Institut Universitaire de Technologie Nancy-Charlemagne",
          "adresse": "2Ter Bd Charlemagne, 54000 Nancy",
          "image": "https://drive.google.com/uc?export=view&id=1F75zAerMMdMGCSYFLjXjVZBHDERg6KYx",
          "site": "http://iut-charlemagne.univ-lorraine.fr/",
          "carousel": [
            "https://images.wallpapersden.com/image/download/purple-sunrise-4k-vaporwave_bGplZmiUmZqaraWkpJRmbmdlrWZlbWU.jpg",
            "https://wallpaperaccess.com/full/2637581.jpg",
            "https://uhdwallpapers.org/uploads/converted/20/01/14/the-mandalorian-5k-1920x1080_477555-mm-90.jpg"
          ]
        },
        {
          "id": "2",
          "longitude": 6.1611247,
          "latitude": 48.6651218,
          "altitude": 20.0,
          "description": "??tablissement d'enseignement sup??rieur ?? Vand??uvre-l??s-Nancy",
          "name": "Facult?? des Sciences et Technologies",
          "adresse": "Campus, Bd des Aiguillettes, 54506 Vand??uvre-l??s-Nancy",
          "image": "https://drive.google.com/uc?export=view&id=1kF5MRQhgfc-Q0MQ-TDcJHlMBwlyJ2U-e",
          "site": "http://fst.univ-lorraine.fr/",
          "carousel": [
            "https://images.wallpapersden.com/image/download/purple-sunrise-4k-vaporwave_bGplZmiUmZqaraWkpJRmbmdlrWZlbWU.jpg",
            "https://wallpaperaccess.com/full/2637581.jpg",
            "https://uhdwallpapers.org/uploads/converted/20/01/14/the-mandalorian-5k-1920x1080_477555-mm-90.jpg"
          ]
        },
        {
          "id": "3",
          "longitude": 6.1660106,
          "latitude": 48.6956049, 
          "altitude": 20.0,
          "description": "Universit?? ?? Nancy",
          "name": "Campus Lettres et Sciences Humaines de Nancy - Universit?? de Lorraine",
          "adresse": "23 Bd Albert 1er, 54000 Nancy",
          "image": "https://drive.google.com/uc?export=view&id=1LvTk24Aq-5vXLVXl6Nxx7TvaNauu5a53",
          "site": "http://campus-lettres.univ-lorraine.fr/",
          "carousel": [
            "https://images.wallpapersden.com/image/download/purple-sunrise-4k-vaporwave_bGplZmiUmZqaraWkpJRmbmdlrWZlbWU.jpg",
            "https://wallpaperaccess.com/full/2637581.jpg",
            "https://uhdwallpapers.org/uploads/converted/20/01/14/the-mandalorian-5k-1920x1080_477555-mm-90.jpg"
          ]
        }
      ];
        World.loadPoisFromJsonData(poi);
        World.isRequestingData = false;
    },*/
    let poi = [
        {
          "id": 0,
          "longitude": 6.172229,
          "latitude": 48.6971757,
          "altitude": 20.0,
          "description":
              "L???Institut europ??en de cin??ma et d???audiovisuel est une des rares structures universitaires et publiques en France ?? dispenser un Master Cin??ma et Audiovisuel ouvert ?? tout ??tudiant d??tenteur d???une Licence (ou d???un dipl??me ??quivalent) en formation initiale, et dans le cadre de la formation continue, aux salari??s et aux personnes ?? la recherche d???un emploi d??s lors que leur formation ant??rieure est jug??e ??ligible.",
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
              "L???UFR Arts, lettres et langues ??? Metz est le si??ge des ??tudes artistiques, des formations litt??raires et de la sp??cialisation en langues vivantes. Elle se compose de 10 d??partements p??dagogiques, assurant une offre de formation et de recherche diversifi??e : ?? arts ?? (?? arts plastiques ?? ou ?? arts du spectacle ??), ?? musique ??, ?? lettres classiques ??, ?? lettres modernes ??, ?? allemand ??, ?? franco-allemand ??, ?? anglais ??, ?? espagnol ??, ?? LEA ?? (?? Langues ??trang??res Appliqu??es ??) ou ?? FLE ?? (?? Fran??ais comme Langue ??trang??re ??).",
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
              "L???UFR Arts, Lettres et Langues (UFR ALL-Nancy) est une composante de l???Universit?? de Lorraine cr????e en 2013. Situ??e au coeur de Nancy, sur le Campus Lettres et Sciences Humaines, elle accueille chaque ann??e 4000 ??tudiants environ en pr??sentiel et ?? distance. Soucieuse de promouvoir la connaissance des langues, histoires et cultures europ??ennes et m??diterran??ennes, le bilinguisme, le trilinguisme et la diversit?? culturelle et linguistique des nombreux pays qui la composent et avec lesquels elle est en relation, l???UFR propose : 16 licences, 2 licences professionnelles, 11 masters, 5 masters M??tiers de l???Enseignement, de l?????ducation et de la Formation (MEEF) et 2 Dipl??mes universitaires ainsi que des pr??parations ?? l???Agr??gation, autour des arts, des lettres modernes et classiques et des langues et cultures ??trang??res (anglais, allemand, arabe, espagnol, italien, russe, polonais).",
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
              "Le Centre europ??en universitaire est n?? il y a plus de soixante ans, alors que l???Union europ??enne ??mergeait. Le Centre Europ??en Universitaire de Nancy compte parmi les plus anciennes formations ?? vocation europ??enne. Une des valeurs premi??res du CEU est d?????tre et d???avoir toujours ??t?? un lieu de brassage entre l???Europe de l???Est et de l???Europe de l???Ouest.",
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
              "Avec pr??s de 3.000 ??tudiants sur le site principal de Metz et le site d??localis?? de Sarreguemines, la Facult?? de droit, ??conomie et administration de Metz conna??t une constante augmentation de ses effectifs gr??ce ?? une ??quipe dynamique compos??e dune cinquantaine d???enseignants-chercheurs, impliqu??e dans le domaine p??dagogique et active dans le domaine de la recherche, et gr??ce ?? des services administratifs, d??vou??s et comp??tents, compos??s dune vingtaine d???agents.",
          "name": 'FACULT?? DE DROIT, ??CONOMIE ET ADMINISTRATION DE METZ',
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
              "Fond??e en 1582 ?? Pont-??-Mousson, transf??r??e ?? Nancy en 1768, ferm??e en 1792, notre Facult?? fut restaur??e par l???Empereur Napol??on III le 9 janvier 1864. Fi??re de son histoire, forte de ses 4800 ??tudiants, b??n??ficiant dune identit?? culturelle affirm??e, la Facult?? de droit, Sciences ??conomiques et gestion de Nancy allie recherche de l???excellence et volont?? de professionnalisation de ses enseignements. Offrant une large gamme de formations ouvrant sur les carri??res judiciaires, le droit des affaires, le droit du travail, le droit public, la finance ou l?????conomie, la Facult?? est r??solument tourn??e vers l???avenir.",
          "name": 'FACULT?? DE DROIT, SCIENCES ??CONOMIQUES ET GESTION - NANCY',
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
              "L???Institut de pr??paration ?? l???administration g??n??rale ??? IPAG ??? pr??pare aux concours administratifs par la licence et le master 1 d???Administration Publique, ainsi que par les fili??res externes et internes non dipl??mantes aux concours A et B de la fonction publique.",
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
              "Institut r??gional du travail : ???Les instituts du travail ont pour mission la formation et la recherche en sciences sociales du travail. Dans ce cadre, ils contribuent ?? la formation des membres des organisations syndicales, des organismes du secteur de l?????conomie sociale et des associations??? (D??cret n?? 89-266 du 25 avril 1989 relatif aux Instituts du Travail.)",
          "name": 'INSTITUT R??GIONAL DU TRAVAIL',
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
              "L???Institut National Sup??rieur du Professorat et de l?????ducation, composante universitaire du collegium INTERFACE, se consacre principalement ?? la formation initiale des ??tudiants se destinant aux m??tiers de l???enseignement, de l?????ducation et de la formation. L???INSP?? de Lorraine participe ?? la formation des enseignants du sup??rieur et contribue ?? la formation continue de tous les enseignants quel que soit leur niveau d???enseignement. L???INSP?? investit aussi le champ de la recherche disciplinaire et p??dagogique en ??ducation et d??veloppe des actions de coop??ration internationale.",
          "name":
              "INSTITUT NATIONAL SUP??RIEUR DU PROFESSORAT ET DE L'??DUCATION Nancy",
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
              "L???Institut National Sup??rieur du Professorat et de l?????ducation, composante universitaire du collegium INTERFACE, se consacre principalement ?? la formation initiale des ??tudiants se destinant aux m??tiers de l???enseignement, de l?????ducation et de la formation. L???INSP?? de Lorraine participe ?? la formation des enseignants du sup??rieur et contribue ?? la formation continue de tous les enseignants quel que soit leur niveau d???enseignement. L???INSP?? investit aussi le champ de la recherche disciplinaire et p??dagogique en ??ducation et d??veloppe des actions de coop??ration internationale.",
          "name":
              "INSTITUT NATIONAL SUP??RIEUR DU PROFESSORAT ET DE L'??DUCATION Max??ville",
          "adresse": '5 Rue Paul Richard, 54320 Max??ville',
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
              "Institut sup??rieur franco-allemand de techniques, d?????conomie et de sciences : Premier cursus int??gr?? franco-allemand de l???enseignement sup??rieur lISFATES fut cr???? en 1978 par d??cision intergouvernementale. Soutenus depuis 2005 par l???Universit?? Franco allemande www.dfh-ufa.org,en particulier par l???attribution de bourses de mobilit??, les cursus de l???ISFATES d??livrent des dipl??mes conjoints de licence et master avec la Hochschule f??r Technik und Wirtschaft des Saarlandes (HTW) www.htwsaar.de . Les fili??res transversales franco-allemandes de l???ISFATES s???appuient sur les formations r??seau d???UFR couvrant diff??rents domaines de formation et cycles d?????tudes.",
          "name":
              "INSTITUT SUP??RIEUR FRANCO-ALLEMAND DE TECHNIQUES, D'??CONOMIE ET DE SCIENCES",
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
              "L???UFR Lansad assure la formation en langues ??trang??res et en fran??ais langue ??trang??re des usagers sp??cialistes d???autres disciplines au sein de l???Universit?? de Lorraine.",
          "name": 'UFR LANSAD METZ',
          "adresse":
              "B??timent A de l'ex-ISGMP Bureau 111 - 1er ??tage ??le du Saulcy, 57045 METZ",
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
              "L???EEIGM ??? Ecole Europ??enne d???Ing??nieurs en G??nie des Mat??riaux est une ??cole en 3 ou 5 ans. Ing??nieurs avec double comp??tence : g??nie des mat??riaux et langues ??trang??res. Scolarit?? dans 6 universit??s : Nancy, Barcelone, Sarrebruck, Lule??, Valence, Moscou. Fili??re classique et par apprentissage.",
          "name": "??COLE EUROP??ENNE D'ING??NIEURS EN G??NIE DES MAT??RIAUX (EEIGM)",
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
              "L???ENIM ??? Ecole Nationale d???Ing??nieurs de Metz est n??e en 1961 en m??me temps que ses ??????soeurs?????? de Tarbes, Saint-Etienne et Brest, l???ENIM est le fruit de deux volont??s conjointes : celle de l???Etat, qui veut alors d??concentrer et structurer l???enseignement technique sup??rieur, et celle de l???industrie qui, dans un contexte de forte expansion ??conomique, redoute une p??nurie d???ing??nieurs.",
          "name": "??COLE NATIONALE D'ING??NIEURS DE METZ",
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
              "L???ENSAIA : Ecole Nationale Sup??rieure en Agronomie et Industries Alimentaires est un ??cole d??livrant 3 dipl??mes d???ing??nieur en 3 ans : ??????Agronomie??????, ??????Industries Alimentaires??????, ??????Production agro-alimentaire??????, cette 3e fili??re ??tant accessible uniquement par voie d???apprentissage.",
          "name":
              "??COLE NATIONALE SUP??RIEURE D'AGRONOMIE ET DES INDUSTRIES ALIMENTAIRES",
          "adresse": '2 Av. de la For??t de Haye, 54505 Vand??uvre-l??s-Nancy',
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
              "L???ENSEM : Ecole Nationale Sup??rieure d???Electricit?? et M??canique est une Ecole d???ing??nieurs g??n??raliste en 3 ans. Formation pluriscientifique en g??nie ??lectrique, m??canique, ??nergie, ing??nierie des syst??mes automatis??s, technologies embarqu??es et formation sp??cialis??e en ing??nierie des syst??mes num??riques.",
          "name": "??COLE NATIONALE SUP??RIEURE D'??LECTRICIT?? ET DE M??CANIQUE",
          "adresse": "2 Av. de la For??t de Haye, 54500 Vand??uvre-l??s-Nancy",
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
              "L???ENSG : Ecole Nationale Sup??rieure de G??ologie est la grande ??cole fran??aise de r??f??rence en g??osciences. Ing??nieurs ?? double comp??tence : observation naturaliste et ma??trise de la physique et la chimie de la Terre et de l???Eau. G??otechnique, Mati??res premi??res min??rales, Mati??res premi??res ??nerg??tiques, Eau, Environnement.",
          "name": "??COLE NATIONALE SUP??RIEURE DE G??OLOGIE",
          "adresse": '2 Rue du doyen Marcel Roubault, 54518 Vand??uvre-l??s-Nancy',
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
              "L?????cole Nationale Sup??rieure des Industries Chimiques propose une formation d???ing??nieurs polyvalents en 3 ans, d???envergure internationale en sciences, ing??nierie et management dans les secteurs d???activit??s de l?????nergie, l???environnement, le d??veloppement durable, la pharmacie, cosm??tologie, les biotechnologies, les proc??d??s de production et produits et syst??mes ?? haute valeur technologique.",
          "name": '??COLE NATIONALE SUP??RIEURE DES INDUSTRIES CHIMIQUES',
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
              "L???ENSTIB : Ecole Nationale Sup??rieure des Technologies et Industries du Bois est l???unique grande ??cole publique d???ing??nieurs sp??cialis??e dans les industries de transformation industrielle du bois et de ses d??riv??s. Formation scientifique, technologique et manag??riale en 3 ans. Une dominante : l???Eco-construction. 4 orientations : production-logistique / mat??riaux biosourc??s / construction / ??nergie et environnement. Au sein du Campus Fibres, partenariats R et D, transfert de technologie.",
          "name": "??COLE NATIONALE SUP??RIEURE DES TECHNOLOGIES ET INDUSTRIES DU BOIS",
          "adresse": '27 Rue Philippe S??guin, 88000 ??pinal',
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
              "L???ENSGSI : Ecole Nationale Sup??rieure en G??nie des Syst??mes et de l???Innovation est une ??cole d???ing??nieurs g??n??raliste en 3 ou 5 ans. Formation scientifique et manag??riale. Innovation au service du d??veloppement des entreprises. Parcours internationaux personnalis??s. D??bouch??s dans tous secteurs d???activit??s.",
          "name":
              "??COLE NATIONALE SUP??RIEURE EN G??NIE DES SYST??MES ET DE L'INNOVATION",
          "adresse": "27 Rue Philippe S??guin, 88000 ??pinal",
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
              "Rejoignez La pr??pa des INP avec un Bac scientifique ou technologique. La pr??pa des INP, c???est deux ans de scolarit?? valid??s en contr??le continu avec une pr??-sp??cialisation et un stage en entreprise ou en laboratoire pour choisir et int??grer sans concours une des 31 Ecoles dIng??nieurs du r??seau INP (Lorraine Toulouse Grenoble Bordeaux).  La pr??pa des INP, c???est un autre style de Pr??pa.",
          "name": "CPP - La Pr??pa des INP",
          "adresse": "2 Rue du Doyen Marcel Roubault, 54500 Vand??uvre-l??s-Nancy",
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
              "MINES Nancy forme des ing??nieurs appel??s ?? devenir des leaders, dont la performance intellectuelle et scientifique, la cr??ativit??, la responsabilit?? et l???exigence ??thique, leur permettent d???appr??hender le monde et d?????voluer en acteurs agiles et efficients des entreprises et des organisations. Ses enseignements sont tourn??s vers l???international, l???innovation et l???humain et elle d??veloppe une p??dagogie par l???action fortement ancr??e dans les entreprises, et organis??e dans un environnement inter-culturel et transdisciplinaire.",
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
              "Polytech Nancy est une ??cole d???ing??nieurs en 5 ans, membre du R??seau Polytech. Elle a form?? depuis 1960 plus de 5 300 ing??nieurs qui travaillent dans tous les secteurs d???activit?? (??nergie, Transport, Technologies de l???information, BTP, ??co industrie???). L?????cole regroupe 900 ??l??ves ing??nieurs, 80 enseignants permanents, une centaine d???intervenants ext??rieurs et une quarantaine de personnels administratifs et techniques.",
          "name": "POLYTECH NANCY",
          "adresse": "2 Rue Jean Lamour, 54519 Vand??uvre-l??s-Nancy",
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
              "??cole d???ing??nieurs g??n??ralistes en 3 ans. Associ??e de l???Institut Mines-T??l??com, l?????cole forme des ing??nieurs en informatique et sciences du num??rique. Dominantes : Syst??mes d???information ??? Ing??nierie du logiciel ??? Gestion de projets ??? Imagerie num??rique ??? Logiciels embarqu??s R??seaux ??? Services ??? Management.",
          "name": "TELECOM NANCY",
          "adresse": "193 Av. Paul Muller, 54602 Villers-l??s-Nancy",
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
              "L???IAE Metz School of management, membre du r??seau national des Instituts d???Administration des Entreprises, propose un ensemble de formations dipl??mantes professionnalisant adoss?? ?? une recherche forte de haut niveau dans le domaine des sciences de gestion. Sa vocation est d???accueillir ?? l???Universit?? des ??tudiants et des auditeurs de formation continue venus se former aux m??tiers du Management.",
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
              "L???IAE Nancy ??? School of management, n?? en 2010 de la fusion de l???Institut d???Administration des Entreprises, de l???UFR Administration ??conomique et Sociale et de l???Institut Commercial de Nancy, constitue aujourd???hui le premier p??le public lorrain d???enseignement sup??rieur et de recherche en gestion avec une offre couvrant l?????ventail des formations ouvertes aux m??tiers du management, de la gestion et de l???administration, en formation initiale et en formation continue.",
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
              "L???Institut des Sciences du Digital, Management et Cognition propose des formations aux Sciences Num??riques et Cognitives en Licence et en Master. Apr??s une premi??re ann??e de Licence MIASHS ??? Math??matiques et Informatique Appliqu??es aux Sciences Humaines et Sociales ??? ?? caract??re fortement pluridisciplinaire, les ??tudiants ont le choix entre deux parcours professionnalisants MIAGE ou Sciences Cognitives. Ces deux parcours m??nent ?? une carri??re de d??cideur (chef de projet informatique, ing??nieur en design de linteraction, ).",
          "name": "INSTITUT DES SCIENCES DU DIGITAL, MANAGEMENT & COGNITION",
          "adresse": "P??le Herbert Simon, 13 Rue Michel Ney, 54000 Nancy",
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
              "Premi??re ??cole dentaire publique de France (cr??e en 1901), la facult?? d???odontologie de Lorraine prodigue un enseignement de pointe sur les diff??rentes disciplines et pratiques de l???odontologie au profit des ??tudiants de formation initiale (100 chirurgiens-dentistes par an issus essentiellement des acad??mies de Nancy-Metz, de Dijon et du Luxembourg) et des praticiens en formation professionnelle continue (5 dipl??mes d???universit??, 2 certificats d?????tudes sup??rieures, 20 formations courtes par an, 1 cursus dentiste-ing??nieur). Le cursus des ??tudes est de cinq ann??es apr??s une premi??re ann??e commune des ??tudes de sant?? (PASS, L.AS) et la r??ussite au concours classant. Partant du contexte que l???innovation en odontologie et plus globalement les interactions entre sant?? et ing??nierie sont balbutiantes, la facult?? d???odontologie ambitionne, gr??ce ?? l???environnement de l???Universit?? de Lorraine, de cr??er le premier p??le d???ing??nierie et d???innovation dentaires en Europe. En outre, elle propose ?? ses ??tudiants d??s la 4e ann??e de compl??ter leur dipl??me d?????tat de docteur en chirurgie dentaire avec le dipl??me d???ing??nieur des Mines de Nancy via une passerelle nomm??e ?? ODONTO+ ??. Cette formation, unique en Europe, est ??galement d??clin??e en formation professionnelle continue et permet aux praticiens d??j?? dipl??m?? d???obtenir un v??ritable dipl??me d???ing??nieur.",
          "name": "FACULT?? D'ODONTOLOGIE",
          "adresse": "7 Av. de la For??t de Haye, 54500 Vand??uvre-l??s-Nancy",
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
              "Cr????e en 1592, la Facult?? de M??decine de Nancy est l???h??riti??re dune histoire prestigieuse commenc??e il y a plus de 4 si??cles. Son histoire, son potentiel d???innovations scientifique et technologique et sa vitalit?? p??dagogique la positionnent comme un partenaire majeur dun P??le Sant?? nanc??ien dont l???attractivit?? transcende le territoire r??gional. Pour les 1er et 2e cycles des ??tudes m??dicales, la Facult?? de M??decine d??livre les dipl??mes suivants : le Dipl??me de Formation G??n??rale en Sciences M??dicales (sanctionne le 1er cycle) et le Dipl??me de Formation Approfondie en Sciences M??dicales (sanctionne le 2e cycle). Elle d??livre ??galement la Licence Sciences pour la Sant??, le Master Biosciences et Ing??nierie de la Sant?? (BSIS), le Master ??thique de la Sant?? et M??decine L??gale et le Master Sant?? publique et Environnement (SPE).",
          "name": "FACULT?? DE M??DECINE, MA??EUTIQUE ET M??TIERS DE LA SANT?? ?? NANCY",
          "adresse": "9 Av. de la For??t de Haye, 54500 Vand??uvre-l??s-Nancy",
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
              "Cr????e en 1872, La Facult?? de Pharmacie de Nancy, composante de l???Universit?? de Lorraine, est l???une des 24 Facult??s de Pharmacie de France. A la pointe de la technique et de l???innovation, Son objectif principal est la formation des futurs professionnels du m??dicament et acteurs de sant??, les pharmaciens.",
          "name": "FACULT?? DE PHARMACIE",
          "adresse": "7 Av. de la For??t de Haye, 54500 Vand??uvre-l??s-Nancy",
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
              "La Facult?? des sciences du sport de l???Universit?? de Lorraine propose des formations universitaires diversifi??es et professionnalis??es aux m??tiers de l???enseignement et de l???encadrement des activit??s physiques et sportives.",
          "name": "FACULT?? DES SCIENCES DU SPORT",
          "adresse": "30 Rue du Jardin-Botanique, 54600 Villers-l??s-Nancy",
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
              "L???UFR Sciences humaines et sociales ??? Metz est organis?? de la fa??on suivante : les 8 d??partements p??dagogiques de l???UFR SHS ??? Metz (G??ographie, Histoire, Information et communication, Philosophie, Psychologie, Sciences du langage, Sociologie, Th??ologie) offrent un large programme de formations qui concilie exigences th??oriques, ouverture culturelle et applications professionnelles. les cours g??n??ralistes prodigu??s s???appuient sur le travail de recherche et de publication des enseignants, r??alis?? au sein de nos six centres de recherche et de la Maison des Sciences de l???Homme de Lorraine. La production et la diffusion de savoirs nouveaux enrichissent ainsi les cours. les cours professionnalisants sont assur??s par de nombreux intervenants ext??rieurs (dont une partie d???anciens ??tudiants) qui viennent vous faire profiter de leurs comp??tences acquises. De plus, nombre de licences int??grent des stages obligatoires en entreprise. l???ouverture au monde est favoris??e via l???enseignement des langues ??trang??res dans tous les cursus, via l???encouragement ?? la mobilit?? ?? l?????tranger, par des programmes d?????change comme le c??l??bre Erasmus, et par l???attribution de bourses de mobilit?? (informations aupr??s des secr??tariats p??dagogiques et du service des relations internationales).",
          "name": "UFR SCIENCES HUMAINES ET SOCIALES - METZ",
          "adresse": "30 Rue du Jardin-Botanique, 54600 Villers-l??s-Nancy",
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
              "L???Unit?? de Formation et de Recherche Sciences humaines et Sociales de Nancy (UFR SHS-Nancy) est une composante de l???Universit?? de Lorraine. Implant??e sur le Campus Lettres et Sciences Humaines de Nancy, elle accueille chaque ann??e plus de 4 500 ??tudiants. L???UFR SHS-Nancy poss??de une composante s??ur sur le campus de Metz qui propose des formations similaires ?? quelques exceptions pr??s. Les deux composantes forment le Collegium Sciences humaines et sociales.",
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
              "La Facult?? des Sciences et Technologies comprend 3 secteurs scientifiques : Math??matiques ; Informatique, Automatique, ??lectronique ; Physique, G??osciences, Chimie, M??canique Biologie",
          "name": "FACULT?? DES SCIENCES ET TECHNOLOGIES",
          "adresse": "Campus, Bd des Aiguillettes, 54506 Vand??uvre-l??s-Nancy",
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
              "L???UFR Math??matiques, Informatique, M??canique et Automatique est structur??e en 3 d??partements : Math??matiques, Informatique et Sciences pour l???ing??nieur. Elle propose des formations dans les domaines suivants : Math??matiques, Informatique, Sciences Pour lIng??nieur, Mat??riaux, G??nie Civil, Logistique, Hydraulique et Automatique.",
          "name": "UFR DE MATH??MATIQUES, INFORMATIQUE, M??CANIQUE",
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
              "L???UFR SciFA (Unit?? de Formation et de Recherche en Sciences Fondamentales et Appliqu??es) accueille sur ses sites plus de 2 000 ??tudiants et d??veloppe son activit?? de formation autour de 4 d??partements (Chimie, Physique-??lectronique, Sciences de la Vie et de la Terre, et STAPS) et de laboratoires de recherche pr??sents sur le site messin (IJL, LCOMS, LCP-A2MC, LEM3, LGIPM, LIEC, LMOPS, SRSMC, URAFPA).",
          "name": "UFR SCIENCES FONDAMENTALES ET APPLIQU??ES",
          "adresse": "Campus Bridoux, Rue du G??n??ral Delestraint, 57070 Metz",
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
              "Cr???? en 1967, l???IUT de Metz propose 6 DUT aujourd???hui semestrialis??s, et 17 sp??cialit??s de Licence Professionnelle sur les sites du Saulcy et du Technopole. En parall??le de cette formation initiale classique, il existe aussi la possibilit?? de pr??parer et d???obtenir ces dipl??mes en formation continue, par le biais de la Validation des Acquis de l???Exp??rience, ou encore en alternance sous statut d???apprenti. Dans le cadre de l???apprentissage, notamment, l???IUT propose 5 DUT et 14 sp??cialit??s de Licence Professionnelle, dautres ouvertures en LP en alternance sont pr??vues ?? court terme.",
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
              "L???IUT de Moselle-Est dispose d???implantations ?? Saint-Avold, Forbach et Sarreguemines et accueille environ 450 ??tudiants chaque ann??e. L???IUT participe ainsi ?? l???am??nagement du territoire en offrant aux jeunes des formations universitaires de proximit?? et en d??veloppant un partenariat ??troit avec de nombreuses entreprises de la r??gion en particulier au travers de sa plateforme de transfert de Technologie PLASTINNOV labellis??e par le Minist??re de l???Enseignement Sup??rieur.",
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
              "L???IUT de Saint-Di??-des-Vosges est n?? en 1993 dans le cadre du sch??ma ??Universit?? 2000 ?? de politique d???am??nagement du territoire. Situ?? dans un cadre de verdure, ?? mi-chemin entre Nancy et Strasbourg, il accueille des ??tudiants pour les former aux services et technologies de l???information et de la communication sous leurs multiples aspects.",
          "name": "IUT DE SAINT-DI??-DES-VOSGES",
          "adresse": "11 Rue de l'Universit??, 88100 Saint-Di??-des-Vosges",
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
              "Le site universitaire de Thionville-Yutz a ??t?? cr???? en 1995 sur l???espace Cormontaigne de l???Agglom??ration de Thionville-Yutz. Cette agglom??ration est situ??e ?? proximit?? de la zone des Trois Fronti??res (France, Luxembourg, Allemagne). De ce fait, c???est un lieu privil??gi?? d?????changes transfrontaliers, ??conomiques et humains. L???IUT Thionville-Yutz assume sa mission en formation initiale et continue : recherche et valorisation scientifique et technique ; orientation et insertion professionnelle ; diffusion de la culture et de l???information scientifique et technique ; coop??ration internationale.",
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
              "L???Institut Universitaire de Technologie Henri Poincar?? de Longwy, composante de l???Universit?? de Lorraine, est l???un des sept IUT lorrains. Implant?? dans un ??crin de verdure, aux fronti??res de la Belgique et du Luxembourg, il accueille des ??tudiants depuis 1969, dans une structure ?? la fois fonctionnelle et aux dimensions humaines. L???IUT Henri Poincar?? se compose de trois d??partements: G??nie Electrique et Informatique Industrielle (GEII), G??nie Thermique et Energie (GTE) et Gestion des Entreprises et des Administrations (GEA).",
          "name": "IUT HENRI POINCAR?? - LONGWY",
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
              "L???IUT ??pinal ??? Hubert Curien propose une offre de formation multiple et vari??e tant au niveau tertiaire que secondaire. Ses 3 DUT et 6 licences professionnelles permettent aux ??tudiants vosgiens de b??n??ficier d???un enseignement adapt?? aux besoins des entreprises vosgiennes avec lesquelles l???institut a tiss?? de nombreuses relations. En formation initiale ou continue, en apprentissage ou contrat de professionnalisation, l???IUT est en mesure de r??pondre aux exigences de nombreux publics.",
          "name": "IUT HUBERT CURIEN - EPINAL",
          "adresse": "7 Rue Fusill??s R??sistance 88000 ??pinal",
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
              "Composante de l???Universit?? de Lorraine, l???IUT Nancy-Brabois forme depuis plus de 50 ans les techniciens sup??rieurs et cadres moyens de demain. Il propose des formations ?? BAC+3  (LP et BUT) ?? l???issue desquelles les ??tudiants peuvent int??grer directement le march?? du travail ou poursuivre leurs ??tudes. Ses formations sont reconnues par les entreprises gr??ce ?? leur qualit?? et leur lien direct avec le monde professionnel.",
          "name": "IUT NANCY-BRABOIS",
          "adresse":
              "Lieu-dit Le Montet, Rue du Doyen Urion, 54600 Villers-l??s-Nancy",
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
              "L'Institut Universitaire de Technologie Nancy-Charlemagne (souvent abr??g?? en IUT Nancy-Charlemagne) est un IUT cr???? en 1967. Il est une composante de l'Universit?? de Lorraine.",
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
      World.loadPoisFromJsonData(poi);
        World.isRequestingData = false;
    },

    /* Helper to sort places by distance. */
    sortByDistanceSorting: function sortByDistanceSortingFn(a, b) {
        return a.distanceToUser - b.distanceToUser;
    },

    /* Helper to sort places by distance, descending. */
    sortByDistanceSortingDescending: function sortByDistanceSortingDescendingFn(a, b) {
        return b.distanceToUser - a.distanceToUser;
    },

    onError: function onErrorFn(error) {
        alert(error);
    }

};


/* Forward locationChanges to custom function. */
AR.context.onLocationChanged = World.locationChanged;

/* Forward clicks in empty area to World. */
AR.context.onScreenClick = World.onScreenClick;