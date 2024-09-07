local md5 = require "md5"

local function part1(allLines)
	local key = allLines[1]
	local i = 1
	while (true) do
		local hash = md5.sumhexa(key .. i)
		if string.sub(hash, 1, 5) == "00000" then
			return i
		end
		i = i + 1
	end
	return -1
end

local function part2(allLines)
	local key = allLines[1]
	local i = 1
	while (true) do
		local hash = md5.sumhexa(key .. i)
		if string.sub(hash, 1, 6) == "000000" then
			return i
		end
		i = i + 1
	end
	return -1
end

io.input("input/input04.txt")
local allLines = {}
local nextLine = io.read("*line")
while nextLine ~= nil do
	allLines[#allLines + 1] = nextLine
	nextLine = io.read("*line")
end
print("Part 1: " .. part1(allLines))
print("Part 2: " .. part2(allLines))