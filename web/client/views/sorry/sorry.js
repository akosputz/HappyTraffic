/**
 * Created by nemethzsolt on 8/10/14.
 */
Template.sorry.events = {
    'click #sorry-pay': function(){
        window.location.href = "/pay";
    },
    'click .back': function(){
        window.history.back()
    }

}