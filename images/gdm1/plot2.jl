using Plots

## define functions
f(x1::Float64 ,x2::Float64) = 0.5 * x1^2 + 0.5 * x2^2
f(xs::Vector{Float64}) = f(xs[1], xs[2])
df(x1::Float64 ,x2::Float64) = [-x1, -x2]
df(xs::Vector{Float64}) = df(xs[1], xs[2])
# α(x1::Float64 ,x2::Float64) = (x1^2 + 81 * x2^2) / (x1^2 + 729 * x2^2)
# α(xs::Vector{Float64}) = α(xs[1], xs[2])

## initialisation
xs = [9. 1.; 0. 0.]
ys = f.(xs[:,1], xs[:,2])

## plot3d
gr()
plot(layout=(2,1), dpi=300, size=(600,700))
x1 = LinRange(-10, 10, 1001)
x2 = LinRange(-10, 10, 1001)

plot3d!(xlabel="x₁'", ylabel="x₂'", zlabel="f(x')", subplot=1)
plot3d!(x1, x2, f, st = :surface, camera = (30, 40), label="Surface", subplot=1)
plot3d!(xs[:,1], xs[:,2], ys, markershape = :circle, label="Opt Trajectory", subplot=1)

# plot!(xlabel="x₁", ylabel="x₂", dpi=300, subplot=2)
# xlims!((-1,1), subplot=2)
# ylims!((-0.15,0.15), subplot=2)
contour!(x1, x2, f, label="Contour", subplot=2)
plot!(xs[:,1], xs[:,2], markershape = :circle, label="Opt Trajectory", subplot=2)
png("gdm2")