module AtDocStar

using Docile, Docile.Interface
@docstrings

@doc* "Generic docs for f." ->
f(x) = x

@doc "Method f specific docs." ->
f(x::Int) = x

@doc* "Generic docs for g." { :returns => (Bool,) } ->
g(x, y) = x < y

@doc "Method g specific docs." { :returns => (Bool,) } ->
g(x, y::Vector) = x ≤ minimum(y)

end

let results = query(AtDocStar.f; all = false)
    @test length(results) == 1
    
    mod, obj, ent = results.entries[1]
    @test docs(ent) == "Generic docs for f."
end

let results = @query AtDocStar.f(1)
    @test length(results) == 1
    
    mod, obj, ent = results.entries[1]
    @test docs(ent) == "Method f specific docs."
end

let results = query(AtDocStar.g; all = false)
    @test length(results) == 1
    
    mod, obj, ent = results.entries[1]
    @test docs(ent) == "Generic docs for g."
    @test metadata(ent)[:returns] == (Bool,)
end

let results = @query AtDocStar.g(1, [3, 4, 5])
    @test length(results) == 1
    
    mod, obj, ent = results.entries[1]
    @test docs(ent) == "Method g specific docs."
    @test metadata(ent)[:returns] == (Bool,)
end