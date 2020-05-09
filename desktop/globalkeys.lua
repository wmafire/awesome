local gears = require("gears")
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local switcher = require("desktop.switcher")
local sequentialkey = require("desktop.sequentialkey")

globalkeys =
    gears.table.join(
    awful.key(
        {},
        "Print",
        function()
            awful.spawn.with_shell("flameshot gui")
        end,
        {
            description = "screen capture",
            group = "awesome"
        }
    ),
    awful.key(
        {keydefine.alt},
        "space",
        function()
            awful.spawn.with_shell("rofi -show drun -drun-show-actions -display-drun 'A' -show-icons")
        end,
        {
            description = "show rofi",
            group = "awesome"
        }
    ),
    awful.key(
        {keydefine.alt},
        "Tab",
        function()
            switcher.switch(1, keydefine.alt, "Alt_L", "Shift", "Tab")
        end
    ),
    awful.key(
        {keydefine.alt, keydefine.shift},
        "Tab",
        function()
            switcher.switch(-1, keydefine.alt, "Alt_L", "Shift", "Tab")
        end
    ),
    awful.key(
        {keydefine.modkey, keydefine.shift},
        "/",
        hotkeys_popup.show_help,
        {
            description = "show help",
            group = "awesome"
        }
    ),
    awful.key(
        {keydefine.modkey, keydefine.control},
        "r",
        awesome.restart,
        {
            description = "reload awesome",
            group = "awesome"
        }
    ),
    awful.key(
        {keydefine.modkey, keydefine.control},
        "q",
        awesome.quit,
        {
            description = "quit awesome",
            group = "awesome"
        }
    )
)
-- Tag
globalkeys =
    gears.table.join(
    globalkeys,
    awful.key(
        {keydefine.modkey},
        "t",
        function()
            sequentialkey.show(
                {
                    {
                        {},
                        "j",
                        awful.tag.viewprev,
                        {
                            description = "view previous tag",
                            group = "tag",
                            hold = true
                        }
                    },
                    {
                        {},
                        "k",
                        awful.tag.viewnext,
                        {
                            description = "view previous tag",
                            group = "tag",
                            hold = true
                        }
                    },
                    {
                        {},
                        "n",
                        function()
                            awful.tag.add(
                                "NewTag",
                                {
                                    -- screen = screen,
                                    layout = awful.layout.suit.floating
                                }
                            )
                        end,
                        {
                            description = "create new tag",
                            group = "tag"
                        }
                    },
                    {
                        {keydefine.shift},
                        "n",
                        function()
                            awful.tag.add(
                                "NewTag",
                                {
                                    screen = screen,
                                    layout = awful.layout.suit.floating
                                }
                            ):view_only()
                        end,
                        {
                            description = "create new tag and view",
                            group = "tag"
                        }
                    },
                    {
                        {},
                        "d",
                        function()
                            local t = awful.screen.focused().selected_tag
                            if not t then
                                return
                            end
                            t:delete()
                        end,
                        {
                            description = "delete tag",
                            group = "tag",
                            hold = true
                        }
                    }
                },
                {
                    description = "tag control"
                }
            )
        end,
        {description = "tag control", group = "tag"}
    )
)
-- Layout
globalkeys =
    gears.table.join(
    globalkeys,
    awful.key(
        {keydefine.modkey},
        "l",
        function()
            sequentialkey.show(
                {
                    {
                        {},
                        "space",
                        function()
                            awful.layout.inc(1)
                        end,
                        {
                            description = "select next layout",
                            group = "layout",
                            hold = true
                        }
                    },
                    {
                        {keydefine.shift},
                        "space",
                        function()
                            awful.layout.inc(1)
                        end,
                        {
                            description = "select previous layout",
                            group = "layout",
                            hold = true
                        }
                    },
                    -- master size
                    {
                        {},
                        "k",
                        function()
                            awful.tag.incmwfact(0.05)
                        end,
                        {
                            description = "increase master width factor",
                            group = "layout",
                            hold = true
                        }
                    },
                    {
                        {},
                        "j",
                        function()
                            awful.tag.incmwfact(-0.05)
                        end,
                        {
                            description = "decrease master width factor",
                            group = "layout",
                            hold = true
                        }
                    },
                    -- master clients number
                    {
                        {},
                        "m",
                        {
                            {
                                {},
                                "k",
                                function()
                                    awful.tag.incnmaster(1, nil, true)
                                end,
                                {
                                    description = "increase the number of master clients",
                                    group = "layout",
                                    hold = true
                                }
                            },
                            {
                                {},
                                "j",
                                function()
                                    awful.tag.incnmaster(-1, nil, true)
                                end,
                                {
                                    description = "decrease the number of master clients",
                                    group = "layout",
                                    hold = true
                                }
                            }
                        },
                        {
                            description = "the number of master clients",
                            group = "layout",
                            hold = true
                        }
                    },
                    {
                        {},
                        "c",
                        {
                            {
                                {},
                                "k",
                                function()
                                    awful.tag.incncol(1, nil, true)
                                end,
                                {
                                    description = "increase the number of columns",
                                    group = "layout",
                                    hold = true
                                }
                            },
                            {
                                {},
                                "j",
                                function()
                                    awful.tag.incncol(-1, nil, true)
                                end,
                                {
                                    description = "decrease the number of columns",
                                    group = "layout",
                                    hold = true
                                }
                            }
                        },
                        {
                            description = "the number of layout columns",
                            group = "layout",
                            hold = true
                        }
                    }
                },
                {
                    description = "layout control"
                }
            )
        end,
        {
            description = "layout control",
            group = "layout"
        }
    )
)

