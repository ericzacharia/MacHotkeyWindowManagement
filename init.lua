-- Import the window management library
local hs_window = require 'hs.window'
local hs_hotkey = require 'hs.hotkey'
local hs_screen = require 'hs.screen'
local hs_eventtap = require 'hs.eventtap'
local dev = true

local function compare_x_coors(a, b)
    return a:frame().x < b:frame().x
end

local function moveWindowInDirection(direction)
    local focusedWindow = hs_window.focusedWindow()
    local window = focusedWindow:frame()
    local screen = focusedWindow:screen()
    -- create a table of all the monitors sorted by their x coordinates
    local monitor = screen:frame()

    local display_order = {}
    for _, monitor in ipairs(hs_screen.allScreens()) do
        table.insert(display_order, monitor)
    end
    table.sort(display_order, compare_x_coors)

    if dev then
        -- print all the monitors to the console
        print('----------------------')
        for _, monitor in ipairs(display_order) do
            print(monitor:name())
        end
        -- print the dimensions of the screen to the console
        print('----------------------')
        print('monitor: x: ' .. monitor.x .. ' y: ' .. monitor.y .. ' w: ' .. monitor.w .. ' h: ' .. monitor.h)
        print('window: x: ' .. window.x .. ' y: ' .. window.y .. ' w: ' .. window.w .. ' h: ' .. window.h)
    end

    
    -- MACBOOK PRO MONITOR (1728 x 1026) (dock and/or menu bar might deduct from the height)
    local window_coordinates = {
        x = window.x,
        y = window.y,
        w = window.w,
        h = window.h
    }
    local dock = 'right' -- 'bottom' or 'left' or 'right'
    local height_adjustment = 0
    if dock == 'bottom' then
        height_adjustment = 1
    end
    local num_cols = 2

    -- if the screen is the macbook pro monitor, then use the following dimensions
    if screen:name() == 'Built-in Retina Display' or screen:name() == 'Sidecar Display (AirPlay)' or screen:name() == 'DELL S2421HN' then
        num_cols = 2
    elseif screen:name() == 'Dell U4919DW' or screen:name() == 'Dell U4924DW' or screen:name() == 'C49RG9x' or screen:name() == 'DELL U4021QW' then -- or screen:name() == 'DELL U4021QW' then
        num_cols = 4
    end

    local one = {
        x = math.floor(monitor.x + (monitor.w / num_cols) * 0),
        y = math.floor(monitor.y),
        w = math.floor(monitor.w / num_cols),
        h = math.floor(monitor.h - height_adjustment)
    }
    local two = {
        x = math.floor(monitor.x + (monitor.w / num_cols) * 1),
        y = math.floor(monitor.y),
        w = math.floor(monitor.w / num_cols),
        h = math.floor(monitor.h - height_adjustment)
    }
    local three = {
        x = math.floor(monitor.x + (monitor.w / num_cols) * 2),
        y = math.floor(monitor.y),
        w = math.floor(monitor.w / num_cols),
        h = math.floor(monitor.h - height_adjustment)
    }
    local four = {
        x = math.floor(monitor.x + (monitor.w / num_cols) * 3),
        y = math.floor(monitor.y),
        w = math.floor(monitor.w / num_cols),
        h = math.floor(monitor.h - height_adjustment)
    }
    local upper_one = {
        x = math.floor(monitor.x + (monitor.w / num_cols) * 0),
        y = math.floor(monitor.y),
        w = math.floor(monitor.w / num_cols),
        h = math.floor(monitor.h / 2)
    }
    local upper_two = {
        x = math.floor(monitor.x + (monitor.w / num_cols) * 1),
        y = math.floor(monitor.y),
        w = math.floor(monitor.w / num_cols),
        h = math.floor(monitor.h / 2)
    }
    local upper_three = {
        x = math.floor(monitor.x + (monitor.w / num_cols) * 2),
        y = math.floor(monitor.y),
        w = math.floor(monitor.w / num_cols),
        h = math.floor(monitor.h / 2)
    }
    local upper_four = {
        x = math.floor(monitor.x + (monitor.w / num_cols) * 3),
        y = math.floor(monitor.y),
        w = math.floor(monitor.w / num_cols),
        h = math.floor(monitor.h / 2)
    }
    local lower_one = {
        x = math.floor(monitor.x + (monitor.w / num_cols) * 0),
        y = math.floor(monitor.y + (monitor.h / 2)),
        w = math.floor(monitor.w / num_cols),
        h = math.floor(monitor.h / 2)
    }
    local lower_two = {
        x = math.floor(monitor.x + (monitor.w / num_cols) * 1),
        y = math.floor(monitor.y + (monitor.h / 2)),
        w = math.floor(monitor.w / num_cols),
        h = math.floor(monitor.h / 2)
    }
    local lower_three = {
        x = math.floor(monitor.x + (monitor.w / num_cols) * 2),
        y = math.floor(monitor.y + (monitor.h / 2)),
        w = math.floor(monitor.w / num_cols),
        h = math.floor(monitor.h / 2)
    }
    local lower_four = {
        x = math.floor(monitor.x + (monitor.w / num_cols) * 3),
        y = math.floor(monitor.y + (monitor.h / 2)),
        w = math.floor(monitor.w / num_cols),
        h = math.floor(monitor.h / 2)
    }
    local one_two = {
        x = math.floor(monitor.x),
        y = math.floor(monitor.y),
        w = math.floor(2 * monitor.w / num_cols),
        h = math.floor(monitor.h - height_adjustment)
    }
    local two_three = {
        x = math.floor(monitor.x + (monitor.w / num_cols)),
        y = math.floor(monitor.y),
        w = math.floor(2 * monitor.w / num_cols),
        h = math.floor(monitor.h - height_adjustment)
    }
    local three_four = {
        x = math.floor(monitor.x + (monitor.w / num_cols) * 2),
        y = math.floor(monitor.y),
        w = math.floor(2 * monitor.w / num_cols),
        h = math.floor(monitor.h - height_adjustment)
    }
    local one_two_three = {
        x = math.floor(monitor.x + (monitor.w / num_cols) * 0),
        y = math.floor(monitor.y),
        w = math.floor(3 * monitor.w / num_cols),
        h = math.floor(monitor.h - height_adjustment)
    }
    local two_three_four = {
        x = math.floor(monitor.x + (monitor.w / num_cols) * 1),
        y = math.floor(monitor.y),
        w = math.floor(3 * monitor.w / num_cols),
        h = math.floor(monitor.h - height_adjustment)
    }
    local one_two_three_four = {
        x = math.floor(monitor.x),
        y = math.floor(monitor.y),
        w = math.floor(monitor.w),
        h = math.floor(monitor.h - height_adjustment)
    }
    
    if direction == 'right' then
        print(window_coordinates.x, window_coordinates.y, window_coordinates.h, window_coordinates.w)
        -- print(one.x, one.y, one.h, one.w)
        print(one_two.x, one_two.y, one_two.h, one_two.w)
        print(two.x, two.y, two.h, two.w)
        print(upper_one.x, upper_one.y, upper_one.h, upper_one.w)
        print(lower_one.x, lower_one.y, lower_one.h, lower_one.w)

        -- if the the window is in one, then move it to one_two
        if window_coordinates.x == one.x and window_coordinates.y == one.y
        and window_coordinates.h == one.h and window_coordinates.w == one.w then
            print('right from one to one_two')
            window.x = one_two.x
            window.y = one_two.y
            window.h = one_two.h
            window.w = one_two.w
        -- if the window is in one_two, then move it to two
        elseif window_coordinates.x == one_two.x and window_coordinates.y == one_two.y
        and window_coordinates.h == one_two.h and window_coordinates.w == one_two.w then
            print('right from one_two to two')
            window.x = two.x
            window.y = two.y
            window.h = two.h
            window.w = two.w
        -- if the window is in two, then move it to two_three
        elseif window_coordinates.x == two.x and window_coordinates.y == two.y
        and window_coordinates.h == two.h and window_coordinates.w == two.w then
            print('right from two to two_three')
            if num_cols == 2 then
                window.x = one.x
                window.y = one.y
                window.h = one.h
                window.w = one.w
            else
                window.x = two_three.x
                window.y = two_three.y
                window.h = two_three.h
                window.w = two_three.w
            end
        -- if the window is in two_three, then move it to three
        elseif window_coordinates.x == two_three.x and window_coordinates.y == two_three.y
        and window_coordinates.h == two_three.h and window_coordinates.w == two_three.w then
            print('right from two_three to three')
            window.x = three.x
            window.y = three.y
            window.h = three.h
            window.w = three.w
        -- if the window is in three, then move it to three_four
        elseif window_coordinates.x == three.x and window_coordinates.y == three.y
        and window_coordinates.h == three.h and window_coordinates.w == three.w then
            print('right from three to three_four')
            window.x = three_four.x
            window.y = three_four.y
            window.h = three_four.h
            window.w = three_four.w
        -- if the window is in three_four, then move it to four
        elseif window_coordinates.x == three_four.x and window_coordinates.y == three_four.y
        and window_coordinates.h == three_four.h and window_coordinates.w == three_four.w then
            print('right from three_four to four')
            window.x = four.x
            window.y = four.y
            window.h = four.h
            window.w = four.w
        -- if the window is in four, then move it to one
        elseif window_coordinates.x == four.x and window_coordinates.y == four.y
        and window_coordinates.h == four.h and window_coordinates.w == four.w then
            print('right from four to one')
            window.x = one.x
            window.y = one.y
            window.h = one.h
            window.w = one.w
        elseif window_coordinates.x == upper_one.x and window_coordinates.y == upper_one.y
        and window_coordinates.h == upper_one.h and window_coordinates.w == upper_one.w then
            window.x = upper_two.x
            window.y = upper_two.y
            window.h = upper_two.h
            window.w = upper_two.w
        -- if the window is in upper_two, then move it to upper_three
        elseif window_coordinates.x == upper_two.x and window_coordinates.y == upper_two.y
        and window_coordinates.h == upper_two.h and window_coordinates.w == upper_two.w then
            if num_cols == 2 then
                window.x = upper_one.x
                window.y = upper_one.y
                window.h = upper_one.h
                window.w = upper_one.w
            else
                window.x = upper_three.x
                window.y = upper_three.y
                window.h = upper_three.h
                window.w = upper_three.w
            end
        -- if the window is in upper_three, then move it to upper_four
        elseif window_coordinates.x == upper_three.x and window_coordinates.y == upper_three.y
        and window_coordinates.h == upper_three.h and window_coordinates.w == upper_three.w then
            window.x = upper_four.x
            window.y = upper_four.y
            window.h = upper_four.h
            window.w = upper_four.w
        -- if the window is in upper_four, then move it to upper_one
        elseif window_coordinates.x == upper_four.x and window_coordinates.y == upper_four.y
        and window_coordinates.h == upper_four.h and window_coordinates.w == upper_four.w then
            window.x = upper_one.x
            window.y = upper_one.y
            window.h = upper_one.h
            window.w = upper_one.w
        -- if the window is in lower_one, then move it to lower_two
        elseif window_coordinates.x == lower_one.x and window_coordinates.y == lower_one.y
        and window_coordinates.h == lower_one.h and window_coordinates.w == lower_one.w then
            window.x = lower_two.x
            window.y = lower_two.y
            window.h = lower_two.h
            window.w = lower_two.w
        -- if the window is in lower_two, then move it to lower_three
        elseif window_coordinates.x == lower_two.x and window_coordinates.y == lower_two.y
        and window_coordinates.h == lower_two.h and window_coordinates.w == lower_two.w then
            if num_cols == 2 then
                window.x = lower_one.x
                window.y = lower_one.y
                window.h = lower_one.h
                window.w = lower_one.w
            else
                window.x = lower_three.x
                window.y = lower_three.y
                window.h = lower_three.h
                window.w = lower_three.w
            end
        -- if the window is in lower_three, then move it to lower_four
        elseif window_coordinates.x == lower_three.x and window_coordinates.y == lower_three.y
        and window_coordinates.h == lower_three.h and window_coordinates.w == lower_three.w then
            window.x = lower_four.x
            window.y = lower_four.y
            window.h = lower_four.h
            window.w = lower_four.w
        -- if the window is in lower_four, then move it to lower_one
        elseif window_coordinates.x == lower_four.x and window_coordinates.y == lower_four.y
        and window_coordinates.h == lower_four.h and window_coordinates.w == lower_four.w then
            window.x = lower_one.x
            window.y = lower_one.y
            window.h = lower_one.h
            window.w = lower_one.w
        -- if the window is in one_two_three, then move it to two_three_four
        elseif window_coordinates.x == one_two_three.x and window_coordinates.y == one_two_three.y
        and window_coordinates.h == one_two_three.h and window_coordinates.w == one_two_three.w then
            window.x = two_three_four.x
            window.y = two_three_four.y
            window.h = two_three_four.h
            window.w = two_three_four.w
        -- if the window is in two_three_four, then move it to one_two_three
        elseif window_coordinates.x == two_three_four.x and window_coordinates.y == two_three_four.y
        and window_coordinates.h == two_three_four.h and window_coordinates.w == two_three_four.w then
            window.x = one_two_three.x
            window.y = one_two_three.y
            window.h = one_two_three.h
            window.w = one_two_three.w
        -- else 
        else
            -- determine the closest section to the right of current location between one, two, three, four, and five
            local one_distance = math.sqrt(math.pow(window_coordinates.x - one.x, 2) + math.pow(window_coordinates.y - one.y, 2))  
            local two_distance = math.sqrt(math.pow(window_coordinates.x - two.x, 2) + math.pow(window_coordinates.y - two.y, 2))
            local three_distance = math.sqrt(math.pow(window_coordinates.x - three.x, 2) + math.pow(window_coordinates.y - three.y, 2))
            local four_distance = math.sqrt(math.pow(window_coordinates.x - four.x, 2) + math.pow(window_coordinates.y - four.y, 2))
            
            local min_distance = math.min(one_distance, two_distance, three_distance, four_distance)
            if min_distance == one_distance then
                window.x = one.x
                window.y = one.y
                window.h = one.h
                window.w = one.w
            elseif min_distance == two_distance then
                window.x = two.x
                window.y = two.y
                window.h = two.h
                window.w = two.w
            elseif min_distance == three_distance then
                window.x = three.x
                window.y = three.y
                window.h = three.h
                window.w = three.w
            elseif min_distance == four_distance then
                window.x = four.x
                window.y = four.y
                window.h = four.h
                window.w = four.w
            end
        end
    elseif direction == 'left' then
        -- if the window is in four, then move it to three_four
        if window_coordinates.x == four.x and window_coordinates.y == four.y
        and window_coordinates.h == four.h and window_coordinates.w == four.w then
            window.x = three_four.x
            window.y = three_four.y
            window.h = three_four.h
            window.w = three_four.w
        -- if the window is in three_four, then move it to three
        elseif window_coordinates.x == three_four.x and window_coordinates.y == three_four.y
        and window_coordinates.h == three_four.h and window_coordinates.w == three_four.w then
            window.x = three.x
            window.y = three.y
            window.h = three.h
            window.w = three.w
        -- if the window is in three, then move it to two_three
        elseif window_coordinates.x == three.x and window_coordinates.y == three.y
        and window_coordinates.h == three.h and window_coordinates.w == three.w then
            window.x = two_three.x
            window.y = two_three.y
            window.h = two_three.h
            window.w = two_three.w
        -- if the window is in two_three, then move it to two
        elseif window_coordinates.x == two_three.x and window_coordinates.y == two_three.y
        and window_coordinates.h == two_three.h and window_coordinates.w == two_three.w then
            window.x = two.x
            window.y = two.y
            window.h = two.h
            window.w = two.w
        -- if the window is in two, then move it to one_two
        elseif window_coordinates.x == two.x and window_coordinates.y == two.y
        and window_coordinates.h == two.h and window_coordinates.w == two.w then
            window.x = one_two.x
            window.y = one_two.y
            window.h = one_two.h
            window.w = one_two.w
        -- if the window is in one_two, then move it to one
        elseif window_coordinates.x == one_two.x and window_coordinates.y == one_two.y
        and window_coordinates.h == one_two.h and window_coordinates.w == one_two.w then
            window.x = one.x
            window.y = one.y
            window.h = one.h
            window.w = one.w
        -- if the window is in one, then move it to four
        elseif window_coordinates.x == one.x and window_coordinates.y == one.y
        and window_coordinates.h == one.h and window_coordinates.w == one.w then
            if num_cols == 2 then
                window.x = two.x
                window.y = two.y
                window.h = two.h
                window.w = two.w
            else
                window.x = four.x
                window.y = four.y
                window.h = four.h
                window.w = four.w
            end
            print("Moving from one to four (wrap-around)")
            print("four.x:", four.x, "four.y:", four.y, "four.w:", four.w, "four.h:", four.h)
        -- if the window is in upper_four, then move it to upper_three
        elseif window_coordinates.x == upper_four.x and window_coordinates.y == upper_four.y
        and window_coordinates.h == upper_four.h and window_coordinates.w == upper_four.w then
            window.x = upper_three.x
            window.y = upper_three.y
            window.h = upper_three.h
            window.w = upper_three.w
        -- if the window is in upper_three, then move it to upper_two
        elseif window_coordinates.x == upper_three.x and window_coordinates.y == upper_three.y
        and window_coordinates.h == upper_three.h and window_coordinates.w == upper_three.w then
            window.x = upper_two.x
            window.y = upper_two.y
            window.h = upper_two.h
            window.w = upper_two.w
        -- if the window is in upper_two, then move it to upper_one
        elseif window_coordinates.x == upper_two.x and window_coordinates.y == upper_two.y
        and window_coordinates.h == upper_two.h and window_coordinates.w == upper_two.w then
            window.x = upper_one.x
            window.y = upper_one.y
            window.h = upper_one.h
            window.w = upper_one.w
        -- if the window is in upper_one, then move it to upper_four
        elseif window_coordinates.x == upper_one.x and window_coordinates.y == upper_one.y
        and window_coordinates.h == upper_one.h and window_coordinates.w == upper_one.w then
            if num_cols == 2 then
                window.x = upper_two.x
                window.y = upper_two.y
                window.h = upper_two.h
                window.w = upper_two.w
            else
                window.x = upper_four.x
                window.y = upper_four.y
                window.h = upper_four.h
                window.w = upper_four.w
            end
        -- if the window is in lower_four, then move it to lower_three
        elseif window_coordinates.x == lower_four.x and window_coordinates.y == lower_four.y
        and window_coordinates.h == lower_four.h and window_coordinates.w == lower_four.w then
            window.x = lower_three.x
            window.y = lower_three.y
            window.h = lower_three.h
            window.w = lower_three.w
        -- if the window is in lower_three, then move it to lower_two
        elseif window_coordinates.x == lower_three.x and window_coordinates.y == lower_three.y
        and window_coordinates.h == lower_three.h and window_coordinates.w == lower_three.w then
            window.x = lower_two.x
            window.y = lower_two.y
            window.h = lower_two.h
            window.w = lower_two.w
        -- if the window is in lower_two, then move it to lower_one
        elseif window_coordinates.x == lower_two.x and window_coordinates.y == lower_two.y
        and window_coordinates.h == lower_two.h and window_coordinates.w == lower_two.w then
            window.x = lower_one.x
            window.y = lower_one.y
            window.h = lower_one.h
            window.w = lower_one.w
        -- if the window is in lower_one, then move it to lower_four
        elseif window_coordinates.x == lower_one.x and window_coordinates.y == lower_one.y
        and window_coordinates.h == lower_one.h and window_coordinates.w == lower_one.w then
            if num_cols == 2 then
                window.x = lower_two.x
                window.y = lower_two.y
                window.h = lower_two.h
                window.w = lower_two.w
            else
                window.x = lower_four.x
                window.y = lower_four.y
                window.h = lower_four.h
                window.w = lower_four.w
            end
        -- if the window is in one_two_three, then move it to two_three_four
        elseif window_coordinates.x == one_two_three.x and window_coordinates.y == one_two_three.y
        and window_coordinates.h == one_two_three.h and window_coordinates.w == one_two_three.w then
            window.x = two_three_four.x
            window.y = two_three_four.y
            window.h = two_three_four.h
            window.w = two_three_four.w
        -- if the window is in two_three_four, then move it to one_two_three
        elseif window_coordinates.x == two_three_four.x and window_coordinates.y == two_three_four.y
        and window_coordinates.h == two_three_four.h and window_coordinates.w == two_three_four.w then
            window.x = one_two_three.x
            window.y = one_two_three.y
            window.h = one_two_three.h
            window.w = one_two_three.w
        -- else move it to one
        else
            -- determine the closest section to the left of current location between one, two, three, four, and five
            local one_distance = math.sqrt(math.pow(window_coordinates.x - one.x, 2) + math.pow(window_coordinates.y - one.y, 2))
            local two_distance = math.sqrt(math.pow(window_coordinates.x - two.x, 2) + math.pow(window_coordinates.y - two.y, 2))
            local three_distance = math.sqrt(math.pow(window_coordinates.x - three.x, 2) + math.pow(window_coordinates.y - three.y, 2))
            local four_distance = math.sqrt(math.pow(window_coordinates.x - four.x, 2) + math.pow(window_coordinates.y - four.y, 2))
            local min_distance = math.min(one_distance, two_distance, three_distance, four_distance)
            if min_distance == one_distance then
                window.x = one.x
                window.y = one.y
                window.h = one.h
                window.w = one.w
            elseif min_distance == two_distance then
                window.x = two.x
                window.y = two.y
                window.h = two.h
                window.w = two.w
            elseif min_distance == three_distance then
                window.x = three.x
                window.y = three.y
                window.h = three.h
                window.w = three.w
            elseif min_distance == four_distance then
                window.x = four.x
                window.y = four.y
                window.h = four.h
                window.w = four.w
            end
        end
    elseif direction == 'up' then
        -- if the the window is in lower_one, then move it to one
        if window_coordinates.x == lower_one.x and window_coordinates.y == lower_one.y
        and window_coordinates.h == lower_one.h and window_coordinates.w == lower_one.w then
            window.x = one.x
            window.y = one.y
            window.h = one.h
            window.w = one.w
        -- if the window is in lower_two, then move it to two
        elseif window_coordinates.x == lower_two.x and window_coordinates.y == lower_two.y
        and window_coordinates.h == lower_two.h and window_coordinates.w == lower_two.w then
            window.x = two.x
            window.y = two.y
            window.h = two.h
            window.w = two.w
        -- if the window is in lower_three, then move it to three
        elseif window_coordinates.x == lower_three.x and window_coordinates.y == lower_three.y
        and window_coordinates.h == lower_three.h and window_coordinates.w == lower_three.w then
            window.x = three.x
            window.y = three.y
            window.h = three.h
            window.w = three.w
        -- if the window is in lower_four, then move it to four
        elseif window_coordinates.x == lower_four.x and window_coordinates.y == lower_four.y
        and window_coordinates.h == lower_four.h and window_coordinates.w == lower_four.w then
            window.x = four.x
            window.y = four.y
            window.h = four.h
            window.w = four.w
        -- if the window is in one, then move it to upper one
        elseif window_coordinates.x == one.x and window_coordinates.y == one.y
        and window_coordinates.h == one.h and window_coordinates.w == one.w then
            window.x = upper_one.x
            window.y = upper_one.y
            window.h = upper_one.h
            window.w = upper_one.w
        -- if the window is in two, then move it to upper two
        elseif window_coordinates.x == two.x and window_coordinates.y == two.y
        and window_coordinates.h == two.h and window_coordinates.w == two.w then
            window.x = upper_two.x
            window.y = upper_two.y
            window.h = upper_two.h
            window.w = upper_two.w
        -- if the window is in three, then move it to upper three
        elseif window_coordinates.x == three.x and window_coordinates.y == three.y
        and window_coordinates.h == three.h and window_coordinates.w == three.w then
            window.x = upper_three.x
            window.y = upper_three.y
            window.h = upper_three.h
            window.w = upper_three.w
        -- if the window is in four, then move it to upper four
        elseif window_coordinates.x == four.x and window_coordinates.y == four.y
        and window_coordinates.h == four.h and window_coordinates.w == four.w then
            window.x = upper_four.x
            window.y = upper_four.y
            window.h = upper_four.h
            window.w = upper_four.w
        -- if the window is in upper_one, then move it to lower_one
        elseif window_coordinates.x == upper_one.x and window_coordinates.y == upper_one.y
        and window_coordinates.h == upper_one.h and window_coordinates.w == upper_one.w then
            window.x = lower_one.x
            window.y = lower_one.y
            window.h = lower_one.h
            window.w = lower_one.w
        -- if the window is in upper_two, then move it to lower_two
        elseif window_coordinates.x == upper_two.x and window_coordinates.y == upper_two.y
        and window_coordinates.h == upper_two.h and window_coordinates.w == upper_two.w then
            window.x = lower_two.x
            window.y = lower_two.y
            window.h = lower_two.h
            window.w = lower_two.w
        -- if the window is in upper_three, then move it to lower_three
        elseif window_coordinates.x == upper_three.x and window_coordinates.y == upper_three.y
        and window_coordinates.h == upper_three.h and window_coordinates.w == upper_three.w then
            window.x = lower_three.x
            window.y = lower_three.y
            window.h = lower_three.h
            window.w = lower_three.w
        -- if the window is in upper_four, then move it to lower_four
        elseif window_coordinates.x == upper_four.x and window_coordinates.y == upper_four.y
        and window_coordinates.h == upper_four.h and window_coordinates.w == upper_four.w then
            window.x = lower_four.x
            window.y = lower_four.y
            window.h = lower_four.h
            window.w = lower_four.w
        -- if the window is in one_two or two_three, then move it to one_two_three
        elseif (window_coordinates.x == one_two.x and window_coordinates.y == one_two.y
        and window_coordinates.h == one_two.h and window_coordinates.w == one_two.w) 
        or (window_coordinates.x == two_three.x and window_coordinates.y == two_three.y
        and window_coordinates.h == two_three.h and window_coordinates.w == two_three.w) then
            window.x = one_two_three.x
            window.y = one_two_three.y
            window.h = one_two_three.h
            window.w = one_two_three.w
        -- if the window is in three_four, then move it to two_three_four
        elseif (window_coordinates.x == three_four.x and window_coordinates.y == three_four.y
        and window_coordinates.h == three_four.h and window_coordinates.w == three_four.w) then
            window.x = two_three_four.x
            window.y = two_three_four.y
            window.h = two_three_four.h
            window.w = two_three_four.w
        -- if the window is in one_two_three or two_three_four, then move it to one_two_three_four
        elseif (window_coordinates.x == one_two_three.x and window_coordinates.y == one_two_three.y
        and window_coordinates.h == one_two_three.h and window_coordinates.w == one_two_three.w)
        or (window_coordinates.x == two_three_four.x and window_coordinates.y == two_three_four.y
        and window_coordinates.h == two_three_four.h and window_coordinates.w == two_three_four.w) then
            window.x = one_two_three_four.x
            window.y = one_two_three_four.y
            window.h = one_two_three_four.h
            window.w = one_two_three_four.w
        -- if the window is in one_two_three_four, then move it to two
        elseif window_coordinates.x == one_two_three_four.x and window_coordinates.y == one_two_three_four.y
        and window_coordinates.h == one_two_three_four.h and window_coordinates.w == one_two_three_four.w then
            window.x = two.x
            window.y = two.y
            window.h = two.h
            window.w = two.w
        -- else move it to closest fifth column of the screen
        else
            -- determine the closest section to the current location between one, two, three, four, and five
            local one_distance = math.sqrt(math.pow(window_coordinates.x - one.x, 2) + math.pow(window_coordinates.y - one.y, 2))
            local two_distance = math.sqrt(math.pow(window_coordinates.x - two.x, 2) + math.pow(window_coordinates.y - two.y, 2))
            local three_distance = math.sqrt(math.pow(window_coordinates.x - three.x, 2) + math.pow(window_coordinates.y - three.y, 2))
            local four_distance = math.sqrt(math.pow(window_coordinates.x - four.x, 2) + math.pow(window_coordinates.y - four.y, 2))
            local min_distance = math.min(one_distance, two_distance, three_distance, four_distance)

            if min_distance == one_distance then
                window.x = one.x
                window.y = one.y
                window.h = one.h
                window.w = one.w
            elseif min_distance == two_distance then
                window.x = two.x
                window.y = two.y
                window.h = two.h
                window.w = two.w
            elseif min_distance == three_distance then
                window.x = three.x
                window.y = three.y
                window.h = three.h
                window.w = three.w
            elseif min_distance == four_distance then
                window.x = four.x
                window.y = four.y
                window.h = four.h
                window.w = four.w
            end
        end
    elseif direction == 'down' then
        -- if the window is in one, then move it to lower_one
        if window_coordinates.x == one.x and window_coordinates.y == one.y
        and window_coordinates.h == one.h and window_coordinates.w == one.w then
            window.x = lower_one.x
            window.y = lower_one.y
            window.h = lower_one.h
            window.w = lower_one.w
        -- if the window is in two, then move it to lower_two
        elseif window_coordinates.x == two.x and window_coordinates.y == two.y
        and window_coordinates.h == two.h and window_coordinates.w == two.w then
            window.x = lower_two.x
            window.y = lower_two.y
            window.h = lower_two.h
            window.w = lower_two.w
        -- if the window is in three, then move it to lower_three
        elseif window_coordinates.x == three.x and window_coordinates.y == three.y
        and window_coordinates.h == three.h and window_coordinates.w == three.w then
            window.x = lower_three.x
            window.y = lower_three.y
            window.h = lower_three.h
            window.w = lower_three.w
        -- if the window is in four, then move it to lower_four
        elseif window_coordinates.x == four.x and window_coordinates.y == four.y
        and window_coordinates.h == four.h and window_coordinates.w == four.w then
            window.x = lower_four.x
            window.y = lower_four.y
            window.h = lower_four.h
            window.w = lower_four.w
        -- if the window is in upper_one, then move it to one
        elseif window_coordinates.x == upper_one.x and window_coordinates.y == upper_one.y
        and window_coordinates.h == upper_one.h and window_coordinates.w == upper_one.w then
            window.x = one.x
            window.y = one.y
            window.h = one.h
            window.w = one.w
        -- if the window is in upper_two, then move it to two
        elseif window_coordinates.x == upper_two.x and window_coordinates.y == upper_two.y
        and window_coordinates.h == upper_two.h and window_coordinates.w == upper_two.w then
            window.x = two.x
            window.y = two.y
            window.h = two.h
            window.w = two.w
        -- if the window is in upper_three, then move it to three
        elseif window_coordinates.x == upper_three.x and window_coordinates.y == upper_three.y
        and window_coordinates.h == upper_three.h and window_coordinates.w == upper_three.w then
            window.x = three.x
            window.y = three.y
            window.h = three.h
            window.w = three.w
        -- if the window is in upper_four, then move it to four
        elseif window_coordinates.x == upper_four.x and window_coordinates.y == upper_four.y
        and window_coordinates.h == upper_four.h and window_coordinates.w == upper_four.w then
            window.x = four.x
            window.y = four.y
            window.h = four.h
            window.w = four.w
        -- if the window is in lower_one, then move it to upper_one
        elseif window_coordinates.x == lower_one.x and window_coordinates.y == lower_one.y
        and window_coordinates.h == lower_one.h and window_coordinates.w == lower_one.w then
            window.x = upper_one.x
            window.y = upper_one.y
            window.h = upper_one.h
            window.w = upper_one.w
        -- if the window is in lower_two, then move it to upper_two
        elseif window_coordinates.x == lower_two.x and window_coordinates.y == lower_two.y
        and window_coordinates.h == lower_two.h and window_coordinates.w == lower_two.w then
            window.x = upper_two.x
            window.y = upper_two.y
            window.h = upper_two.h
            window.w = upper_two.w
        -- if the window is in lower_three, then move it to upper_three
        elseif window_coordinates.x == lower_three.x and window_coordinates.y == lower_three.y
        and window_coordinates.h == lower_three.h and window_coordinates.w == lower_three.w then
            window.x = upper_three.x
            window.y = upper_three.y
            window.h = upper_three.h
            window.w = upper_three.w
        -- if the window is in lower_four, then move it to upper_four
        elseif window_coordinates.x == lower_four.x and window_coordinates.y == lower_four.y
        and window_coordinates.h == lower_four.h and window_coordinates.w == lower_four.w then
            window.x = upper_four.x
            window.y = upper_four.y
            window.h = upper_four.h
            window.w = upper_four.w
        -- if the window is in one_two or two_three, then move it to two
        elseif (window_coordinates.x == one_two.x and window_coordinates.y == one_two.y
        and window_coordinates.h == one_two.h and window_coordinates.w == one_two.w)
        or (window_coordinates.x == two_three.x and window_coordinates.y == two_three.y
        and window_coordinates.h == two_three.h and window_coordinates.w == two_three.w) then
            window.x = two.x
            window.y = two.y
            window.h = two.h
            window.w = two.w
        -- if the window is in three_four, then move it to three
        elseif (window_coordinates.x == three_four.x and window_coordinates.y == three_four.y
        and window_coordinates.h == three_four.h and window_coordinates.w == three_four.w) then
            window.x = three.x
            window.y = three.y
            window.h = three.h
            window.w = three.w
        -- if the window is in one_two_three or two_three_four, then move it to two_three
        elseif (window_coordinates.x == one_two_three.x and window_coordinates.y == one_two_three.y
        and window_coordinates.h == one_two_three.h and window_coordinates.w == one_two_three.w)
        or (window_coordinates.x == two_three_four.x and window_coordinates.y == two_three_four.y
        and window_coordinates.h == two_three_four.h and window_coordinates.w == two_three_four.w) then
            window.x = two_three.x
            window.y = two_three.y
            window.h = two_three.h
            window.w = two_three.w
        -- if the window is in one_two_three_four, then move it to one_two_three
        elseif window_coordinates.x == one_two_three_four.x and window_coordinates.y == one_two_three_four.y
        and window_coordinates.h == one_two_three_four.h and window_coordinates.w == one_two_three_four.w then
            window.x = one_two_three.x
            window.y = one_two_three.y
            window.h = one_two_three.h
            window.w = one_two_three.w
        -- else move it to closest fifth column of the screen
        else
            -- determine the closest section to the current location between one, two, three, four, and five
            local one_distance = math.sqrt(math.pow(window_coordinates.x - one.x, 2) + math.pow(window_coordinates.y - one.y, 2))
            local two_distance = math.sqrt(math.pow(window_coordinates.x - two.x, 2) + math.pow(window_coordinates.y - two.y, 2))
            local three_distance = math.sqrt(math.pow(window_coordinates.x - three.x, 2) + math.pow(window_coordinates.y - three.y, 2))
            local four_distance = math.sqrt(math.pow(window_coordinates.x - four.x, 2) + math.pow(window_coordinates.y - four.y, 2))
            local min_distance = math.min(one_distance, two_distance, three_distance, four_distance)
            
            if min_distance == one_distance then
                window.x = one.x
                window.y = one.y
                window.h = one.h
                window.w = one.w
            elseif min_distance == two_distance then
                window.x = two.x
                window.y = two.y
                window.h = two.h
                window.w = two.w
            elseif min_distance == three_distance then
                window.x = three.x
                window.y = three.y
                window.h = three.h
                window.w = three.w
            elseif min_distance == four_distance then
                window.x = four.x
                window.y = four.y
                window.h = four.h
                window.w = four.w
            end
        end
    end
    focusedWindow:setFrame(window)
end

local function focusWindowInDirection(direction)
    local focusedWindow = hs_window.focusedWindow()
    if not focusedWindow then return end
    
    local otherWindow
    if direction == 'right' then
        otherWindow = focusedWindow:windowsToEast(nil, false, true)[1]
    elseif direction == 'left' then
        otherWindow = focusedWindow:windowsToWest(nil, false, true)[1]
    elseif direction == 'up' then
        otherWindow = focusedWindow:windowsToNorth(nil, false, true)[1]
    elseif direction == 'down' then
        otherWindow = focusedWindow:windowsToSouth(nil, false, true)[1]
    end

    if otherWindow then
        otherWindow:focus()
    end
end

local arrows = {'right', 'left', 'up', 'down'}
-- loop through the array and bind the hotkeys
for _, arrow in ipairs(arrows) do
    hs_hotkey.bind({"⌘ ⌥ ctrl"}, arrow, function()
        focusWindowInDirection(arrow)
    end)
    hs_hotkey.bind({"⌘ ⌥"}, arrow, function()
        moveWindowInDirection(arrow)
    end)
end


