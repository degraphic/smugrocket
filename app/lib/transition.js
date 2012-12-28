// Perform a page transition. If our new view is stage-right, it is new content so 
// we need call its render method. If it's stage-left, it's already in our history 
// so we just need to transition back. In either case, all event handlers are removed
// from the old view, as they will be re-attached by the router when/if that view is
// brought back to stage-center. If the view is pushed back to stage right, its
// contents are also cleared to make room for any future renders from that view.
//
SmugRocket.transition = function(newView) {  
  $(document).one('webkitTransitionEnd transitionend', function(e) {
    $('.page').removeClass('transition');
    $('.stage-right').html('');
  });
  
  if (newView.$el.hasClass('stage-right')) {
    newView.render();
    $('.stage-center').removeClass('stage-center').addClass('transition stage-left').off();
    newView.$el.removeClass('stage-right').addClass('transition stage-center');
  }
  
  if (newView.$el.hasClass('stage-left')) {
    $('.stage-center').removeClass('stage-center').addClass('transition stage-right').off();
    newView.$el.removeClass('stage-left').addClass('transition stage-center');
  }
}
