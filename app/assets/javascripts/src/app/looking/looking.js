angular.module('sm.looking', [
  'ui.router'
])

.config(function config($stateProvider, $urlRouterProvider) {
  $stateProvider
  .state('looking', {
    url: '/looking/{eventid:[0-9]+}',
    resolve: {
      matches: function() {
        //return MatchesModel.get();
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
  //var match = _.find(matches, { person: { id: $rootScope.currentUser.id }});
  //$rootScope.match = match;
  
  //$state.go('match', { match: match });
});
