angular.module('sm.looking', [
  'ui.router'
])

.config(function config($stateProvider, $urlRouterProvider) {
  $stateProvider
  .state('looking', {
    url: '/looking',
    resolve: {
      matches: function(MatchesModel) {
        return MatchesModel.get();
      }
    },
    views: {
      "": {
        controller: 'LookingCtrl',
        templateUrl: 'looking/looking.html'
      }
    }
  });
})

.controller('LookingCtrl', function LookingCtrl($scope, $state, matches, $rootScope) {
  var match = _.find(matches, { person: { id: $rootScope.currentUser.id }});
  $rootScope.match = match;
  
  $state.go('match', { match: match });
});
