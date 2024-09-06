local function part1(allLines)
	local memory = {}
	for i, thisLine in ipairs(allLines) do
		memory[i] = tonumber(thisLine)
	end
	local stepCount = 0
	local i = 1
	while 1 <= i and i <= #memory do
		local nextI = i + memory[i]
		memory[i] = memory[i] + 1
		i = nextI
		stepCount = stepCount + 1
	end
	return stepCount
end

local function part2(allLines)
	local memory = {}
	for i, thisLine in ipairs(allLines) do
		memory[i] = tonumber(thisLine)
	end
	local stepCount = 0
	local i = 1
	while 1 <= i and i <= #memory do
		local nextI = i + memory[i]
		if memory[i] >= 3 then
			memory[i] = memory[i] - 1
		else
			memory[i] = memory[i] + 1
		end
		i = nextI
		stepCount = stepCount + 1
	end
	return stepCount
end

io.input("input/input05.txt")
local allLines = {}
local nextLine = io.read("*line")
while nextLine ~= nil do
	allLines[#allLines + 1] = nextLine
	nextLine = io.read("*line")
end
print("Part 1: " .. part1(allLines))
print("Part 2: " .. part2(allLines))