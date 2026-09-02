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
    local screen = focusedWindow:screen()
    -- create a table of all the monitors sorted by their x coordinates
    local monitor = screen:frame()
    local window = focusedWindow:frame()

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
    local dock = 'bottom' -- 'bottom' or 'left' or 'right'
    local height_adjustment = 0
    if dock == 'bottom' then
        height_adjustment = 1
    end
    local num_cols = 2
    local num_thirds = 3

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
    local one_third = {
        x = math.floor(monitor.x + (monitor.w / num_thirds) * 0),
        y = math.floor(monitor.y),
        w = math.floor(monitor.w / num_thirds),
        h = math.floor(monitor.h - height_adjustment)
    }
    local two_third = {
        x = math.floor(monitor.x + (monitor.w / num_thirds) * 1),
        y = math.floor(monitor.y),
        w = math.floor(monitor.w / num_thirds),
        h = math.floor(monitor.h - height_adjustment)
    }
    local three_third = {
        x = math.floor(monitor.x + (monitor.w / num_thirds) * 2),
        y = math.floor(monitor.y),
        w = math.floor(monitor.w / num_thirds),
        h = math.floor(monitor.h - height_adjustment)
    }
    local one_two_third = {
        x = math.floor(monitor.x + (monitor.w / num_thirds) * 0),
        y = math.floor(monitor.y),
        w = math.floor(2 * monitor.w / num_thirds),
        h = math.floor(monitor.h - height_adjustment)
    }
    local two_three_third = {
        x = math.floor(monitor.x + (monitor.w / num_thirds) * 1),
        y = math.floor(monitor.y),
        w = math.floor(2 * monitor.w / num_thirds),
        h = math.floor(monitor.h - height_adjustment)
    }
    local one_two_three_four_third = {
        x = math.floor(monitor.x),
        y = math.floor(monitor.y),
        w = math.floor(monitor.w - 1), -- hack to make it different than one_two_three_four and allow up down cycling for thirds
        h = math.floor(monitor.h - height_adjustment)
    }
    -- Upper- and lower-half counterparts of the five third-width slots. The
    -- half- and quarter-width slots have had these all along, which is what
    -- lets ⌘⌥↑/↓ drop them into the top or bottom half of the screen; without
    -- them a third-width window had no vertical dimension at all and ⌘⌥↑ fell
    -- through to the nearest-slot fallback at the end of this function.
    -- x/w come from the full-height slots above so the columns stay aligned.
    local upper_row_y = math.floor(monitor.y)
    local lower_row_y = math.floor(monitor.y + (monitor.h / 2))
    local row_h = math.floor(monitor.h / 2)
    local function upper_of(slot)
        return {x = slot.x, y = upper_row_y, w = slot.w, h = row_h}
    end
    local function lower_of(slot)
        return {x = slot.x, y = lower_row_y, w = slot.w, h = row_h}
    end

    local upper_one_third       = upper_of(one_third)
    local lower_one_third       = lower_of(one_third)
    local upper_two_third       = upper_of(two_third)
    local lower_two_third       = lower_of(two_third)
    local upper_three_third     = upper_of(three_third)
    local lower_three_third     = lower_of(three_third)
    local upper_one_two_third   = upper_of(one_two_third)
    local lower_one_two_third   = lower_of(one_two_third)
    local upper_two_three_third = upper_of(two_three_third)
    local lower_two_three_third = lower_of(two_three_third)

    -- Quarter positions (25%-wide columns, for 2-col monitors)
    local q1 = {
        x = math.floor(monitor.x),
        y = math.floor(monitor.y),
        w = math.floor(monitor.w / 4),
        h = math.floor(monitor.h - height_adjustment)
    }
    local q2 = {
        x = math.floor(monitor.x + monitor.w / 4),
        y = math.floor(monitor.y),
        w = math.floor(monitor.w / 4),
        h = math.floor(monitor.h - height_adjustment)
    }
    local q3 = {
        x = math.floor(monitor.x + monitor.w / 2),
        y = math.floor(monitor.y),
        w = math.floor(monitor.w / 4),
        h = math.floor(monitor.h - height_adjustment)
    }
    local q4 = {
        x = math.floor(monitor.x + 3 * monitor.w / 4),
        y = math.floor(monitor.y),
        w = math.floor(monitor.w / 4),
        h = math.floor(monitor.h - height_adjustment)
    }
    local center_half = {
        x = math.floor(monitor.x + monitor.w / 4),
        y = math.floor(monitor.y),
        w = math.floor(monitor.w / 2),
        h = math.floor(monitor.h - height_adjustment)
    }
    local upper_q1 = {
        x = math.floor(monitor.x),
        y = math.floor(monitor.y),
        w = math.floor(monitor.w / 4),
        h = math.floor(monitor.h / 2)
    }
    local upper_q2 = {
        x = math.floor(monitor.x + monitor.w / 4),
        y = math.floor(monitor.y),
        w = math.floor(monitor.w / 4),
        h = math.floor(monitor.h / 2)
    }
    local upper_q3 = {
        x = math.floor(monitor.x + monitor.w / 2),
        y = math.floor(monitor.y),
        w = math.floor(monitor.w / 4),
        h = math.floor(monitor.h / 2)
    }
    local upper_q4 = {
        x = math.floor(monitor.x + 3 * monitor.w / 4),
        y = math.floor(monitor.y),
        w = math.floor(monitor.w / 4),
        h = math.floor(monitor.h / 2)
    }
    local upper_center_half = {
        x = math.floor(monitor.x + monitor.w / 4),
        y = math.floor(monitor.y),
        w = math.floor(monitor.w / 2),
        h = math.floor(monitor.h / 2)
    }
    local lower_q1 = {
        x = math.floor(monitor.x),
        y = math.floor(monitor.y + monitor.h / 2),
        w = math.floor(monitor.w / 4),
        h = math.floor(monitor.h / 2)
    }
    local lower_q2 = {
        x = math.floor(monitor.x + monitor.w / 4),
        y = math.floor(monitor.y + monitor.h / 2),
        w = math.floor(monitor.w / 4),
        h = math.floor(monitor.h / 2)
    }
    local lower_q3 = {
        x = math.floor(monitor.x + monitor.w / 2),
        y = math.floor(monitor.y + monitor.h / 2),
        w = math.floor(monitor.w / 4),
        h = math.floor(monitor.h / 2)
    }
    local lower_q4 = {
        x = math.floor(monitor.x + 3 * monitor.w / 4),
        y = math.floor(monitor.y + monitor.h / 2),
        w = math.floor(monitor.w / 4),
        h = math.floor(monitor.h / 2)
    }
    local lower_center_half = {
        x = math.floor(monitor.x + monitor.w / 4),
        y = math.floor(monitor.y + monitor.h / 2),
        w = math.floor(monitor.w / 2),
        h = math.floor(monitor.h / 2)
    }

    -- Some apps (e.g. Chrome) settle a few px away from the requested frame after setFrame.
    -- Snap window_coordinates to the nearest known slot before matching, so exact checks work.
    do
        local slots = {
            one, two, three, four,
            upper_one, upper_two, upper_three, upper_four,
            lower_one, lower_two, lower_three, lower_four,
            one_two, two_three, three_four,
            one_two_three, two_three_four, one_two_three_four,
            one_third, two_third, three_third,
            one_two_third, two_three_third, one_two_three_four_third,
            upper_one_third, upper_two_third, upper_three_third,
            upper_one_two_third, upper_two_three_third,
            lower_one_third, lower_two_third, lower_three_third,
            lower_one_two_third, lower_two_three_third,
            q1, q2, q3, q4, center_half,
            upper_q1, upper_q2, upper_q3, upper_q4, upper_center_half,
            lower_q1, lower_q2, lower_q3, lower_q4, lower_center_half
        }
        local tol = 5
        local best, best_dist = nil, math.huge
        for _, slot in ipairs(slots) do
            local dx = math.abs(window_coordinates.x - slot.x)
            local dy = math.abs(window_coordinates.y - slot.y)
            local dw = math.abs(window_coordinates.w - slot.w)
            local dh = math.abs(window_coordinates.h - slot.h)
            if dx <= tol and dy <= tol and dw <= tol and dh <= tol then
                local dist = dx + dy + dw + dh
                if dist < best_dist then best, best_dist = slot, dist end
            end
        end
        if best then
            window_coordinates = {x=best.x, y=best.y, w=best.w, h=best.h}
        end
    end

    -- Slot cycling on 2-column monitors walks an explicit grid instead of the
    -- branch cascade below: ←/→ step along a row, ↑/↓ step between rows.
    --
    -- Columns are ordered by the *center* of the slot, which is the rule the
    -- cascade already followed for halves and quarters (centers 25, 37.5, 50,
    -- 62.5, 75, 87.5), so ⌘⌥→ sweeps the window steadily left to right and the
    -- third-width slots simply interleave at their own centers.
    --
    -- Rows are ordered the way ⌘⌥↑ already walked them for halves and
    -- quarters: full height → top half → bottom half, wrapping.
    --
    -- Slot names read oddly, so: two_third is the MIDDLE third, three_third the
    -- RIGHT third, one_two_third the LEFT two-thirds, two_three_third the RIGHT
    -- two-thirds.
    if num_cols == 2 then
        local ROW_FULL, ROW_COUNT = 1, 3
        local columns = {
            --  full height       top half               bottom half              span    center
            {q1,              upper_q1,              lower_q1             }, --   0-25    12.5
            {one_third,       upper_one_third,       lower_one_third      }, --   0-33    16.7
            {one,             upper_one,             lower_one            }, --   0-50    25
            {one_two_third,   upper_one_two_third,   lower_one_two_third  }, --   0-67    33.3
            {q2,              upper_q2,              lower_q2             }, --  25-50    37.5
            {two_third,       upper_two_third,       lower_two_third      }, --  33-67    50
            {center_half,     upper_center_half,     lower_center_half    }, --  25-75    50
            {q3,              upper_q3,              lower_q3             }, --  50-75    62.5
            {two_three_third, upper_two_three_third, lower_two_three_third}, --  33-100   66.7
            {two,             upper_two,             lower_two            }, --  50-100   75
            {three_third,     upper_three_third,     lower_three_third    }, --  67-100   83.3
            {q4,              upper_q4,              lower_q4             }, --  75-100   87.5
        }

        local function matches(slot)
            return window_coordinates.x == slot.x and window_coordinates.y == slot.y
               and window_coordinates.w == slot.w and window_coordinates.h == slot.h
        end

        local col, row
        for c = 1, #columns do
            for r = 1, ROW_COUNT do
                if matches(columns[c][r]) then col, row = c, r break end
            end
            if col then break end
        end

        local target
        if col and (direction == 'right' or direction == 'left') then
            -- The full-height row carries full screen as an extra stop, the
            -- wrap between q4 and q1. The half-height rows have no such slot.
            local n = (row == ROW_FULL) and #columns + 1 or #columns
            local step = (direction == 'right') and 1 or -1
            local i = ((col - 1 + step) % n) + 1
            target = (i > #columns) and one_two_three_four or columns[i][row]
        elseif col then
            local step = (direction == 'up') and 1 or -1
            target = columns[col][((row - 1 + step) % ROW_COUNT) + 1]
        elseif matches(one_two_three_four) then
            -- Full screen: ←/→ enter the row at its ends, while ↑/↓ keep the
            -- long-standing behaviour of splitting into left/right half.
            if direction == 'right' then
                target = columns[1][ROW_FULL]
            elseif direction == 'left' then
                target = columns[#columns][ROW_FULL]
            elseif direction == 'up' then
                target = one
            else
                target = two
            end
        end

        if target then
            if dev then
                print('grid: ' .. direction .. ' -> x: ' .. target.x .. ' y: ' .. target.y ..
                      ' w: ' .. target.w .. ' h: ' .. target.h)
            end
            window.x = target.x
            window.y = target.y
            window.w = target.w
            window.h = target.h
            focusedWindow:setFrame(window)
            return
        end
    end

    if direction == 'right' then
        print(window_coordinates.x, window_coordinates.y, window_coordinates.h, window_coordinates.w)
        -- print(one.x, one.y, one.h, one.w)
        print(one_two.x, one_two.y, one_two.h, one_two.w)
        print(two.x, two.y, two.h, two.w)
        print(upper_one.x, upper_one.y, upper_one.h, upper_one.w)
        print(lower_one.x, lower_one.y, lower_one.h, lower_one.w)


        if window_coordinates.x == one.x and window_coordinates.y == one.y
        and window_coordinates.h == one.h and window_coordinates.w == one.w then
                -- if two cols and the window is in one, then move it to one_two
            if num_cols == 2 then
                print('right from one to q2')
                window.x = q2.x
                window.y = q2.y
                window.h = q2.h
                window.w = q2.w
            -- if four cols and the window is in one, then move it to one_third
            else
                print('right from one to one_third')
                window.x = one_third.x
                window.y = one_third.y
                window.h = one_third.h
                window.w = one_third.w
            end
        -- if the window is in one_third, then move it to two
        elseif window_coordinates.x == one_third.x and window_coordinates.y == one_third.y
        and window_coordinates.h == one_third.h and window_coordinates.w == one_third.w then
            print('right from one_third to two')
            window.x = two.x
            window.y = two.y
            window.h = two.h
            window.w = two.w
        -- if the window is in one_two, then move it to two_three
        elseif window_coordinates.x == one_two.x and window_coordinates.y == one_two.y
        and window_coordinates.h == one_two.h and window_coordinates.w == one_two.w then
            if num_cols == 2 then
                print('right from one_two to q1')
                window.x = q1.x
                window.y = q1.y
                window.h = q1.h
                window.w = q1.w
            -- if four cols and the window is in two, then move it to two_third
            else
                print('right from one_two to two_three')
                window.x = two_three.x
                window.y = two_three.y
                window.h = two_three.h
                window.w = two_three.w
            end
        elseif window_coordinates.x == two.x and window_coordinates.y == two.y
        and window_coordinates.h == two.h and window_coordinates.w == two.w then
            -- if two cols and the window is in two, then move it to q4
            if num_cols == 2 then
                print('right from two to q4')
                window.x = q4.x
                window.y = q4.y
                window.h = q4.h
                window.w = q4.w
            -- if four cols and the window is in two, then move it to two_third
            else
                print('right from two to two_third')
                window.x = two_third.x
                window.y = two_third.y
                window.h = two_third.h
                window.w = two_third.w
            end
        -- if the window is in two_third, then move it to three
        elseif window_coordinates.x == two_third.x and window_coordinates.y == two_third.y
        and window_coordinates.h == two_third.h and window_coordinates.w == two_third.w then
            print('right from two_third to three')
            window.x = three.x
            window.y = three.y
            window.h = three.h
            window.w = three.w
        -- if the window is in two_three, then move it to three_four
        elseif window_coordinates.x == two_three.x and window_coordinates.y == two_three.y
        and window_coordinates.h == two_three.h and window_coordinates.w == two_three.w then
            print('right from two_three to three_four')
            window.x = three_four.x
            window.y = three_four.y
            window.h = three_four.h
            window.w = three_four.w
        -- if the window is in three, then move it to three_third
        elseif window_coordinates.x == three.x and window_coordinates.y == three.y
        and window_coordinates.h == three.h and window_coordinates.w == three.w then
            print('right from three to three_third')
            window.x = three_third.x
            window.y = three_third.y
            window.h = three_third.h
            window.w = three_third.w
        -- if the window is in three_four, then move it to one_two
        elseif window_coordinates.x == three_four.x and window_coordinates.y == three_four.y
        and window_coordinates.h == three_four.h and window_coordinates.w == three_four.w then
            print('right from three_four to one_two')
            window.x = one_two.x
            window.y = one_two.y
            window.h = one_two.h
            window.w = one_two.w
        -- if the window is in three_third, then move it to four
        elseif window_coordinates.x == three_third.x and window_coordinates.y == three_third.y
        and window_coordinates.h == three_third.h and window_coordinates.w == three_third.w then
            print('right from three_third to four')
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
            if num_cols == 2 then
                window.x = upper_q2.x
                window.y = upper_q2.y
                window.h = upper_q2.h
                window.w = upper_q2.w
            else
                window.x = upper_two.x
                window.y = upper_two.y
                window.h = upper_two.h
                window.w = upper_two.w
            end
        -- if the window is in upper_two, then move it to upper_three
        elseif window_coordinates.x == upper_two.x and window_coordinates.y == upper_two.y
        and window_coordinates.h == upper_two.h and window_coordinates.w == upper_two.w then
            if num_cols == 2 then
                window.x = upper_q4.x
                window.y = upper_q4.y
                window.h = upper_q4.h
                window.w = upper_q4.w
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
            if num_cols == 2 then
                window.x = lower_q2.x
                window.y = lower_q2.y
                window.h = lower_q2.h
                window.w = lower_q2.w
            else
                window.x = lower_two.x
                window.y = lower_two.y
                window.h = lower_two.h
                window.w = lower_two.w
            end
        -- if the window is in lower_two, then move it to lower_three
        elseif window_coordinates.x == lower_two.x and window_coordinates.y == lower_two.y
        and window_coordinates.h == lower_two.h and window_coordinates.w == lower_two.w then
            if num_cols == 2 then
                window.x = lower_q4.x
                window.y = lower_q4.y
                window.h = lower_q4.h
                window.w = lower_q4.w
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
        -- QUARTER POSITIONS (2-col only) --
        -- q1 (0-25%, full) → one (0-50%)
        elseif num_cols == 2 and window_coordinates.x == q1.x and window_coordinates.y == q1.y
        and window_coordinates.h == q1.h and window_coordinates.w == q1.w then
            window.x = one.x
            window.y = one.y
            window.h = one.h
            window.w = one.w
        -- q2 (25-50%, full) → center_half (25-75%)
        elseif num_cols == 2 and window_coordinates.x == q2.x and window_coordinates.y == q2.y
        and window_coordinates.h == q2.h and window_coordinates.w == q2.w then
            window.x = center_half.x
            window.y = center_half.y
            window.h = center_half.h
            window.w = center_half.w
        -- center_half (25-75%) → q3 (50-75%)
        elseif num_cols == 2 and window_coordinates.x == center_half.x and window_coordinates.y == center_half.y
        and window_coordinates.h == center_half.h and window_coordinates.w == center_half.w then
            window.x = q3.x
            window.y = q3.y
            window.h = q3.h
            window.w = q3.w
        -- q3 (50-75%, full) → two (50-100%)
        elseif num_cols == 2 and window_coordinates.x == q3.x and window_coordinates.y == q3.y
        and window_coordinates.h == q3.h and window_coordinates.w == q3.w then
            window.x = two.x
            window.y = two.y
            window.h = two.h
            window.w = two.w
        -- q4 (75-100%, full) → one_two (full screen, wraps)
        elseif num_cols == 2 and window_coordinates.x == q4.x and window_coordinates.y == q4.y
        and window_coordinates.h == q4.h and window_coordinates.w == q4.w then
            window.x = one_two.x
            window.y = one_two.y
            window.h = one_two.h
            window.w = one_two.w
        -- upper_q1 → upper_one
        elseif num_cols == 2 and window_coordinates.x == upper_q1.x and window_coordinates.y == upper_q1.y
        and window_coordinates.h == upper_q1.h and window_coordinates.w == upper_q1.w then
            window.x = upper_one.x
            window.y = upper_one.y
            window.h = upper_one.h
            window.w = upper_one.w
        -- upper_q2 → upper_center_half
        elseif num_cols == 2 and window_coordinates.x == upper_q2.x and window_coordinates.y == upper_q2.y
        and window_coordinates.h == upper_q2.h and window_coordinates.w == upper_q2.w then
            window.x = upper_center_half.x
            window.y = upper_center_half.y
            window.h = upper_center_half.h
            window.w = upper_center_half.w
        -- upper_center_half → upper_q3
        elseif num_cols == 2 and window_coordinates.x == upper_center_half.x and window_coordinates.y == upper_center_half.y
        and window_coordinates.h == upper_center_half.h and window_coordinates.w == upper_center_half.w then
            window.x = upper_q3.x
            window.y = upper_q3.y
            window.h = upper_q3.h
            window.w = upper_q3.w
        -- upper_q3 → upper_two
        elseif num_cols == 2 and window_coordinates.x == upper_q3.x and window_coordinates.y == upper_q3.y
        and window_coordinates.h == upper_q3.h and window_coordinates.w == upper_q3.w then
            window.x = upper_two.x
            window.y = upper_two.y
            window.h = upper_two.h
            window.w = upper_two.w
        -- upper_q4 → upper_q1 (wrap)
        elseif num_cols == 2 and window_coordinates.x == upper_q4.x and window_coordinates.y == upper_q4.y
        and window_coordinates.h == upper_q4.h and window_coordinates.w == upper_q4.w then
            window.x = upper_q1.x
            window.y = upper_q1.y
            window.h = upper_q1.h
            window.w = upper_q1.w
        -- lower_q1 → lower_one
        elseif num_cols == 2 and window_coordinates.x == lower_q1.x and window_coordinates.y == lower_q1.y
        and window_coordinates.h == lower_q1.h and window_coordinates.w == lower_q1.w then
            window.x = lower_one.x
            window.y = lower_one.y
            window.h = lower_one.h
            window.w = lower_one.w
        -- lower_q2 → lower_center_half
        elseif num_cols == 2 and window_coordinates.x == lower_q2.x and window_coordinates.y == lower_q2.y
        and window_coordinates.h == lower_q2.h and window_coordinates.w == lower_q2.w then
            window.x = lower_center_half.x
            window.y = lower_center_half.y
            window.h = lower_center_half.h
            window.w = lower_center_half.w
        -- lower_center_half → lower_q3
        elseif num_cols == 2 and window_coordinates.x == lower_center_half.x and window_coordinates.y == lower_center_half.y
        and window_coordinates.h == lower_center_half.h and window_coordinates.w == lower_center_half.w then
            window.x = lower_q3.x
            window.y = lower_q3.y
            window.h = lower_q3.h
            window.w = lower_q3.w
        -- lower_q3 → lower_two
        elseif num_cols == 2 and window_coordinates.x == lower_q3.x and window_coordinates.y == lower_q3.y
        and window_coordinates.h == lower_q3.h and window_coordinates.w == lower_q3.w then
            window.x = lower_two.x
            window.y = lower_two.y
            window.h = lower_two.h
            window.w = lower_two.w
        -- lower_q4 → lower_q1 (wrap)
        elseif num_cols == 2 and window_coordinates.x == lower_q4.x and window_coordinates.y == lower_q4.y
        and window_coordinates.h == lower_q4.h and window_coordinates.w == lower_q4.w then
            window.x = lower_q1.x
            window.y = lower_q1.y
            window.h = lower_q1.h
            window.w = lower_q1.w
        -- if the window is in one_two_third, then move it to two_three_third
        elseif window_coordinates.x == one_two_third.x and window_coordinates.y == one_two_third.y
        and window_coordinates.h == one_two_third.h and window_coordinates.w == one_two_third.w then
            window.x = two_three_third.x
            window.y = two_three_third.y
            window.h = two_three_third.h
            window.w = two_three_third.w
        -- if the window is in two_three_third, then move it to one_two_third
        elseif window_coordinates.x == two_three_third.x and window_coordinates.y == two_three_third.y
        and window_coordinates.h == two_three_third.h and window_coordinates.w == two_three_third.w then
            window.x = one_two_third.x
            window.y = one_two_third.y
            window.h = one_two_third.h
            window.w = one_two_third.w
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
            local one_distance = math.sqrt((window_coordinates.x - one.x) ^ 2 + (window_coordinates.y - one.y) ^ 2)
            local two_distance = math.sqrt((window_coordinates.x - two.x) ^ 2 + (window_coordinates.y - two.y) ^ 2)
            local three_distance = math.sqrt((window_coordinates.x - three.x) ^ 2 + (window_coordinates.y - three.y) ^ 2)
            local four_distance = math.sqrt((window_coordinates.x - four.x) ^ 2 + (window_coordinates.y - four.y) ^ 2)
            
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
        -- if the window is in four, then move it to three_third
        if window_coordinates.x == four.x and window_coordinates.y == four.y
        and window_coordinates.h == four.h and window_coordinates.w == four.w then
            window.x = three_third.x
            window.y = three_third.y
            window.h = three_third.h
            window.w = three_third.w
        -- if the window is in three_third, then move it to three
        elseif window_coordinates.x == three_third.x and window_coordinates.y == three_third.y
        and window_coordinates.h == three_third.h and window_coordinates.w == three_third.w then
            window.x = three.x
            window.y = three.y
            window.h = three.h
            window.w = three.w
        -- if the window is in three_four, then move it to two_three
        elseif window_coordinates.x == three_four.x and window_coordinates.y == three_four.y
        and window_coordinates.h == three_four.h and window_coordinates.w == three_four.w then
            window.x = two_three.x
            window.y = two_three.y
            window.h = two_three.h
            window.w = two_three.w
        -- if the window is in three, then move it to two_third
        elseif window_coordinates.x == three.x and window_coordinates.y == three.y
        and window_coordinates.h == three.h and window_coordinates.w == three.w then
            window.x = two_third.x
            window.y = two_third.y
            window.h = two_third.h
            window.w = two_third.w
        -- if the window is in two_third, then move it to two
        elseif window_coordinates.x == two_third.x and window_coordinates.y == two_third.y
        and window_coordinates.h == two_third.h and window_coordinates.w == two_third.w then
            window.x = two.x
            window.y = two.y
            window.h = two.h
            window.w = two.w
        -- if the window is in two_three, then move it to one_two
        elseif window_coordinates.x == two_three.x and window_coordinates.y == two_three.y
        and window_coordinates.h == two_three.h and window_coordinates.w == two_three.w then
            window.x = one_two.x
            window.y = one_two.y
            window.h = one_two.h
            window.w = one_two.w
        -- if the window is in two, then move it to one_third
        elseif window_coordinates.x == two.x and window_coordinates.y == two.y
        and window_coordinates.h == two.h and window_coordinates.w == two.w then
            if num_cols == 2 then
                window.x = q3.x
                window.y = q3.y
                window.h = q3.h
                window.w = q3.w
            else
                window.x = one_third.x
                window.y = one_third.y
                window.h = one_third.h
                window.w = one_third.w
            end
        -- if the window is in one_two, then move it to three_four
        elseif window_coordinates.x == one_two.x and window_coordinates.y == one_two.y
        and window_coordinates.h == one_two.h and window_coordinates.w == one_two.w then
            if num_cols == 2 then
                window.x = q4.x
                window.y = q4.y
                window.h = q4.h
                window.w = q4.w
            else
                window.x = three_four.x
                window.y = three_four.y
                window.h = three_four.h
                window.w = three_four.w
            end
        -- if the window is in one_third, then move it to one
        elseif window_coordinates.x == one_third.x and window_coordinates.y == one_third.y
        and window_coordinates.h == one_third.h and window_coordinates.w == one_third.w then
            window.x = one.x
            window.y = one.y
            window.h = one.h
            window.w = one.w
        -- if the window is in one, then move it to four
        elseif window_coordinates.x == one.x and window_coordinates.y == one.y
        and window_coordinates.h == one.h and window_coordinates.w == one.w then
            if num_cols == 2 then
                window.x = q1.x
                window.y = q1.y
                window.h = q1.h
                window.w = q1.w
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
            if num_cols == 2 then
                window.x = upper_q3.x
                window.y = upper_q3.y
                window.h = upper_q3.h
                window.w = upper_q3.w
            else
                window.x = upper_one.x
                window.y = upper_one.y
                window.h = upper_one.h
                window.w = upper_one.w
            end
        -- if the window is in upper_one, then move it to upper_four
        elseif window_coordinates.x == upper_one.x and window_coordinates.y == upper_one.y
        and window_coordinates.h == upper_one.h and window_coordinates.w == upper_one.w then
            if num_cols == 2 then
                window.x = upper_q1.x
                window.y = upper_q1.y
                window.h = upper_q1.h
                window.w = upper_q1.w
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
            if num_cols == 2 then
                window.x = lower_q3.x
                window.y = lower_q3.y
                window.h = lower_q3.h
                window.w = lower_q3.w
            else
                window.x = lower_one.x
                window.y = lower_one.y
                window.h = lower_one.h
                window.w = lower_one.w
            end
        -- if the window is in lower_one, then move it to lower_four
        elseif window_coordinates.x == lower_one.x and window_coordinates.y == lower_one.y
        and window_coordinates.h == lower_one.h and window_coordinates.w == lower_one.w then
            if num_cols == 2 then
                window.x = lower_q1.x
                window.y = lower_q1.y
                window.h = lower_q1.h
                window.w = lower_q1.w
            else
                window.x = lower_four.x
                window.y = lower_four.y
                window.h = lower_four.h
                window.w = lower_four.w
            end
        -- QUARTER POSITIONS (2-col only) --
        -- q4 (75-100%) → two (50-100%)
        elseif num_cols == 2 and window_coordinates.x == q4.x and window_coordinates.y == q4.y
        and window_coordinates.h == q4.h and window_coordinates.w == q4.w then
            window.x = two.x
            window.y = two.y
            window.h = two.h
            window.w = two.w
        -- q3 (50-75%) → center_half (25-75%)
        elseif num_cols == 2 and window_coordinates.x == q3.x and window_coordinates.y == q3.y
        and window_coordinates.h == q3.h and window_coordinates.w == q3.w then
            window.x = center_half.x
            window.y = center_half.y
            window.h = center_half.h
            window.w = center_half.w
        -- center_half (25-75%) → q2 (25-50%)
        elseif num_cols == 2 and window_coordinates.x == center_half.x and window_coordinates.y == center_half.y
        and window_coordinates.h == center_half.h and window_coordinates.w == center_half.w then
            window.x = q2.x
            window.y = q2.y
            window.h = q2.h
            window.w = q2.w
        -- q2 (25-50%) → one (0-50%)
        elseif num_cols == 2 and window_coordinates.x == q2.x and window_coordinates.y == q2.y
        and window_coordinates.h == q2.h and window_coordinates.w == q2.w then
            window.x = one.x
            window.y = one.y
            window.h = one.h
            window.w = one.w
        -- q1 (0-25%) → one_two (full, wrap)
        elseif num_cols == 2 and window_coordinates.x == q1.x and window_coordinates.y == q1.y
        and window_coordinates.h == q1.h and window_coordinates.w == q1.w then
            window.x = one_two.x
            window.y = one_two.y
            window.h = one_two.h
            window.w = one_two.w
        -- upper_q4 → upper_two
        elseif num_cols == 2 and window_coordinates.x == upper_q4.x and window_coordinates.y == upper_q4.y
        and window_coordinates.h == upper_q4.h and window_coordinates.w == upper_q4.w then
            window.x = upper_two.x
            window.y = upper_two.y
            window.h = upper_two.h
            window.w = upper_two.w
        -- upper_q3 → upper_center_half
        elseif num_cols == 2 and window_coordinates.x == upper_q3.x and window_coordinates.y == upper_q3.y
        and window_coordinates.h == upper_q3.h and window_coordinates.w == upper_q3.w then
            window.x = upper_center_half.x
            window.y = upper_center_half.y
            window.h = upper_center_half.h
            window.w = upper_center_half.w
        -- upper_center_half → upper_q2
        elseif num_cols == 2 and window_coordinates.x == upper_center_half.x and window_coordinates.y == upper_center_half.y
        and window_coordinates.h == upper_center_half.h and window_coordinates.w == upper_center_half.w then
            window.x = upper_q2.x
            window.y = upper_q2.y
            window.h = upper_q2.h
            window.w = upper_q2.w
        -- upper_q2 → upper_one
        elseif num_cols == 2 and window_coordinates.x == upper_q2.x and window_coordinates.y == upper_q2.y
        and window_coordinates.h == upper_q2.h and window_coordinates.w == upper_q2.w then
            window.x = upper_one.x
            window.y = upper_one.y
            window.h = upper_one.h
            window.w = upper_one.w
        -- upper_q1 → upper_q4 (wrap)
        elseif num_cols == 2 and window_coordinates.x == upper_q1.x and window_coordinates.y == upper_q1.y
        and window_coordinates.h == upper_q1.h and window_coordinates.w == upper_q1.w then
            window.x = upper_q4.x
            window.y = upper_q4.y
            window.h = upper_q4.h
            window.w = upper_q4.w
        -- lower_q4 → lower_two
        elseif num_cols == 2 and window_coordinates.x == lower_q4.x and window_coordinates.y == lower_q4.y
        and window_coordinates.h == lower_q4.h and window_coordinates.w == lower_q4.w then
            window.x = lower_two.x
            window.y = lower_two.y
            window.h = lower_two.h
            window.w = lower_two.w
        -- lower_q3 → lower_center_half
        elseif num_cols == 2 and window_coordinates.x == lower_q3.x and window_coordinates.y == lower_q3.y
        and window_coordinates.h == lower_q3.h and window_coordinates.w == lower_q3.w then
            window.x = lower_center_half.x
            window.y = lower_center_half.y
            window.h = lower_center_half.h
            window.w = lower_center_half.w
        -- lower_center_half → lower_q2
        elseif num_cols == 2 and window_coordinates.x == lower_center_half.x and window_coordinates.y == lower_center_half.y
        and window_coordinates.h == lower_center_half.h and window_coordinates.w == lower_center_half.w then
            window.x = lower_q2.x
            window.y = lower_q2.y
            window.h = lower_q2.h
            window.w = lower_q2.w
        -- lower_q2 → lower_one
        elseif num_cols == 2 and window_coordinates.x == lower_q2.x and window_coordinates.y == lower_q2.y
        and window_coordinates.h == lower_q2.h and window_coordinates.w == lower_q2.w then
            window.x = lower_one.x
            window.y = lower_one.y
            window.h = lower_one.h
            window.w = lower_one.w
        -- lower_q1 → lower_q4 (wrap)
        elseif num_cols == 2 and window_coordinates.x == lower_q1.x and window_coordinates.y == lower_q1.y
        and window_coordinates.h == lower_q1.h and window_coordinates.w == lower_q1.w then
            window.x = lower_q4.x
            window.y = lower_q4.y
            window.h = lower_q4.h
            window.w = lower_q4.w
        -- if window is in one_two_third, then move it to two_three_third
        elseif window_coordinates.x == one_two_third.x and window_coordinates.y == one_two_third.y
        and window_coordinates.h == one_two_third.h and window_coordinates.w == one_two_third.w then
            window.x = two_three_third.x
            window.y = two_three_third.y
            window.h = two_three_third.h
            window.w = two_three_third.w
        -- if window is in two_three_third, then move it to one_two_third
        elseif window_coordinates.x == two_three_third.x and window_coordinates.y == two_three_third.y
        and window_coordinates.h == two_three_third.h and window_coordinates.w == two_three_third.w then
            window.x = one_two_third.x
            window.y = one_two_third.y
            window.h = one_two_third.h
            window.w = one_two_third.w
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
            local one_distance = math.sqrt((window_coordinates.x - one.x) ^ 2 + (window_coordinates.y - one.y) ^ 2)
            local two_distance = math.sqrt((window_coordinates.x - two.x) ^ 2 + (window_coordinates.y - two.y) ^ 2)
            local three_distance = math.sqrt((window_coordinates.x - three.x) ^ 2 + (window_coordinates.y - three.y) ^ 2)
            local four_distance = math.sqrt((window_coordinates.x - four.x) ^ 2 + (window_coordinates.y - four.y) ^ 2)
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
        -- QUARTER POSITIONS up cycle: lower_qN → qN → upper_qN → lower_qN (2-col only)
        elseif num_cols == 2 and window_coordinates.x == lower_q1.x and window_coordinates.y == lower_q1.y
        and window_coordinates.h == lower_q1.h and window_coordinates.w == lower_q1.w then
            window.x = q1.x; window.y = q1.y; window.h = q1.h; window.w = q1.w
        elseif num_cols == 2 and window_coordinates.x == q1.x and window_coordinates.y == q1.y
        and window_coordinates.h == q1.h and window_coordinates.w == q1.w then
            window.x = upper_q1.x; window.y = upper_q1.y; window.h = upper_q1.h; window.w = upper_q1.w
        elseif num_cols == 2 and window_coordinates.x == upper_q1.x and window_coordinates.y == upper_q1.y
        and window_coordinates.h == upper_q1.h and window_coordinates.w == upper_q1.w then
            window.x = lower_q1.x; window.y = lower_q1.y; window.h = lower_q1.h; window.w = lower_q1.w
        elseif num_cols == 2 and window_coordinates.x == lower_q2.x and window_coordinates.y == lower_q2.y
        and window_coordinates.h == lower_q2.h and window_coordinates.w == lower_q2.w then
            window.x = q2.x; window.y = q2.y; window.h = q2.h; window.w = q2.w
        elseif num_cols == 2 and window_coordinates.x == q2.x and window_coordinates.y == q2.y
        and window_coordinates.h == q2.h and window_coordinates.w == q2.w then
            window.x = upper_q2.x; window.y = upper_q2.y; window.h = upper_q2.h; window.w = upper_q2.w
        elseif num_cols == 2 and window_coordinates.x == upper_q2.x and window_coordinates.y == upper_q2.y
        and window_coordinates.h == upper_q2.h and window_coordinates.w == upper_q2.w then
            window.x = lower_q2.x; window.y = lower_q2.y; window.h = lower_q2.h; window.w = lower_q2.w
        elseif num_cols == 2 and window_coordinates.x == lower_q3.x and window_coordinates.y == lower_q3.y
        and window_coordinates.h == lower_q3.h and window_coordinates.w == lower_q3.w then
            window.x = q3.x; window.y = q3.y; window.h = q3.h; window.w = q3.w
        elseif num_cols == 2 and window_coordinates.x == q3.x and window_coordinates.y == q3.y
        and window_coordinates.h == q3.h and window_coordinates.w == q3.w then
            window.x = upper_q3.x; window.y = upper_q3.y; window.h = upper_q3.h; window.w = upper_q3.w
        elseif num_cols == 2 and window_coordinates.x == upper_q3.x and window_coordinates.y == upper_q3.y
        and window_coordinates.h == upper_q3.h and window_coordinates.w == upper_q3.w then
            window.x = lower_q3.x; window.y = lower_q3.y; window.h = lower_q3.h; window.w = lower_q3.w
        elseif num_cols == 2 and window_coordinates.x == lower_q4.x and window_coordinates.y == lower_q4.y
        and window_coordinates.h == lower_q4.h and window_coordinates.w == lower_q4.w then
            window.x = q4.x; window.y = q4.y; window.h = q4.h; window.w = q4.w
        elseif num_cols == 2 and window_coordinates.x == q4.x and window_coordinates.y == q4.y
        and window_coordinates.h == q4.h and window_coordinates.w == q4.w then
            window.x = upper_q4.x; window.y = upper_q4.y; window.h = upper_q4.h; window.w = upper_q4.w
        elseif num_cols == 2 and window_coordinates.x == upper_q4.x and window_coordinates.y == upper_q4.y
        and window_coordinates.h == upper_q4.h and window_coordinates.w == upper_q4.w then
            window.x = lower_q4.x; window.y = lower_q4.y; window.h = lower_q4.h; window.w = lower_q4.w
        elseif num_cols == 2 and window_coordinates.x == lower_center_half.x and window_coordinates.y == lower_center_half.y
        and window_coordinates.h == lower_center_half.h and window_coordinates.w == lower_center_half.w then
            window.x = center_half.x; window.y = center_half.y; window.h = center_half.h; window.w = center_half.w
        elseif num_cols == 2 and window_coordinates.x == center_half.x and window_coordinates.y == center_half.y
        and window_coordinates.h == center_half.h and window_coordinates.w == center_half.w then
            window.x = upper_center_half.x; window.y = upper_center_half.y; window.h = upper_center_half.h; window.w = upper_center_half.w
        elseif num_cols == 2 and window_coordinates.x == upper_center_half.x and window_coordinates.y == upper_center_half.y
        and window_coordinates.h == upper_center_half.h and window_coordinates.w == upper_center_half.w then
            window.x = lower_center_half.x; window.y = lower_center_half.y; window.h = lower_center_half.h; window.w = lower_center_half.w
        -- if the window is in one_third or two_third, then move it to one_two_third
        elseif (window_coordinates.x == one_third.x and window_coordinates.y == one_third.y
        and window_coordinates.h == one_third.h and window_coordinates.w == one_third.w)
        or (window_coordinates.x == two_third.x and window_coordinates.y == two_third.y
        and window_coordinates.h == two_third.h and window_coordinates.w == two_third.w) then
            window.x = one_two_third.x
            window.y = one_two_third.y
            window.h = one_two_third.h
            window.w = one_two_third.w
        -- if the window is in three_third, then move it to two_three_third
        elseif window_coordinates.x == three_third.x and window_coordinates.y == three_third.y
        and window_coordinates.h == three_third.h and window_coordinates.w == three_third.w then
            window.x = two_three_third.x
            window.y = two_three_third.y
            window.h = two_three_third.h
            window.w = two_three_third.w
        -- if the window is in one_two_third or two_three_third, then move it to one_two_three_four_third
        elseif (window_coordinates.x == one_two_third.x and window_coordinates.y == one_two_third.y
        and window_coordinates.h == one_two_third.h and window_coordinates.w == one_two_third.w)
        or (window_coordinates.x == two_three_third.x and window_coordinates.y == two_three_third.y
        and window_coordinates.h == two_three_third.h and window_coordinates.w == two_three_third.w) then
            window.x = one_two_three_four_third.x
            window.y = one_two_three_four_third.y
            window.h = one_two_three_four_third.h
            window.w = one_two_three_four_third.w
        -- if the window is in one_two_three_four_third, then move it to two_third
        elseif window_coordinates.x == one_two_three_four_third.x and window_coordinates.y == one_two_three_four_third.y
        and window_coordinates.h == one_two_three_four_third.h and window_coordinates.w == one_two_three_four_third.w then
            window.x = two_third.x
            window.y = two_third.y
            window.h = two_third.h
            window.w = two_third.w
        -- if the window is in one_two or two_three, then move it to one_two_three
        elseif (window_coordinates.x == one_two.x and window_coordinates.y == one_two.y
        and window_coordinates.h == one_two.h and window_coordinates.w == one_two.w) 
        or (window_coordinates.x == two_three.x and window_coordinates.y == two_three.y
        and window_coordinates.h == two_three.h and window_coordinates.w == two_three.w) then
            -- if two cols, then move it to one.
            if num_cols == 2 then
                window.x = one.x
                window.y = one.y
                window.h = one.h
                window.w = one.w
            -- if four cols, then move it to one_two_three
            else
                window.x = one_two_three.x
                window.y = one_two_three.y
                window.h = one_two_three.h
                window.w = one_two_three.w
            end
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
        -- if the window is in one_two_three_four, then move it to two_three
        elseif window_coordinates.x == one_two_three_four.x and window_coordinates.y == one_two_three_four.y
        and window_coordinates.h == one_two_three_four.h and window_coordinates.w == one_two_three_four.w then
            window.x = two_three.x
            window.y = two_three.y
            window.h = two_three.h
            window.w = two_three.w
        -- else move it to closest fifth column of the screen
        else
            -- determine the closest section to the current location between one, two, three, four, and five
            local one_distance = math.sqrt((window_coordinates.x - one.x) ^ 2 + (window_coordinates.y - one.y) ^ 2)
            local two_distance = math.sqrt((window_coordinates.x - two.x) ^ 2 + (window_coordinates.y - two.y) ^ 2)
            local three_distance = math.sqrt((window_coordinates.x - three.x) ^ 2 + (window_coordinates.y - three.y) ^ 2)
            local four_distance = math.sqrt((window_coordinates.x - four.x) ^ 2 + (window_coordinates.y - four.y) ^ 2)
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
        -- QUARTER POSITIONS down cycle: qN → lower_qN → upper_qN → qN (2-col only)
        elseif num_cols == 2 and window_coordinates.x == q1.x and window_coordinates.y == q1.y
        and window_coordinates.h == q1.h and window_coordinates.w == q1.w then
            window.x = lower_q1.x; window.y = lower_q1.y; window.h = lower_q1.h; window.w = lower_q1.w
        elseif num_cols == 2 and window_coordinates.x == upper_q1.x and window_coordinates.y == upper_q1.y
        and window_coordinates.h == upper_q1.h and window_coordinates.w == upper_q1.w then
            window.x = q1.x; window.y = q1.y; window.h = q1.h; window.w = q1.w
        elseif num_cols == 2 and window_coordinates.x == lower_q1.x and window_coordinates.y == lower_q1.y
        and window_coordinates.h == lower_q1.h and window_coordinates.w == lower_q1.w then
            window.x = upper_q1.x; window.y = upper_q1.y; window.h = upper_q1.h; window.w = upper_q1.w
        elseif num_cols == 2 and window_coordinates.x == q2.x and window_coordinates.y == q2.y
        and window_coordinates.h == q2.h and window_coordinates.w == q2.w then
            window.x = lower_q2.x; window.y = lower_q2.y; window.h = lower_q2.h; window.w = lower_q2.w
        elseif num_cols == 2 and window_coordinates.x == upper_q2.x and window_coordinates.y == upper_q2.y
        and window_coordinates.h == upper_q2.h and window_coordinates.w == upper_q2.w then
            window.x = q2.x; window.y = q2.y; window.h = q2.h; window.w = q2.w
        elseif num_cols == 2 and window_coordinates.x == lower_q2.x and window_coordinates.y == lower_q2.y
        and window_coordinates.h == lower_q2.h and window_coordinates.w == lower_q2.w then
            window.x = upper_q2.x; window.y = upper_q2.y; window.h = upper_q2.h; window.w = upper_q2.w
        elseif num_cols == 2 and window_coordinates.x == q3.x and window_coordinates.y == q3.y
        and window_coordinates.h == q3.h and window_coordinates.w == q3.w then
            window.x = lower_q3.x; window.y = lower_q3.y; window.h = lower_q3.h; window.w = lower_q3.w
        elseif num_cols == 2 and window_coordinates.x == upper_q3.x and window_coordinates.y == upper_q3.y
        and window_coordinates.h == upper_q3.h and window_coordinates.w == upper_q3.w then
            window.x = q3.x; window.y = q3.y; window.h = q3.h; window.w = q3.w
        elseif num_cols == 2 and window_coordinates.x == lower_q3.x and window_coordinates.y == lower_q3.y
        and window_coordinates.h == lower_q3.h and window_coordinates.w == lower_q3.w then
            window.x = upper_q3.x; window.y = upper_q3.y; window.h = upper_q3.h; window.w = upper_q3.w
        elseif num_cols == 2 and window_coordinates.x == q4.x and window_coordinates.y == q4.y
        and window_coordinates.h == q4.h and window_coordinates.w == q4.w then
            window.x = lower_q4.x; window.y = lower_q4.y; window.h = lower_q4.h; window.w = lower_q4.w
        elseif num_cols == 2 and window_coordinates.x == upper_q4.x and window_coordinates.y == upper_q4.y
        and window_coordinates.h == upper_q4.h and window_coordinates.w == upper_q4.w then
            window.x = q4.x; window.y = q4.y; window.h = q4.h; window.w = q4.w
        elseif num_cols == 2 and window_coordinates.x == lower_q4.x and window_coordinates.y == lower_q4.y
        and window_coordinates.h == lower_q4.h and window_coordinates.w == lower_q4.w then
            window.x = upper_q4.x; window.y = upper_q4.y; window.h = upper_q4.h; window.w = upper_q4.w
        elseif num_cols == 2 and window_coordinates.x == center_half.x and window_coordinates.y == center_half.y
        and window_coordinates.h == center_half.h and window_coordinates.w == center_half.w then
            window.x = lower_center_half.x; window.y = lower_center_half.y; window.h = lower_center_half.h; window.w = lower_center_half.w
        elseif num_cols == 2 and window_coordinates.x == upper_center_half.x and window_coordinates.y == upper_center_half.y
        and window_coordinates.h == upper_center_half.h and window_coordinates.w == upper_center_half.w then
            window.x = center_half.x; window.y = center_half.y; window.h = center_half.h; window.w = center_half.w
        elseif num_cols == 2 and window_coordinates.x == lower_center_half.x and window_coordinates.y == lower_center_half.y
        and window_coordinates.h == lower_center_half.h and window_coordinates.w == lower_center_half.w then
            window.x = upper_center_half.x; window.y = upper_center_half.y; window.h = upper_center_half.h; window.w = upper_center_half.w
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
        -- if the window is in one_third, then move it to one
        elseif window_coordinates.x == one_third.x and window_coordinates.y == one_third.y
        and window_coordinates.h == one_third.h and window_coordinates.w == one_third.w then
            window.x = one.x
            window.y = one.y
            window.h = one.h
            window.w = one.w
        -- if the window is in two_third, then move it to two
        elseif window_coordinates.x == two_third.x and window_coordinates.y == two_third.y
        and window_coordinates.h == two_third.h and window_coordinates.w == two_third.w then
            window.x = two.x
            window.y = two.y
            window.h = two.h
            window.w = two.w
        -- if the window is in one_two_third or two_three_third, then move it to two_third
        elseif window_coordinates.x == two_three_third.x and window_coordinates.y == two_three_third.y
        and window_coordinates.h == two_three_third.h and window_coordinates.w == two_three_third.w then
            window.x = two_third.x
            window.y = two_third.y
            window.h = two_third.h
            window.w = two_third.w
        -- if the window is in one_two_three_four_third, then move it to one_two_third
        elseif window_coordinates.x == one_two_three_four_third.x and window_coordinates.y == one_two_three_four_third.y
        and window_coordinates.h == one_two_three_four_third.h and window_coordinates.w == one_two_three_four_third.w then
            window.x = one_two_third.x
            window.y = one_two_third.y
            window.h = one_two_third.h
            window.w = one_two_third.w
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
            local one_distance = math.sqrt((window_coordinates.x - one.x) ^ 2 + (window_coordinates.y - one.y) ^ 2)
            local two_distance = math.sqrt((window_coordinates.x - two.x) ^ 2 + (window_coordinates.y - two.y) ^ 2)
            local three_distance = math.sqrt((window_coordinates.x - three.x) ^ 2 + (window_coordinates.y - three.y) ^ 2)
            local four_distance = math.sqrt((window_coordinates.x - four.x) ^ 2 + (window_coordinates.y - four.y) ^ 2)
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

-- Directional focus is not symmetric. hs.window's :windowsToEast/:windowsToWest
-- pick by angle and distance, so the neighbour chosen going right is often not
-- the one chosen coming back left: right from A can land on C, while left from
-- C lands on B. To make the arrows feel reversible, remember the jumps we made
-- and let the opposite arrow retrace the path instead of re-running geometry.
--
-- The trail self-heals: any focus change we did not make ourselves (a click,
-- cmd-tab, a window closing) leaves the top of the trail pointing at a window
-- that is no longer focused, and we discard it and fall back to geometry.
local focus_trail = {}
local FOCUS_TRAIL_MAX = 25

local opposite_direction = {
    right = 'left', left = 'right', up = 'down', down = 'up'
}

local function focusWindowInDirection(direction)
    local focusedWindow = hs_window.focusedWindow()
    if not focusedWindow then return end

    local currentID = focusedWindow:id()

    local top = focus_trail[#focus_trail]
    if top and top.to ~= currentID then
        -- Focus moved without us, so the trail no longer describes where we are.
        focus_trail = {}
        top = nil
    end

    -- Opposite arrow: step back to the window we actually came from.
    if top and direction == opposite_direction[top.direction] then
        local back = hs_window.get(top.from)
        if back and back:isVisible() then
            table.remove(focus_trail)
            if dev then print('focus: ' .. direction .. ' retracing to window ' .. top.from) end
            back:focus()
            return
        end
        -- The window we came from is gone or minimised; the trail is useless.
        focus_trail = {}
    end

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
        local targetID = otherWindow:id()
        -- Only record the hop if both ends have ids to match on later.
        if currentID and targetID then
            table.insert(focus_trail, {from = currentID, to = targetID, direction = direction})
            if #focus_trail > FOCUS_TRAIL_MAX then table.remove(focus_trail, 1) end
        else
            focus_trail = {}
        end
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


