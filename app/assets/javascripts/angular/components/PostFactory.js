/**
 * @ngdoc service
 * @name picturegram:PostFactory
 *
 * @description
 *
 *
 * */
angular.module('picturegram')
    .factory('PostFactory', function($resource){
        return $resource('/posts/:id', {id: '@id', post: '@post'},
            {
              index: {method: 'GET'},
              show: {method: 'GET'}
            });
});
