Template.rate.events = {


    'click #rate-submit':function(e){

        var item = {
            userId: Meteor.userId(),
            plateId: Meteor.user().profile.plateId,
            plate: Session.get("plateNumber"),
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

Template.rate.plate = function(){
    return Session.get("plateNumber");
}