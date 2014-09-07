angular.module('sm.match', [
  'ui.router'
])

.config(function config($stateProvider, $urlRouterProvider) {
  $stateProvider
  .state('match', {
    url: '/match/{matchid:[0-9]*}',
    views: {
      "": {
        controller: 'MatchCtrl',
        templateUrl: 'assets/src/app/match/match.html'
      }
    }
  });
})

.controller('MatchCtrl', function MatchCtrl($scope, $state, $stateParams, $rootScope) {
  $scope.match = $rootScope.match;
});
