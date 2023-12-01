LowerA = string.byte("a", 1, 1)
UpperA = string.byte("A", 1, 1)

local function part1(allLines)
	local prioritySum = 0;
	for i = 1, #allLines do
		local firstCompartment = string.sub(allLines[i], 1, #allLines[i] / 2)
		local secondCompartment = string.sub(allLines[i], #allLines[i] / 2 + 1, #allLines[i])
		local duplicate
		for j = 1, #firstCompartment do
			local thisItem = string.sub(firstCompartment, j, j)
			if string.find(secondCompartment, thisItem) then
				duplicate = thisItem
			end
		end
		local asciiValue = string.byte(duplicate, 1, 1)
		if duplicate == string.lower(duplicate) then
			prioritySum = prioritySum + asciiValue - LowerA + 1
		else
			prioritySum = prioritySum + asciiValue - UpperA + 27
		end
	end
	return prioritySum
end

local function part2(allLines)
	local prioritySum = 0;
	for i = 1, #allLines - 2, 3 do
		local firstRucksack = allLines[i]
		local secondRucksack = allLines[i + 1]
		local thirdRucksack = allLines[i + 2]
		local sharedItem
		for j = 1, #firstRucksack do
			local thisItem = string.sub(firstRucksack, j, j)
			if string.find(secondRucksack, thisItem) and string.find(thirdRucksack, thisItem) then
				sharedItem = thisItem
			end
		end
		local asciiValue = string.byte(sharedItem, 1, 1)
		if sharedItem == string.lower(sharedItem) then
			prioritySum = prioritySum + asciiValue - LowerA + 1
		else
			prioritySum = prioritySum + asciiValue - UpperA + 27
		end
	end
	return prioritySum
end

io.input("input.txt")
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