local function getCommonLetters(string1, string2)
	local commonLetters = ""
	for i = 1, #string1 do
		if string.sub(string1, i, i) == string.sub(string2, i, i) then
			commonLetters = commonLetters .. string.sub(string1, i, i)
		end
	end
	return commonLetters
end

local function part1(allLines)
	local doubleCount = 0
	local tripleCount = 0
	for _, thisLine in ipairs(allLines) do
		local hasDouble = false
		local hasTriple = false
		for i = string.byte("a"), string.byte("z") do
			local thisChar = string.char(i)
			local _, count = string.gsub(thisLine, thisChar, "")
			if count == 2 then
				hasDouble = true
			end
			if count == 3 then
				hasTriple = true
			end
		end
		if hasDouble then
			doubleCount = doubleCount + 1
		end
		if hasTriple then
			tripleCount = tripleCount + 1
		end
	end
	return doubleCount * tripleCount
end

local function part2(allLines)
	for i = 1, #allLines - 1 do
		for j = i + 1, #allLines do
			local commonLetters = getCommonLetters(allLines[i], allLines[j])
			if #allLines[i] - #commonLetters == 1 then
				return commonLetters
			end
		end
	end
	return -1
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