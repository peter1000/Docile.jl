require(joinpath(dirname(@__FILE__), "ExampleAside.jl"))
require(joinpath(dirname(@__FILE__), "ExampleGlobal.jl"))
require(joinpath(dirname(@__FILE__), "Example.jl"))

import ExampleAside
import ExampleGlobal
import Example

import Docile: Cache
import Docile.Cache: getmod

facts("Cache.") do

    context("ExampleAside") do

        obj = Cache.objects(ExampleAside)[1]
        @fact getmod(obj) => ExampleAside

    end

    context("ExampleGlobal") do

        obj = Cache.objects(ExampleGlobal)[1]
        @fact getmod(obj) => ExampleGlobal

    end

    context("Example Modules.") do

        @fact getmod(Example.Example) => Example

    end

    context("Example Types.") do

        @fact getmod(Example.T_A_1)  => Example
        @fact getmod(Example.T_M_1)  => Example
        @fact getmod(Example.T_I_1)  => Example

    end

    context("Example Macros.") do

        @fact getmod(macrofunc(Example, "m_1")) => Example

    end

    context("Example Functions.") do

        @fact getmod(fmeth(Example.f_10)) => Example

    end

end
