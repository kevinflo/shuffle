angular.module('sm.looking', [
  'ui.router',
  'timer'
])

.config(function config($stateProvider, $urlRouterProvider) {
  $stateProvider
  .state('looking', {
    url: '/looking/{eventid:[0-9]+}',
    resolve: {
      matches: function($http, $stateParams) {
        return $http.get('/events/' + $stateParams.eventid + '.json')
        .then(function(data) {
          return data.data;
        });
      }
    },
    views: {
      "": {
        controller: 'LookingCtrl',
        templateUrl: 'assets/src/app/looking/looking.html'
      }
    }
  });
})

.controller('LookingCtrl', function LookingCtrl($scope, $state, $stateParams, matches, $rootScope, $timeout, $http) {
  var cUserid = $rootScope.currentUser.meetup_uid;
  var match, tOut;

  matches.pairings.forEach(function(val) {
    if(val[0] === cUserid) {
      match = val[1];
    } else if (val[1] === cUserid) {
      match = val[0];
    }
  });

  if (match) {
    $state.go('match', { matchid: match });
  } else {

    tOut = $timeout(pollNew, 5000);

  }

  function pollNew() {
    $http.get('/events/' + $stateParams.eventid + '.json')
    .then(function(data) {
      var match = null;
      data.data.pairings.forEach(function(val) {
        if(val[0] === cUserid) {
          match = val[1];
        } else if (val[1] === cUserid) {
          match = val[0];
        }
      });

      if (match) {
        $timeout.cancel(tOut);
        $state.go('match', { matchid: match });
      } else {
        tOut = $timeout(pollNew, 5000);
      }
    });
  }
});
