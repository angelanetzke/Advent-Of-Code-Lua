local md5 = require 'md5'

local function part1(allLines)
	local doorID = allLines[1]
	local password = ""
	local i = 0
	local hash = ""
	while #password < 8 do
		hash = md5.sumhexa(doorID .. i)
		if string.sub(hash, 1, 5) == "00000" then
			password = password .. string.sub(hash, 6, 6)
		end
		i = i + 1
	end
	return password
end

local function part2(allLines)
	local passwordChars = {}
	local charCount = 0
	local doorID = allLines[1]
	local i = 0
	local hash = ""
	while charCount < 8 do
		hash = md5.sumhexa(doorID .. i)
		if string.sub(hash, 1, 5) == "00000" then
			local position = string.sub(hash, 6, 6)
			if "0" <= position and position <= "7" and passwordChars[position] == nil then
				passwordChars[position] = string.sub(hash, 7, 7)
				charCount = charCount + 1
			end
		end
		i = i + 1
	end
	local password = ""
	for key = 0, 7 do
		password = password .. passwordChars[tostring(key)]
	end
	return password
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