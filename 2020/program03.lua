local function iterate(allLines, row, column, deltaRow, deltaColumn)
	local nextRow = row + deltaRow
	local nextColumn = column + deltaColumn
	local nextType = "X"
	if nextRow <= #allLines then
		local adjustedColumn = (nextColumn - 1) % #allLines[1] + 1
		nextType = string.sub(allLines[nextRow], adjustedColumn, adjustedColumn)
	end
	return nextRow, nextColumn, nextType
end

local function part1(allLines)
	local nextRow = 1
	local nextColumn = 1
	local nextType = "."
	local treeCount = 0
	while nextType ~= "X" do
		nextRow, nextColumn, nextType = iterate(allLines, nextRow, nextColumn, 1, 3)
		if nextType == "#" then
			treeCount = treeCount + 1
		end
	end
	return treeCount
end

local function part2(allLines)
	local nextRow = 1
	local nextColumn = 1
	local nextType = "."
	local treeCount = 0
	local slopes = {
		{1, 1},
		{1, 3},
		{1, 5},
		{1, 7},
		{2, 1}
	}
	local treeProduct = 1
	for _, thisSlope in ipairs(slopes) do
		nextRow = 1
		nextColumn = 1
		nextType = "."
		treeCount = 0
		while nextType ~= "X" do
			nextRow, nextColumn, nextType = iterate(allLines, nextRow, nextColumn, thisSlope[1], thisSlope[2])
			if nextType == "#" then
				treeCount = treeCount + 1
			end
		end
		treeProduct = treeProduct * treeCount
	end
	return treeProduct
end

io.input("input/input03.txt")
local allLines = {}
local nextLine = io.read("*line")
while nextLine ~= nil do
	allLines[#allLines + 1] = nextLine
	nextLine = io.read("*line")
end
print("Part 1: " .. part1(allLines))
print("Part 2: " .. part2(allLines))