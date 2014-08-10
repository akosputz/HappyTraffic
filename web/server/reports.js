/**
 plate      string
 feedbackType   boolean

 **/

Reports = new Meteor.Collection('reports');

Reports.allow({
    insert: function(){  return true; }
    , update: function(){  return true; }
    , remove: function(){  return true; }
});

Meteor.publish("r", function (obj) {
    return Reports.find({});
});


Meteor.methods({
    submit: function(report){

        // Validation, Error handling

        var reportId = Reports.insert(report);

        report.reportId = reportId;

        return report;

    },

    updatePlate: function(plateNum) {
        Meteor.users.update(Meteor.userId(), {$set: {'profile.plateId': plateNum}});
    }
});
