# LatPhysPlottingPyPlot.jl

Lattice plotting for the main module [`LatticePhysics.jl`](https://github.com/janattig/LatticePhysics.jl).



## Contents

Provides the plotting in PyPlot for [`LatticePhysics.jl`](https://github.com/janattig/LatticePhysics.jl) for the following types:
1.  `AbstractSite`
2.  `AbstractBond`
3.  `AbstractUnitcell`


## Installation

You can install the package via the package mode in Julia (Pkg). However, since the package
is not listed in the Julia package repositories, you have to first install the unregistered
dependencies manually. To do so, first install [`LatticePhysics.jl`](https://github.com/janattig/LatticePhysics.jl) as specified on its Readme file. Then install the main package with
```julia
(v1.0) pkg> add "https://github.com/janattig/LatPhysPlottingPyPlot.jl"
```
