################################################################################
#
#   PLOTTING SITES
#
################################################################################

# PLOTTING SITES IN 2D (but complex)
function plotSiteComplex(
            site    :: S,
            radius  :: Real,
            color   :: Vector{<:Integer}
            ;
            detail  :: Int64 = 21,
            kwargs...
        ) where {L,S<:AbstractSite{L,2}}

    # get the coordinates
    x = point(site)[1]
    y = point(site)[2]
    # Make data of sphere
    n = detail
    u = range(0,stop=2*pi,length=n);
    px = cos.(u);
    py = sin.(u);
    px = (px.*radius) .+ x
    py = (py.*radius) .+ y
    # Plot the surface of the sphere
    PyPlot.fill(px,py, color=color ./ 255)
end

# PLOTTING SITES IN 3D (but complex)
function plotSiteComplex(
            site    :: S,
            radius  :: Real,
            color   :: Vector{<:Integer}
            ;
            detail  :: Int64 = 7,
            kwargs...
        ) where {L,S<:AbstractSite{L,3}}

    # get the coordinates
    x = point(site)[1]
    y = point(site)[2]
    z = point(site)[3]
    # Make data of sphere
    n = detail
    u = range(0,stop=2*pi,length=n);
    v = range(0,stop=pi,length=n);
    px = cos.(u) * sin.(v)';
    py = sin.(u) * sin.(v)';
    pz = ones(n) * cos.(v)';
    px = (px.*radius) .+ x
    py = (py.*radius) .+ y
    pz = (pz.*radius) .+ z
    # Plot the surface of the sphere
    PyPlot.surf(px,py,pz, rstride=1, cstride=1, linewidth=0, antialiased=true, color=color ./ 255)
end

# PLOTTING SITES IN 2D
function plotSite(
            site    :: S,
            radius  :: Real,
            color   :: Vector{<:Integer}
            ;
            site_labels :: Bool = true,
            site_label_fontsize :: Real = 12,
            site_label_offset :: Vector{<:Real} = [0.1, 0.0],
            kwargs...
        ) where {L,S<:AbstractSite{L,2}}

    # get the coordinates
    x = point(site)[1]
    y = point(site)[2]
    # scatter the point
    PyPlot.scatter([x,],[y,], color=color./255)
    # maybe annotate the label as text
    if site_labels
        PyPlot.text(x+site_label_offset[1],y+site_label_offset[2], string(label(site)), fontsize=site_label_fontsize, color=color./255)
    end
end

# PLOTTING SITES IN 3D
function plotSite(
            site    :: S,
            radius  :: Real,
            color   :: Vector{<:Integer}
            ;
            site_labels :: Bool = true,
            site_label_fontsize :: Real = 12,
            site_label_offset :: Vector{<:Real} = [0.1, 0.0, 0.0],
            kwargs...
        ) where {L,S<:AbstractSite{L,3}}

    # get the coordinates
    x = point(site)[1]
    y = point(site)[2]
    z = point(site)[3]
    # scatter the point
    PyPlot.scatter3D([x,],[y,],[z,], color=color./255)
    # maybe annotate the label as text
    if site_labels
        PyPlot.text3D(x+site_label_offset[1],y+site_label_offset[2],z+site_label_offset[3], string(label(site)), fontsize=site_label_fontsize, color=color./255)
    end
end


# plotting based on scattering

# 2D
function plotSites(
            sites   :: Vector{S},
            radius  :: Real,
            color   :: Vector{<:Integer}
            ;
            site_labels :: Bool = true,
            site_label_fontsize :: Real = 12,
            site_label_offset :: Vector{<:Real} = [0.1, 0.0],
            kwargs...
        ) where {L,S<:AbstractSite{L,2}}

    # scatter the points
    PyPlot.scatter([point(s)[1] for s in sites],[point(s)[2] for s in sites], color=color./255, zorder=10)
    # maybe annotate the label as text
    if site_labels
        for site in sites
            PyPlot.text(point(site)[1]+site_label_offset[1],point(site)[2]+site_label_offset[2], string(label(site)), fontsize=site_label_fontsize, color=color./255)
        end
    end
