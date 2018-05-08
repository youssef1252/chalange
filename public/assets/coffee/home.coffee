home = angular.module 'appHome', []

home.factory('products_data', ['$http', ($http) ->
  factory = {}
  factory.get_products = ->
    $http.get('/products').then (result) ->
      return result.data
  factory.update_products = (id, type) ->
    $http.get('/products/update/'+id+'/'+type).then (result) ->
      return result.data
  factory.favorite_products = (id, type) ->
    $http.get('/products/favorites').then (result) ->
      return result.data
  return factory
])

home.controller 'homeController', ($scope, products_data) ->
  $scope.products = []

  products_data.get_products().then (results) ->
    $scope.products = results

  products_data.favorite_products().then (results) ->
    $scope.products_favorite = results

  $scope.action = (product, type) ->
    products_data.update_products(product.id, type).then (results) ->
      if results.response == 'success Response'
        if type == 'like'
          product.like = true
        else
          product.like = false
