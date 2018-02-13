require 'net/http'
class TestsController < ApplicationController
  before_action :set_test, only: [:show, :edit, :update, :destroy]
  #helper_method :test_service

  # GET /tests
  # GET /tests.json
  def index
    @tests = Test.all
  end
  # GET /addresses/1
  # GET /addresses/1.json
  def show
  end

  # GET /tests/new
  def new
    @test = Test.new
  end

  # POST /tests
  # POST /tests.json
  def create
    @test = Test.new(test_params)      
    service_status = test_service(params[:cl_sk])
    respond_to do |format|
      if @test.save
        if service_status == '200'         
          format.html { redirect_to @test, notice: 'Test success.' }
          format.json { render :show, status: :created, location: @test, message: 'OK' }
        else
          format.html { redirect_to @test, notice: 'Test fail.' }
          format.json { render json: @test.errors, status: 422 }
        end
      else
        format.html { render :new }
        format.json { render json: @test.errors, status: :unprocessable_entity }  
      end  
    end 
  end

  # DELETE /addresses/1
  # DELETE /addresses/1.json
  def destroy
    @test.destroy
    respond_to do |format|
      format.html { redirect_to tests_url, notice: 'Test was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def test_service(cl_sk)
      #1000.times do |i|
        url = URI.parse("http://localhost:3008/api/v1/activities/")
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = false
        request = Net::HTTP::Post.new(url, initheader = {'Content-Type' =>'application/json'})
        data = {
          cl_sk: cl_sk
          msg_num: 1 + i
        }        
        request.body = data.to_json
        response = http.request(request)
        if response.code == '200'
          return response.code
        else
          return response.body
        end
      #end  
    end

    def set_test
      @test = Test.find(params[:id])
    end

    def test_params
      params.require(:test).permit(:service_url)
    end
end
