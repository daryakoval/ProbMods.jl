using StatsPlots, StatsBase
function viz(values,label="",counted=false,sum=0,title="",xlabel="",ylabel="Frequency")
    if !counted
        datamap = countmap(values)
        normalizer=length(values)
    else
        datamap = values
        normalizer = sum
    end
    s = sort(collect(keys(datamap)))
    bar((x -> datamap[x]/normalizer).(s),xticks=(1:length(s), s),title=title,xlabel=xlabel,ylabel=ylabel,label=hcat(label),ygridalpha = 0.1)
end

function groupedviz(values,names,cats,num_groups,title="",xlabel="",ylabel="Frequency",legendtitle="",normalizer=0)
    normalizer_flag = normalizer != 0
    counts=zeros(num_groups,2)
    i::Int32=1
    for value in values
        datamap=countmap(value)
        if !normalizer_flag
            normalizer=length(value)
        end
        for item in datamap
            if item.first == cats[:1]
            counts[i,1]=item.second/normalizer
            else
            counts[i,2]=item.second/normalizer
            end
        end
        i=i+1
    end
    ctg = repeat(cats, inner = num_groups)    
    groupedbar(names, counts, group = ctg, xlabel = xlabel, ylabel = ylabel,
            title =title, bar_width = 0.67,legendtitle = legendtitle,
            lw = 0, framestyle = :box)
end
