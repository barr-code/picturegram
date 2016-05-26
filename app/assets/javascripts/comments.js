function bindDeleteButtons(){
  $('.delete-comment').on('click', function(event){
    event.preventDefault();
    var comment = $(this).parents('.row.post_message')
    var url = this.href
    $.ajax({
      url: url,
      type: 'DELETE',
      success: function(){
        $(comment).hide();
      }
    });
  });
}

$(document).ready(function() {
  $('.comment_form').hide();
  bindDeleteButtons();

  $('.add-comment, .submit-comment').on('click', function(event){
    event.preventDefault();
  });

  $('.add-comment').on('click', function(){
    var form = $(this).parents().siblings('.comment_form')
    $(form).show();
  });

  $('.submit-comment').on('click', function(){
    if($(this).attr('disabled') !== 'disabled'){
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
        var formattedContent = '<div class="row post_message raleway">' + username + ': ' + content + '<div class="pull-right"><a class="delete-comment" href="/comments/'+ response.comment_id +  '"><i class="fa fa-times"></i></div></div>'
        $(commentList).append(formattedContent)
        bindDeleteButtons();
        $(comment).val('')
        $(comment).parents('.comment_form').hide();
      })
    }
  });
})
