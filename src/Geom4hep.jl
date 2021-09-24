module Geom4hep

export Point3, Vector3
export AbstractShape, AbstractMaterial
export Box, getindex, capacity, surface, extent, normal, distanceToOut, distanceToIn, inside, safetyToOut, safetyToIn, toMesh
export Material
export Transformation3D, RotMatrix3, one, isone, transform, hasrotation, hastranslation
export Volume, placeDaughter!, draw
export kTolerance

using StaticArrays, GeometryBasics, LinearAlgebra, Rotations

# basic stuff
Vector3 = SVector{3}
Base.:*(x::Vector3, y::Vector3) = Vector3(x[1]*y[1], x[2]*y[2], x[3]*y[3])
const kTolerance = 1e-9

# enums are neded to be exported
macro exported_enum(name, args...)
    esc(quote
        @enum($name, $(args...))
        export $name
        $([:(export $arg) for arg in args]...)
        end)
end
@exported_enum EInside kInside kSurface kOutside

abstract type AbstractShape{T<:AbstractFloat} end
abstract type AbstractMaterial{T<:AbstractFloat} end

const coordmap = Dict(:dx => 1, :dy => 2, :dz => 3)

include("Transformation3D.jl")
include("Box.jl")
include("Volume.jl")


end # module
