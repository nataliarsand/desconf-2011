class ModelValidationsMiddleware < Riot::ContextMiddleware
  register

  def call(context)
    obj = context.description

    if obj.is_a?(Class) && obj.included_modules.include?(ActiveModel::Validations)
      context.setup { obj.new }
    end

    middleware.call(context)
  end
end

