class VistorsController < ApplicationController
  before_action :set_vistor, only: [:show, :edit, :update, :destroy]

  # GET /vistors
  # GET /vistors.json
  def index
    @vistors = Vistor.all
  end

  # GET /vistors/1
  # GET /vistors/1.json
  def show
  end

  # GET /vistors/new
  def new
    @vistor = Vistor.new
  end

  # GET /vistors/1/edit
  def edit
  end

  # POST /vistors
  # POST /vistors.json
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

  # PATCH/PUT /vistors/1
  # PATCH/PUT /vistors/1.json
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

  # DELETE /vistors/1
  # DELETE /vistors/1.json
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
    @vistor = Vistor.all.order(:created_at)
    respond_to do |format|
      format.csv { send_data @vistor.to_csv }
    end
  end


  def generate_reports
    @vistor = Vistor.all.order(:created_at)
    respond_to do |format|
      format.html
      format.csv { send_data @vistor.to_csv, filename: "vistor_report-#{Time.zone.today}.csv" }
    end
  end

  def search_by_date
    params[:search][:search_by_date].to_date
    @vistor = Vistor.where('created_at BETWEEN ? AND ?', params[:search][:search_by_date].to_date.beginning_of_day, params[:search][:search_by_date].to_date.end_of_day)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vistor
      @vistor = Vistor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vistor_params
      params.require(:vistor).permit(:username, :contact_number, :email, :visitor_type, :here_for, :host, :note, :arrival_time, :arrival_date)
    end
end
