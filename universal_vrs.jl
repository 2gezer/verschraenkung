using Gadfly
using DataFrames
using Distributions


s= String("1 1 1 0 1 0 1 0 1 0 0 1 0 1 0 0 1 1 0 1 1 0 1 0 1 0 1 1 1 1 1 1 0 0 1 0 1 1 0 1 1 0 1 0 0 1 0 0 0 1 1 0 1 1 1 0 0 1 1 0 0 1 1 0 0 0 1 0 0 1 1 1 1 1 0 0 0 1 0 0 0 0 1 1 0 0 0 0 0 1 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 0 1 0 1 0 1 0 1 0 1 1 1 0 1 1 1 1 1 1 1 0 1 1 0 1 1 1 0 0 0 1 0 1 0 0 1 1 1 1 1 0 0 0 0 1 1 1 1 1 0 1 0 1 0 0 0 0 1 1 0 0 0 0 1 1 0 0 1 0 0 0 1 1 1 1 1 1 1 1 1 0 0 1 0 0 0 1 0 0 0 0 1 0 0 1 1 1 1 0 0 0 1 0 1 0 1 0 1 1 1 0 0 0 0 1 1 1 1 0 1 1 0 0 1 1 1 1 0 0 0 1 1 1 1 1 1 0 0 1 1 0 1 0 0 1 1 0 1 1 1 0 1 1 0 0 0 0 0 1 1 1 1 0 1 0 1 1 0 1 1 1 0 0 0 1 1 0 0 0 0 1 0 1 1 0 1 1 0 0 0 1 0 1 0 0 0 1 0 0 0 0 1 1 1 0 0 1 1 1 0 1 1 1 0 0 1 0 1 1 1 1 0 1 0 0 1 0 0 1 1 0 0 1 0 1 0 0 1 0 0 1 0 1 1 1 0 1 0 1 0 1 1 1 1 1 0 0 1 1 0 0 1 1 0 0 0 0 1 0 0 0 0 1 1 1 1 0 1 1 0 0 1 1 1 0 1 1 0 1 1 0 1 1 0 0 1 1 1 0 0 1 0 1 0 1 1 0 1 0 0 1 0 0 1 1 0 1 0 0 1 1 1 1 1 1 1 1 1 0 1 1 1 0 0 1 0 1 0 1 1 1 0 1 0 0 1 0 0 0 0 1 1 1 0 1 1 0 0 1 0 0 1 0 0 0 1 1 1 0 0 0 1 1 0 1 1 0 0 0 1 0 1 1 1 0 1 1 1 0 0 0 1 0 1 1 0 0 1 1 0 0 0 1 0 0 1 0 0 1 1 1 0 1 0 0 0 1 0 1 1 0 0 1 1 0 1 1 0 0 0 0 0 1 0 1 0 1 0 0 0 1 1 1 1 0 0 0 1 1 0 1 0 1 0 1 0 0 0 1 1 0 0 1 1 0 0 1 0 1 0 0 1 0 1 0 1 0 1 1 1 1 1 0 1 1 0 1 1 1 1 1 0 1 1 0 0 0 0 1 0 0 1 0 1 0 0 0 0 1 0 1 0 1 0 0 1 0 0 1 0 1 0 0 0 1 1 0 0 1 1 1 1 0 0 0 0 1 0 0 0 1 1 0 0 0 1 0 0 1 0 1 0 1 1 0 1 0 0 1 1 1 0 1 1 1 0 1 0 0 0 1 1 0 1 1 1 1 0 0 1 0 1 1 1 0 0 1 0 1 0 0 1 0 0 0 1 1 1 0 1 0 1 0 0 1 1 1 1 1 1 0 1 1 0 1 0 1 0 1 1 1 1 1 1 1 0 0 1 0 0 1 1 1 0 1 0 1 0 0 0 1 1 0 1 1 0 0 1 0 0 1 1 1 1 1 1 1 0 1 0 0 1 0 1 0 1 0 1 1 1 0 1 1 0 0 0 0 1 1 0 0 0 1 0 1 1 0 1 1 0 0 0 1 0 0 0 0 0 1 1 0 0 0 1 0 0 0 1 0 0 0 1 0 0 0 1 0 1 0 0 1 0 0 1 0 1 0 1 1 0 0 1 1 0 1 0 0 0 0 0 0 1 0 1 0 0 0 0 1 1 0 1 0 1 0 0 0 0 1 0 0 0 0 1 0 1 1 1 1 0 1 0 1 1 1 1 0 0 0 0 0 1 1 0 1 1 0 0 1 0 1 1 1 1 0 0 1 0 0 1 0 0 0 0 1 0 1 1 1 1 0 1 0 1 0 0 1 0 1 1 1 0 0 0 0 1 0 1 1 0 1 0 0 1 0 1 1 1 0 1 1 0 0 1 0 0 1 1 0 1 0 1 1 0 0 1 0 1 0 1 1 1 1 0 0 0 0 0 0 1 0 0 1 1 1 0 0 0 1 0 0 0 0 0 0 1 0 1 0 0 0 0 1 0 0 0 1 0 1 0 0 1 1 0 0 0 1 1 1 1 1 1 1 1 0 0 0 1 1 1 0 1 1 0 1 1 1 0 1 1 0 0 1 0 0 0 0 0 0 1 0 1 1 1 1 1 1 0 1 1 1 1 1 0 1 0 1 1 0 1 0 1 1 1 1 1 0 1 1 1 0 0 0 0 0 1 1 0 1 0 1 0 0 1 0 0 0 0 0 0 1 0 1 1 0 1 1 1 0 0 0 0 1 1 0 0 0 1 1 0 0 0 0 1 1 0 1 0 1 0 1 0 1 1 0 0 1 0 1 1 0 1 1 1 1 1 0 1 0 1 1 1 0 1 1 0 1 1 1 0 1 0 1 1 1 1 0 0 0 1 1 0 1 0 0 1 1 0 1 1 1 0 0 1 1 0 0 0 1 0 1 0 0 1 0 1 1 0 0 1 0 1 0 1 1 1 1 0 0 0 1 1 1 0 1 1 1 0 0 1 1 0 1 1 1 1 1 0 1 0 0 1 1 1 0 0 0 1 1 0 1 1 0 1 0 1 0 0 1 1 0 1 1 1 0 0 1 0 0 0 0 1 1 0 0 0 1 1 0 1 0 1 0 1 0 1 1 0 1 1 0 1 0 0 1 1 0 0 0 0 0 0 0 0 0 0 1 1 1 0 0 0 1 1 0 0 1 0 0 0 0 1 0 0 1 0 1 1 0 0 0 1 1 1 0 0 1 0 0 1 1 1 0 1 0 1 1 1 0 1 0 0 1 0 1 0 0 0 1 0 0 1 1 1 1 0 0 0 1 0 1 0 1 0 0 0 0 1 0 1 1 0 0 1 1 1 1 1 0 0 1 1 0 1 0 0 0 0 1 1 0 0 0 1 0 1 0 1 0 1 1 0 0 0 1 1 0 1 1 1 1 0 0 0 1 1 1 0 1 0 0 1 0 0 0 1 0 0 1 0 1 1 0 0 0 0 0 1 0 0 0 1 1 0 1 0 0 0 1 0 0 0 0 0 0 0 1 0 1 1 1 0 1 1 1 0 0 1 1 1 1 1 1 1 0 0 1 0 1 1 0 0 0 1 1 0 1 1 0 0 0 1 1 1 1 1 0 1 1 0 1 1 1 0 0 1 1 1 1 1 0 1 0 0 1 0 1 1 0 0 0 0 1 0 1 1 1 0 1 1 1 1 0 0 0 1 0 1 1 0 1 0 1 0 1 1 0 1 0 1 0 0 1 1 0 1 1 1 1 1 0 0 0 0 0 1 1 1 1 1 0 1 0 1 0 0 0 0 1 1 0 1 0 1 1 0 0 0 1 0 0 0 0 1 1 0 0 0 0 1 0 0 1 1 1 0 0 1 0 1 1 0 1 1 0 1 0 1 1 0 0 1 1 1 0 0 0 0 1 0 1 1 0 1 0 0 1 0 1 0 1 1 0 0 0 0 0 0 0 1 1 1 0 1 1 0 1 0 1 0 0 0 0 0 1 1 1 0 0 1 1 0 1 1 0 1 1 0 1 1 1 0 1 0 1 0 0 0 0 1 1 1 1 1 0 1 0 0 0 1 1 0 0 0 0 0 1 1 0 0 1 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 1 1 1 1 1 0 0 0 0 0 1 1 0 1 1 1 0 1 1 1 1 0 0 0 0 1 0 0 0 1 1 1 0 1 0 0 1 1 0 0 0 1 1 1 1 1 0 0 1 0 0 1 0 0 0 0 0 0 1 0 0 0 0 0 0 1 1 1 1 0 1 0 0 1 0 1 0 1 1 0 0 0 0 0 0 1 1 0 0 1 1 0 0 1 0 1 1 1 1 1 1 1 0 1 0 0 0 1 1 1 1 0 0 0 0 1 0 1 1 1 0 1 0 0 0 1 1 1 1 1 1 1 0 1 0 1 0 1 0 1 1 1 0 1 0 1 0 0 1 1 0 1 0 0 0 1 1 0 1 1 1 0 0 1 1 1 1 1 0 1 1 1 0 1 0 1 0 0 1 0 1 1 1 0 1 1 0 0 0 1 0 1 1 1 1 1 1 1 0 1 1 0 0 1 1 1 1 0 0 1 0 1 0 0 1 1 1 0 1 0 1 1 1 0 1 1 0 0 1 0 1 0 1 1 1 0 0 0 0 0 1 1 1 0 1 0 0 0 0 0 0 1 1 0 1 0 1 1 1 0 1 0 0 1 1 1 1 1 1 0 1 0 0 0 1 0 0 0 1 1 0 1 0 0 1 1 1 0 1 1 1 1 1 1 1 0 0 1 0 1 1 1 1 0 0 0 1 0 0 0 1 1 1 0 1 0 0 0 0 1 1 1 0 0 1 0 0 1 1 0 0 0 1 0 0 1 1 1 0 0 0 0 0 0 1 1 0 1 0 1 0 1 0 0 1 0 1 0 0 0 0 0 0 0 0 0 0 1 1 1 1 0 1 1 0 0 0 1 1 0 1 1 1 1 1 0 1 0 1 1 1 0 0 0 1 0 1 0 0 1 0 1 1 0 1 1 0 1 0 0 0 0 1 0 0 0 1 1 1 0 1 0 0 1 1 1 0 1 0 0 0 1 1 1 1 0 0 1 1 0 1 0 0 1 1 1 0 1 0 0 0 0 1 1 1 0 1 0 0 0 0 1 0 0 1 1 0 1 0 1 1 1 1 1 1 1 1 1 1 1 1 0 1 0 1 1 0 0 0 1 1 0 0 1 1 0 1 0 1 1 0 0 1 0 1 0 1 1 1 1 1 1 0 0 0 0 0 1 0 1 1 1 0 0 0 0 1 0 1 1 1 1 1 0 0 1 1 1 0 0 1 0 1 1 0 0 0 1 0 0 0 0 0 0 0 0 0 1 1 0 1 1 0 1 0 0 1 1 1 0 0 1 0 1 1 1 0 1 0 0 1 1 1 0 0 0 0 1 1 0 1 0 0 1 0 1 1 0 0 0 1 0 0 1 1 0 0 1 1 1 0 1 0 1 1 0 1 0 1 1 1 0 1 0 1 1 1 1 0 1 1 1 1 0 0 0 1 0 0 1 0 0 1 1 1 0 0 0 1 0 0 0 1 0 1 0 0 0 0 0 1 1 0 0 1 1 0 0 1 1 0 1 0 0 1 1 0 0 1 0 1 0 1 1 1 1 0 0 0 1 0 0 1 0 1 0 0 0 0 0 1 0 0 1 0 0 0 0 0 1 0 0 0 0 0 0 1 1 0 1 0 1 1 1 0 1 1 0 0 0 1 0 0 1 1 1 0 0 0 0 0 0 0 1 0 1 1 1 0 0 0 0 1 0 1 0 0 0 0 1 1 0 1 1 0 1 1 0 0 1 1 1 1 0 1 0 0 1 1 1 1 0 1 0 0 0 0 1 1 0 1 1 0 1 1 1 0 1 0 0 1 0 0 1 0 0 1 1 0 1 0 0 1 1 1 1 0 0 1 0 0 1 0 0 1 0 1 1 0 0 0 1 0 0 0 1 1 0 1 1 1 1 1 0 1 1 1 1 1 1 0 0 1 0 1 0 0 0 0 0 1 1 1 1 1 0 0 1 1 1 0 1 0 1 0 1 1 1 0 0 0 1 1 0 1 0 0 0 0 0 1 0 0 0 1 0 1 0 1 0 0 0 0 1 0 1 1 1 0 1 0 0 1 1 0 1 1 0 1 1 0 1 0 1 0 0 1 1 1 0 1 1 0 0 0 1 1 1 1 1 0 1 0 0 1 0 1 1 1 1 1 0 1 1 0 0 1 0 0 1 1 0 0 0 1 1 1 1 0 0 0 1 0 0 1 0 1 0 0 0 1 1 0 1 1 0 0 1 1 1 1 0 1 1 1 0 0 0 1 1 1 1 1 1 1 1 0 1 1 0 1 1 0 1 1 1 0 0 1 0 1 1 1 0 0 1 0 0 1 0 0 1 0 1 1 0 0 1 0 0 1 0 1 1 0 1 0 1 1 0 0 0 0 1 1 1 1 1 0 1 0 1 0 0 1 1 0 1 1 1 0 0 0 1 1 0 1 1 0 0 1 0 1 1 1 1 0 1 1 0 1 0 0 1 1 1 1 1 1 1 1 1 1 0 1 1 1 0 0 0 1 0 0 1 0 1 0 0 0 1 1 1 0 1 1 0 0 1 0 1 1 1 0 1 0 1 1 0 0 0 0 0 1 0 0 0 0 1 0 0 1 1 0 1 1 0 0 1 1 1 1 1 1 0 0 0 1 1 0 0 1 1 1 0 0 1 0 0 0 0 0 0 0 1 1 1 0 1 1 0 0 0 1 0 0 1 1 0 1 0 1 1 1 0 0 0 0 0 1 1 0 1 1 0 1 0 1 1 1 1 0 0 1 0 0 1 0 0 0 1 0 1 0 1 0 1 1 0 0 1 0 1 1 1 1 0 1 0 0 1 1 0 0 1 1 0 1 1 0 1 0 1 0 0 0 1 1 1 0 1 1 1 0 0 0 1 1 0 1 1 1 0 1 0 1 1 0 1 1 1 1 0 1 1 1 1 1 1 0 1 1 1 1 1 0 0 1 0 0 0 1 0 0 0 0 1 1 0 1 1 0 0 1 0 0 0 1 1 0 1 0 0 0 1 1 0 1 0 0 1 0 1 1 0 1 1 1 1 1 0 1 0 1 1 0 0 1 1 0 1 0 1 1 1 0 1 0 0 1 0 0 1 0 1 0 1 0 1 0 0 1 0 0 0 0 1 0 0 1 1 1 1 0 1 1 0 1 0 1 0 0 1 1 1 0 0 0 1 1 0 1 0 1 0 1 0 1 0 1 1 1 0 0 0 0 1 1 1 1 0 1 1 1 1 0 0 1 0 0 1 1 0 1 1 1 0 0 1 0 0 1 1 1 0 0 0 0 0 1 0 0 1 1 1 1 1 1 0 0 0 0 1 0 1 1 1 0 0 0 0 1 0 0 1 1 1 0 0 0 1 1 0 0 1 0 1 0 1 0 1 1 0 0 1 0 0 0 1 1 0 1 1 1 0 0 0 1 1 0 0 0 0 1 0 0 1 1 0 0 0 0 0 0 0 1 0 1 0 1 1 0 0 0 0 1 1 0 0 1 1 1 1 1 1 1 0 1 0 0 0 1 1 1 0 1 1 0 1 1 1 1 0 1 0 1 1 1 0 1 0 1 1 1 1 0 0 0 1 0 1 1 1 0 0 1 0 1 1 0 0 0 1 1 0 1 0 1 1 1 0 0 0 0 1 1 1 1 0 0 1 0 0 1 0 0 1 1 0 0 1 0 0 1 1 0 1 0 1 1 1 0 0 1 1 0 1 0 1 0 0 0 0 0 1 0 0 1 1 1 0 1 1 1 0 0 0 1 0 1 1 1 0 0 0 1 1 0 1 0 0 0 0 0 0 1 0 0 0 1 1 1 1 0 1 1 0 1 0 1 1 1 1 1 1 1 0 0 0 1 1 0 1 0 1 1 1 1 1 0 0 1 1 1 0 0 1 1 1 0 1 1 0 1 1 0 1 0 1 1 0 1 1 0 0 1 1 0 1 1 0 0 1 0 1 1 0 1 0 0 1 1 1 0 1 0 1 0 1 0 1 1 0 0 0 1 0 1 1 1 0 0 0 0 1 1 1 0 1 0 0 1 1 1 1 0 0 1 1 1 1 0 1 0 0 1 0 1 1 0 0 0 0 1 1 0 1 0 1 1 1 1 1 1 0 1 1 0 0 0 0 0 0 1 1 0 0 0 0 1 1 0 1 0 1 0 0 1 0 1 1 1 1 1 1 1 0 0 1 1 1 0 1 1 1 1 0 1 0 1 0 0 1 1 1 0 0 0 1 0 1 1 0 1 0 1 1 1 0 1 0 0 1 0 1 0 0 0 0 1 1 0 0 1 1 1 0 1 1 0 0 1 0 1 1 0 0 1 0 1 0 1 1 1 0 1 1 1 1 1 0 1 0 0 0 0 1 1 0 0 0 0 1 1 0 1 0 0 0 0 1 0 1 0 0 0 1 1 1 1 1 1 0 0 0 1 1 0 1 1 1 0 1 0 0 0 0 1 0 0 0 0 0 1 0 1 1 0 0 0 1 0 0 0 0 1 1 1 0 0 1 1 0 1 1 0 1 1 0 0 1 0 1 0 1 0 1 0 0 1 1 1 1 0 0 0 1 0 0 1 0 0 0 0 1 1 0 1 1 0 1 1 0 1 0 1 1 0 1 0 1 1 1 0 0 0 1 1 0 1 1 0 1 0 1 0 1 1 0 1 1 0 1 0 1 1 0 1 0 0 1 1 1 0 0 1 1 1 0 1 0 1 1 1 1 0 0 0 1 1 0 1 1 0 0 0 0 1 0 0 0 1 0 1 0 1 0 1 1 1 0 0 1 0 1 0 0 0 1 1 1 1 1 1 0 1 1 0 1 1 1 0 0 0 0 1 0 0 0 0 0 0 1 0 1 0 0 1 1 0 0 1 0 0 1 0 1 0 1 0 1 0 1 0 1 0 1 1 0 0 0 0 1 1 0 1 1 1 1 0 0 1 1 0 0 0 0 1 1 0 1 1 0 1 0 0 1 0 1 0 0 1 0 0 1 0 1 1 1 1 1 0 0 0 0 0 1 0 0 1 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 1 0 0 1 0 0 0 1 1 0 1 0 0 1 0 0 0 0 0 0 1 1 0 0 1 0 0 0 1 1 1 0 0 1 1 0 1 0 0 1 0 0 0 1 0 1 0 0 0 0 1 0 1 1 0 0 0 1 0 0 0 1 1 1 0 1 0 0 0 1 0 0 0 1 0 1 0 0 0 0 0 1 1 1 1 0 1 1 1 0 1 0 0 0 0 1 1 0 0 1 1 1 1 1 0 1 0 1 0 0 0 1 0 0 1 1 1 1 1 1 1 0 0 1 0 0 0 1 1 0 0")


