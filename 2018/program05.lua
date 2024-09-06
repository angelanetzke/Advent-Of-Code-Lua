local function react(initialString)
	local i = 1
	local difference = string.byte('a') - string.byte('A')
	local newString = initialString
	local temp = ""
	local removalCount = 1
	while removalCount > 0 do
		removalCount = 0
		temp = ""
		i = 1
		while i <= #newString do
			if i == #newString then
				temp = temp .. string.sub(newString, i, i)
				i = i + 1
			else
				local charValue1 = string.byte(newString, i)
				local charValue2 = string.byte(newString, i + 1)
				if math.abs(charValue1 - charValue2) == difference then
					removalCount = removalCount + 1
					i = i + 2
				else
					temp = temp .. string.sub(newString, i, i)
					i = i + 1
				end
			end
		end
		newString = temp
	end
	return #newString
end

local function part1(allLines)
	return react(allLines[1])
end

local function part2(allLines)
	local difference = string.byte('a') - string.byte('A')
	local shortestLength = -1
	for i = string.byte('A'), string.byte('Z') do
		local lowerCase = string.char(i + difference)
		local upperCase = string.char(i)
		local thisString = string.gsub(allLines[1], lowerCase, "")
		thisString = string.gsub(thisString, upperCase, "")
		local thisLength = react(thisString)
		if shortestLength == -1 or thisLength < shortestLength then
			shortestLength = thisLength
		end
	end
	return shortestLength
end

io.input("input/input05.txt")
local allLines = {}
local nextLine = io.read("*line")
while nextLine ~= nil do
	allLines[#allLines + 1] = nextLine
	nextLine = io.read("*line")
end
print("Part 1: " .. part1(allLines))
print("Part 2: " .. part2(allLines))
