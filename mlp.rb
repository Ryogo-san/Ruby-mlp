require_relative './layer'
require_relative './neuron'
require_relative './activation_function'


class MLP
  def initialize(learning_rate, func, layer_length)
    @learning_rate = learning_rate
    @activation_func = func
    @num_layers = layer_length.length
    @fLayers = Array.new(@num_layers)

    @num_layers.times{|x|
      if  x== 0
        @fLayers[x] = Layer.new(layer_length[x], 0)
      else
        @fLayers[x] = Layer.new(layer_length[x], layer_length[x-1])
      end
    }
  end

  def forward input
    output = Array.new(@fLayers[@fLayers.length-1].Length)

    @fLayers[0].Length.times{|x|
      @fLayers[0].neurons[x].value = input[x]
    }

    for i in 1...@fLayers.length
      for j in 0...@fLayers[i].Length
        new_value = 0.0
        for k in 0...@fLayers[i-1].Length
          new_value += @fLayers[i].neurons[j].weights[k] * @fLayers[i-1].neurons[k].value
        end
        new_value += @fLayers[i].neurons[j].bias

        @fLayers[i].neurons[j].value = @activation_func.new(new_value).evaluate
      end
    end

    @fLayers[@fLayers.length-1].Length.times{|x|
      output[x] = @fLayers[@fLayers.length-1].neurons[x].value
    }

    output
  end

  def backprop(input, target)
    output = self.forward(input)
    error = nil

    for i in 0...@fLayers[@fLayers.length-1].Length
      error = target[i] - output[i]
      @fLayers[@fLayers.length-1].neurons[i].delta = error * @activation_func.new(output[i]).evaluateDerivative
    end

    for i in -(@fLayers.length-2)..0
      for j in 0...@fLayers[-i].Length
        error = 0.0
        for k in 0...@fLayers[-i+1].Length
          error += @fLayers[-i+1].neurons[k].delta * @fLayers[-i+1].neurons[k].weights[-i]
        end
        @fLayers[-i].neurons[j].delta = error * @activation_func.new(@fLayers[-i].neurons[j].value).evaluateDerivative
      end

      for j in 0...@fLayers[-i+1].Length
        for k in 0...@fLayers[-i].Length
          @fLayers[-i+1].neurons[j].weights[k] += @learning_rate*@fLayers[-i+1].neurons[j].delta*@fLayers[-i].neurons[k].value
        end
        @fLayers[-i+1].neurons[j].bias += @learning_rate*@fLayers[-i+1].neurons[j].delta
      end
    end

    error = 0.0
    for i in 0...target.length
      error += (output[i] - target[i]).abs
    end
    error = error / output.length

    return error
  end
end