function imp(x::String,N,a)
  b=N-a
  number = readdlm(IOBuffer(x), Int)
  s= zeros(2^a,2^b)
 for i in 1:(2^a*2^b)
   s[i] = number[rand(1:length(number))]
   if s[i]== 1 && rand(Binomial(1,0.5))==1
     s[i]=-1
   end
 end
 s = s/norm(s)
 return s
 end


#Stelle einen zufaellig praeparierten Zustand auf mit julia random
function PsiRand(N,a)
  #Plaetzverteilung kan beliebig gewaehlt werden
  b = (N-a)

  #erstelle einen zufaelligen Zustand zunächst ohne  Koeffizienten
  state = rand(0:1,2^a,2^b)  #Binomial(), Poisson, Gauß-Verteilungen ausprobieren

  #Normiere: |a|^2+|b|^2 =1
  nState= state/norm(state)

  return nState
end

#Stelle einen zufaellig praeparierten Zustand auf mit  mit Koeffiziente im offenen Intervall (-1,1)
function PsiUni(N,a)
  #Plaetzverteilung kan beliebig gewaehlt werden
  b = (N-a)

  #erstelle einen zufaelligen Zustand
  state = rand(Uniform(-1,1),2^a,2^b)

  #Normiere: |a|^2+|b|^2 =1
  nState= state/norm(state)

  return nState
