local function getMatchCount(thisLine)
	local colonIndex = string.find(thisLine, ":")
	local pipeIndex = string.find(thisLine, "|")
	local winningNumbers = {}
	local elfNumbers = {}
	local i = colonIndex + 1
	while i < pipeIndex - 1 do
		local _, finish, nextNumber = string.find(thisLine, " (%d+) ", i)
		winningNumbers[#winningNumbers + 1] = tonumber(nextNumber)
		i = finish
	end
	i = pipeIndex + 1
	while i < #thisLine do
		local _, finish, nextNumber = string.find(thisLine, " (%d+) ", i)
		if nextNumber == nil then
			_, finish, nextNumber = string.find(thisLine, " (%d+)$", i)
		end
		elfNumbers[#elfNumbers + 1] = tonumber(nextNumber)
		i = finish
	end
	local count = 0
	for i = 1, #winningNumbers do
		for j = 1, #elfNumbers do
			if winningNumbers[i] == elfNumbers[j] then
				count = count + 1
			end
		end
	end
	return count
end

local function part1(allLines)
	local value = 0
	for i = 1, #allLines do
		local matchCount = getMatchCount(allLines[i])
		if matchCount > 0 then
			value = value + 2 ^ (matchCount - 1)
		end
	end
	return value
end

local function part2(allLines)
	local values = {}
	local counts = {}
	for i = 1, #allLines do
		local _, _, cardNumber = string.find(allLines[i], " (%d+):")
		cardNumber = tonumber(cardNumber)
		counts[cardNumber] = 1
		local matchCount = getMatchCount(allLines[i])
		values[cardNumber] = matchCount
	end
	for k, v in pairs(values) do
		for i = 1, v do
			counts[k + i] = counts[k + i] + counts[k]
		end
	end
	local total = 0
	for i = 1, #counts do
		total = total + counts[i]
	end
	return total
end

io.input("input/input04.txt")
local allLines = {}
local i = 1
local nextLine = io.read("*line")
while nextLine ~= nil do
	allLines[i] = nextLine
	i = i + 1
	nextLine = io.read("*line")
end
print("Part 1: " .. part1(allLines))
print("Part 2: " .. part2(allLines))