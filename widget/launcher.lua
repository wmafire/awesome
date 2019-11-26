local awful = require('awful')
local wibox = require('wibox')
local menubar = require('menubar')


-- menubar.utils.terminal = terminal

local module = {}

function module.new(args)
    local args = args or {}
    local menu = args.menu or awful.menu()

    local launcher_menu = setmetatable({}, menu)

    function launcher_menu:toggle()
        menu:toggle(
            {
                coords = {
                    x = 0,
                    y = 0
                }
            }
        )
    end
    function launcher_menu:show()
        menu:show(
            {
                coords = {
                    x = 0,
                    y = 0
                }
            }
        )
    end
    local margin = args.margin or 0
    return wibox.container.margin(
        awful.widget.launcher(
            {
                image = beautiful.awesome_icon,
                menu = launcher_menu
            }
        ),
        margin + 10,
        margin + 10,
        margin,
        margin
    )
end

return module
