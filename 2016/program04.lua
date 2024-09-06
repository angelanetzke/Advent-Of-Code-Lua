local realRooms = {}

local function isReal(roomName, checkSum)
	local counts = {}
		for i = 1, #roomName do
			if "a" <= string.sub(roomName, i, i) and string.sub(roomName, i, i) <= "z" then
				if counts[string.sub(roomName, i, i)] == nil then
					counts[string.sub(roomName, i, i)] = 1
				else
					counts[string.sub(roomName, i, i)] = counts[string.sub(roomName, i, i)] + 1
				end
			end
		end
		local sortableCounts = {}
		for character, count in pairs(counts) do
			sortableCounts[#sortableCounts + 1] = { character, count }
		end
		table.sort(sortableCounts, function (a, b)
			if a[2] == b[2] then
				return a[1] < b[1]
			else
				return a[2] > b[2]
			end
		end)
		local compareToCheckSum = ""
		for _, value in ipairs(sortableCounts) do
			compareToCheckSum = compareToCheckSum .. value[1]
		end
		return checkSum == string.sub(compareToCheckSum, 1, 5)
end

local function part1(allLines)
	local sectorIDSum = 0
	for _, thisLine in ipairs(allLines) do
		local roomName = string.match(thisLine, "^(.+)%[")
		local checkSum = string.match(thisLine, "%[(.+)%]")
		local sectorID = string.match(thisLine, "%d+")
		if isReal(roomName, checkSum) then
			sectorIDSum = sectorIDSum + sectorID
			realRooms[#realRooms + 1] = roomName
		end
	end
	return sectorIDSum
end

local function part2(allLines)
	for _, thisRoom in ipairs(realRooms) do
		local decryptedName = ""
		for i = 1, #thisRoom do
			local sectorID = string.match(thisRoom, "%d+")
			local thisChar = string.sub(thisRoom, i, i)
			if "a" <= thisChar and thisChar <= "z" then
				decryptedName = decryptedName .. string.char((string.byte(thisChar) - string.byte("a") + sectorID) % 26 + string.byte("a"))
			elseif "0" <= thisChar and thisChar <= "9" then
				decryptedName = decryptedName .. thisChar
			else
				decryptedName = decryptedName .. " "
			end
		end
		if string.find(decryptedName, "storage") then
			print (decryptedName)
		end
	end
end

io.input("input/input04.txt")
local allLines = {}
local nextLine = io.read("*line")
while nextLine ~= nil do
	allLines[#allLines + 1] = nextLine
	nextLine = io.read("*line")
end
print("Part 1: " .. part1(allLines))
part2(allLines)