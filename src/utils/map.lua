return function(fn, t) 
    local new = {}
    for i, v in ipairs(t) do
        table.insert(new, (fn(v, i)))
    end
    return new
end