$(document).ready(function() {
  $('.add-like').on('click', function(event){  
    event.preventDefault();
    var url = $(this).attr('href');

    var likeCount = $('.total_likes');

    $.post(url, function(response){
      likeCount.text(response.new_like_count);
    })
  })
})