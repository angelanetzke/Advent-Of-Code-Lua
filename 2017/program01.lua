local function sumMatches(digitList, offset)
	local matchSum = 0
	local firstDigit = ""
	local secondDigit = ""
	for i = 1, #digitList do
		firstDigit = string.sub(digitList, i, i)
		secondDigit = string.sub(digitList, (i + offset) % #digitList, (i + offset) % #digitList)
		if firstDigit == secondDigit then
			matchSum = matchSum + tonumber(firstDigit)
		end
	end
	return matchSum
end

local function part1(allLines)
	return sumMatches(allLines[1], 1)
end

local function part2(allLines)
	return sumMatches(allLines[1], #allLines[1] / 2)
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