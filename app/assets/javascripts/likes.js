$(document).ready(function() {
  $('.add-like').on('click', function(event){
    event.preventDefault();
    var likeIcon = $(this).children('i')
    var url = $(this).attr('href');
    var likeCount = $(this).siblings('.total_likes');
    $.post(url, function(response){
      likeCount.text(response.new_like_count);
      if(response.liked){
        likeIcon.addClass('fa-heart');
        likeIcon.removeClass('fa-heart-o');
      } else {
        likeIcon.removeClass('fa-heart');
        likeIcon.addClass('fa-heart-o');
      }
    })
  })
})
