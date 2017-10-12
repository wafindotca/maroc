class VistorsController < ApplicationController
  before_action :set_vistor, only: [:show, :edit, :update, :destroy]

  def index
    @today = Time.now
    @yesterday = Time.now - 1.day
    @tomorrow = Time.now + 1.day
    @vistors = Vistor.where("created_at >= ?",Time.now.beginning_of_day)
  end

  def show
  end

  def new
    @vistor = Vistor.new
  end

  def edit
  end

 
  def create
    @vistor = Vistor.new(vistor_params)

    respond_to do |format|
      if @vistor.save
        format.html { redirect_to vistors_path, notice: 'Vistor was successfully Checked In' }
        format.json { render :show, status: :created, location: @vistor }
      else
        format.html { render :new }
        format.json { render json: @vistor.errors, status: :unprocessable_entity }
      end
    end
  end
 
  def update
    respond_to do |format|
      if @vistor.update(vistor_params)
        format.html { redirect_to @vistor, notice: 'Vistor was successfully Checked In' }
        format.json { render :show, status: :ok, location: @vistor }
      else
        format.html { render :edit }
        format.json { render json: @vistor.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @vistor.destroy
    respond_to do |format|
      format.html { redirect_to vistors_url, notice: 'Vistor was successfully Checked Out.' }
      format.json { head :no_content }
    end
  end

  def signout_vistor
    vistor = Vistor.find_by_id(params[:vistor_id])
    if vistor.present?
      vistor.update_attributes(checkout_time: Time.now)
      redirect_to vistors_url
    else
      redirect_to vistors_url
    end
  end

  def search_visitor
    if params[:search_query].blank? || params[:search_query].nil?
      @vistors = Vistor.all
    else
      @vistors = Vistor.where("username like ?", "%#{params[:search_query]}%")
    end
  end

  def search_by_user_type
    if params[:user_type] == ""
      @vistors = Vistor.all.order(:created_at)
    elsif params[:user_type] == "Currently Signed In"
      @vistors = Vistor.where(checkout_time: nil).order(:created_at)
    elsif params[:user_type] == "Currently Signed Out"
      @vistors = Vistor.where.not(checkout_time: nil).order(:created_at)
    end
  end

  def generate_reports
    @vistor = Vistor.where('created_at BETWEEN ? AND ?', params[:date].to_time.beginning_of_day, params[:date].to_time.end_of_day)
    respond_to do |format|
      format.html
      format.csv { send_data @vistor.to_csv, filename: "vistor_report-#{Time.zone.today}.csv" }
    end
  end

  def search_by_date
    @today = params[:search_by_date].to_date
    @yesterday = @today - 1.day
    @tomorrow = @today + 1.day
    @vistors = Vistor.where('created_at BETWEEN ? AND ?', params[:search_by_date].to_time.beginning_of_day, params[:search_by_date].to_time.end_of_day)
  end


  def calender_search_record
    @today = params[:search][:search_by_date].to_date
    @yesterday = @today - 1.day
    @tomorrow = @today + 1.day
    @vistors = Vistor.where('created_at BETWEEN ? AND ?', params[:search][:search_by_date].to_time.beginning_of_day, params[:search][:search_by_date].to_time.end_of_day)
  end

  private

    def set_vistor
      @vistor = Vistor.find(params[:id])
    end

    def vistor_params
      params.require(:vistor).permit(:username, :contact_number, :email, :visitor_type, :here_for, :host, :note, :arrival_time, :arrival_date)
    end
end
