local function parseInput(dataString)
	local min = 0
	local max = 0
	local temp = {}
	for x in string.gmatch(dataString, "%d+") do
		table.insert(temp, tonumber(x))
	end
	min = temp[1]
	max = temp[2]
	local givenLetter = string.match(dataString, " (%a):")
	local password = string.match(dataString, ": (%a+)")
	return min, max, givenLetter, password
end

local function part1(allLines)
	local validCount = 0
	for _, thisLine in ipairs(allLines) do
		local min, max, givenLetter, password = parseInput(thisLine)
		local _, count = string.gsub(password, givenLetter, "")
		if min <= count and count <= max then
			validCount = validCount + 1
		end
	end
	return validCount
end

local function part2(allLines)
	local validCount = 0
	for _, thisLine in ipairs(allLines) do
		local min, max, givenLetter, password = parseInput(thisLine)
		local isMinGivenLetter = string.sub(password, min, min) == givenLetter
		local isMaxGivenLetter = string.sub(password, max, max) == givenLetter
		if (isMinGivenLetter or isMaxGivenLetter) and not (isMinGivenLetter and isMaxGivenLetter) then
			validCount = validCount + 1
		end
	end
	return validCount
end

io.input("input/input02.txt")
local allLines = {}
local nextLine = io.read("*line")
while nextLine ~= nil do
	allLines[#allLines + 1] = nextLine
	nextLine = io.read("*line")
end
print("Part 1: " .. part1(allLines))
print("Part 2: " .. part2(allLines))