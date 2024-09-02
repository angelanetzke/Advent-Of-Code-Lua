RequiredFields = { "byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid" }
EyeColors = { "amb", "blu", "brn", "gry", "grn", "hzl", "oth" }

local function parsePassport(passportLines)
	local newPassport = {}
	local fieldPairs = {}
	for _, thisLine in ipairs(passportLines) do
		for x in string.gmatch(thisLine, "[^ ]+") do
			fieldPairs[#fieldPairs + 1] = x
		end
	end
	local tokens = {}
	for _, thisPair in ipairs(fieldPairs) do
		tokens = {}
		for x in string.gmatch(thisPair, "[^:]+") do
			tokens[#tokens + 1] = x
		end
		newPassport[tokens[1]] = tokens[2]
	end
	return newPassport
end

local function validatePassport(passport, isPart2)
	local includedFieldCount = 0
	for _, thisField in ipairs(RequiredFields) do
		for thisKey, _ in pairs(passport) do
			if thisField == thisKey then
				includedFieldCount = includedFieldCount + 1
			end
		end
	end
	if isPart2 then
		if includedFieldCount ~= #RequiredFields then
			return false
		end
	else
		return includedFieldCount == #RequiredFields
	end
	local byr = tonumber(passport["byr"])
	if byr < 1920 or byr > 2002 then
		return false
	end
	local iyr = tonumber(passport["iyr"])
	if iyr < 2010 or iyr > 2020 then
		return false
	end
	local eyr = tonumber(passport["eyr"])
	if eyr < 2020 or eyr > 2030 then
		return false
	end	
	local hgt = passport["hgt"]
	if string.match(hgt, "^%d+cm$") then
		local hgtValue = tonumber(string.match(hgt, "%d+"))
		if hgtValue < 150 or hgtValue > 193 then
			return false
		end
	elseif string.match(hgt, "^%d+in$") then
		local hgtValue = tonumber(string.match(hgt, "%d+"))
		if hgtValue < 59 or hgtValue > 76 then
			return false
		end
	else
		return false
	end
	local hcl = passport["hcl"]
	if #hcl ~= 7 or not string.match(hcl, "^#[0-9a-f]+$") then
		return false
	end
	local ecl = passport["ecl"]
	local isValidColor = false
	for _, thisEyeColor in ipairs(EyeColors) do
		if ecl == thisEyeColor then
			isValidColor = true
		end
	end
	if not isValidColor then
		return false
	end
	local pid = passport["pid"]
	if #pid ~= 9 or not string.match(pid, "^%d+$") then
		return false
	end
	return true
end

local function part1(allLines)
	local validCount = 0
	local thisPassportLines = {}
	local thisPassport = {}
	for i, thisLine in ipairs(allLines) do
		if #thisLine > 0 then
			thisPassportLines[#thisPassportLines + 1] = thisLine
		end
		if #thisLine == 0 or i == #allLines then
			thisPassport = parsePassport(thisPassportLines)
			local isValid = validatePassport(thisPassport, false)
			if isValid then
				validCount = validCount + 1
			end
			thisPassportLines = {}
		end
	end
	return validCount
end

local function part2(allLines)
	local validCount = 0
	local thisPassportLines = {}
	local thisPassport = {}
	for i, thisLine in ipairs(allLines) do
		if #thisLine > 0 then
			thisPassportLines[#thisPassportLines + 1] = thisLine
		end
		if #thisLine == 0 or i == #allLines then
			thisPassport = parsePassport(thisPassportLines)
			local isValid = validatePassport(thisPassport, true)
			if isValid then
				validCount = validCount + 1
			end
			thisPassportLines = {}
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