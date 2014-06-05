$(document).ready(function() {
    if ($('#new_post').length) {
        GMaps.geolocate({
            success: function(position) {
                //map.setCenter(position.coords.latitude, position.coords.longitude);
                var latitude_data = position.coords.latitude;
                var longitude_data = position.coords.longitude;
                $('.longitude').val(longitude_data);
                $('.latitude').val(latitude_data);
                console.log(latitude_data);
                console.log(longitude_data);
            },
            error: function(error) {
                alert('Geolocation failed: ' + error.message);
            },
            not_supported: function() {
                alert("Your browser does not support geolocation");
            },
        });
    }
});