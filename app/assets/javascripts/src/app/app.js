'use strict';

angular.module('sm', [
  'ui.router',
  'ui.bootstrap',
  'ngAnimate',
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ngTouch',

  'sm.event',
  'sm.match',
  'sm.looking'
])

.config(function shuffleAppConfig($stateProvider, $urlRouterProvider) {
  $urlRouterProvider.otherwise('/');
})

.controller('AppCtrl', function AppCtrl($rootScope) {
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
