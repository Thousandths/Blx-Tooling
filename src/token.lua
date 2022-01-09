return (function ()
    local json = require('json')

    local t_file = io.open(
        './token.json',
        'r'
    )

    local token = t_file:read("a")
    token = json.parse(token)
    t_file:close()

    return token['token']
end)()