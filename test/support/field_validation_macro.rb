class FieldValidationMacro < Riot::AssertionMacro
  register :validates_with

  class FieldValidation
    def initialize(model, field, value)
      @model = model
      @field = field
      @value = value
    end

    def passes?
      @model.send(:"#{@field}=", @value)
      @model.valid?
      invalid_fields.include?(@field)
    end

    def invalid_fields
      @model.errors.messages.keys
    end
  end

  def msg(field, value)
    "allows '#{value}' as valid #{field}"
  end

  def valid?(topic, field, value)
    v = FieldValidation.new(topic, field, value)
    v.passes?
  end

  def evaluate(topic, field, value)
    if valid?(topic, field, value)
      fail msg(field, value)
    else
      pass msg(field, value)
    end
  end

  def devaluate(topic, field, value)
    unless valid?(topic, field, value)
      fail msg(field, value)
    else
      pass msg(field, value)
    end
  end
end

