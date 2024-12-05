local function getRow(lines, rowIndex)
	local row = {}
	for i = 1, #lines[rowIndex] do
		row[#row + 1] = string.sub(lines[rowIndex], i, i)
	end
	return row
end

local function getColumn(lines, index)
	local column = {}
	for i = 1, #lines do
		column[#column + 1] = string.sub(lines[i], index, index)
	end
	return column
end

local function getDiagonalDownLeft(lines, index)
	local diagonal = {}
	local row = 1
	local column = index
	if index > #lines[1] then
		row = index - #lines[1] + 1
		column = #lines[1]
	end
	while row <= #lines and column >= 1 do
		diagonal[#diagonal + 1] = string.sub(lines[row], column, column)
		row = row + 1
		column = column - 1
	end
	return diagonal
end

local function getDiagonalDownRight(lines, index)
	local diagonal = {}
	local row = #lines - index + 1
	local column = 1
	if index > #lines then
		row = 1
		column = index - #lines + 1
	end
	while row <= #lines and column <= #lines[1] do
		diagonal[#diagonal + 1] = string.sub(lines[row], column, column)
		row = row + 1
		column = column + 1
	end
	return diagonal
end

local function getIndices(line, target)
	local indices = {}
	for i = 1, #line - #target + 1 do
		local isMatch = true
		for j = 0, #target - 1 do
			if line[i + j] ~= string.sub(target, j + 1, j + 1) then
				isMatch = false
				break
			end
		end
		if isMatch then
			indices[#indices + 1] = i - 1
		end
	end
	return indices
end

local function addPoint(pointTable, x, y)
	for i = 1, #pointTable do
		if pointTable[i][1] == x and pointTable[i][2] == y then
			pointTable[i][3] = pointTable[i][3] + 1
			return
		end
	end
	pointTable[#pointTable + 1] = {x, y, 1}
end

local function countDuplicates(pointTable)
	local count = 0
	for i = 1, #pointTable do
		if pointTable[i][3] > 1 then
			count = count + 1
		end
	end
	return count
end

local function part1(allLines)
	local count = 0
	local target = "XMAS"
	local reversed = "SAMX"
	for i = 1, #allLines do
		local row = getRow(allLines, i)
		count = count + #getIndices(row, target)
		count = count + #getIndices(row, reversed)
	end
	for i = 1, #allLines[1] do
		local column = getColumn(allLines, i)
		count = count + #getIndices(column, target)
		count = count + #getIndices(column, reversed)
	end
	for i = #target, #allLines + #allLines[1] - #target do
		local diagonal = getDiagonalDownLeft(allLines, i)
		count = count + #getIndices(diagonal, target)
		count = count + #getIndices(diagonal, reversed)
	end
	for i = #target, #allLines + #allLines[1] - #target do
		local diagonal = getDiagonalDownRight(allLines, i)
		count = count + #getIndices(diagonal, target)
		count = count + #getIndices(diagonal, reversed)
	end
	return count
end

local function part2(allLines)
	local pointTable = {}
	local target = "MAS"
	local reversed = "SAM"
	for i = #target, #allLines + #allLines[1] - #target do
		local startRow = 1
		local startColumn = i
		if i > #allLines[1] then
			startRow = i - #allLines[1] + 1
			startColumn = #allLines[1]
		end
		local diagonal = getDiagonalDownLeft(allLines, i)
		local indices = getIndices(diagonal, target)
		for j = 1, #indices do
			addPoint(pointTable, startRow + indices[j] + 1, startColumn - indices[j] - 1)
		end
		indices = getIndices(diagonal, reversed)
		for j = 1, #indices do
			addPoint(pointTable, startRow + indices[j] + 1, startColumn - indices[j] - 1)
		end
	end
	for i = #target, #allLines + #allLines[1] - #target do
		local startRow = #allLines - i + 1
		local startColumn = 1
		if i > #allLines then
			startRow = 1
			startColumn = i - #allLines + 1
		end
		local diagonal = getDiagonalDownRight(allLines, i)
		local indices = getIndices(diagonal, target)
		for j = 1, #indices do
			addPoint(pointTable, startRow + indices[j] + 1, startColumn + indices[j] + 1)
		end
		indices = getIndices(diagonal, reversed)
		for j = 1, #indices do
			addPoint(pointTable, startRow + indices[j] + 1, startColumn + indices[j] + 1)
		end
	end
	return countDuplicates(pointTable)
end

io.input("input/input4.txt")
local allLines = {}
local nextLine = io.read("*line")
while nextLine ~= nil do
	allLines[#allLines + 1] = nextLine
	nextLine = io.read("*line")
end
print("Part 1: " .. part1(allLines))
print("Part 2: " .. part2(allLines))