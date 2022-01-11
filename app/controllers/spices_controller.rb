class SpicesController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_response

    def index
        render json: Spice.all, except: [:created_at, :updated_at]
    end

    def show
        render json: find_spice, except: [:created_at, :updated_at]
    end

    def create
        spice = Spice.create(spice_params)
        render json: spice, except: [:created_at, :updated_at], status: :created
    end

    def update
        spice = find_spice
        spice.update(spice_params)
        render json: spice, except: [:created_at, :updated_at]
    end

    def destroy
        find_spice.destroy
        head :no_content
    end

    private

    def record_not_found_response
        render json: { error: 'Spice not found' }, status: :not_found
    end

    def find_spice
        Spice.find(params[:id])
    end

    def spice_params
        params.permit(:title, :image, :description, :notes, :rating)
    end
end
