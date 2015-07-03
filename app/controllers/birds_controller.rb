class BirdsController < ApplicationController

  respond_to :json

  # GET /birds.json
  def index
    @birds = Bird.where(:visible => true)

    render json: @birds, status: 200

  end

  # GET /birds/1.json
  def show
    @bird = Bird.find(params[:id])

    if @bird
      render json: @bird, status: 200
    else
      render json: {msg: "not found"}, status: 404
    end

  end

  # POST /birds.json
  def create
    @bird = Bird.new(params[:bird])

    if @bird.save
      render json: @bird, status: :created, location: @bird
    else
      render json: @bird.errors, status: :unprocessable_entity
    end

  end

  # DELETE /birds/1
  # DELETE /birds/1.json
  def destroy
    @bird = Bird.find(params[:id])
    @bird.destroy

    head :no_content

  end
end
