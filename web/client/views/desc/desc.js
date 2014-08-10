
Template.desc.events = {

'click #desc-honk':function(e){

    var item = {
        userId: Meteor.userId(),
        plateId: Meteor.user().profile.plateId,
        plate: Session.get("plateNumber"),
        feedbackType: Session.get("type"),
        desc: $('#textarea-desc').val()
    };


    Meteor.call('submit', item, function(error, report) {
        if(error){
            console.log(error.reason);

        }else{
            console.log("new report", {'reportId': report.reportId});

            Router.go('/');
        }
    });
  }

}

Template.desc.plate = function(){
    return Session.get("plateNumber");
}