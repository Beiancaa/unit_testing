require 'net/http'
class TestActivitiesController < ApplicationController
  before_action :set_test_activity, only: [:show, :edit, :update, :destroy]

  # GET /test_activities
  # GET /test_activities.json
  def index
    @test_activities = TestActivity.all
  end

  # GET /test_activities/1
  # GET /test_activities/1.json
  def show
  end

  # GET /test_activities/new
  def new
    @test_activity = TestActivity.new
  end

  # GET /test_activities/1/edit
  def edit
  end

  # POST /test_activities
  # POST /test_activities.json
  def create
    activity_status = test_service(
      params[:ClientId],
      params[:CaseId],
      params[:CreatedBy],
      params[:ActivityType],
      params[:ActivityCode],
      params[:Description],
      params[:EnvironmentId]
      )
    puts "===========", activity_status,"==========="
    puts "===========", response.code,"==========="
    puts "===========", response.code.class,"==========="
    @test_activity = TestActivity.new(status: activity_status)
    respond_to do |format| 
      if activity_status == '200'
        if @test_activity.save
          format.html { redirect_to @test_activity, notice: 'Test activity create & succeed.' }
          format.json { render :show, status: :created, location: @test_activity }
          #render json: {message: 'OK'}, status: 200
        else 
          format.html {render :new }
          format.json { render json: @test_activity.errors, status: :unprocessable_entity }
          #render json: {message: 'error'}, status: :unprocessable_entity 
        end
      else  
        if @test_activity.save
          format.html { redirect_to @test_activity, notice: 'Test activity create but failed.' }
          format.json { render :show, status: :created, location: @test_activity }
          #render json: {message: 'OK'}, status: 200
        else 
          format.html {render :new }
          format.json { render json: @test_activity.errors, status: :unprocessable_entity }
          #render json: {message: 'error'}, status: :unprocessable_entity
        end  
      end
    end  
  end  
  
  # PATCH/PUT /test_activities/1
  # PATCH/PUT /test_activities/1.json
  def update
    respond_to do |format|
      if @test_activity.update(test_activity_params)
        format.html { redirect_to @test_activity, notice: 'Test activity was successfully updated.' }
        format.json { render :show, status: :ok, location: @test_activity }
      else
        format.html { render :edit }
        format.json { render json: @test_activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /test_activities/1
  # DELETE /test_activities/1.json
  def destroy
    @test_activity.destroy
    respond_to do |format|
      format.html { redirect_to test_activities_url, notice: 'Test activity was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def test_service(client_id, case_id, created_by, activity_type, activity_code, description, environment_id)
      #1000.times do |i|
        url = URI.parse("http://localhost:3008/api/v1/activities/")
        http = Net::HTTP.new(url.host, url.port)
        #http.use_ssl = false
        request = Net::HTTP::Post.new(url, initheader = {'Content-Type' =>'application/json'})
        data = {
          ClientId: client_id,
          CaseId: case_id,
          CreatedBy: created_by,
          ActivityType: activity_type,
          ActivityCode: activity_code,
          Description: description,
          EnvironmentId: environment_id
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

    # Use callbacks to share common setup or constraints between actions.
    def set_test_activity
      @test_activity = TestActivity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def test_activity_params
      params.require(:test_activity).permit(:activity_url, :status, :client_id, :case_id, :created_by, :activity_type, :activity_code, :description, :environment_id)
    end
end