end

# 3D
function plotSites(
            sites   :: Vector{S},
            radius  :: Real,
            color   :: Vector{<:Integer}
            ;
            site_labels :: Bool = true,
            site_label_fontsize :: Real = 12,
            site_label_offset :: Vector{<:Real} = [0.1, 0.0],
            kwargs...
        ) where {L,S<:AbstractSite{L,3}}

    # scatter the points
    PyPlot.scatter3D([point(s)[1] for s in sites],[point(s)[2] for s in sites],[point(s)[3] for s in sites], color=color./255)
    # maybe annotate the label as text
    if site_labels
        for site in sites
            PyPlot.text3D(point(site)[1]+site_label_offset[1],point(site)[2]+site_label_offset[2],point(site)[3]+site_label_offset[3], string(label(site)), fontsize=site_label_fontsize, color=color./255)
        end
    end
end

# 3D


# export the functions
export plotSite, plotSites, plotSiteComplex




################################################################################
#
#   PLOTTING BONDS
#
################################################################################

# PLOTTING BONDS IN 2D
function plotBond(
            site_from :: S,
            site_to   :: S,
            radius    :: Real,
            color     :: Vector{<:Integer}
            ;
            kwargs...
        ) where {L,S<:AbstractSite{L,2}}

    # get the coordinates
    x1 = point(site_from)[1]
    y1 = point(site_from)[2]
    # get the coordinates
    x2 = point(site_to)[1]
    y2 = point(site_to)[2]
    # plot a bond
    PyPlot.plot([x1,x2], [y1,y2], color=color./255)
end

# PLOTTING BONDS IN 3D
function plotBond(
            site_from :: S,
            site_to   :: S,
            radius    :: Real,
            color     :: Vector{<:Integer}
            ;
            kwargs...
        ) where {L,S<:AbstractSite{L,3}}

    # get the coordinates
    x1 = point(site_from)[1]
    y1 = point(site_from)[2]
    z1 = point(site_from)[3]
    # get the coordinates
    x2 = point(site_to)[1]
    y2 = point(site_to)[2]
    z2 = point(site_to)[3]
    # plot a bond
    PyPlot.plot3D([x1,x2], [y1,y2], [z1,z2], color=color./255)
end



# Plot bonds based on line collections
# https://gist.github.com/gizmaa/7214002#linecollection

# 2D
function plotBonds(
            bonds  :: Vector{B},
            sites  :: Vector{S},
            radius :: Real,
            color  :: Vector{<:Integer}
            ;
            kwargs...
        ) where {LS,S<:AbstractSite{LS,2},N,LB,B<:AbstractBond{LB,N}}

    # make a list of all lines
    lines = Vector{Tuple{Float64,Float64}}[]
    for b in bonds
        # get the coordinates to where the bond is pointing
        x1 = point(sites[from(b)])[1]
        y1 = point(sites[from(b)])[2]
        # get the coordinates to where the bond is pointing
        x2 = point(sites[to(b)])[1]
        y2 = point(sites[to(b)])[2]
        # push a new entry into the line list
        push!(lines, Tuple{Float64,Float64}[(x1,y1), (x2,y2)])
    end
    # make the collection
    line_collection = matplotlib[:collections][:LineCollection](lines,colors=[color./255 for i in 1:length(lines)])
    # plot a bond
    PyPlot.gca()[:add_collection](line_collection)
end

# 3D NOT IMPLEMENTED YET (so tempoerary fix)
function plotBonds(
            bonds  :: Vector{B},
            sites  :: Vector{S},
            radius :: Real,
            color  :: Vector{<:Integer}
            ;
            kwargs...
        ) where {LS,S<:AbstractSite{LS,3},N,LB,B<:AbstractBond{LB,N}}

    # plot all bonds individually
    for b in bonds
        plotBond(
            sites[from(b)],
            sites[to(b)],
            radius,
            color;
            kwargs...
        )
    end
end


# export the functions
export plotBond, plotBonds
