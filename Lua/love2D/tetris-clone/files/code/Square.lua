require("code.Vector")

Square = {}
Square.__index = Square
Square.halfGap = 1
Square.visibleLength = 6
Square.length = Square.visibleLength + Square.halfGap

function Square.new(position)
    return setmetatable(
        {
            position = position or Vector()    -- row and column in a grid
        },
        Square
    )
end

setmetatable(Square, { __call = function (t, ...) return Square.new(...) end })

local fromCornerToCenter = Vector(directions.right, directions.down) / 2
local fromCenterToCorner = -fromCornerToCenter

function Square:getCenter()
    return self.position + fromCornerToCenter
end

function Square:setCenter(position)
    self.position = position + fromCenterToCorner
end

function Square:isBlocked(direction, frozenSquares)
    local target = self.position + direction
    return frozenSquares.invalidCoords(target.x, target.y) or frozenSquares[target.y][target.x]
end

function Square:translate(vector)
    position:translate(vector)
end

function Square:realPosition(grid)
    return grid.position + (Square.length * self.position)
end

function Square:draw(grid)
    local location = self:realPosition(grid)
    love.graphics.rectangle("fill", location.x + Square.halfGap, location.y + Square.halfGap, Square.visibleLength, Square.visibleLength)
end

-- [[ DEBUGGING
function Square:__tostring()
    return "{ position = " .. self.position .. " }"
end
--]]
