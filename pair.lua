

local function waitWlanConnect()
    while 1 do
        local res = fa.ReadStatusReg()
        local a = string.sub(res, 13, 16)
        a = tonumber(a, 16)
        if (bit32.extract(a, 15) == 1) then
            f:write("connect\n")
            break
        end
        if (bit32.extract(a, 0) == 1) then
            f:write("mode Bridge\n")
            break
        end
        if (bit32.extract(a, 12) == 1) then
            f:write("mode AP\n")
            break
        end
        sleep(2000)
    end
end

f = io.open("log.txt", "w")
waitWlanConnect()

local b, c, h = fa.request (
        'http://flashpair.azurewebsites.net/filelist.json?cid=11111',"GET" 
    )
local res = cjson.decode(b)
f:write(b)
f:write(b"\n")
f:write(c)
f:write(c"\n")


--[[
if (c == 200) then
        local cjson = require("cjson")
        local res = cjson.decode(b)
        cjson = nil
        if (res.error ~= nil) then
            f:write(res.error.message)
        else
            if (res.data.error ~= nil) then
                f:write(res.data.error.message)
            else
                f:write(res.data.message)
            end
        end
        f:write("success");
else
        f:write("fail");
end

--[[
]]


