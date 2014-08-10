Template.rate.events = {


    'click button':function(e, item){

        var a = e.target;
        if(a.id == ""){
             a = $(e.target).parent();
        }


        Session.set('type', $(a).attr('data-icon'))
        Router.go('/desc');
    }

}

Template.rate.plate = function(){
    return Session.get("plateNumber");
}