end

#Berechne die reduzierte Dichtematrix mit ρ = ∑ ψ_ij*ψ_i'j
function rho(N,a)
  ρ::Array{Float64,2} = zeros(2^a,2^a)
  for i in 1:size(N)[1]
    for k in 1:size(N)[1]
      for j in 1:size(N)[2]
        ρ[i,k]+= sum(N[i,j]*N[k,j])
      end
    end
  end
  return ρ
end


function vrs(N)
  w::AbstractArray = eigvals(N)
  V::Float64 = 0
  for i = 1:length(w)
    if 0> w[i] <-1.0e-14
      println(w[i])
      throw("eigenwert ist negativ")
    elseif abs(w[i]) < 1.0e-5
      w[i] = 0.0
    else
      V += (w[i]*log(w[i]))
    end
  end
  return V
end
#statistik der randomverteilung
function statV(N,a)
  l=2000
  x= zeros(l)
  V::Float64 = 0
  for i in 1:l
    K=PsiRand(N,a)
    V= abs(vrs((rho(K,a))))
    if V<1.0e-14
      println("Keine Verschränkung bei Zustand ", K)
    end
    x[i]=V
  end
  return x
end
#statistik der Uniform verteilten Zahlen
function statU(N,a)
  l=2000
  x= zeros(l)
  V::Float64 = 0
  for i in 1:l
    K=PsiUni(N,a)
    V= abs(vrs((rho(K,a))))
    if V<1.0e-14
      println("Keine Verschränkung bei Zustand ", K)
    end
    x[i]=V
  end
  return x
