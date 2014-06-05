$(document).ready(function() {
    if ($('#new_post').length) {
        var map = new GMaps({
            div: '#map-posts',
            lat: 16.771974,
            lng: -3.015361,
            click: function(event) {
                console.log(event);
                map.removeMarkers();
                map.addMarker({
                    lat: event.latLng.lat(),
                    lng: event.latLng.lng(),

                });
                $('.longitude').val(event.latLng.lng());
                $('.latitude').val(event.latLng.lat());
            }

        });

        GMaps.geolocate({
            success: function(position) {
                var latitude_data = position.coords.latitude;
                var longitude_data = position.coords.longitude;
                map.setCenter(latitude_data, longitude_data)


                $('.longitude').val(longitude_data);
                $('.latitude').val(latitude_data);

                map.addMarker({
                    lat: latitude_data,
                    lng: longitude_data
                });
            },
            error: function(error) {
                alert('Geolocation failed: ' + error.message);
            },
            not_supported: function() {
                alert("Your browser does not support geolocation");
            }
        });
        $('#submit-location-search').on('click', function() {
            map.removeMarkers();
            GMaps.geocode({
                address: $('#address').val(),
                callback: function(results, status) {
                    if (status == 'OK') {
                        var latlng = results[0].geometry.location;
                        map.setCenter(latlng.lat(), latlng.lng());

                        map.addMarker({
                            lat: latlng.lat(),
                            lng: latlng.lng()
                        });
                    }
                    $('.longitude').val(latlng.lat());
                    $('.latitude').val(latlng.lng());
                }
            });
        });
    };


});