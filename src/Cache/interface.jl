const CACHE = GlobalCache()

"""
Get the raw docstrings associated with all documented objects in a module.
"""
getraw(m::Module) = getraw(CACHE, m)

"""
Get the raw docstring associated with a documented object ``obj`` in module ``m``.
"""
getraw(m::Module, obj) = getraw(CACHE, m, obj)

"""
Get the parsed docstrings associated with all documented objects in a module.
"""
getparsed(m::Module) = getparsed(CACHE, m)

"""
Get the parsed form of a docstring associated with an object ``obj``.

Automatically parses the raw docstring on demand when first called.
Subsequent calls will return the parsed docstring that has been cached.
"""
getparsed(m::Module, obj) = getparsed(CACHE, m, obj)

"""
Get the metadata dictionaries for all documented objects in a module.
"""
getmeta(m::Module) = getmeta(CACHE, m)

"""
Get the ``Dict{Symbol, Any}`` containing an object's metadata.
"""
getmeta(m::Module, obj) = getmeta(CACHE, m, obj)

"""
Get the ``PackageData`` object associated with a module ``m``.
"""
getpackage(m::Module) = getpackage(CACHE, m)

"""
Get the ``ModuleData`` object associated with a module ``m``.
"""
getmodule(m::Module) = getmodule(CACHE, m)

"""
Empty the documentation cache of all data.
"""
clear!() = empty!(CACHE)

"""
Return all documented objects found in a module ``m``.
"""
objects(m::Module) = objects(CACHE, m)

"""
Turn on documenting of ``Base`` and it's submodules. Off by default.
"""
togglebase() = togglebase(CACHE)

"""
Find the metadata ``field`` associated with an object ``obj`` in module ``m``.

When ``obj`` does not contain the field ``field`` then the module's metadata
and all it's parents are searched in turn. Finally the package's metadata is
searched for ``field``.
"""
findmeta(m::Module, obj, field::Symbol) = findmeta(CACHE, m, obj, field)

"""
Returns the set of all loaded modules.
"""
loadedmodules() = loadedmodules(CACHE)

"""
Returns the module where a documented object ``obj`` was defined.
"""
:getmod

getmod(obj::Module)          = obj
getmod(obj::Method)          = obj.func.code.module
getmod(obj::DataType)        = obj.name.module
getmod(obj::QualifiedSymbol) = obj.mod
getmod(obj::Aside)           = obj.mod

function getmod(obj::Function)
    if isgeneric(obj)
        isa(obj.env.defs, Void)                                                                   ?
            throw(ArgumentError("At least one method must be defined for a documented function")) :
            obj.env.defs.func.code.module
    else # Macro
        obj.code.module
    end
end
