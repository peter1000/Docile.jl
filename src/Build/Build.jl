"""
    Build

> Generate static markdown documentation from templated files.

"""
module Build

using Base.Meta, ..Utilities, ..Docs, ..Directives

export makedocs

include("loadfile.jl")
include("makedocs.jl")

end