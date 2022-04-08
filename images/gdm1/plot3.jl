using Plots

## define functions
f(x::Float64) = x^2
df(x::Float64) = -sign(x)
α(i::Int64) = 2.0 + 3.0 * ( 2.0^(-i+1) )
β(i::Int64) = 2.0^(-i+1)

## initialisation
imax = 20
xs = zeros(imax)
xs[1] = 2

for i=2:imax
    xs[i] = xs[i-1] + df(xs[i-1]) * α(i)
end
ys = f.(xs)

## plot3d
gr()
plot(dpi=300, size=(600,350), xlabel="x", ylabel="f(x)=x²", layout=(1,2))
xx = LinRange(-2.2, 2.2, 1001)
yy = f.(xx)
plot!(xx, yy, subplot=1, label="")
plot!(xs, ys, markershape = :circle, label="Opt Trajectory", subplot=1)

for i=2:imax
    xs[i] = xs[i-1] + df(xs[i-1]) * β(i)
end
ys = f.(xs)

plot!(xx, yy, subplot=2, label="")
plot!(xs, ys, markershape = :circle, label="Opt Trajectory", subplot=2)
png("gdm3")