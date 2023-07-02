help = {}
local commands = require 'src.Commands'

function help.message()
    print(colors.BRIGHT_MAGENTA .. "Love" .. colors.RESET .. colors.BRIGHT_CYAN .. "Studio" .. colors.RESET .. colors.BRIGHT_WHITE .. " A Command line interface for " .. colors.BRIGHT_MAGENTA .. "LÖVE" .. colors.RESET)
    print(colors.BRIGHT_WHITE .. "Version " .. _Version .. colors.RESET)
    print("")
    for ct = 1, #commands, 1 do
        print("[+] " .. colors.BRIGHT_MAGENTA .. commands[ct][1].category .. colors.RESET)
        for desc = 1, #commands[ct], 1 do
            io.write(colors.BRIGHT_CYAN .. "\t [" .. commands[ct][desc].name .. "] ")
            for alias = 1, #commands[ct][desc].alias, 1 do
                if #commands[ct][desc].alias > 0 then
                    io.write(colors.BRIGHT_MAGENTA .. commands[ct][desc].alias[alias] .. colors.RESET)
                    if alias < #commands[ct][desc].alias then
                        io.write(", ")
                    end
                end
            end
            io.write(string.format(colors.BRIGHT_CYAN .. "\t\t\t%s\n", commands[ct][desc].description) .. colors.RESET)
            if commands[ct][desc].subcommands ~= nil then
                for sbc = 1, #commands[ct][desc].subcommands, 1 do
                    if sbc == #commands[ct][desc].subcommands then
                        io.write(colors.CYAN .. "\t\t└ {" .. commands[ct][desc].subcommands[sbc].name .. "} ")
                    else
                        io.write(colors.CYAN .. "\t\t├ {" .. commands[ct][desc].subcommands[sbc].name .. "} ")
                    end
                    io.write("\t\t" .. commands[ct][desc].subcommands[sbc].description .. "\n" .. colors.RESET)
                end
            end
        end
    end
end

return help