class Api::V1::BaseController < ApplicationController
  def authenticate!
    render_errors({ status: 401, message: 'Unauthorized' }, status: 401) if current_user.nil?
  end

  def current_user
    User.find_by(api_token:)
  end

  def render_model(model, status: 200)
    render json: serialize(model).serializable_hash, status:
  end

  def render_models(models, status: 200)
    render json: serialize(models.to_a).serializable_hash, status:
  end

  def render_errors(errors, status: 422)
    render json: errors, status:
  end

  private

  def serialize(data)
    return [] if data.nil?

    model_clazz = data.is_a?(Array) ? data.first.class : data.class

    Object.const_get("#{model_clazz}Serializer").new(data)
  end

  def api_token
    @api_token ||= request.headers['X-API-TOKEN']
  end
end
