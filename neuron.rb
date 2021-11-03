class Neuron
  def initialize(prevLayerSize)
    @prevLayerSize = prevLayerSize
    @bias = Random.rand
    @delta = Random.rand
    @value = Random.rand
    @Weights = Array.new(@prevLayerSize){ rand }

    #@prevLayerSize.times{|x| @Weights[x]=Random.rand}
  end
  
  def value
    @value
  end
  
  def value= (v)
    @value = v
  end

  def delta
    @delta
  end

  def delta= (d)
    @delta = d
  end

  def bias
    @bias
  end
  
  def bias= (b)
    @bias = b 
  end

  def weights
    @Weights
  end

  def weights=
    @Weights=weights
  end
end

