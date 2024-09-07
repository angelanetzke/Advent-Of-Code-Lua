local function part1(allLines)
	local total = 0
	for _, thisLine in ipairs(allLines) do
		local dimensions = {}
		for token in string.gmatch(thisLine, "%d+") do
			dimensions[#dimensions + 1] = tonumber(token)
		end
		total = total + 2 * dimensions[1] * dimensions[2] + 2 * dimensions[2] * dimensions[3] + 2 * dimensions[1] * dimensions[3]
		local smallest = dimensions[1] * dimensions[2]
		if dimensions[2] * dimensions[3] < smallest then
			smallest = dimensions[2] * dimensions[3]
		end
		if dimensions[1] * dimensions[3] < smallest then
			smallest = dimensions[1] * dimensions[3]
		end
		total = total + smallest
	end
	return total
end

local function part2(allLines)
	local total = 0
	for _, thisLine in ipairs(allLines) do
		local dimensions = {}
		for token in string.gmatch(thisLine, "%d+") do
			dimensions[#dimensions + 1] = tonumber(token)
		end
		local smallest = 2 * (dimensions[1] + dimensions[2])
		if 2 * (dimensions[2] + dimensions[3]) < smallest then
			smallest = 2 * (dimensions[2] + dimensions[3])
		end
		if 2 * (dimensions[1] + dimensions[3]) < smallest then
			smallest = 2 * (dimensions[1] + dimensions[3])
		end
		total = total + smallest
		total = total + dimensions[1] * dimensions[2] * dimensions[3]
	end
	return total
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