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
        PyPlot.text(x+site_label_offset[1],y+site_label_offset[2], string(label(site)), fontsize=site_label_fontsize)
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
        PyPlot.text3D(x+site_label_offset[1],y+site_label_offset[2],z+site_label_offset[3], string(label(site)), fontsize=site_label_fontsize)
    end
end


# export the functions
export plotSite, plotSiteComplex




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

# export the functions
export plotBond
