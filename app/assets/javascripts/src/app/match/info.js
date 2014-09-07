angular.module('sm.match.info', [
  'ui.router'
])

.config(function config($stateProvider, $urlRouterProvider) {
  $stateProvider
  .state('match.info', {
    url: '/info',
    views: {
      "": {
        controller: 'MatchInfoCtrl',
        templateUrl: 'assets/src/app/match/info.html'
      }
    }
  });
})

.controller('MatchInfoCtrl', function MatchInfoCtrl($scope) {
});