end
#Statistik der Zufallsverteilung
function statZ(N,a)
  l=2000
  x= zeros(l)
  V::Float64 = 0
  for i in 1:l
    K=imp(s,N,a)
    V= abs(vrs((rho(K,a))))
    if V<1.0e-14
      println("Keine Verschränkung bei Zustand ", K)
    end
    x[i]=V
  end
  return x
end

#Dataframe
function statS(N)
  df = DataFrame(a1 = statV(N,1), a2 = statV(N,2), a3 =statV(N,3), a4 =statV(N,4), a5=statV(N,5))

  return df
end

#Plot der Verschränkung von random
function plt(N,a)
  b= N-a
  #Lösche die Eintraege aus vorheriger Schleife
  x = copy(statV(N,a))
  xm = floor(mean(x),4)

  #Plotting Theme
  blankTheme = Theme(
  grid_color=colorant"grey",
  panel_fill=colorant"white",
  major_label_color=colorant"black",
  minor_label_color=colorant"black",
  major_label_font_size=16pt,minor_label_font_size=14pt)
  plot_padding= 7pt



  x[1]=0
  x[end]=2.5
  p = plot(x=x , y=1:length(x), Guide.title("Verschränkung zufälliger Zustände bei $N Plätzen"),
  Guide.XLabel("Aufteilung der Plätze in A= $a, B= $b \n Mittelwert von V = $xm "),Guide.YLabel("Haeufigkeit"),
  blankTheme, Geom.histogram(bincount= floor(1000*log(2))))
   img = PDF("plotV/Verschraenkung $N _$a.pdf", 8inch, 6inch)
   draw(img, p)
  return p
