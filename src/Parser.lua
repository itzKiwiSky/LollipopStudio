parser = {}

local commands = require 'src.Commands'

function parser.runCommand(command, ...)
    for cat = 1, #commands, 1 do
        --% find command by name
        for cmd = 1, #commands[cat], 1 do
            if "--" .. commands[cat][cmd].name == command then
                commands[cat][cmd].run(unpack(...))
                return
            end
        end
        --% do the same thing but looking for aliases
        for cmd = 1, #commands[cat], 1 do
            for alias = 1, #commands[cat][cmd].alias, 1 do
                if "-" .. commands[cat][cmd].alias[alias] == command then
                    commands[cat][cmd].run(unpack(...))
                    return
                end
            end
        end
    end
    print(colors.BRIGHT_RED .. "Invalid command!" .. colors.RESET)
end

return parser