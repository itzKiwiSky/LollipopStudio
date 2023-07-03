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

local path = os.getenv(ENV) .. "/LoveStudio/projects"

local function _deletedir(dir)
    for file in lfs.dir(dir) do
        local file_path = dir..'/'..file
        if file ~= "." and file ~= ".." then
            if lfs.attributes(file_path, 'mode') == 'file' then
                os.remove(file_path)
                print(colors.BRIGHT_RED .. '[-][file]',file_path .. colors.RESET)
            elseif lfs.attributes(file_path, 'mode') == 'directory' then
                print(colors.BRIGHT_RED .. '[-][dir]', file_path .. colors.RESET)
                _deletedir(file_path)
            end
        end
    end
    lfs.rmdir(dir)
    --print('remove dir',dir)
end

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

local function _create(name, registrate)
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

    if registrate then
        table.insert(registry.data.projects, name)
        registry.save()
    end
end

function project.create(name)
    --% create the folder structure
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
                        _create(name, false)
                        io.write(colors.BRIGHT_YELLOW .. "[:WARN:] The project '" .. name .. "' Has been overwritten" .. colors.RESET .. "\n")
                    end
                end
            else
                _create(name, true)
            end
        end
    else
        _create(name, true)
    end
end

function project.remove(name)
    if #registry.data.projects > 0 then
        for n = 1, #registry.data.projects, 1 do
            if name == registry.data.projects[n] then
                io.write(colors.BRIGHT_YELLOW .. "[:WARN:] Warning, this action will permanently delete your project. Are you sure you want continue? [Y/N] " .. colors.RESET)
                local selActive = true
                while selActive do
                    local input = io.read(1)
                    if input == "y" then
                        _deletedir(path .. "/" .. name)
                        for n = 1, #registry.data.projects, 1 do
                            if name == registry.data.projects[n] then
                                table.remove(registry.data.projects, n)
                            end
                        end
                        registry.save()
                        print(colors.BRIGHT_CYAN .. "[:EVENT:] Project deleted" .. colors.RESET)
                        return
                    elseif input == "n" then
                        print(colors.BRIGHT_CYAN .. "[:EVENT:] Operation aborted" .. colors.RESET)
                        return
                    end
                end
            else
                print(colors.BRIGHT_RED .. "[:ERROR:] Invalid project name" .. colors.RESET)
            end
        end
    else
        print(colors.BRIGHT_MAGENTA .. "[:EVENT:] No projects here" .. colors.RESET)
    end
end

function project.open(name)
    if registry.data.defaultIDE == "vscode" then
        for n = 1, #registry.data.projects, 1 do
            if name == registry.data.projects[n] then
                print(colors.BRIGHT_GREEN .. "Good coding :)" .. colors.RESET)
                local projPath = os.getenv(ENV) .. "\\LoveStudio\\projects" .. "\\" .. name
                os.execute([["C:/Users/Phellipe/AppData/Local/Programs/Microsoft VS Code/code.exe" ]] .. projPath)
                return
            else
                print(colors.BRIGHT_RED .. "[:ERROR:] Invald project name or missing project" .. colors.RESET)
                return
            end
        end
    elseif registry.data.defaultIDE == "sublime" then
        for n = 1, #registry.data.projects, 1 do
            if name == registry.data.projects[n] then
                print(colors.BRIGHT_GREEN .. "Good coding :)" .. colors.RESET)
                local projPath = os.getenv(ENV) .. "\\LoveStudio\\projects" .. "\\" .. name
                os.execute([["C:/Program Files/Sublime Text 3/sublime_text.exe" ]] .. projPath)
                return
            else
                print(colors.BRIGHT_RED .. "[:ERROR:] Invalid project name or missing project" .. colors.RESET)
                return
            end
        end
    end
end

return project