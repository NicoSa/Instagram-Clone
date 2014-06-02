// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap
//= require_tree .
//= require mustache

$(document).ready(function() {
    $('body').on('click', '.like', function(event) {
        event.preventDefault();
        $.post($(this).attr('href'), $(this).serialize(), function(response) {

            var targetId = response.post
            var currentPost = $('.col-md-4[data-id=' + targetId + ']')

            var template = $('#likes-template').html();
            var output = Mustache.render(template, response)

            currentPost.find('.likes').append(output);
            currentPost.find('.like').replaceWith(response.unlike);
        }, 'json');
        return false;

    });
    $('body').on('click', '.unlike', function() {
        $.ajax({
            url: $(this).attr('href'),
            type: 'DELETE',
            success: function(response) {
                var targetId = response.post;
                var currentPost = $(".post[data-id='" + targetId + "']");
                currentPost.find(".each-likes[data-id='" + response.user.email + "']").remove();
                currentPost.find('.unlike').replaceWith(response.like);
            }
        });
        return false;

    });

});