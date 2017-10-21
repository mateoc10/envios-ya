    var markerList = [];

    // handler = Gmaps.build('Google');
    // handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
    // });
    
    
      var map;
      var init = {lat: -34.90, lng: -56.16};
      var geocoder = new google.maps.Geocoder;
      var infowindow = new google.maps.InfoWindow;

        map = new google.maps.Map(document.getElementById('map'), {
          zoom: 13,
          center: init,
          mapTypeId: 'terrain'
        });

        // This event listener will call addMarker() when the map is clicked.
        map.addListener('click', function(event) {
          addMarker(event.latLng);
        });

      // Adds a marker to the map and push to the array.
      function addMarker(location) {
        
        let markerLabel = "";
        if(markerList.length == 0) {
          markerLabel = "Origin";
        } else if (markerList.length == 1) {
          markerLabel = "Destiny";
        } else {
          deleteMarkers();
          markerList = [];
          markerLabel = "Origin";
        }
        
        var marker = new google.maps.Marker({
          position: location,
          map: map,
          title: markerLabel,
          snippet: markerLabel,
          infowindow: markerLabel
        });
        markerList.push(marker);
        if (markerList.length == 2) {
          sendLocations(markerList);
        } else if (markerList.length == 2) {
          resetLocations();
        }
        //geocodeLatLng(geocoder, map, infowindow, location);   DESCOMENTAR Y PROBAR
      }

      // Sets the map on all markers in the array.
      function setMapOnAll(map) {
        for (var i = 0; i < markerList.length; i++) {
          markerList[i].setMap(map);
        }
      }

      // Removes the markers from the map, but keeps them in the array.
      function clearMarkers() {
        setMapOnAll(null);
      }

      // Deletes all markers in the array by removing references to them.
      function deleteMarkers() {
        clearMarkers();
        markerList = [];
      }
      
      function sendLocations(markerList) {
        let originAndDestiny = [];
        originAndDestiny.push({ lat: markerList[0].position.lat(), lng: markerList[0].position.lng() });
        originAndDestiny.push({ lat: markerList[1].position.lat(), lng: markerList[1].position.lng() });
        $.ajax({
          url: '/shipments/sendLocations',
          headers: { 'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content') },
           data: { 
             markerList: originAndDestiny
           },
          type: 'POST'
        }).done(function (response) {
          console.log('envio');
        }).fail(function (response) {
          console.log('marcho');
        });
      }
      
      function resetLocations() {
        $.ajax({
          url: 'https://envios-ya-mateoc10.c9users.io/shipments/resetLocation',
           data: { 
           },
          type: 'POST'
        }).done(function (response) {
          console.log('reseteo');
        }).fail(function (response) {
          console.log('marcho el reset');
        });
      }