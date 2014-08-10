if (Meteor.isClient) {

}

if (Meteor.isServer) {
  Meteor.startup(function () {
    // code to run on server at startup
  });
}

Router.map(function () {
    this.route('home', {
        path: '/',
        template: 'home'
    });

    this.route('list');
    this.route('rate');

    this.route('desc');
    this.route('sent');

    this.route('paymentsuccessful');
    this.route('paymentfailed');

});

Router.configure({
    load: function() {
        $('body').animate({
            left: "-1000px",
            scrollTop: 0
        }, 400, function() {
            $(this).animate({ left: "0px" }, 400);
        });
    }
    });
