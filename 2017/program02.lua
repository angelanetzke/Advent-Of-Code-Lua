local function getMin(row)
	local min = -1
	for _, x in ipairs(row) do
		if min == -1 or x < min then
			min = x
		end
	end
	return min
end

local function getMax(row)
	local max = -1
	for _, x in ipairs(row) do
		if max == -1 or x > max then
			max = x
		end
	end
	return max
end

local function getQuotient(row)
	for i = 1, #row - 1 do
		for j = i + 1, # row do
			if row[i] % row[j] == 0 then
				return row[i] / row[j]
			end
			if row[j] % row[i] == 0 then
				return row[j] / row[i]
			end
		end
	end
	return -1
end

local function part1(allLines)
	local checkSum = 0
	for _, thisLine in ipairs(allLines) do
		local thisRow = {}
		for token in string.gmatch(thisLine, "%d+") do
			thisRow[#thisRow + 1] = tonumber(token)
		end
		local thisMin = getMin(thisRow)
		local thisMax = getMax(thisRow)
		checkSum = checkSum + thisMax - thisMin
	end
	return checkSum
end

local function part2(allLines)
	local checkSum = 0
	for _, thisLine in ipairs(allLines) do
		local thisRow = {}
		for token in string.gmatch(thisLine, "%d+") do
			thisRow[#thisRow + 1] = tonumber(token)
		end
		local thisQuotient = getQuotient(thisRow)
		checkSum = checkSum + thisQuotient
	end
	return checkSum
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