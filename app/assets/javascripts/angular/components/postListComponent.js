/**
 * @ngdoc component
 * @name picturegram:postListComponent
 *
 * @description
 * Post index.
 *
 * @restrict A
 * */
angular.module('picturegram')
  .component('postList', {
      template: '<div ng-if="$ctrl.posts">' +
      '<div ng-repeat="post in $ctrl.posts">' +
      '<post-display post="post"></post-display>' +
      '</div>' +
      '</div>',

      controller: function(PostFactory){
        var self = this;

        self.$onInit = function() {
          self.loadPosts();
        }

        self.loadPosts = function(){
          self.allPosts = PostFactory.index()
              .$promise
              .then(function(posts){
                return posts
              });

          self.allPosts.then(function(data){
            self.posts = data.posts;
          });
        }
      }
  });
