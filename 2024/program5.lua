local function AreOutOfOrder(rulesTable, first, second)
	for i = 1, #rulesTable do
		if rulesTable[i][1] == second and rulesTable[i][2] == first then
			return true
		end
	end
	return false
end

local function sort(rulesTable, pages)
	local newPages = {}
	for i = 1, #pages do
		newPages[#newPages + 1] = pages[i]
	end
	for i = 1, #newPages - 1 do
		for j = i + 1, #newPages do
			if AreOutOfOrder(rulesTable, newPages[i], newPages[j]) then
				local temp = newPages[i]
				newPages[i] = newPages[j]
				newPages[j] = temp
			end
		end
	end
	return newPages
	end

local function getIndexInTable(value, pageTable)
	for i = 1, #pageTable do
		if pageTable[i] == value then
			return i
		end
	end
	return -1
end

local function areInOrder(rulesTable, pages)
	for i = 1, #rulesTable do
		local firstIndex = getIndexInTable(rulesTable[i][1], pages)
		local secondIndex = getIndexInTable(rulesTable[i][2], pages)
		if firstIndex >= 0 and secondIndex >= 0 then
			if firstIndex > secondIndex then
				return false
			end
		end
	end
	return true
end

local function part1(allLines, unsorted, rulesTable)
	local sum = 0
	local isProcessingRules = true
	local pagesList = {}
	for i = 1, #allLines do
		if #allLines[i] == 0 then
			isProcessingRules = false
		elseif isProcessingRules then
			local newEntry = {}
			for m in string.gmatch(allLines[i], "%d+") do
				newEntry[#newEntry + 1] = tonumber(m)
			end
			rulesTable[#rulesTable + 1] = newEntry
		else
			local newEntry = {}
			for m in string.gmatch(allLines[i], "%d+") do
				newEntry[#newEntry + 1] = tonumber(m)
			end
			pagesList[#pagesList + 1] = newEntry
		end
	end
	for i = 1, #pagesList do
		if areInOrder(rulesTable, pagesList[i]) then
			sum = sum + pagesList[i][(#pagesList[i] + 1) / 2]
		else
			unsorted[#unsorted + 1] = pagesList[i]
		end
	end
	return sum
end

local function part2(unsorted, rulesTable)
	local sum = 0
	for i = 1, #unsorted do
		local sortedTable = sort(rulesTable, unsorted[i])
		sum = sum + sortedTable[(#sortedTable + 1) / 2]
	end
	return sum
end

io.input("input/input5.txt")
local allLines = {}
local nextLine = io.read("*line")
while nextLine ~= nil do
	allLines[#allLines + 1] = nextLine
	nextLine = io.read("*line")
end
local unsorted = {}
local rulesTable = {}
print("Part 1: " .. part1(allLines, unsorted, rulesTable))
print("Part 2: " .. part2(unsorted, rulesTable))