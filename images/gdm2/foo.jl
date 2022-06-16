using Optim
using Plots
using LineSearches

f(x) = (1.0 - x[1])^2 + 100.0 * (x[2] - x[1]^2)^2

x = LinRange(-0.7, 1.1, 101)
y = LinRange(-0.1, 1.1, 101)
fig = plot(dpi=300, title="Rosenbrock", xlabel="x", ylabel="y", legend=:topleft)
fig = contour!(x, y, (x,y) -> f([x,y]), levels=30)

start = [-0.5, 0.5]

res1 = optimize(f, start, BFGS(),
	Optim.Options(
		store_trace=true,
		extended_trace=true,
		)
	)
trace1 = mapreduce(permutedims, vcat, Optim.x_trace(res1))
fig = plot!(trace1[:,1], trace1[:,2], marker=:circle, label="BFGS ($(size(trace1,1)) iterations)", alpha=0.5, markersize=2, markeralpha=0.5, markerstrokewidth=0.3)

algo_gd_hz = GradientDescent(;alphaguess = LineSearches.InitialStatic(), linesearch = LineSearches.HagerZhang())
res2 = optimize(f, start, algo_gd_hz,
	Optim.Options(
		store_trace=true,
		extended_trace=true,
		)
	)
trace2 = mapreduce(permutedims, vcat, Optim.x_trace(res2))
fig = plot!(trace2[:,1], trace2[:,2], marker=:circle, label="GD w/ Line Search ($(size(trace2,1)) iterations)", alpha=0.5, markersize=2, markeralpha=0.5, markerstrokewidth=0.3)

res3 = optimize(f, start, GradientDescent(),
	Optim.Options(
		store_trace=true,
		extended_trace=true,
		)
	)
trace3 = mapreduce(permutedims, vcat, Optim.x_trace(res3))
fig = plot!(trace3[:,1], trace3[:,2], marker=:circle, label="GD ($(size(trace3,1)) iterations)", alpha=0.5, markersize=2, markeralpha=0.5, markerstrokewidth=0.3)

# savefig(fig, "BFGS.png")