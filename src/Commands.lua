project = require 'src.Project'
return {
    {
        {
            name = "new",
            alias = {"n","nw",},
            category = "Project Management",
            description = "Create a new love2D project by manually picking modules",
            run = function(name, ...)
                modules = {...}
                project.create(name, modules)
            end,
        },
        {
            name = "template",
            alias = {"t","tp",},
            category = "Project Management",
            description = "Create a new love2D project from template",
            run = function(name)
                
            end,
        },
        {
            name = "open",
            alias = {"o","op",},
            category = "Project Management",
            description = "Open a love2D project",
            run = function(name)
    
            end,
        },
        {
            name = "remove",
            alias = {"r","rm",},
            category = "Project Management",
            description = "Remove a project",
            run = function(name)
    
            end,
        },
        {
            name = "list",
            alias = {"l","ls",},
            category = "Project Management",
            description = "List all projects",
            run = function()
                print(#registry.data)
                if #registry.data.projects == 0 then
                    print(colors.BRIGHT_MAGENTA .. "No projects found :(" .. colors.RESET)
                else
                    local c = 6
                    for p = 1, #registry.data.projects, 1 do
                        c = c + 1
                        print(colors[10 + c] .. registry.data.projects[p] .. colors.RESET)
                        if c > 5 then
                            c = 0
                        end
                    end
                end
            end,
        },
    },
    {
        {
            name = "lumina",
            alias = {},
            category = "Lumina Package Manager",
            description = "Uses the LPM (Lumina Package Manager) subcommands",
            run = function(name)
                
            end,
        },
    },
}