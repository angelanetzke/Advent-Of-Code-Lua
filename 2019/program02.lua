IntComputer = {}

function IntComputer:new(o, initialValues)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	o.ip = 0
	o.memory = {}
	local i = 0
	for x in string.gmatch(initialValues, "%d+") do
		o.memory[i] = tonumber(x)
		i = i + 1
	end
	return o
end

function IntComputer:add()
	local input1Location = self.memory[self.ip + 1]
	local input2Location = self.memory[self.ip + 2]
	local outputLocation = self.memory[self.ip + 3]
	self.memory[outputLocation] = self.memory[input1Location] + self.memory[input2Location]
end

function IntComputer:multiply()
	local input1Location = self.memory[self.ip + 1]
	local input2Location = self.memory[self.ip + 2]
	local outputLocation = self.memory[self.ip + 3]
	self.memory[outputLocation] = self.memory[input1Location] * self.memory[input2Location]
end

function IntComputer:setValue(index, value)
	self.memory[index] = value
end

function IntComputer:getValue(index)
	return self.memory[index]
end

function IntComputer:execute()
	while (self.memory[self.ip] ~= 99) do
		if self.memory[self.ip] == 1 then
			self:add()
			self.ip = self.ip + 4
		elseif self.memory[self.ip] == 2 then
			self:multiply()
			self.ip = self.ip + 4
		end
	end
end

local function part1(allLines)
	local computer = IntComputer:new(nil, allLines[1])
	computer:setValue(1, 12)
	computer:setValue(2, 2)
	computer:execute()
	return computer:getValue(0)
end

local function part2(allLines)
	for i = 0, 99 do
		for j = 0, 99 do
			local computer = IntComputer:new(nil, allLines[1])
			computer:setValue(1, i)
			computer:setValue(2, j)
			computer:execute()
			if computer:getValue(0) == 19690720 then
				return 100 * i + j
			end
		end
	end
	return -1
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