# generic lattice plotting in 3D (with fancy everything)
function plotLattice(
    		lattice :: L
            ;
            figsize :: Tuple{<:Real, <:Real} = (6,6),
            coordinate_system :: Bool = false,
            kwargs...
        ) where {LS,LB,N,S<:AbstractSite{LS,3},B<:AbstractBond{LB,N},U,L<:AbstractLattice{S,B,U}}

    # make a copy of the lattice
    lattice = deepcopy(lattice)
    # shift the new lattice to the center
    center = sum(point.(sites(lattice))) ./ length(sites(lattice))
    for s in sites(lattice)
        point!(s, point(s) .- center)
    end

    # create a new figure
    fig = PyPlot.figure(figsize = figsize)

    # plot the lattice
    plot(lattice; kwargs...)

    # get the limits
    max_value = maximum([abs(p[i]) for i in 1:3 for p in point.(sites(lattice))])
    # set the axis limits
    xlim(-max_value, max_value)
    ylim(-max_value, max_value)
    zlim(-max_value, max_value)

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
    # reduce the boundaries
    fig.subplots_adjust(bottom=0, top=1, right=1, left=0)
    # returns the figure
    return fig
end

# export plotting function
export plotLattice
