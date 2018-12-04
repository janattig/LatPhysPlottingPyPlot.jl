# generic 3d lattice plotting
function plot(
    		lattice :: L
            ;
    		site_radius :: Real = 25,
            site_labels :: Symbol = :off,
    		bond_thickness :: Real = 8,
    		visualize_periodic :: Bool = false,
    		colorcode_sites :: Dict = Dict(),
    		colorcode_bonds :: Dict = Dict(),
            colorcode_bonds_automation :: Symbol = :off,
            colorcode_sites_automation :: Symbol = :off,
            background_color :: Vector{Int64} = [255,255,255],
            kwargs...
        ) where {LS,D,LB,N,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N},U,L<:AbstractLattice{S,B,U}}


    ##########-------------------------------
    # STEP 1 #  set the colors correctly
    ##########-------------------------------

    # set the fallback colors (site)
    color_fallback_site = Int64[50,50,50]
    label_fallback_site = getDefaultLabel(LS)

    # set the fallback colors (bond)
    color_fallback_bond = Int64[10,10,10]
    label_fallback_bond = getDefaultLabel(LB)

    # TODO automatically set dictonaries

	# repair color dictonaries with fallback entries
	#colorcode_bonds[label_fallback_bond] = get(colorcode_bonds, label_fallback_bond, color_fallback_bond)
	#colorcode_sites[label_fallback_site] = get(colorcode_sites, label_fallback_site, color_fallback_site)



    ##########-------------------------------
    # STEP 2 #  Plotting
    ##########-------------------------------


    ############---------------------
    # STEP 2.1 #  Plot all Bonds
    ############---------------------

    # iterate over all bonds
    for b in bonds(lattice)
        # check if b is skipped
        if from(b) > to(b)
            # skip if wrong directioin
            continue
        elseif N>0 && !visualize_periodic && sum([abs(w) for w in wrap(b)]) != 0
            # skip if periodic and no periodic plotting desired
            continue
        end
        # plot the bond
        plotBond(
            site(lattice,from(b)),
            site(lattice,to(b)),
            bond_thickness,
            get(colorcode_bonds, label(b), color_fallback_bond)
        )
    end




    ############---------------------
    # STEP 2.2 #  Plot all Sites
    ############---------------------

    # iterate over all sites
    for s in sites(lattice)
        # plot the site
        plotSite(
            s,
            site_radius,
            get(colorcode_sites, label(s), color_fallback_site)
        )
    end


    ############---------------------
    # STEP 2.3 #  TODO Plot all Labels
    ############---------------------
end

# export the plot function
export plot
