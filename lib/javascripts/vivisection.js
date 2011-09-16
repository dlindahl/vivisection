$(function() {

  $('#jump-to').click(function(e) {
    e.preventDefault();

    $('#sources').slideToggle();
  });

  var paths = [];
  $('#sources a[data-path]').each(function(i, el) {
    var root = el.getAttribute('data-path').split('/')[0] + '/' + el.getAttribute('data-path').split('/')[1];

    root = root.replace(/\.\w*$/,'');

    if( paths.indexOf(root) == -1) {
      paths.push( root );
    }
  });
  for(var i=0; i < paths.length; i++) {
    $('#sources a[data-path^="' +paths[i] + '"]').wrapAll('<div class="path-wrapper" data-root="' + paths[i] + '"></div>');
  }

  // Clicking outside of the Navigation will re-hide the drop down.
  $(document).click(function(e) {
    if( $(e.target).parents('header > nav').length == 0 ) {
      $('#sources').slideUp();
    }
  });

  // Reset when navigation back to page.
  $('#sources').slideUp();

});
