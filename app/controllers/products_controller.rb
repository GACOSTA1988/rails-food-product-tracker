class ProductsController < ApplicationController

    def index
      if params[:made_in_usa]
        @products = Product.made_in_usa(params[:made_in_usa])
      elsif params[:most_recent]
        @products = Product.most_recent(params[:most_recent])
      elsif params[:most_reviews]
        @products = Product.most_reviews(params[:most_reviews])
      else params[:id]
        @products = Product.all
        render :index
      end
    end

      def new
        @product = Product.new
        render :new
      end
  
      def create
        @product = Product.new(product_params)
        if @product.save
          flash[:notice] = "New product successfully added!"
          redirect_to products_path
        else
          render :new
        end
      end
  
      def edit
        @product = Product.find(params[:id])
        render :edit
      end
  
      def show
        @product = Product.find(params[:id])
        render :show
      end
      
      def update
        @product= Product.find(params[:id])
        if @product.update(product_params)
          redirect_to products_path
        else
          render :edit
        end
      end
  
      def destroy
        @product = Product.find(params[:id])
        @product.destroy
        redirect_to products_path
      end

    private
    def product_params
      params.require(:product).permit(:name, :cost, :country_of_origin)
    end

  end