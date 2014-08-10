Template.home.events = {

    'click #setplatebutton':function(e){
        var num = $('#setplate').val();


//        Meteor.call('updatePlate', num, function(error, report) {
//
//            if(error){
//                console.log(error.reason);
//
//            }else{
//                console.log("hello");
//            }
//        });
    },

    'click #send': function(e, instance){
        Session.set('plateNumber', $('.plate').val());
        Router.go('/rate');
    }
}

Template.home.recordCount = function(){
    if(Meteor.user()){
        return Reports.find({plate: Meteor.user().profile.plateId}).count();
    }
}




