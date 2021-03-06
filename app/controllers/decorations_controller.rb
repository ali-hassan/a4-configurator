class DecorationsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :style, only: [:index]

  def create
    head :ok
  end
  def index
    @color = current_user.try(:colors).try(:last).try(:hex_code).split(',') if current_user.try(:colors).try(:last).present?
    @decorations        = Decoration.all
    @placements         = Placement.all
    @decoration_packges = Decoration.all
    @texts              = Text.all
    @graphics           = Graphic.all
  end

  def apply
    @object = params[:model_name].capitalize.constantize.order(id: :desc)
  end
  def show
    @object         = params[:model_name].capitalize.constantize.order(id: :desc)
    @style_methods  = StyleMethod.all.collect{|s_m| [s_m.code,s_m.id]}
    @model          = params[:model_name]
    @team_name      = params[:team_name]
    @team_name.nil? && current_user.update_attribute(:decoration_type, params[:model_name]) || current_user.update_attribute(:decoration_type, "team_name")
  end

  def form
    @team_name      = params[:team_name]
    @style_methods  = StyleMethod.where(code: params[:id])
    @texts          = Text.all
    @team_name != "true" && render("form.js.erb" )|| render(partial: "team_name.js.erb")
  end
  private
  def style
    @style = Style.find_by_id(params[:style_id])
  end
end
