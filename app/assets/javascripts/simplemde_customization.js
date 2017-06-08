var customImageUpload = {
  name: 'image',
  action: function(editor){
    window.currentCM = editor.codemirror;

    if(document.getElementById('simpleMDEUpload')){
      $('#simpleMDEUpload').foundation('open');
    }
    else{
      var elemDiv = document.createElement('div');
      elemDiv.classList = 'reveal';
      elemDiv.id = 'simpleMDEUpload';
      elemDiv.innerHTML = '\
        <h2 id="modalTitle">Upload Image</h2>\
        <form class="dropzone" id="my-awesome-dropzone">\
          <div class="fallback">\
            <input name="file" type="file" />\
          </div>\
        </form>\
        <p class="lead">or select an image to upload</p>\
        <input type="file" id="upload-image-input">\
        <br>\
        <button class="button large" id="upload-image-btn">Upload</button>\
        <p id="upload-image-error" class="is-invalid-label hide"></p>\
        <button class="close-button" data-close aria-label="Close modal" type="button">\
          <span aria-hidden="true">&times;</span>\
        </button>\
        ';
      document.body.appendChild(elemDiv);
      var popup = new Foundation.Reveal($('#simpleMDEUpload'));
      popup.open();
      $("#my-awesome-dropzone").dropzone({ 
        url: "/uploads",
        addRemoveLinks: true,
        headers: {
          'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
        },
        success: function(file, res){
          console.log(file, res);
          handleUploadSuccess(res);
        },
        error: function(file, errorMessage, xhr){
          console.log(file, errorMessage, xhr)
          hadnleUploadError(errorMessage);
        }
      });
    }
  },
  className: "fa fa-picture-o",
  title: "Insert Image",
};

var handleUploadSuccess = function(response){
  if(response.success){
    window.currentCM.replaceSelection("!["+response.image.name+"]("+response.image.url+")");
    $('#upload-image-error').addClass('hide')
    $('#simpleMDEUpload').foundation('close');
    $('#simpleMDEUpload').foundation('destroy');
  }
  else{
    $('#upload-image-error').text(response.error);
    $('#upload-image-error').removeClass('hide');
  }
}

var hadnleUploadError = function(response){
  $('#upload-image-error').text("Some unknown error occurred!");
  $('#upload-image-error').removeClass('hide');
}

$(document).on("turbolinks:load", function() {
  var simplemde = new SimpleMDE({ 
    element: document.getElementById("description"),
    previewRender: function(plainText, preview) {
      setTimeout(function() {
        preview.innerHTML = this.parent.markdown(plainText).replace(/<code>/g, '<code class="language-sas">');
        Prism.highlightAll();
      }.bind(this), 1)
      return "Loading..."
    },
    renderingConfig: {
      codeSyntaxHighlighting: true,
    },
    toolbar: [
      "bold", "italic", "heading", "|", "quote", "unordered-list", "ordered-list", "|", "link", 
      customImageUpload, "|", "preview", "side-by-side", "fullscreen", "|", "guide"
    ]
  });
  var simplemde = new SimpleMDE({
    element: document.getElementById("explanation"),
    previewRender: function(plainText, preview) {
      setTimeout(function() {
        preview.innerHTML = this.parent.markdown(plainText).replace(/<code>/g, '<code class="language-sas">');
        Prism.highlightAll();
      }.bind(this), 1)
      return "Loading..."
    },
    renderingConfig: {
      codeSyntaxHighlighting: true,
    },
    toolbar: [
      "bold", "italic", "heading", "|", "quote", "unordered-list", "ordered-list", "|", "link", 
      customImageUpload, "|", "preview", "side-by-side", "fullscreen", "|", "guide"
    ]
  });
});

$(document).on('click', '#upload-image-btn', function(e){
  var file_data = $('#upload-image-input').prop('files')[0];
  var form_data = new FormData();
  form_data.append("file", file_data);

  $.ajax({
    url: '/uploads',
    dataType: 'json',
    beforeSend: function(xhr) { xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content')) },
    cache: false,
    contentType: false,
    processData: false,
    data: form_data,
    type: 'post',
    success: function(response){
      handleUploadSuccess(response);
    },
    error: function(xhr, ajaxOptions, thrownError) {
      console.log(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
      hadnleUploadError(thrownError);
    }
  });
});
