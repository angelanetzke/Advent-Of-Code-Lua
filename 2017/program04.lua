local function isAnagramPair(string1, string2)
	local letters1 = {}
	for i = 1, #string1 do
		letters1[#letters1 + 1] = string1.sub(string1, i, i)
	end
	table.sort(letters1)
	local sortedString1 = table.concat(letters1)
	local letters2 = {}
	for i = 1, #string2 do
		letters2[#letters2 + 1] = string2.sub(string2, i, i)
	end
	table.sort(letters2)
	local sortedString2 = table.concat(letters2)
	return sortedString1 == sortedString2
end

local function part1(allLines)
	local validCount = 0
	for _, thisLine in ipairs(allLines) do
		local isValid = true
		local words = {}
		for token in string.gmatch(thisLine, "[^ ]+") do
			words[#words + 1] = token
		end
		for i = 1, #words - 1 do
			for j = i + 1, #words do
				if words[i] == words[j] then
					isValid = false
				end
			end
		end
		if isValid then
			validCount = validCount + 1
		end
	end
	return validCount
end

local function part2(allLines)
	local validCount = 0
	for _, thisLine in ipairs(allLines) do
		local isValid = true
		local words = {}
		for token in string.gmatch(thisLine, "[^ ]+") do
			words[#words + 1] = token
		end
		for i = 1, #words - 1 do
			for j = i + 1, #words do
				if isAnagramPair(words[i], words[j]) then
					isValid = false
				end
			end
		end
		if isValid then
			validCount = validCount + 1
		end
	end
	return validCount
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