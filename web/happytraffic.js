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
});
