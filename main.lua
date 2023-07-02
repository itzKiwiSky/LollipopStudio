lfs = require 'lfs'
registry = require 'src.Registry'
getos = require 'src.GetOS'

_Version = "0.0.1"

local function _fileExists(name)
    local f = io.open(name, "r")
    if f ~= nil then 
        io.close(f) 
        return true 
    else 
        return false 
    end
end

local function _folderExists(path)
    local attributes = lfs.attributes(path)
    return attributes and attributes.mode == "directory"
end

ENV = "APPDATA"

local OS = getos.get_os_name()
if OS == "Windows" then
    ENV = "APPDATA"
else
    ENV = "HOME"
end


function main()
    os.execute("@chcp 65001>nul")
    args = arg
    colors = require 'src.Colors'
    parser = require 'src.Parser'
    commands = require 'src.Commands'
    help = require 'src.Help'
    json = require 'src.json'
    getTableContent = require 'src.Gettablecontent'
    char = require 'src.Char'

    --% this part will setup the module database and also project db
    if not _folderExists(os.getenv(ENV) .. "/LoveStudio") then
        lfs.mkdir(os.getenv(ENV) .. "/LoveStudio")
        lfs.mkdir(os.getenv(ENV) .. "/LoveStudio/lumina")
        lfs.mkdir(os.getenv(ENV) .. "/LoveStudio/lumina/modules")
        lfs.mkdir(os.getenv(ENV) .. "/LoveStudio/projects")
    end
    if not _fileExists(os.getenv(ENV) .. "/LoveStudio/installation.json") then
        registry.save()
    end
    if _fileExists(os.getenv(ENV) .. "/LoveStudio/installation.json") then
        registry.data = json.decode(io.open(os.getenv(ENV) .. "/LoveStudio/installation.json", "r"):read("*all"))
    end

    --% this part will check if everything is setup, if yes set var to 1 to invalidate command use "setup"


    local command = args[1]
    table.remove(args, 1)
    if command == nil or command == "help" or command == "h" or command == "hp" or command == "?" then
        help.message()
    else
        parser.runCommand(command, args)
    end
end


main()