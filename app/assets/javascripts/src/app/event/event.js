angular.module('sm.event', [
  'ui.router',
  'sm.event.list',
  'sm.event.detail'
])

.config(function config($stateProvider, $urlRouterProvider) {
  $stateProvider
  .state('event', {
    abstract: true,
    url: '/event',
    views: {
      "": {
        controller: 'EventCtrl',
        templateUrl: 'event/event.html'
      }
    }
  });
})

.controller('EventCtrl', function EventCtrl($scope, $state, $stateParams, $rootScope) {
});
