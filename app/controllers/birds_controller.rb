class BirdsController < ApplicationController

  respond_to :json

  # GET /birds.json
  def index
    birds = Bird.where(:visible => true)

    render json: birds, status: 200

  end

  # GET /birds/1.json
  def show
    bird = Bird.find(params[:id])

    if bird
      render json: bird, status: 200
    else
      render nothing: true, status: 404
    end

  end

  # POST /birds.json
  def create
    bird = Bird.make(params)

    if bird && bird.save
      render json: bird, status: 201, location: bird
    elsif bird
      render json: bird.errors, status: 400
    else
      render json: {msg: "missing required fields"}, status: 400
    end

  end

  # DELETE /birds/1.json
  def destroy
    bird = Bird.find(params[:id])

    if bird && bird.destroy
      render nothing: true, status: 200
    else
      render nothing: true, status: 404
    end

  end
end
