angular.module('sm.event.list', [
  'ui.router'
])

.config(function config($stateProvider, $urlRouterProvider) {
  $stateProvider
  .state('event.list', {
    url: '/',
    views: {
      "": {
        controller: 'EventListCtrl',
        templateUrl: 'event/list/event-list.html'
      }
    }
  });
})

.controller('EventListCtrl', function EventListCtrl($scope, $state, $stateParams, $rootScope) {
  $scope.match = $rootScope.match;
});
