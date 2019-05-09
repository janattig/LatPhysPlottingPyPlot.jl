# generic lattice plotting in 3D (with fancy everything)
function plotLattice(
    		lattice :: L
            ;
            figsize :: Tuple{<:Real, <:Real} = (6,6),
            coordinate_system :: Bool = false,
            kwargs...
        ) where {LS,LB,N,S<:AbstractSite{LS,3},B<:AbstractBond{LB,N},U,L<:AbstractLattice{S,B,U}}

    # create a new figure
    fig = PyPlot.figure(figsize = figsize)

    # plot the lattice
    plot(lattice; kwargs...)

    # get the current axis
    ax = fig.gca()
    # turn off everthing but the plot
    if !coordinate_system
        ax.set_axis_off()
    end
    # equal aspect ratio
    ax.set_aspect("equal")
    # tighten layout
    tight_layout()
    # returns the figure
    return fig
end

# export plotting function
export plotLattice
