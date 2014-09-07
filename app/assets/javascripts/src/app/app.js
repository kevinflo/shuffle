'use strict';

angular.module('sm', [
  'ui.router',
  'ui.bootstrap',
  'ngAnimate',
  //'ngResource',
  //'ngSanitize',
  //'ngTouch',

  'sm.event',
  'sm.match',
  'sm.looking'
])

.config(function shuffleAppConfig($stateProvider, $urlRouterProvider) {
  $urlRouterProvider.when('/', '/event/');
  $urlRouterProvider.otherwise('/');
})

.controller('AppCtrl', function AppCtrl($rootScope) {
  $rootScope.currentUser = window.sm_current_user;
})

.controller('HeaderCtrl', function HeaderCtrl() {

})

.directive('profileImage', function(){
  return function(scope, element, attrs){
    attrs.$observe('profileImage', function(value) {
      element.css({
        'background-image': 'url(' + value +')',
        'background-size' : 'cover'
      });
    });
  };
});
