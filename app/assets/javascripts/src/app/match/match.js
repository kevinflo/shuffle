angular.module('sm.match', [
  'ui.router',
  'sm.match.info'
])

.config(function config($stateProvider, $urlRouterProvider) {
  $stateProvider
  .state('match', {
    url: '/match/{matchid:[0-9]*}',
    resolve: {
      match: function($http, $stateParams) {
        return $http.get('/users/' + $stateParams.matchid + '.json')
        .then(function(user) {
          user = user.data;
          return $http.get('/csearch/' + user.company + '.json')
          .then(function(data) {
            user.companyInfo = data.data;
            return user;
          }).catch(function(err) {
            return user;
          });
        });
      }
    },
    views: {
      "": {
        controller: 'MatchCtrl',
        templateUrl: 'assets/src/app/match/match.html'
      }
    }
  });
})

.controller('MatchCtrl', function MatchCtrl($scope, match) {
  $scope.match = match;
  $scope.nextMatchTime = new Date((new Date()).getTime() + 1000*60*5);
});

