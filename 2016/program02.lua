local function part1(allLines)
	local code = ""
	local buttons = {}
	-- up down left right
	buttons["1"] = { nil, "4", nil, "2" }
	buttons["2"] = { nil, "5", "1", "3" }
	buttons["3"] = { nil, "6", "2", nil }
	buttons["4"] = { "1", "7", nil, "5" }
	buttons["5"] = { "2", "8", "4", "6" }
	buttons["6"] = { "3", "9", "5", nil }
	buttons["7"] = { "4", nil, nil, "8" }
	buttons["8"] = { "5", nil, "7", "9" }
	buttons["9"] = { "6", nil, "8", nil }
	local currentButton = "5"
	for _, thisLine in ipairs(allLines) do
		for i = 1, #thisLine do
			local thisChar = string.sub(thisLine, i, i)
			if thisChar == "U" and buttons[currentButton][1] ~= nil then
				currentButton = buttons[currentButton][1]
			elseif thisChar == "D" and buttons[currentButton][2] ~= nil then
				currentButton = buttons[currentButton][2]
			elseif thisChar == "L" and buttons[currentButton][3] ~= nil then
				currentButton = buttons[currentButton][3]
			elseif thisChar == "R" and buttons[currentButton][4] ~= nil then
				currentButton = buttons[currentButton][4]
			end
		end
		code = code .. currentButton
	end
	return code
end

local function part2(allLines)
	local code = ""
	local buttons = {}
	-- up down left right
	buttons["1"] = { nil, "3", nil, nil }
	buttons["2"] = { nil, "6", nil, "3" }
	buttons["3"] = { "1", "7", "2", "4" }
	buttons["4"] = { nil, "8", "3", nil }
	buttons["5"] = { nil, nil, nil, "6" }
	buttons["6"] = { "2", "A", "5", "7" }
	buttons["7"] = { "3", "B", "6", "8" }
	buttons["8"] = { "4", "C", "7", "9" }
	buttons["9"] = { nil, nil, "8", nil }
	buttons["A"] = { "6", nil, nil, "B" }
	buttons["B"] = { "7", "D", "A", "C" }
	buttons["C"] = { "8", nil, "B", nil }
	buttons["D"] = { "B", nil, nil, nil }
	local currentButton = "5"
	for _, thisLine in ipairs(allLines) do
		for i = 1, #thisLine do
			local thisChar = string.sub(thisLine, i, i)
			if thisChar == "U" and buttons[currentButton][1] ~= nil then
				currentButton = buttons[currentButton][1]
			elseif thisChar == "D" and buttons[currentButton][2] ~= nil then
				currentButton = buttons[currentButton][2]
			elseif thisChar == "L" and buttons[currentButton][3] ~= nil then
				currentButton = buttons[currentButton][3]
			elseif thisChar == "R" and buttons[currentButton][4] ~= nil then
				currentButton = buttons[currentButton][4]
			end
		end
		code = code .. currentButton
	end
	return code
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