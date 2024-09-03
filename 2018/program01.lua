local function part1(allLines)
	local frequency = 0
	for _, thisLine in ipairs(allLines) do
		frequency = frequency + tonumber(thisLine)
	end
	return frequency
end

local function part2(allLines)
	local i = 1
	local frequency = 0
	local frequencyList = {}
	frequencyList[0] = true
	while true do
		frequency = frequency + tonumber(allLines[i])
		if frequencyList[frequency] ~= nil then
			return frequency
		end
		frequencyList[frequency] = true
		i = i % #allLines + 1
	end
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