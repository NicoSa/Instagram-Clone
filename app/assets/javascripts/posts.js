$(document).ready(function() {
    if ($('#new_post').length) {
        GMaps.geolocate({
            success: function(position) {
                //map.setCenter(position.coords.latitude, position.coords.longitude);
                var latitude_data = position.coords.latitude;
                var longitude_data = position.coords.longitude;
                // console.log(latitude_data);
                // console.log(longitude_data);

                $('.longitude').val(longitude_data);
                $('.latitude').val(latitude_data);
                var map = new GMaps({
                    div: '#map-posts',
                    lat: latitude_data,
                    lng: longitude_data,
                    click: function(event) {
                        console.log(event);
                        map.removeMarkers();
                        map.addMarker({
                            lat: event.latLng.lat(),
                            lng: event.latLng.lng()
                        });
                        $('.longitude').val(event.latLng.lng());
                        $('.latitude').val(event.latLng.lat());
                    }
                });
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
    };


});