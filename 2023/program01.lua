local function part1(allLines)
	local values = {}
	values["1"] = 1
	values["2"] = 2
	values["3"] = 3
	values["4"] = 4
	values["5"] = 5
	values["6"] = 6
	values["7"] = 7
	values["8"] = 8
	values["9"] = 9
	local sum = 0
	for i = 1, #allLines do
		local firstDigit = 0
		local lastDigit = 0
		local isFirstDigitFound = false
		local isLastDigitFound = false
		local j = 1
		-- Look for substring starting at beginning
		while not isFirstDigitFound do
			for k,v in pairs(values) do
				if string.sub(allLines[i], j, j) == k then
					isFirstDigitFound = true
					firstDigit = v
				end
			end
			j = j + 1
		end
		-- Look for substring starting at end
		j = #allLines[i]
		while not isLastDigitFound do
			for k,v in pairs(values) do
				if string.sub(allLines[i], j, j) == k then
					isLastDigitFound = true
					lastDigit = v
				end
			end
			j = j - 1
		end
		sum = sum + 10 * firstDigit + lastDigit
	end
	return sum
end

local function part2(allLines)
	local values = {}
	values["1"] = 1
	values["2"] = 2
	values["3"] = 3
	values["4"] = 4
	values["5"] = 5
	values["6"] = 6
	values["7"] = 7
	values["8"] = 8
	values["9"] = 9
	values["one"] = 1
	values["two"] = 2
	values["three"] = 3
	values["four"] = 4
	values["five"] = 5
	values["six"] = 6
	values["seven"] = 7
	values["eight"] = 8
	values["nine"] = 9
	local sum = 0
	for i = 1, #allLines do
		local firstDigit = 0
		local lastDigit = 0
		local isFirstDigitFound = false
		local isLastDigitFound = false
		local j = 1
		-- Look for substring starting at beginning
		while not isFirstDigitFound do
			for k,v in pairs(values) do
				if string.sub(allLines[i], j, j + #k - 1) == k then
					isFirstDigitFound = true
					firstDigit = v
				end
			end
			j = j + 1
		end
		-- Look for substring starting at end
		j = #allLines[i]
		while not isLastDigitFound do
			for k,v in pairs(values) do
				if j + # k - 1 <= #allLines[i] and string.sub(allLines[i], j, j + #k - 1) == k then
					isLastDigitFound = true
					lastDigit = v
				end
			end
			j = j - 1
		end
		sum = sum + 10 * firstDigit + lastDigit
	end
	return sum
end

io.input("input/input01.txt")
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