globalkeys =
    gears.table.join(
    globalkeys,
    -- Client
    awful.key(
        {keydefine.modkey},
        "z",
        function()
            awful.spawn.with_shell("python ~/Projects/hud-menu/hud-menu.py")
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key(
        {keydefine.modkey},
        "Tab",
        function()
            awful.client.focus.byidx(1)
            -- awful.client.focus.bydirection('down')
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key(
        {keydefine.modkey},
        "j",
        function()
            awful.client.focus.byidx(1)
            -- awful.client.focus.bydirection('down')
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key(
        {keydefine.modkey},
        "k",
        function()
            -- awful.client.focus.bydirection('up')
            awful.client.focus.byidx(-1)
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key(
        {keydefine.modkey, keydefine.shift},
        "j",
        function()
            awful.client.swap.byidx(1)
        end,
        {description = "swap next by index", group = "client"}
    ),
    awful.key(
        {keydefine.modkey, keydefine.shift},
        "k",
        function()
            awful.client.swap.byidx(-1)
        end,
        {description = "swap previous by index", group = "client"}
    )
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys =
        gears.table.join(
        globalkeys, -- View tag only.
        awful.key(
            {keydefine.modkey},
            "#" .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    tag:view_only()
                end
            end,
            {description = "view tag #" .. i, group = "tag"}
        ),
        -- Toggle tag display.
        awful.key(
            {keydefine.modkey, keydefine.control},
            "#" .. i + 9,
            function()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            {description = "toggle tag #" .. i, group = "tag"}
        ),
        -- Move client to tag.
        awful.key(
            {keydefine.modkey, keydefine.shift},
            "#" .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:move_to_tag(tag)
                        tag:view_only()
                    end
                end
            end,
            {description = "move focused client to tag #" .. i, group = "tag"}
        ),
        -- Toggle tag on focused client.
        awful.key(
            {keydefine.modkey, keydefine.control, keydefine.shift},
            "#" .. i + 9,
            function()
                if client.focus then
                    local tag = client.focus.screen.tags[i]
                    if tag then
                        client.focus:toggle_tag(tag)
                    end
                end
            end,
            {description = "toggle focused client on tag #" .. i, group = "tag"}
        )
    )
end

-- Volume control
globalkeys =
    gears.table.join(
    globalkeys,
    awful.key(
        {},
        "#122",
        function()
            os.execute("amixer -q sset Master 5%-")
            local wibox = require("wibox")
        end,
        {description = "volume --"}
    ),
    awful.key(
        {},
        "#123",
        function()
            os.execute("amixer -q sset Master 5%+")
        end,
        {description = "volume ++"}
    ),
    awful.key(
        {},
        "#121",
        function()
            os.execute("amixer -q sset Master toggle")
        end,
        {description = "volume mute"}
    )
)

return globalkeys
