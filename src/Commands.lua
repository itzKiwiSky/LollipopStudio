project = require 'src.Project'
setup = require 'src.Setup'
return {
    {
        {
            name = "setup",
            alias = {"s","st",},
            category = "LoveStudio Setup",
            description = "Executes the LoveStudio setup shell",
            run = function(name)
                setup.run()
            end,
        },
    },
    {
        {
            name = "new",
            alias = {"n","nw",},
            category = "Project Management",
            description = "Create a new LOVE project by manually picking modules",
            subcommands = {
                {
                    name = "project-name",
                    description = "the name of the project",
                },
            },
            run = function(name)
                project.create(name)
            end,
        },
        {
            name = "open",
            alias = {"o","op",},
            category = "Project Management",
            description = "Open a project",
            subcommands = {
                {
                    name = "project-name",
                    description = "the name of the project",
                },
            },
            run = function(name)
                project.open(name)
            end,
        },
        {
            name = "remove",
            alias = {"r","rm",},
            category = "Project Management",
            description = "Remove a project",
            subcommands = {
                {
                    name = "project-name",
                    description = "the name of the project",
                },
            },
            run = function(name)
                project.remove(name)
            end,
        },
        {
            name = "refresh",
            alias = {"rs",},
            category = "Project Management",
            description = "Remove a project",
            subcommands = {
                {
                    name = "project-name",
                    description = "the name of the project",
                },
            },
            run = function(name)
    
            end,
        },
        {
            name = "list",
            alias = {"l","ls",},
            category = "Project Management",
            description = "List all projects",
            run = function()
                print(colors.BRIGHT_WHITE .. "Listing projects" .. colors.RESET)
                print(colors.BRIGHT_WHITE .. "-===============-" .. colors.RESET)
                if #registry.data.projects == 0 then
                    print(colors.BRIGHT_MAGENTA .. "No projects found created" .. colors.RESET)
                else
                    for p = 1, #registry.data.projects, 1 do
                        print(colors.BRIGHT_WHITE .. "[" .. p .. "] - " .. registry.data.projects[p] .. colors.RESET)
                    end
                end
            end,
        },
    },
    {
        {
            name = "lollipop",
            alias = {},
            category = "Lollipop Package Manager",
            description = "Uses the LPM (lollipop Package Manager) subcommands",
            subcommands = {
                {
                    name = "install",
                    description = "Install a package from a repository",
                },
                {
                    name = "remove",
                    description = "remove a package from local repository",
                },
                {
                    name = "refresh",
                    description = "refresh the packages installed",
                },
                {
                    name = "list",
                    description = "list all installed packages on local repository",
                },
            },
            run = function(name, ...)
                
            end,
        },
    },
    {
        {
            name = "version",
            alias = {"v", "vr"},
            category = "Miscellaneous",
            description = "LoveStudio Version",
            run = function()
                print(colors.BRIGHT_MAGENTA .. "Love" .. colors.RESET .. colors.BRIGHT_CYAN .. "Studio" .. colors.RESET .. colors.BRIGHT_WHITE .. " A Command line interface for " .. colors.BRIGHT_MAGENTA .. "LÖVE" .. colors.RESET)
                print(colors.BRIGHT_WHITE .. "Version " .. _Version .. colors.RESET)
            end,
        },
        {
            name = "devcolors",
            alias = {"d", "dv"},
            category = "Miscellaneous",
            description = "Display all colors",
            run = function()
                local COLORS = {
                    "BLACK",
                    "RED",
                    "GREEN",
                    "YELLOW",
                    "BLUE",
                    "MAGENTA",
                    "CYAN",
                    "WHITE",
                    "BRIGHT_RED",
                    "BRIGHT_GREEN",
                    "BRIGHT_YELLOW",
                    "BRIGHT_BLUE",
                    "BRIGHT_MAGENTA",
                    "BRIGHT_CYAN",
                    "BRIGHT_WHITE",
                    "BGRed",
                    "BGGreen",
                    "BGYellow",
                    "BGBlue",
                    "BGMagenta",
                    "BGCyan",
                    "BGWhite",
                }
                for c = 1, #COLORS, 1 do
                    if c > 15 then
                        print(colors[COLORS[c]] .. colors.BLACK .. "TestColors" .. colors.RESET)
                    else
                        print(colors[COLORS[c]] .. "TestColors" .. colors.RESET)
                    end
                end
            end,
        },
    }
}