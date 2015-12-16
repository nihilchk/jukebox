# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  $("#youtube_url_fetcher").on 'change', ->
    query = $("#youtube_url_fetcher").val()
    if query == ''
      $("#search_results").html("")
    else
      $.get '/search_youtube_videos?q=' + query, (data) ->
        $("#search_results").html("")
        for element in data
          html_snippet = "<a data-video-url='"+element.url+"' class='data-link'>"+element.name+"</a><br/>"
          $("#search_results").append(html_snippet)

  $(document).on "click", ".data-link", ->
    $("#song_request_song_url").val("http://www.youtube.com" + $(this).attr('data-video-url'))
  $("#youtube_url_fetcher").on 'focus', ->
    $(this).val("")