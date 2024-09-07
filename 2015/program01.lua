local function part1(allLines)
	local directions = allLines[1]
	local floor = 0
	for i = 1, #directions do
		if string.sub(directions, i, i) == "(" then
			floor = floor + 1
		elseif string.sub(directions, i, i) == ")" then
			floor = floor - 1
		end
	end
	return floor
end

local function part2(allLines)
	local directions = allLines[1]
	local floor = 0
	for i = 1, #directions do
		if string.sub(directions, i, i) == "(" then
			floor = floor + 1
		elseif string.sub(directions, i, i) == ")" then
			floor = floor - 1
		end
		if floor == -1 then
			return i
		end
	end
	return -1
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