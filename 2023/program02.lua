local function getGameID(gameData)
	local start, finish, result = string.find(gameData, "Game (%d+):")
	return tonumber(result)
end

local function getMaxCount(gameData, colorName)
	local max = 0
	local startIndex = 1
	local start, finish, result = string.find(gameData, "(%d+) " .. colorName, startIndex)
	while result ~= nil do
		local thisColorCount = tonumber(result)
		if (thisColorCount ~= nil and thisColorCount > max) then
			max = thisColorCount
		end
		if finish ~= nil then
			startIndex = finish
		end
		start, finish, result = string.find(gameData, "(%d+) " .. colorName, startIndex)
	end
	return max
end

local function part1(allLines)
	local maxRed = 12
	local maxGreen = 13
	local maxBlue = 14
	local gameIDSum = 0
	for i = 1, #allLines do
		local isPossible = true
		local thisGameID = getGameID(allLines[i])
		local redCount = getMaxCount(allLines[i], "red")
		isPossible = isPossible and (redCount <= maxRed)
		local greenCount = getMaxCount(allLines[i], "green")
		isPossible = isPossible and (greenCount <= maxGreen)
		local blueCount = getMaxCount(allLines[i], "blue")
		isPossible = isPossible and (blueCount <= maxBlue)
		if isPossible then
			gameIDSum = gameIDSum + thisGameID
		end
	end
	return gameIDSum
end

local function part2(allLines)
	local gamePowerSum = 0
	for i = 1, #allLines do
		local redCount = getMaxCount(allLines[i], "red")
		local greenCount = getMaxCount(allLines[i], "green")
		local blueCount = getMaxCount(allLines[i], "blue")
		gamePowerSum = gamePowerSum + redCount * greenCount * blueCount
	end
	return gamePowerSum
end

io.input("input/input02.txt")
local allLines = {}
local i = 1
local nextLine = io.read("*line")
while nextLine ~= nil do
	allLines[i] = nextLine
	i = i + 1
	nextLine = io.read("*line")
end
print("Part 1: " .. part1(allLines))
print("Part 2: " .. part2(allLines))