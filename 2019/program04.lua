local function hasAdjacentDigits(password)
	local passwordString = tostring(password)
	for i = 1, #passwordString - 1 do
		if string.sub(passwordString, i, i) == string.sub(passwordString, i + 1, i + 1) then
			return true
		end
	end
	return false
end

local function isIncreasing(password)
	local passwordString = tostring(password)
	for i = 1, #passwordString - 1 do
		if tonumber(string.sub(passwordString, i + 1, i + 1)) < tonumber(string.sub(passwordString, i, i)) then
			return false
		end
	end
	return true
end

local function hasTwoAdjacentDigits(password)
	local passwordString = tostring(password)
	for i = 0, 9 do
		local double = tostring(i) .. tostring(i)
		local triple = tostring(i) .. tostring(i) .. tostring(i)
		if string.find(passwordString, double) and not string.find(passwordString, triple) then
			return true
		end
	end
	return false
end

local function isValid(password, isPart2)
	if isPart2 then
		if not hasTwoAdjacentDigits(password) then
			return false
		end
	else
		if not hasAdjacentDigits(password) then
			return false
		end
	end
	if not isIncreasing(password) then
		return false
	end
	return true
end

local function part1(allLines)
	local validCount = 0
	local temp = {}
	for token in string.gmatch(allLines[1], "[^-]+") do
		temp[#temp + 1] = tonumber(token)
	end
	for i = temp[1], temp[2] do
		if isValid(i, false) then
			validCount = validCount + 1
		end
	end
	return validCount
end

local function part2(allLines)
	local validCount = 0
	local temp = {}
	for token in string.gmatch(allLines[1], "[^-]+") do
		temp[#temp + 1] = tonumber(token)
	end
	for i = temp[1], temp[2] do
		if isValid(i, true) then
			validCount = validCount + 1
		end
	end
	return validCount
end

io.input("input/input04.txt")
local allLines = {}
local nextLine = io.read("*line")
while nextLine ~= nil do
	allLines[#allLines + 1] = nextLine
	nextLine = io.read("*line")
end
print("Part 1: " .. part1(allLines))
print("Part 2: " .. part2(allLines))