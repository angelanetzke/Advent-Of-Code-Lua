local function part1(allLines)
	local increaseCount = 0
	for i = 1, #allLines - 1 do
		if tonumber(allLines[i + 1]) > tonumber(allLines[i]) then
			increaseCount = increaseCount + 1
		end
	end
	return increaseCount
end

local function part2(allLines)
	local increaseCount = 0
	local windowSize = 3
	for i = 1, #allLines - windowSize do
		if tonumber(allLines[i + windowSize]) > tonumber(allLines[i]) then
			increaseCount = increaseCount + 1
		end
	end
	return increaseCount
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