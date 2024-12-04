-- Read input from file
function read_input()
    local grid = {}
    for line in io.lines("input.txt") do
        table.insert(grid, line)
    end
    return grid
end

-- Check if coordinates are within grid bounds
function is_valid(grid, row, col)
    return row >= 1 and row <= #grid and col >= 1 and col <= #grid[1]
end

-- Check for XMAS in a direction
function check_direction(grid, row, col, dx, dy)
    if not is_valid(grid, row + 3*dx, col + 3*dy) then
        return false
    end
    
    return grid[row]:sub(col,col) == 'X'
       and grid[row + dx]:sub(col + dy, col + dy) == 'M'
       and grid[row + 2*dx]:sub(col + 2*dy, col + 2*dy) == 'A'
       and grid[row + 3*dx]:sub(col + 3*dy, col + 3*dy) == 'S'
end

-- Find all XMAS occurrences
function count_xmas(grid)
    local directions = {
        {-1,-1}, {-1,0}, {-1,1},
        {0,-1},          {0,1},
        {1,-1},  {1,0},  {1,1}
    }
    
    local count = 0
    for row = 1, #grid do
        for col = 1, #grid[1] do
            for _, dir in ipairs(directions) do
                if check_direction(grid, row, col, dir[1], dir[2]) then
                    count = count + 1
                end
            end
        end
    end
    return count
end

-- Main execution
local grid = read_input()
print("XMAS appears " .. count_xmas(grid) .. " times")