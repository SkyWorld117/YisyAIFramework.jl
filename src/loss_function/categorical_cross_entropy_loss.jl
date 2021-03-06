module Categorical_Cross_Entropy_Loss
    using LoopVectorization

    function func(output_matrix::Array{Float32}, sample_matrix::Array{Float32})
        loss_matrix = zeros(Float32, size(output_matrix))
        @avxt for i in axes(loss_matrix, 1), j in axes(loss_matrix, 2)
            loss_matrix[i,j] = -sample_matrix[i,j]*log(max(output_matrix[i,j], 1e-8))
        end
        return loss_matrix
    end

    function prop!(δ::Array{Float32}, output_matrix::Array{Float32}, sample_matrix::Array{Float32})
        @avxt for i in eachindex(δ)
            δ[i] = -sample_matrix[i]/max(output_matrix[i], 1e-8)
        end
    end
end
