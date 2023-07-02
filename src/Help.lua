help = {}
local commands = require 'src.Commands'

function help.message()
    print(colors.BRIGHT_MAGENTA .. "Love" .. colors.RESET .. colors.CYAN .. "Studio" .. colors.RESET .. " A Command line interface for " .. colors.BRIGHT_MAGENTA .. "Love" .. colors.RESET .. colors.CYAN .. "2D" .. colors.RESET)
    print(colors.BRIGHT_WHITE .. "Version 0.0.1" .. colors.RESET)
    print("")
    for ct = 1, #commands, 1 do
        print("+ " .. colors.BRIGHT_WHITE .. commands[ct][1].category)
        for desc = 1, #commands[ct], 1 do
            io.write("\t| [" .. commands[ct][desc].name .. "] ")
            for alias = 1, #commands[ct][desc].alias, 1 do
                if #commands[ct][desc].alias > 0 then
                    io.write("" .. colors.BRIGHT_WHITE .. commands[ct][desc].alias[alias])
                    if alias < #commands[ct][desc].alias then
                        io.write(", ")
                    end
                end
            end
            io.write(string.format("\t\t\t%s\n", commands[ct][desc].description))
        end
    end
end

return help