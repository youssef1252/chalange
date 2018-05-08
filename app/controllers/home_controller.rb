class HomeController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :get_products]

  def index
  end

  def get_products
    data = []
    products = Product.all
    products.each do |p|
      liked = false
      if current_user
        favorite = Favorite.find_by_user_id_and_product_id(current_user.id, p.id)
        if favorite
          liked = true
        end
      end
      data.push({
        id: p.id,
        name: p.libelle,
        price: p.price,
        latitude: p.latitude,
        longitude: p.longitude,
        like: liked,
        created: p.created_at
      })
    end
    render json: data
  end

  def update_products
    if request.params[:id].blank? || request.params[:type].blank?
      render json: {"response" => "Bad Response"}
      return
    end

    if request.params[:type] == 'like'
      begin
        Favorite.create!([user_id: current_user.id, product_id: request.params[:id]])
      rescue => e
        render json: {"response" => "Bad Response"}
        ap "An error occured: #{e}"
        return
      end
    end

    if request.params[:type] == 'dislike'
      favorite = Favorite.find_by_user_id_and_product_id(current_user.id, request.params[:id])
      favorite.destroy
    end
    render json: {"response" => "success Response"}
    return
  end

  def favorites

  end

  def favorite_products
    data = []
    favorites = Favorite.where(user_id: current_user.id)
    favorites.each do |f|
      p = Product.find_by_id(f.product_id)
      data.push({
        id: p.id,
        name: p.libelle,
        price: p.price,
        latitude: p.latitude,
        longitude: p.longitude,
        like: true,
        created: p.created_at
      })
    end
    render json: data
  end
end
