Template.home.events = {

    'click #setplatebutton':function(e){
        var num = $('#setplate').val();


        Meteor.call('updatePlate', num, function(error, report) {

            if(error){
                console.log(error.reason);

            }else{
                console.log("hello");
            }
        });
    },

    'click #send': function(e, instance){
        Session.set('plateNumber', $('.plate').val());
        Router.go('/rate');
    }
}



Template.home.recordCount = function(){
    if(Meteor.user()){
        var a = Reports.find({plate: Meteor.user().profile.plateId}).count();

        if(a > 0){
            $('.msg-ph').addClass('badged');
            $('.msg-ph').find('.counter').val(a) ;
        }
    }
}




