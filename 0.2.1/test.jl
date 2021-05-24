using BenchmarkTools
include("./framework.jl")
using .Yisy_AI_Framework

data = [0 1 2 3 5; 4 5 6 7 8; 8 9 0 1 2; 2 3 4 5 6]
data = convert(Array{Float32}, data)

data2 = zeros(Float32, (2,5))

let
    model = Sequential()
    model.add_layer(model, Dense(input_size=4, layer_size=5, randomization=true, activation_function=ReLU))
    model.add_layer(model, Dense(input_size=5, layer_size=5, randomization=true, activation_function=tanH))
    model.add_layer(model, Dense(input_size=5, layer_size=5, randomization=true, activation_function=None))
    model.add_layer(model, Dense(input_size=5, layer_size=2, randomization=true, activation_function=Sigmoid))

    Adam.fit(sequential=model, input_data=data, output_data=data2, loss_function=Absolute_Loss, monitor=Absolute_Loss, α=0.02, epochs=10, mini_batch=32)
end