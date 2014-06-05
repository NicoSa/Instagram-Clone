$(document).ready(function() {
    var postId = $('#map').data('post-id');

    // if (postId) {
        $.get('/posts/' + postId + '.json', function(post) {
            var map = new GMaps({
                div: '#map',
                lat: post.latitude,
                lng: post.longitude,
            // click: function(event) {
            //     console.log(event);
            //     map.removeMarkers();
            //     map.addMarker({
            //         lat: event.latLng.lat(),
            //         lng: event.latLng.lng()
            //     });
            // }
            });

            map.addMarker({
                lat: post.latitude,
                lng: post.longitude
            });
        });
    // }
});