local function getCoordinates (targetSquare)
	if targetSquare == 1 then
		return 0, 0
	end
	local x = 0
	local y = 0
	local layer = 0
	local addends =  { 2, 4, 6, 8 }
	local values = { 1, 1, 1, 1 }
	while (true) do
		layer = layer + 1
		for i = 1, #addends do
			values[i] = values[i] + addends[i]
			addends[i] = addends[i] + 8
		end
		local layerMin = values[1] - ((layer - 1) * 2 + 1)
		if layerMin <= targetSquare and targetSquare <= values[1] then
			x = layer
			y = layer - (values[1] - targetSquare)
			break
		end
		if values[1] < targetSquare and targetSquare <= values[2] then
			x = layer - (targetSquare - values[1])
			y = layer
			break
		end
		if values[2] < targetSquare and targetSquare <= values[3] then
			x = -layer
			y = -layer + (values[3] - targetSquare)
			break
		end
		if values[3] < targetSquare and targetSquare <= values[4] then
			x = -layer + (targetSquare - values[3])
			y = -layer
			break
		end
	end
	return x, y
end

local function getCoordString(x, y)
	return x .. "," .. y
end

local function part1(allLines)
	local x, y = getCoordinates(tonumber(allLines[1]))
	return math.abs(x) + math.abs(y)
end

local function part2(allLines)
	local maxValue = tonumber(allLines[1])
	local writtenValues = {}
	writtenValues[getCoordString(0, 0)] = 1
	local currentSquare = 2
	local currentValue = -1
	while currentValue <= maxValue do
		currentValue = 0
		local x, y = getCoordinates(currentSquare)
		for deltaX = -1, 1 do
			for deltaY = -1, 1 do
				local thisX = x + deltaX
				local thisY = y + deltaY
				if (deltaX ~= 0 or deltaY ~= 0) and writtenValues[getCoordString(thisX, thisY)] ~= nil then
					currentValue = currentValue + writtenValues[getCoordString(thisX, thisY)]
				end
			end
		end
		writtenValues[getCoordString(x, y)] = currentValue
		currentSquare = currentSquare + 1
	end
	return currentValue
end

io.input("input/input03.txt")
local allLines = {}
local nextLine = io.read("*line")
while nextLine ~= nil do
	allLines[#allLines + 1] = nextLine
	nextLine = io.read("*line")
end
print("Part 1: " .. part1(allLines))
print("Part 2: " .. part2(allLines))