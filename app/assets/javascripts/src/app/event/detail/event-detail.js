angular.module('sm.event.detail', [
  'ui.router'
])

.config(function config($stateProvider, $urlRouterProvider) {
  $stateProvider
  .state('event.detail', {
    url: '/',
    views: {
      "": {
        controller: 'EventDetailCtrl',
        templateUrl: 'assets/src/app/event/detail/event-detail.html'
      }
    }
  });
})

.controller('EventDetailCtrl', function EventDetailCtrl($scope, $state, $stateParams, $rootScope) {
  //$scope.match = $rootScope.match;
});
