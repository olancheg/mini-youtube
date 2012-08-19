(function($){

  $(function (){

    // fetch file input
    var $file_field = $('.upload input[type=file]');

    // init file upload
    $file_field.fileupload({
      dataType: 'script', // parse response as javascript
      progressall: function (e, data) {
        var progress = parseInt(data.loaded / data.total * 100, 10);
        $('#progress .bar').css(
          'width',
          progress + '%'
        );
      }
    });

    // on video name change
    $('.upload input[type=text]').keyup(function() {
      var value = $.trim($(this).attr('value')); // trim value

      if (value != "") {                         // if value is not empty
        $file_field.removeAttr('disabled');      // enable file input
      } else {                                   // otherwise
        $file_field.attr('disabled', '');        // disable file input
      }
    });

  });

})(jQuery);
