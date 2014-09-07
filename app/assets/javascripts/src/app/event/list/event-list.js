angular.module('sm.event.list', [
  'ui.router'
])

.config(function config($stateProvider, $urlRouterProvider) {
  $stateProvider
  .state('eventlist', {
    url: '/',
    resolve: {
      events: function($http) {
        return $http.get('/events.json')
        .then(function(data) {
          return data.data;
        });
      }
    },
    views: {
      "": {
        controller: 'EventListCtrl',
        templateUrl: 'assets/src/app/event/list/event-list.html'
      }
    }
  });
})

.controller('EventListCtrl', function EventListCtrl($scope, $state, $stateParams, $rootScope, events) {
  if (!angular.isArray(events)) {
    events = [events];
  }

  $scope.events = events;
});
