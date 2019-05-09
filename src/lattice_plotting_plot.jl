# generic lattice plotting
function plot(
    		lattice :: L
            ;
            site_labels :: Bool = false,
    		site_radius :: Real = 25,
    		bond_thickness :: Real = 8,
    		visualize_periodic :: Bool = false,
    		colorcode_sites :: Union{Symbol,Dict} = Dict(),
    		colorcode_bonds :: Union{Symbol,Dict} = Dict(),
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
    if typeof(colorcode_bonds) == Symbol
        if colorcode_bonds == :kitaev || colorcode_bonds == :Kitaev
            colorcode_bonds = generateBondColorcodeKitaev(lattice)
        else
            println("colorcode :$(colorcode_bonds) could not be built, using fallback")
            colorcode_bonds = Dict()
        end
    end
    if typeof(colorcode_sites) == Symbol
        println("colorcode :$(colorcode_sites) could not be built, using fallback")
        colorcode_sites = Dict()
    end

	# repair color dictonaries with fallback entries
	#colorcode_bonds[label_fallback_bond] = get(colorcode_bonds, label_fallback_bond, color_fallback_bond)
	#colorcode_sites[label_fallback_site] = get(colorcode_sites, label_fallback_site, color_fallback_site)



    ##########-------------------------------
    # STEP 2 #  Plotting
    ##########-------------------------------


    ############---------------------
    # STEP 2.1 #  Plot all Bonds
    ############---------------------

    # get all bond labels
    bond_label_list = unique!(label.(bonds(lattice)))
    # iterate over all bond labels
    for l in bond_label_list
        # get all bonds to that label
        bond_list = B[b for b in bonds(lattice) if label(b)==l && from(b)>to(b) && (!isPeriodic(b) || visualize_periodic)]
        color     = get(colorcode_bonds, l, color_fallback_bond)
        # plot the bonds
        plotBonds(
            bond_list,
            sites(lattice),
            bond_thickness,
            color;
            kwargs...
        )
    end




    ############---------------------
    # STEP 2.2 #  Plot all Sites
    ############---------------------

    # get all site labels
    site_label_list = unique!(label.(sites(lattice)))

    # iterate over all site labels
    for l in site_label_list
        # get all sites to that label
        site_list = S[s for s in sites(lattice) if label(s)==l]
        color     = get(colorcode_sites, l, color_fallback_site)
        # plot the site
        plotSites(
            site_list,
            site_radius,
            color;
            site_labels = site_labels,
            kwargs...
        )
    end

end

# export the plot function
export plot
