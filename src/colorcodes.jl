# function to generate a Kitaev colorcode
function generateBondColorcodeKitaev(
        lattice :: L
    ) :: Dict{LB,Vector{Int64}} where {LS,D,LB,N,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N},U,L<:AbstractLattice{S,B,U}}

    # put the default kitaev labels with default colors into a dictonary
    return Dict{LB,Vector{Int64}}(
        getDefaultLabelX(LB) => [255,0,0],
        getDefaultLabelY(LB) => [0,255,0],
        getDefaultLabelZ(LB) => [0,0,255]
    )
end

# function to generate a Kitaev colorcode
function generateBondColorcodeRandom(
        lattice :: L
    ) :: Dict{LB,Vector{Int64}} where {LS,D,LB,N,S<:AbstractSite{LS,D},B<:AbstractBond{LB,N},U,L<:AbstractLattice{S,B,U}}

    # put the default kitaev labels with default colors into a dictonary
    d = Dict{LB,Vector{Int64}}()
    # insert all labels
    for lb in label.(bonds(lattice))
        d[lb] = round.(Int64,[rand()*255, rand()*255, rand()*255])
    end
    # return the colorcode dict
    return d
end
