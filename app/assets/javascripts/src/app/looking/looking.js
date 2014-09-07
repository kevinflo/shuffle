angular.module('sm.looking', [
  'ui.router'
])

.config(function config($stateProvider, $urlRouterProvider) {
  $stateProvider
  .state('looking', {
    url: '/looking/{eventid:[0-9]+}',
    resolve: {
      matches: function($http) {
        return $http.get('/')
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

.controller('LookingCtrl', function LookingCtrl($scope, $state, matches, $rootScope) {
  var cUserid = $rootScope.currentUser.id;
  var match;

  matches.forEach(function(val) {
    if(val[0] === cUserid) {
      match = val[1];
    } else if (val[1] === cUserid) {
      match = val[0];
    }
  });
  
  $state.go('match', { matchid: match });
});
