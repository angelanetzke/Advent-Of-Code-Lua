local function part1(allLines)
	local containedCount = 0
	for _, thisLine in ipairs(allLines) do
		local temp = {}
		for num in string.gmatch(thisLine, "%d+") do
			temp[#temp + 1] = tonumber(num)
		end
		if temp[3] <= temp[1] and temp[2] <= temp[4] then
			containedCount = containedCount + 1
		elseif temp[1] <= temp[3] and temp[4] <= temp[2] then
			containedCount = containedCount + 1
		end
	end	
	return containedCount
end

local function part2(allLines)
	local overlapCount = 0
	for _, thisLine in ipairs(allLines) do
		local temp = {}
		for num in string.gmatch(thisLine, "%d+") do
			temp[#temp + 1] = tonumber(num)
		end
		if math.max(temp[1], temp[3]) <= math.min(temp[2], temp[4]) then
			overlapCount = overlapCount + 1
		end
	end	
	return overlapCount
end

io.input("input/input04.txt")
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