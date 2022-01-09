local discordia = require('discordia')
local fs = require('fs')
local filter = require('./src/utils/filter')
local endswith = require('./src/utils/ew')
local client = discordia.Client()
local token = require('./src/token')

local function loadmode(path, reg)
    local exts = filter(
        function(v) return endswith(v, '.lua') end,
        fs.readdirSync(path)
    )

    if reg == 'commands' then 
        client['_'..reg] = {}
    end 

    for _, ext in pairs(exts) do
        ext = require(path..'/'..ext)
        if reg == 'commands' then 
            client['_'..reg][ext.name] = ext
        elseif reg == 'events' then 
            client:on(ext.name, ext.fn)
        end       
    end
end

loadmode('./src/cmds', 'commands')
loadmode('./src/events', 'events')


client:run("Bot "..token)