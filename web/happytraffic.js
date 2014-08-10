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

    this.route('detail', {
        // get parameter via this.params
        path: '/detail/:_id',
        data: function() { return Reports.findOne(this.params._id); }
    });

    this.route('sorry');

});

