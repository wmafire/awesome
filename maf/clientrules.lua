local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local menubar = require("menubar")
local clientkeys = require("maf.clientkeys")
local utils = require("utils")
local keydefine = require("maf.keydefine")
local xresources = require("beautiful.xresources")

local module = {}

local clientbuttons =
    gears.table.join(
    awful.button(
        {},
        1,
        function(c)
            if not awful.rules.match(c, {class = "jetbrains-studio", name = "^win[0-9]+$"}) then
                client.focus = c
            end
            c:raise()
        end
    ),
    awful.button(
        {keydefine.modkey},
        1,
        function(c)
            client.focus = c
            c:raise()
            awful.mouse.client.move(c)
        end
    ),
    awful.button(
        {keydefine.modkey},
        3,
        function(c)
            client.focus = c
            c:raise()
            awful.mouse.client.resize(c)
        end
    )
)

local function create_tag(c)
    local tag =
        awful.tag.add(
        c.instance,
        {
            layout = awful.layout.suit.floating,
            screen = screen.primary,
            gap_single_client = false,
            gap = 0,
            volatile = true
        }
    )
    c:move_to_tag(tag)
    tag:view_only()
end

local function placement(d, args)
    local args = args or {}

    if d.transient_for then
        args.parent = d.transient_for
        args.parent = nil
        return
    elseif d.instance ~= nil and client.focus ~= nil and d.instance == client.focus.instance then
        args.parent = client.focus
        args.offset = {
            x = xresources.apply_dpi(30),
            y = xresources.apply_dpi(30),
            width = 0,
            height = 0
        }
    else
        args.parent = screen.primary
    end

    if d.fullscreen == true then
        args.parent = nil
        args.offset = {
            x = 0,
            y = 0,
            width = 0,
            height = 0
        }
    elseif d.maximized == true then
        args.parent = nil
        args.offset = {
            x = 0,
            y = 0,
            width = 0,
            height = 0
        }
        args.honor_workarea = true
    end

    return awful.placement.centered(d, args)
end

module = {
    -- All clients will match this rule.
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            size_hints_honor = false, -- Remove gaps between terminals
            screen = awful.screen.preferred,
            callback = awful.client.setslave,
            -- placement = awful.placement.centered,
            placement = placement,
            titlebars_enabled = true,
            switchtotag = true,
            tag = "normal"
        },
        callback = function(c)
            if c.transient_for then
                c:move_to_tag(c.transient_for.first_tag)
            end
        end
    }, -- Floating clients.
    {
        rule_any = {
            instance = {},
            class = {
                "Arandr",
                "Blueman-manager",
                "Gpick",
                "Kruler",
                "MessageWin", -- kalarm.--[[  ]]
                "Sxiv",
                "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
                "Wpa_gui",
                "veromix",
                "xtightvncviewer",
                "obs",
                "Qq",
                "Peek",
                "Anki",
                "Dragon-drag-and-drop",
                "scrcpy"
            },
            name = {
                "Event Tester", -- xev.
                "win0" -- jetbrains
            },
            role = {
                "pop-up" -- e.g. Google Chrome's (detached) Developer Tools.
            }
        },
        properties = {floating = true}
    }, -- Sticky clients
    {
        rule_any = {
            class = {}
        },
        properties = {sticky = true}
    }, -- OnTop clients
    {
        rule_any = {
            class = {}
        },
        properties = {ontop = true}
    }, -- No border clients
    {
        rule_any = {
            class = {},
            type = {
                "utility"
            }
        },
        properties = {
            border_width = 0
        }
    },
    {
        rule_any = {
            instance = {
                "chromium"
            },
            class = {
                "firefox"
            }
        },
        properties = {
            tag = "view"
        }
    },
    {
        rule_any = {
            class = {
                "jetbrains-studio"
            },
            instance = {
                "jetbrains-idea",
                "jetbrains-datagrip",
                "emacs",
                "code-oss"
            }
        },
        properties = {
            tag = "work"
        }
    },
    {
        rule_any = {
            class = {
                "VirtualBox Machine"
            }
        },
        callback = create_tag
    }
}

-- Ranger dragon
table.insert(
    module,
    {
        rule = {
            class = "Dragon-drag-and-drop"
        },
        properties = {
            ontop = true,
            sticky = true
        }
    }
)
-- Android Emulator
table.insert(
    module,
    {
        rule = {
            name = "Emulator",
            type = "utility"
        },
        properties = {
            sticky = false,
            ontop = false,
            skip_taskbar = true
        }
    }
)
table.insert(
    module,
    {
        rule = {
            name = "Android Emulator.+"
        },
        properties = {
            ontop = false
        }
    }
)


return module