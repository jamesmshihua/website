using Plots

## define functions
f(x1::Float64 ,x2::Float64) = 0.5 * x1^2 + 4.5 * x2^2
f(xs::Vector{Float64}) = f(xs[1], xs[2])
df(x1::Float64 ,x2::Float64) = [-x1, -9 * x2]
df(xs::Vector{Float64}) = df(xs[1], xs[2])
α(x1::Float64 ,x2::Float64) = (x1^2 + 81 * x2^2) / (x1^2 + 729 * x2^2)
α(xs::Vector{Float64}) = α(xs[1], xs[2])

## initialisation
xs = zeros(56, 2)
ys = zeros(56)
xs[1,:] = [9, 1]

for i=1:55
    xs[i+1, :] = xs[i, :] + α(xs[i, :]) * df(xs[i, :])
end

ys = f.(xs[:,1], xs[:,2])

## plot3d
gr()
plot(layout=(2,1), size=(600,700))
x1 = LinRange(-10, 10, 1001)
x2 = LinRange(-1.5, 1.5, 1001)

plot3d!(xlabel="x₁", ylabel="x₂", zlabel="f(x)", dpi=300, subplot=1)
plot3d!(x1, x2, f, st = :surface, camera = (30, 40), label="Surface")
plot3d!(xs[:,1], xs[:,2], ys, markershape = :circle, label="Opt Trajectory", subplot=1)

plot!(xlabel="x₁", ylabel="x₂", dpi=300, subplot=2)
xlims!((-1,1), subplot=2)
ylims!((-0.15,0.15), subplot=2)
contour!(LinRange(-1,1,1001), LinRange(-0.15,0.15,1001), f, label="Contour", subplot=2)
plot!(xs[:,1], xs[:,2], markershape = :circle, label="Opt Trajectory", subplot=2)
png("gdm1")