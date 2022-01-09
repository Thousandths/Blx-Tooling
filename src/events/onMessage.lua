local startwith = require('../utils/sw')
return {
    name = 'messageCreate',
    fn = function(message)
        local client = message.client

        if message.author == client.user then
            return
        end

        if not startwith(message.content, '!') then
            return
        end

        local parsed = {}
        for w in message.content:gmatch('%S+', 1) do
            parsed[#parsed+1] = w
        end

        local cmdname = parsed[1]:lower():sub(2)

        local command = client._commands[cmdname]
        
        -- !check for missing arguments
        -- !other checks are done in the
        -- !command it self
        local _, err = pcall(function () 
            local nargs = debug.getinfo(command.fn).nparams - (command.defualt or 0)

            if #parsed < (nargs) then
                local arg = debug.getlocal(command.fn, #parsed + 1)
                error({
                    message = string.format(
                        'Missing required argument `%s`',
                        tostring(arg)
                    ),
                    state=1
                })
            end
            table.remove(parsed, 1)
            command.fn(message, table.unpack(parsed))
        end)

        -- !err.state is used to
        -- !recognized errors raised
        -- !by me, anything else is
        -- !probably ignored or logged
        if err and err.state then
            message.channel:send(err.message)
        end
    end
}