local function part1(allLines)
	local x = 0
	local y = 0
	for _, thisLine in ipairs(allLines) do
		if string.find(thisLine, "forward") then
			x = x + tonumber(string.match(thisLine, "%d+"))
		elseif string.find(thisLine, "up") then
			y = y - tonumber(string.match(thisLine, "%d+"))
		elseif string.find(thisLine, "down") then
			y = y + tonumber(string.match(thisLine, "%d+"))
		end
	end
	return x * y
end

local function part2(allLines)
	local x = 0
	local y = 0
	local aim = 0
	for _, thisLine in ipairs(allLines) do
		if string.find(thisLine, "forward") then
			x = x + tonumber(string.match(thisLine, "%d+"))
			y = y + aim * tonumber(string.match(thisLine, "%d+"))
		elseif string.find(thisLine, "up") then
			aim = aim - tonumber(string.match(thisLine, "%d+"))
		elseif string.find(thisLine, "down") then
			aim = aim + tonumber(string.match(thisLine, "%d+"))
		end
	end
	return x * y
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
