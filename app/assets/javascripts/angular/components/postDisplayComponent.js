/**
 * @ngdoc component
 * @name picturegram:postDisplayComponent
 *
 * @description
 * Renders post details.
 *
 * @restrict A
 * */
angular.module('picturegram')
    .component('postDisplay', {
        bindings: {
          post: '<'
        },

        template: '<p>{{$ctrl.likes.length}} {{$ctrl.post.message}}</p>' +
        '<p ng-repeat="comment in $ctrl.comments">{{comment.content}}</p>',

        controller: function(PostFactory){
          var self = this;

          self.$onInit = function() {
            self.loadPostData();
          }

          self.loadPostData = function(){
            self.postData = PostFactory.show(self.post)
                .$promise
                .then(function(data){
                  return data
                });

            self.postData.then(function(data){
              self.likes = data.likes
              self.comments = data.comments
            });
          }
        }
    });
