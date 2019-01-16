class AuditsController < ApplicationController
  before_action :set_audit, only: [:show, :update, :destroy]

  # GET /audits
  def index
    @audits = Audit.all

    render json: @audits
  end

  # GET /audits/1
  def show
    render json: @audit
  end

  # POST /audits
  def create
    @audit = Audit.new(audit_params)

    if @audit.save
      render json: @audit, status: :created, location: @audit
    else
      render json: @audit.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /audits/1
  def update
    if @audit.update(audit_params)
      render json: @audit
    else
      render json: @audit.errors, status: :unprocessable_entity
    end
  end

  # DELETE /audits/1
  def destroy
    @audit.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_audit
      @audit = Audit.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def audit_params
      params.fetch(:audit, {})
    end
end
