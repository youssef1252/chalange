var home;

home = angular.module('appHome', []);

home.factory('products_data', [
  '$http', function($http) {
    var factory;
    factory = {};
    factory.get_products = function() {
      return $http.get('/products').then(function(result) {
        return result.data;
      });
    };
    factory.update_products = function(id, type) {
      return $http.get('/products/update/' + id + '/' + type).then(function(result) {
        return result.data;
      });
    };
    factory.favorite_products = function(id, type) {
      return $http.get('/products/favorites').then(function(result) {
        return result.data;
      });
    };
    return factory;
  }
]);

home.controller('homeController', function($scope, products_data) {
  $scope.products = [];
  products_data.get_products().then(function(results) {
    return $scope.products = results;
  });
  products_data.favorite_products().then(function(results) {
    return $scope.products_favorite = results;
  });
  return $scope.action = function(product, type) {
    return products_data.update_products(product.id, type).then(function(results) {
      if (results.response === 'success Response') {
        if (type === 'like') {
          return product.like = true;
        } else {
          return product.like = false;
        }
      }
    });
  };
});
