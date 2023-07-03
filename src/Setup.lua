Setup = {}

local message = [[
Select your IDE:

    [1] - Visual Studio Code
    [2] - Sublime Text 3
    [3] - Exit

]]

function Setup.run()
    if registry.data.setup == 1 then
        local editConfirm = true
        io.write(colors.BRIGHT_YELLOW .. "[:WARN:] This will edit your configs, are you sure you want continue? [Y/N] " .. colors.RESET)
        while editConfirm do
            local confirm = io.read(1)
            if confirm == "y" then
                editConfirm = false
            elseif confirm == "n" then
                print(colors.BRIGHT_CYAN .. "[:EVENT:] Process aborted" .. colors.RESET)
                editConfirm = false
                return 
            end
        end
    end
    io.write("\n")
    local setupactive = true
    io.write(colors.BRIGHT_CYAN .. message .. colors.RESET)
    io.write("Selection >")
    while setupactive do
        local choose = io.read("*n")
        if choose == 1 then
            registry.data.defaultIDE = "vscode"
            registry.data.setup = 1
            setupactive = false
            print(colors.BRIGHT_CYAN .. "[:EVENT:] IDE Selected = 'Visual Studio Code'" .. colors.RESET)
            registry.save()
            return
        elseif choose == 2 then
            registry.data.defaultIDE = "sublime"
            registry.data.setup = 1
            print(colors.BRIGHT_CYAN .. "[:EVENT:] IDE Selected = 'Sublime Text 3'" .. colors.RESET)
            registry.save()
            setupactive = false
            return 
        elseif choose == 3 then
            print(colors.BRIGHT_CYAN .. "[:EVENT:] Process aborted" .. colors.RESET)
            setupactive = false
            return
        else
            print(colors.BRIGHT_RED .. "[:ERROR:] Invalid selection" .. colors.RESET)
            setupactive = false
            return
        end
    end
end

return Setup