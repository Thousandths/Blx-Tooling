return {
    name = 'ping',
    defualt = 1,
    fn = function (message, arg)
        message.channel:send(
            string.format(
                'Pong, <arg> "%s"',
                arg or "no arg"
            )
        )
    end
}