end

#Plot Verschränkung von zufall
function pltZ(N,a)
  b= N-a
  #Lösche die Eintraege aus vorheriger Schleife
  x = copy(statZ(N,a))
  xm = floor(mean(x),4)

  #Plotting Theme
  blankTheme = Theme(
  grid_color=colorant"grey",
  panel_fill=colorant"white",
  major_label_color=colorant"black",
  minor_label_color=colorant"black",
  major_label_font_size=16pt,minor_label_font_size=14pt)
  plot_padding= 7pt



  x[1]=0
  x[end]=2.5
  p = plot(x=x , y=1:length(x), Guide.title("Verschränkung zufälliger Zustände bei $N Plätzen"),
  Guide.XLabel("Aufteilung der Plätze in A= $a, B= $b \n Mittelwert von V = $xm "),Guide.YLabel("Haeufigkeit"),
  blankTheme, Geom.histogram(bincount= floor(1000*log(2))))
   img = PDF("plotZ/Verschraenkung $N _$a.pdf", 8inch, 6inch)
   draw(img, p)
  return p
end

#Plot der Verschränkung von uniform verteilten zahlen(0,1)
function pltU(N,a)
  b= N-a
  #Lösche die Eintraege aus vorheriger Schleife
  x = copy(statU(N,a))
  xm = floor(mean(x),4)

  #Plotting Theme
  blankTheme = Theme(
  grid_color=colorant"grey",
  panel_fill=colorant"white",
  major_label_color=colorant"black",
  minor_label_color=colorant"black",
  major_label_font_size=16pt,minor_label_font_size=14pt)
  plot_padding= 7pt



  x[1]=0
  x[end]=2.5
  p = plot(x=x , y=1:length(x), Guide.title("Verschränkung zufälliger Zustände bei $N Plätzen"),
  Guide.XLabel("Aufteilung der Plätze in A= $a, B= $b \n Mittelwert von V = $xm "),Guide.YLabel("Haeufigkeit"),
  blankTheme, Geom.histogram(bincount= floor(1000*log(2))))
   img = PDF("plotV_Uniform/Verschraenkung $N _$a.pdf", 8inch, 6inch)
   draw(img, p)
  return p
end
