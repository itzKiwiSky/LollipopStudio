return function(c)
    local string_char = string.char
    local math_floor = math.floor
    if c <= 0x7f then
        return string_char(c)
    elseif c <= 0x7ff then
        return string_char(math_floor(c / 64) + 192, c % 64 + 128)
    elseif c <= 0xffff then
        return string_char(
            math_floor(c / 4096) + 224,
            math_floor(c % 4096 / 64) + 128,
            c % 64 + 128
        )
    elseif c <= 0x10ffff then
        return string_char(
            math_floor(c / 262144) + 240,
            math_floor(c % 262144 / 4096) + 128,
            math_floor(c % 4096 / 64) + 128,
            c % 64 + 128
        )
    end
    error(string_format("invalid UTF-8 code '%x'", c))
end