local function part1(allLines)
	local greatestCalories = 0;
	local currentCalories = 0;
	for i = 1, #allLines do
		if #allLines[i] == 0 then -- Reset the calorie count
			if currentCalories > greatestCalories then
				greatestCalories = currentCalories
			end
			currentCalories = 0;
		else -- Add current number to current calories
			local thisNumber = tonumber(allLines[i])
			currentCalories = currentCalories + thisNumber
		end
	end
	-- Handle situation where last calorie set is the greatest
	if currentCalories > greatestCalories then
			greatestCalories = currentCalories
		end
	return greatestCalories
end

local function part2(allLines)
	local currentCalories = 0;
	local calorieTable = {}
	local calorieIndex = 1
	for i = 1, #allLines do
		if #allLines[i] == 0 then -- Add currentCalories to calorieTable
			calorieTable[calorieIndex] = currentCalories
			calorieIndex = calorieIndex + 1
			currentCalories = 0;
		else -- Increase currentCalories
			local thisNumber = tonumber(allLines[i])
			currentCalories = currentCalories + thisNumber
		end
	end
	-- Add last currentCalories to calorieTable
	calorieTable[#calorieTable + 1] = currentCalories
	table.sort(calorieTable)
	local sum = calorieTable[#calorieTable]
		+ calorieTable[#calorieTable - 1]
		+ calorieTable[#calorieTable - 2]
	return sum
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
