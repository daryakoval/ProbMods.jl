using StatsPlots, StatsBase
function viz(values,label="",title="",xlabel="",ylabel="Frequency")
    datamap = countmap(values)
    s = sort(collect(keys(datamap)))
    bar((x -> datamap[x]/length(values)).(s),xticks=(1:length(s), s),title=title,xlabel=xlabel,ylabel=ylabel,label=hcat(label))
end

function groupedviz(values,names,cats,num_groups,title="",xlabel="",ylabel="Frequency",legendtitle="")
    N=0
    counts=zeros(num_groups,2)
    i::Int32=1
    for value in values
        datamap=countmap(value)
        N=length(value)
        for item in datamap
            if item.first == cats[:1]
            counts[i,1]=item.second/N
            else
            counts[i,2]=item.second/N
            end
        end
        i=i+1
    end
    ctg = repeat(cats, inner = num_groups)    
    groupedbar(names, counts, group = ctg, xlabel = xlabel, ylabel = ylabel,
            title =title, bar_width = 0.67,legendtitle = legendtitle,
            lw = 0, framestyle = :box)
end