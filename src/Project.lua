project = {}

scripts = {
main = [[
function love.load(args)
    
end

function love.draw()
    
end

function love.update(dt)
    
end
]],

conf = [[
function love.conf(w)
    w.window.width          =       1280
    w.window.height         =       768
    w.window.title          =       "new love game"
    w.console               =       true
    w.identity              =       "default"
    w.window.resizable      =       false 
end
]]
}

local function _attrdir(path, tbl)
    for file in lfs.dir(path) do
        if file ~= "." and file ~= ".." then
            local f = path .. "/" .. file
            --print(f)
            table.insert(tbl, f)
            local attr = lfs.attributes(f)
            assert(type(attr) == "table")
            if attr.mode == "directory" then
                _attrdir(f)
            end
        end
    end
end

function _createFile(name, data)
    local file = io.open(name, "w")
    file:write(data)
    file:close()
end

function project.create(name)
    --% create the folder structure
    local path = os.getenv(ENV) .. "/LoveStudio/projects"
    local projFile = {
        name = name,
        path = path .. "/" .. name,
        dependencies = {}
    }

    if #registry.data.projects > 0 then
        for n = 1, #registry.data.projects, 1 do
            if name == registry.data.projects[n] then
                io.write(colors.BRIGHT_YELLOW .. "[:WARN:] The project '" .. name .. "' will be overwritten, are you sure you want continue? [Y/N] " .. colors.RESET)
                local active = true
                while active do
                    local choose = io.read(1)
                    if choose == "n" then
                        active = false
                        print(colors.BRIGHT_CYAN .. "[:EVENT:] Operation aborted." .. colors.RESET)
                        return
                    elseif choose == "y" then
                        active = false
                        lfs.mkdir(path .. "/" .. name)
                        lfs.mkdir(path .. "/" .. name .. "/libraries")
                        lfs.mkdir(path .. "/" .. name .. "/resources/")
                        lfs.mkdir(path .. "/" .. name .. "/resources/images")
                        lfs.mkdir(path .. "/" .. name .. "/resources/sounds")
                        lfs.mkdir(path .. "/" .. name .. "/resources/data")
                        lfs.mkdir(path .. "/" .. name .. "/src")
                        lfs.mkdir(path .. "/" .. name .. "/src/Components")
                        lfs.mkdir(path .. "/" .. name .. "/src/Archive")
                        lfs.mkdir(path .. "/" .. name .. "/src/States")
                        _createFile(path .. "/" .. name .. "/main.lua", scripts.main)
                        _createFile(path .. "/" .. name .. "/conf.lua", scripts.conf)
                        _createFile(path .. "/" .. name .. "/.loveproject", json.encode(projFile))
                        io.write(colors.BRIGHT_YELLOW .. "[:WARN:] The project '" .. name .. "' Has been overwritten" .. colors.RESET .. "\n")
                    end
                end
            else
                lfs.mkdir(path .. "/" .. name)
                lfs.mkdir(path .. "/" .. name .. "/libraries")
                lfs.mkdir(path .. "/" .. name .. "/resources/")
                lfs.mkdir(path .. "/" .. name .. "/resources/images")
                lfs.mkdir(path .. "/" .. name .. "/resources/sounds")
                lfs.mkdir(path .. "/" .. name .. "/resources/data")
                lfs.mkdir(path .. "/" .. name .. "/src")
                lfs.mkdir(path .. "/" .. name .. "/src/Components")
                lfs.mkdir(path .. "/" .. name .. "/src/Archive")
                lfs.mkdir(path .. "/" .. name .. "/src/States")
                _createFile(path .. "/" .. name .. "/main.lua", scripts.main)
                _createFile(path .. "/" .. name .. "/conf.lua", scripts.conf)
                _createFile(path .. "/" .. name .. "/.loveproject", json.encode(projFile))
                io.write(colors.BRIGHT_GREEN .. "[:SUCESS:] Project created with sucess\n" .. colors.RESET)
            
                table.insert(registry.data.projects, name)
                registry.save()
            end
        end
    else
        lfs.mkdir(path .. "/" .. name)
        lfs.mkdir(path .. "/" .. name .. "/libraries")
        lfs.mkdir(path .. "/" .. name .. "/resources/")
        lfs.mkdir(path .. "/" .. name .. "/resources/images")
        lfs.mkdir(path .. "/" .. name .. "/resources/sounds")
        lfs.mkdir(path .. "/" .. name .. "/resources/data")
        lfs.mkdir(path .. "/" .. name .. "/src")
        lfs.mkdir(path .. "/" .. name .. "/src/Components")
        lfs.mkdir(path .. "/" .. name .. "/src/Archive")
        lfs.mkdir(path .. "/" .. name .. "/src/States")
        _createFile(path .. "/" .. name .. "/main.lua", scripts.main)
        _createFile(path .. "/" .. name .. "/conf.lua", scripts.conf)
        _createFile(path .. "/" .. name .. "/.loveproject", json.encode(projFile))
        io.write(colors.BRIGHT_GREEN .. "[:SUCESS:] Project created with sucess\n" .. colors.RESET)
    
        table.insert(registry.data.projects, name)
        registry.save()
    end
end

function project.remove(name)
    
end

function project.open(name)
    if registry.data.defaultIDE == "vscode" then
        for n = 1, #registry.data.projects, 1 do
            if name == registry.data.projects[n] then
                print(colors.BRIGHT_GREEN .. "Good coding :)" .. colors.RESET)
                os.execute([["C:\Users\Phellipe\AppData\Local\Programs\Microsoft VS Code" "]] .. path .. "/" .. name .. [["]])
                return
            else
                print(colors.BRIGHT_RED .. "[:ERROR:] Invald project name or missing project" .. colors.RESET)
                return
            end
        end
    elseif registry.data.defaultIDE == "sublime" then
        for n = 1, #registry.data.projects, 1 do
            if name == registry.data.projects[n] then
                os.execute([["C:\Program Files\Sublime Text 3\sublime_text.exe" "]] .. path .. "/" .. name .. [["]])
                return
            else
                print(colors.BRIGHT_RED .. "[:ERROR:] Invalid project name or missing project" .. colors.RESET)
                return
            end
        end
    end
end

return project