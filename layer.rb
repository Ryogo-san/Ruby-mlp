require_relative './neuron'

class Layer
  def initialize(l, prev)
    @Length = l
    @Neurons = Array.new(l)
    @Length.times{|x| @Neurons[x] = Neuron.new(prev) }
  end
  
  def Length
    @Length
  end

  def neurons
    @Neurons
  end

  def neurons= (n)
    @Neurons = n
  end
end

