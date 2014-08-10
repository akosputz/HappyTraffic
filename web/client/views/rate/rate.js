Template.rate.events = {



    'click #rate-next':function(e){
        Session.set('type', $('input[name=ks-radio]:checked').val())
        Router.go('/desc');
    }

}

Template.rate.plate = function(){
    return Session.get("plateNumber");
}