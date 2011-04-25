


$.fn.extend({
  vAlignMin: function(min) {
    var oh = $(this).outerHeight();
    var wh = $(window).height();
    var vpos = String();

    if ((wh / 2) > min) {
      vpos = '50%'
    } else {
      vpos = min + 'px';
    }
//    console.log(oh, vpos, wh);
    return $(this).css({position: 'absolute', marginTop: (-1 * (oh / 2)) + 'px',top: vpos});
  },
  vAlign: function() {
    var oh = $(this).outerHeight();
    return $(this).css({position: 'absolute', marginTop: (-1 * (oh / 2)) + 'px',top: '50%'});
  },
  hAlign: function() {
    var ow = $(this).outerWidth();
    return $(this).css({position:'absolute', marginLeft: (-1 * (ow / 2)) + 'px', left: '50%'});
  }
});