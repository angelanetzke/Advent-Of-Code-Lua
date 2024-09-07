local vowels = { "a", "e", "i", "o", "u"}
local naughtyPairs = { "ab", "cd", "pq", "xy" }

local function isNiceStringPart1(thisLine)
	local vowelCount = 0
	for _, thisVowel in ipairs(vowels) do
		local _, count = string.gsub(thisLine, thisVowel, "")
		vowelCount = vowelCount + count
	end
	if vowelCount < 3 then
		return false
	end
	local hasTwoInARow = false
	for i = 1, #thisLine - 1 do
		if string.sub(thisLine, i, i) == string.sub(thisLine, i + 1, i + 1) then
			hasTwoInARow = true
			break
		end
	end
	if not hasTwoInARow then
		return false
	end
	for _, thisPair in ipairs(naughtyPairs) do
		if string.find(thisLine, thisPair) then
			return false
		end
	end
	return true
end

local function isNiceStringPart2(thisLine)
	local hasTwoOfAPair = false
	for i = 1, #thisLine - 3 do
		for j = i + 2, #thisLine - 1 do
			if string.sub(thisLine, i, i) == string.sub(thisLine, j, j)
				and string.sub(thisLine, i + 1, i + 1) == string.sub(thisLine, j + 1, j + 1) then
				hasTwoOfAPair = true
			end
		end
	end
	if not hasTwoOfAPair then
		return false
	end
	for i = 1, #thisLine - 2 do
		if string.sub(thisLine, i, i) == string.sub(thisLine, i + 2, i + 2) then
			return true
		end
	end
	return false
end

local function part1(allLines)
	local niceCount = 0
	for _, thisLine in ipairs(allLines) do
		if isNiceStringPart1(thisLine) then
			niceCount = niceCount + 1
		end
	end
	return niceCount
end

local function part2(allLines)
	local niceCount = 0
	for _, thisLine in ipairs(allLines) do
		if isNiceStringPart2(thisLine) then
			niceCount = niceCount + 1
		end
	end
	return niceCount
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