module RegressionAndOtherStories

using Reexport

@reexport using CSV, DelimitedFiles, Unicode
@reexport using DataFrames, CategoricalArrays
@reexport using NamedArrays, DataStructures, NamedTupleTools
@reexport using Distributions, StatsBase, Statistics
@reexport using LinearAlgebra, LaTeXStrings, Dates

using AlgebraOfGraphics, Makie

# Direct access to the R repository "ROS-Examples"

"""

ros_data()

Base part of the path to datafiles in the R package ROS-Examples.
Return "" if `env_var` is not present in ENV.

## Positional argument
```julia
* `dataset::Union{AbstractString, Missing}` # Path to data in ROS-Examples
```

### Keyword arguments
```julia
* `env_var = "JULIA_ROS_HOME"` # Environment variable name
```

### Returns
```julia
* `path::AbstractString` # Path or "".
```

# Extended help

Examples:
```julia
ros_path()
ros_path("HDI")
```
"""
function ros_path(dataset::Union{AbstractString, Missing} = missing;
    env_var="JULIA_ROS_HOME")

    if haskey(ENV, env_var)
        ros_src_path = ENV["JULIA_ROS_HOME"]
    else
        @warn "JULIA_ROS_HOME environment variable not defined."
        return ""
    end
    if ismissing(dataset)
        normpath(ros_src_path)
    else
        normpath(joinpath(ros_src_path, dataset))
    end
end

"""

ros_data()

Construct the path to a datafile in the R package ROS-Examples.
Return "" if `env_var` is not present in ENV.

## Positional argument
```julia
* `dataset::AbstractString`
* `parts::Vector{AbstractString}` # Path to data file in 
```

### Keyword arguments
```julia
* `env_var = "JULIA_ROS_HOME"` # Environment variable name
```

### Returns
```julia
* `path::AbstractString` # Path or "".
```

# Extended help

Examples:
```julia
ros_data()
ros_data("HDI", "hdi.dat")
```
"""
function ros_data(dataset, parts...; env_var="JULIA_ROS_HOME") 
   if haskey(ENV, env_var)
        ros_src_path = ENV["JULIA_ROS_HOME"]
    else
        @warn "JULIA_ROS_HOME environment variable not defined."
        return ""
    end
    normpath(joinpath(ros_path(dataset), "data", parts...))
end

export
    ros_path,
    ros_data

# Access RegressionAndOtherStories.jl data files (.csv) using ros_datadir()
"""

# ros_datadir()

Path to the RegressionAndOtherStories.jl data files.

Construct the path to a dataset in RegressionAndOtherStories.jl.

## Positional argument
```julia
* `parts::Vector{AbstractString}` # Path to data file in 
```

### Returns
```julia
* `path::AbstractString` # Path or "".
```

# Extended help

Examples:
```julia
ros_datadir("ElectionsEconomy", "hibbs.dat")
```
or, to read in as a DataFrame:
```julia
hibbs = CSV.read(ros_datadir("ElectionsEconomy", "hibbs.csv"), DataFrame)
```

"""
function ros_datadir(parts...)
    normpath(@__DIR__, "..", "data", parts...)
end

export
    ros_datadir

include("General/model_summary.jl")
include("Makie/plot_chains.jl")

end # module
