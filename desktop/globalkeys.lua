local gears = require("gears")
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local switcher = require("desktop.switcher")
local sequentialkey = require("desktop.sequentialkey")

globalkeys =
    gears.table.join(
    awful.key(
        {keydefine.modkey},
        "Print",
        function()
            awful.spawn.with_shell("deepin-screen-recorder")
        end,
        {
            description = "Screen Record",
            group = "Application"
        }
    ),
    awful.key(
        {},
        "Print",
        function()
            awful.spawn.with_shell("flameshot gui")
        end,
        {
            description = "Screen capture",
            group = "Application"
        }
    ),
    awful.key(
        {keydefine.alt},
        "space",
        function()
            awful.spawn.with_shell(
                "rofi -modi 'window,drun' -show drun -drun-show-actions -display-drun '' -show-icons"
            )
        end,
        {
            description = "Show rofi",
            group = "Application"
        }
    )
)

globalkeys =
    gears.table.join(
    globalkeys,
    awful.key(
        {keydefine.alt},
        "Tab",
        function()
            switcher.switch(1, keydefine.alt, "Alt_L", "Shift", "Tab")
        end,
        {
            description = "Next client",
            group = "Awesome"
        }
    ),
    awful.key(
        {keydefine.alt, keydefine.shift},
        "Tab",
        function()
            switcher.switch(-1, keydefine.alt, "Alt_L", "Shift", "Tab")
        end,
        {
            description = "Previous client",
            group = "Awesome"
        }
    ),
    awful.key(
        {keydefine.modkey, keydefine.shift},
        "/",
        hotkeys_popup.show_help,
        {
            description = "Show help",
            group = "Awesome"
        }
    ),
    awful.key(
        {keydefine.modkey, keydefine.control},
        "r",
        awesome.restart,
        {
            description = "Reload awesome",
            group = "Awesome"
        }
    ),
    awful.key(
        {keydefine.modkey, keydefine.control},
        "q",
        awesome.quit,
        {
            description = "Quit awesome",
            group = "Awesome"
        }
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
                            group = "Layout",
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
                            group = "Layout",
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
                            group = "Layout",
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
                            group = "Layout",
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
                                    group = "Layout",
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
                                    group = "Layout",
                                    hold = true
                                }
                            }
                        },
                        {
                            description = "the number of master clients",
                            group = "Layout",
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
                                    group = "Layout",
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
                                    group = "Layout",
                                    hold = true
                                }
                            }
                        },
                        {
                            description = "the number of layout columns",
                            group = "Layout",
                            hold = true
                        }
                    }
                },
                {
                    description = "Layout control"
                }
            )
        end,
        {
            description = "Layout control",
            group = "Layout"
        }
    )
)

-- Client
globalkeys =
    gears.table.join(
    globalkeys,
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
        {description = "Focus next by index", group = "Client"}
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
        {description = "Focus previous by index", group = "Client"}
    ),
    awful.key(
        {keydefine.modkey, keydefine.shift},
        "j",
        function()
            awful.client.swap.byidx(1)
        end,
        {description = "Swap next by index", group = "Client"}
    ),
    awful.key(
        {keydefine.modkey, keydefine.shift},
        "k",
        function()
            awful.client.swap.byidx(-1)
        end,
        {description = "Swap previous by index", group = "Client"}
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
        {description = "Tag control", group = "Tag"}
    )
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 2 do
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
            {description = "View tag #" .. i, group = "Tag"}
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
            {description = "Toggle tag #" .. i, group = "Tag"}
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
            {description = "Move focused client to tag #" .. i, group = "Tag"}
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
            {description = "Toggle focused client on tag #" .. i, group = "Tag"}
        )
    )
end

-- Volume control
globalkeys =
    gears.table.join(
    globalkeys,
    awful.key(
        {},
        -- "XF86AudioLowerVolume",
        "#122",
        function()
            os.execute("amixer -q sset Master 5%-")
            local wibox = require("wibox")
        end
    ),
    awful.key(
        {},
        "#123",
        function()
            os.execute("amixer -q sset Master 5%+")
        end
    ),
    awful.key(
        {},
        "#121",
        function()
            os.execute("amixer -q sset Master toggle")
        end
    )
)
local at = require("service.awesome-translate")

-- local selection = require("selection")
-- Volume control
-- 是否使用 rofi 展示单词，false 则使用通知展示
-- at.enable_rofi = false
-- 是否启用 anki
at.enable_anki = true
-- Anki保存单词的 Desk
at.anki.desk = "Word"
 -- Anki保存单词的 NodeType
at.anki.model = "Word"
-- Anki-Connect 的端口号
at.anki.connect_port = 8701
-- 单词字段
at.anki.word_field = "Word"
-- 释义字段
at.anki.definition_field = "Definition"
-- 美式音标
at.anki.us_pronunciations_field = "USPronunciations"
-- 英式音标
at.anki.uk_pronunciations_field = "UKPronunciations"
-- Anki保存美式发音的字段
at.anki.us_audio_field = "USAudio"
-- Anki保存英式发音的字段
at.anki.uk_audio_field = "UKAudio"
globalkeys =
    gears.table.join(
    globalkeys,
    awful.key(
        {keydefine.modkey},
        -- "XF86AudioLowerVolume",
        "q",
        function()
            at.query(selection())
        end
    ),
    awful.key(
        {keydefine.modkey},
        -- "XF86AudioLowerVolume",
        "c",
        function()
            at.copy()
        end
    )
)
return globalkeys
