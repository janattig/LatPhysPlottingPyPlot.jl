################################################################################
#
#   module LatPhysPlottingPyPlot
#   -> PyPlot
#   -> LatPhysBase
#   -> LinearAlgebra
#
#   --> PLOTTING OF LATTICES WITH PYPLOT
#           - 2D lattices
#           - 3D lattices
#
################################################################################


# start of module
module LatPhysPlottingPyPlot


# used libraries
using LatPhysBase
using PyPlot




# Plotting of 2D lattices
include("lattice_plotting_2d.jl")

# Plotting of 3D lattices
include("lattice_plotting_3d.jl")


# end of module
end
