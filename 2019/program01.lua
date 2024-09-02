local function getFuelRequired(mass)
	return math.floor(mass / 3) - 2
end

local function part1(allLines)
	local fuelSum = 0
	for _, thisLine in ipairs(allLines) do
		fuelSum = fuelSum + getFuelRequired(tonumber(thisLine))
	end
	return fuelSum
end

local function part2(allLines)
	local fuelSum = 0
	for _, thisLine in ipairs(allLines) do
		local fuelNeeded = getFuelRequired(tonumber(thisLine))
		while fuelNeeded > 0 do
			fuelSum = fuelSum + fuelNeeded
			fuelNeeded = getFuelRequired(fuelNeeded)
		end
	end
	return fuelSum
end

io.input("input/input01.txt")
local allLines = {}
local nextLine = io.read("*line")
while nextLine ~= nil do
	allLines[#allLines + 1] = nextLine
	nextLine = io.read("*line")
end
print("Part 1: " .. part1(allLines))
print("Part 2: " .. part2(allLines))