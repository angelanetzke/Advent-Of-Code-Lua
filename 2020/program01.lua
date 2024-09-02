local function part1(allLines)
	local numbers = {}
	for _, value in ipairs(allLines) do
		numbers[#numbers + 1] = tonumber(value)
	end
	for i = 1, #numbers - 1 do
		for j = i + 1, #numbers do
			if numbers[i] + numbers[j] == 2020 then
				return numbers[i] * numbers[j]
			end
		end
	end
	return 0
end

local function part2(allLines)
	local numbers = {}
	for _, value in ipairs(allLines) do
		numbers[#numbers + 1] = tonumber(value)
	end
	for i = 1, #numbers - 2 do
		for j = i + 1, #numbers - 1 do
			for k = j + 1, #numbers do
				if numbers[i] + numbers[j] + numbers[k] == 2020 then
					return numbers[i] * numbers[j] * numbers[k]
				end
			end
		end
	end
	return 0
end

io.input("input/input01.txt")
local allLines = {}
local nextLine = io.read("*line")
while nextLine ~= nil do
	allLines[#allLines + 1] = nextLine
	nextLine = io.read("*line")
end
print("Part 1: " .. part1(allLines))
print("Part 2: " .. part2(allLines))