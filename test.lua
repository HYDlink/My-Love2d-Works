function tableWrap(...)
    values = {...}
    assert(#values == select('#', ...))
    for _, v in ipairs(values) do
        print(v)
    end
end

function iterPrint(...)
    for i = 1, select('#', ...) do
        -- 会把 i 位置之后的所有元素打印出来
        -- print(select(i, ...))
        local tmp = select(i, ...)
        print(tmp)
    end
end

iterPrint(1, 'haha', 5.34)
tableWrap(1, 'haha', 5.34)