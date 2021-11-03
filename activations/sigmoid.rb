require_relative '../activation_function'

class Sigmoid < ActivationFunction
  def initialize(value)
    super(value)
  end

  def evaluate
    1 / (1 + Math::E ** (-@value))
  end
  
  def evaluateDerivative
    y = evaluate
    return y * (1 - y)
  end
end

