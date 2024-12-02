local function countOccurances(t, x)
	local count = 0
	for i = 1, #t do
		if t[i] == x then
			count = count + 1
		end
	end
	return count
end

local function part1(leftList, rightList)
	local differenceSum = 0
	for i = 1, #leftList do
		differenceSum = differenceSum + math.abs(leftList[i] - rightList[i])
	end
	return differenceSum
end

local function part2(leftList, rightList)
	local similarityScore = 0
	for i = 1, #leftList do
		similarityScore = similarityScore + leftList[i] * countOccurances(rightList, leftList[i])
	end
	return similarityScore
end

io.input("input/input1.txt")
local allLines = {}
local i = 1
local nextLine = io.read("*line")
while nextLine ~= nil do
	allLines[i] = nextLine
	i = i + 1
	nextLine = io.read("*line")
end
local leftList = {}
local rightList = {}
for i = 1, #allLines do
	local _, _, left, right = string.find(allLines[i], "(%d+) +(%d+)")
	leftList[i] = tonumber(left)
	rightList[i] = tonumber(right)
end
table.sort(leftList)
table.sort(rightList)
print("Part 1: " .. part1(leftList, rightList))
print("Part 2: " .. part2(leftList, rightList))