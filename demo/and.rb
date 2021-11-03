require_relative '../mlp'
require_relative '../activations/relu'

EPOCH = 10000
LEARNING_RATE = 0.1

layers = [2, 3, 3, 1]
net = MLP.new(LEARNING_RATE, Relu, layers)

for i in 0..EPOCH
  inputs = [rand(0..1).round, rand(0..1).round]

  # AND operator
  target = Array.new(1)
  target[0] = (inputs[0].to_i & inputs[1].to_i).to_f
  
  # forward & back propagation
  error = net.backprop(inputs, target)
  
  # show the log
  if i%1000 == 0
    printf("%f and %f = %f\n", inputs[0], inputs[1], target[0])
    printf("Error at step %d is %f\n", i, error)
    puts "-"*40
  end

end

puts "=====Learning Completed! ====="

# test
inputs = [1.0, 0.0]
output = net.forward(inputs)
printf("%f and %f = %d (%f)", inputs[0], inputs[1], output[0].round, output[0])

