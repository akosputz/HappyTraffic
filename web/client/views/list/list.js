Reports = new Meteor.Collection('reports');

Template.list.reports = function(){
    return Reports.find({});
}
