return function(fn, t)
    local new = {}
    for i, v in ipairs(t) do
        if fn(v, i) then
            table.insert(new, v)
        end
    end

    return new
end