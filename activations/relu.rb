require_relative '../activation_function'

class Relu < ActivationFunction
  def initialize(value)
    super(value)
  end

  def evaluate
    if @value > 0
      @value
    else
      0
    end
  end
  
  def evaluateDerivative
    if @value > 0
      1
    else
      0
    end
  end
end

