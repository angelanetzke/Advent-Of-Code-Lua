local function clearTable(table)
	for k, _ in ipairs(table) do
		table[k] = nil
	end
end

local function isElementInTable(table, element)
	for _, v in ipairs(table) do
		if element == v then
			return true
		end
	end
	return false
end

local function addSymbolNeighbors(symbolNeighbors, allLines, coordinates)
	for deltaRow = -1, 1 do
		for deltaColumn = -1, 1 do
			local searchRow = coordinates[1] + deltaRow
			local searchColumn = coordinates[2] + deltaColumn
			if 1 <= searchRow
				and searchRow <= #allLines
				and 1 <= searchColumn
				and searchColumn <= #allLines[coordinates[1]]
				and (deltaRow ~= 0 or deltaColumn ~= 0)
				then
					local thisCharacter = string.sub(allLines[searchRow], searchColumn, searchColumn)
					local coordinateID = searchRow .. "-" .. searchColumn
					if thisCharacter ~= "."
						and tonumber(thisCharacter) == nil
						and not isElementInTable(symbolNeighbors, coordinateID)
						then
							symbolNeighbors[#symbolNeighbors + 1] = coordinateID
					end
				end
		end
	end
end

local function addToGears(symbolNeighbors, gears, partNumber)
	for _, v in ipairs(symbolNeighbors) do
		if gears[v] == nil then
			gears[v] = { partNumber }
		elseif not isElementInTable(gears[v], partNumber) then
			gears[v][#gears[v] + 1] = partNumber
		end
	end
end

local function part1And2(allLines)
	local partNumberSum = 0
	local symbolNeighbors = {}
	local gears = {}
	for row = 1, #allLines do
		local currentNumber = 0
		local isNumberInProgress = false
		clearTable(symbolNeighbors)
		for column = 1, #allLines[row] do
			local coordinates = { row, column }
			local thisCharacter = tonumber(string.sub(allLines[row], column, column))
			if (thisCharacter ~= nil) then
				currentNumber = currentNumber * 10 + tonumber(thisCharacter)
				isNumberInProgress = true
				addSymbolNeighbors(symbolNeighbors, allLines, coordinates)
			elseif isNumberInProgress then
				if #symbolNeighbors > 0 then
					partNumberSum = partNumberSum + currentNumber
					addToGears(symbolNeighbors, gears, currentNumber)
				end
				currentNumber = 0
				isNumberInProgress = false
				clearTable(symbolNeighbors)
			end
		end
		if isNumberInProgress and #symbolNeighbors > 0 then
			partNumberSum = partNumberSum + currentNumber
			addToGears(symbolNeighbors, gears, currentNumber)
		end		
	end
	print("Part 1: " .. partNumberSum)
	local gearRatioSum = 0
	for _, v in pairs(gears) do
		if #v == 2 then
			gearRatioSum = gearRatioSum + v[1] * v[2]
		end
	end
	print("Part 2: " .. gearRatioSum)
end

io.input("input/input03.txt")
local allLines = {}
local i = 1
local nextLine = io.read("*line")
while nextLine ~= nil do
	allLines[i] = nextLine
	i = i + 1
	nextLine = io.read("*line")
end
part1And2(allLines)

