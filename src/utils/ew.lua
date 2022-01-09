return function(str, snd)
    return string.sub(str, -#snd) == snd
end