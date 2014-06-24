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
// require turbolinks
//= require bootstrap
//= require mustache
//= require websocket_rails/main
//= require gmaps
//= require_tree .

$(document).ready(function() {
    var connection = new WebSocketRails(window.location.host + '/websocket');
    channel1 = connection.subscribe('likes');
    channel1.bind('like', function(post) {
        console.log(post);
        var postElem = $('.post[data-id=' + post.id + '] .btn-like');
        console.log(postElem);
        postElem.text('♥' + post.new_like_count);
    });

    channel2 = connection.subscribe('unlikes');
    channel2.bind('unlike', function(post) {
        console.log(post);
        var postElem = $('.post[data-id=' + post.id + '] .btn-like');
        console.log(postElem);
        postElem.text('♥' + post.new_like_count);
    });

    var connection = new WebSocketRails(window.location.host + '/websocket');
    channel3 = connection.subscribe('hates');
    channel3.bind('hate', function(post) {
        console.log(post);
        var postElem = $('.post[data-id=' + post.id + '] .btn-hate');
        console.log(postElem);
        postElem.text('☁' + post.new_hate_count);
    });

    channel4 = connection.subscribe('unhates');
    channel4.bind('unhate', function(post) {
        console.log(post);
        var postElem = $('.post[data-id=' + post.id + '] .btn-hate');
        console.log(postElem);
        postElem.text('☁' + post.new_hate_count);
    });

    channel3 = connection.subscribe('comments');
    channel3.bind('new', function(post) {
        console.log(post);
        $('.comments-display[data-comment-id=' + post.comment.post_id + ']').append(post.comment.comment + " | " + post.user.email + "<br>");
    })

    $('body').on('submit', '.new_comment', function(event) {
        event.preventDefault();
        event.stopPropagation();
        $.post($(this).attr('action'), $(this).serialize(), function(comment) {});
    });

    $('body').on('click', '.like', function(event) {
        event.preventDefault();
        event.stopPropagation();
        $.post($(this).attr('href'), $(this).serialize(), function(response) {
            console.log(response);

            var targetId = response.post
            var currentPost = $('.col-md-4[data-id=' + targetId + ']')

            var template = $('#likes-template').html();
            var output = Mustache.render(template, response)

            currentPost.find('.likes').append(output);
            currentPost.find('.like').replaceWith(response.unlike);
        }, 'json');
    });

    $('body').on('click', '.unlike', function(event) {
        event.preventDefault();
        event.stopPropagation();
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
    });

    $('body').on('click', '.hate', function(event) {
        event.preventDefault();
        event.stopPropagation();
        $.post($(this).attr('href'), $(this).serialize(), function(response) {
            console.log(response);

            var targetId = response.post
            var currentPost = $('.col-md-4[data-id=' + targetId + ']')

            var template = $('#hates-template').html();
            var output = Mustache.render(template, response)

            currentPost.find('.hates').append(output);
            currentPost.find('.hate').replaceWith(response.unhate);
        }, 'json');
    });

    $('body').on('click', '.unhate', function(event) {
        event.preventDefault();
        event.stopPropagation();
        $.ajax({
            url: $(this).attr('href'),
            type: 'DELETE',
            success: function(response) {
                var targetId = response.post;
                var currentPost = $(".post[data-id='" + targetId + "']");
                currentPost.find(".each-hates[data-id='" + response.user.email + "']").remove();
                currentPost.find('.unhate').replaceWith(response.hate);
            }
        });
    });
});