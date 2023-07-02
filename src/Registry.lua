registry = {}

registry.data = {
    installed = true,
    modules = {},
    projects = {},
    defaultIDE = "none",
}

function registry.save()
    local file = io.open(os.getenv(ENV) .. "/LoveStudio/installation.json", "w+")
    file:write(json.encode(registry.data))
    file:close()
end

return registry