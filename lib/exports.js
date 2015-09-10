//Declare .coffee variables to be shared throughout the app
//LOGS
Logs = new Mongo.Collection('logs');

Logs.helpers({
  year: function() {
    return this.start.getFullYear();
  }
});

//USERS
Users = new Mongo.Collection('members');

//HELPERS
var getTimeOfLog = function (log) {
  var start = log.start;
  if(log.end) {
    var end = log.end;
  } else {
    var end = start;
  }

  var diff = end.getTime() - start.getTime();
  return (diff / 1000);
}

var totalMinutes = function(logs) {
  var total = 0;
  for(var i = 0, l = logs.length; i < l; i++) {
    total += getTimeOfLog(logs[i])
  }

  return total;
}

Users.helpers({
  seasonTime: function() {
    var today = new Date();
    var year = today.getFullYear();
    var startDate = new Date(year, 0, 1);
    var endDate = new Date(year + 1, 0, 1);
    var logs = Logs.find({userId: this._id, start: {$gte: startDate, $lt: endDate}}).fetch();
    return totalMinutes(logs);
  },
  totalTime: function () {
    var logs = Logs.find({userId: this._id}).fetch();
    return totalMinutes(logs);
  },
  curStatus: function() {
    var lastLog = Logs.findOne({userId: this._id}, {sort: {start: -1}});
    if(!lastLog || lastLog.end) {
      return 0;
    }

    return 1;
  }
});
