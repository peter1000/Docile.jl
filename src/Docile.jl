"""
    Docile

> Documentation extensions for Julia.

**Package Exports:**

$(Utilities.exportlist(Docile))

"""
module Docile

include("Utilities.jl")

include(joinpath("Directives", "Directives.jl"))
include(joinpath("Docs",       "Docs.jl"))
include(joinpath("Doctests",   "Doctests.jl"))
include(joinpath("Build",      "Build.jl"))

# Public API.

import .Directives: @D_str, directive
export @D_str, directive

import .Docs: addhook
export addhook

import .Doctests: doctest, details
export doctest, details

import .Build: makedocs
export makedocs

end # module
