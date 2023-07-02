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

function _attrdir(path)
    for file in lfs.dir(path) do
        if file ~= "." and file ~= ".." then
            local f = path..'/'..file
            print ("\t "..f)
            local attr = lfs.attributes (f)
            assert (type(attr) == "table")
            if attr.mode == "directory" then
                attrdir (f)
            else
                for name, value in pairs(attr) do
                    print (name, value)
                end
            end
        end
    end
end

function _createFile(name, data)
    local file = io.open(name, "w")
    file:write(data)
    file:close()
end

function project.create(name, modules)
    --% create the folder structure
    local path = os.getenv(ENV) .. "/LoveStudio/projects"
    local projFile = {
        name = name,
        path = path .. "/" .. "name",
        dependencies = modules
    }

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

    if #modules > 0 then
        for m = 1, #registry.data.modules, 1 do
            if modules[m] == registry.data.modules[m] then
                --% if module exist copy to the project folder --
                --data = io.open(os.getenv(ENV) .. "/LoveStudio/lumina/modules/" .. modules[m] .. ".lua"):read("*all")
                if lfs.attributes(os.getenv(ENV) .. "/LoveStudio/lumina/modules/" .. modules[m]).mode == "file" then

                else

                end
            else
                print(colors.BRIGHT_YELLOW .. "[:WARN:] | Module " .. modules[m] .. " doesn't" .. colors.RESET) 
            end
        end
    end

    table.insert(registry.data.projects, name)
    registry.save()
end

return project