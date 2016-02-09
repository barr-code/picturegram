function previewImage() {
  $('.image_upload input').bind('change', function() {
    upload = this;
    if (upload.files && input.files[0]) {
      var reader = new FileReader();
      reader.onload = function(e) {
        $('.upload_preview').attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }
  });
}

$(document).ready(function(){
  previewImage();
})
