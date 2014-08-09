Template.home.events = {

    'click input#send': function(e, instance){


        var item = {
            userId: Meteor.userId(),
            plate: $('.plate').val(),
            feedbackType: $("#like").prop("checked")
        };



        Meteor.call('submit', item, function(error, report) {

            if(error){
                console.log(error.reason);

            }else{
                console.log("new report", {'reportId': report.reportId});

                Router.go('/list');
            }
        });

    }
}

Template.home.recordCount = function(){
    return Reports.find({userId: Meteor.userId()}).count();
}




