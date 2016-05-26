$(document).ready(function() {
  $('.submit-comment').on('click', function(event){
    event.preventDefault();
    var comment = $(this).siblings('.new_comment')
    var commentList = $(comment).parents('.comment_form').siblings('.photo_comments')
    var content = $(comment).val()
    var userId = $(comment).data('user-id')
    var postId = $(comment).data('post-id')
    var data = {
      content: content,
      user_id: userId,
      post_id: postId
    }

    $.post('/comments', data, function(response){
      var username = "@" + response.username
      var content = response.content
      var formattedContent = '<div class="row post_message raleway">' + username + ': ' + content + '</div>'
      $(commentList).append(formattedContent)
    })
  })
})
