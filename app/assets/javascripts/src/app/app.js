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
})

.run(function($rootScope) {
  /* This should only be here on dev */
  $rootScope.$on('$stateChangeError', 
  function(event, toState, toParams, fromState, fromParams, error){
    console.error(arguments);
  });

  $rootScope.$on('$stateChangeSuccess', 
  function(event, toState, toParams, fromState, fromParams) {
    console.group("Changing state to:", toState.name);
    console.log('toState:', toState);
    console.log('toParams:', toParams);
    console.log('fromState:', fromState);
    console.log('fromParams:', fromParams);
    console.groupEnd();
  });

});
