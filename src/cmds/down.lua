local http = require('coro-http')

return {
    name = 't',
    fn = function (message, id, name)
        if not tonumber(id) then
            error({
                message = 'Invalid argument type, expected number',
                state=1
            })
        end
        message.channel:send('Here!')
    end
}