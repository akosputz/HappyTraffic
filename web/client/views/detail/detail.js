/**
 * Created by nemethzsolt on 8/10/14.
 */

Meteor.startup(function(){

    Template.detail.rendered = function() {

Template.detail.title = function(){

  switch (this.feedbackType){
      case "ion-happy": {

          return "  New Compliment"
      }
      case "ion-sad": {

          return "  New Complain"
      }
      case "ion-alert": {

          return "  New Notification"
      }
  }
}

Template.detail.momentdate = function(a, b) {
    var a = moment(this.date);
    return a.format("ddd, hA");
}

Template.detail.isthanks = function(a, b) {
   if(this.feedbackType  == "ion-happy" || this.feedbackType  == "ion-alert" ){
       return true;
   }

    return false;
}

   }

});


Template.detail.events = {
    'click #detail-sorry': function(){
        Router.go('/sorry');
    },
    'click .back': function(){
        Router.go('/list');
    }


}