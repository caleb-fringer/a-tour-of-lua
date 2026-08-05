xml = [=[
<![CDATA[
    Hello world
]]> 
]=]

xml2 = "<![CDATA[\n\tHello World\n]]>"

--print(xml)
--print(xml2)

function insert(a, i, b)
    local firstHalf = a:sub(0, i-1)
    local secondHalf = a:sub(i, -1)
    return firstHalf .. b .. secondHalf
end

print(insert("Hello world",1, "start: "))

