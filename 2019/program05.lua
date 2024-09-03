local IntComputer = {}

function IntComputer:new(o, initialValues)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	o.ip = 0
	o.memory = {}
	o.inputQueue = {}
	o.inputHead = 1
	o.inputTail = 1
	o.output = {}
	local i = 0
	for x in string.gmatch(initialValues, "[-]*%d+") do
		o.memory[i] = tonumber(x)
		i = i + 1
	end
	return o
end

-- internal functions

function IntComputer:add()
	local instructionString = string.format("%05d", self.memory[self.ip])
	local param1 = 0
	local param2 = 0
	if string.sub(instructionString, -3, -3) == "0" then
		param1 = self.memory[self.memory[self.ip + 1]]
	else
		param1 = self.memory[self.ip + 1]
	end
	if string.sub(instructionString, -4, -4) == "0" then
		param2 = self.memory[self.memory[self.ip + 2]]
	else
		param2 = self.memory[self.ip + 2]
	end
	local writeLocation = self.memory[self.ip + 3]
	self.memory[writeLocation] = param1 + param2
	self.ip = self.ip + 4
end

function IntComputer:multiply()
	local instructionString = string.format("%05d", self.memory[self.ip])
	local param1 = 0
	local param2 = 0
	if string.sub(instructionString, -3, -3) == "0" then
		param1 = self.memory[self.memory[self.ip + 1]]
	else
		param1 = self.memory[self.ip + 1]
	end
	if string.sub(instructionString, -4, -4) == "0" then
		param2 = self.memory[self.memory[self.ip + 2]]
	else
		param2 = self.memory[self.ip + 2]
	end
	local writeLocation = self.memory[self.ip + 3]
	self.memory[writeLocation] = param1 * param2
	self.ip = self.ip + 4
end

function IntComputer:getInput()
	local inputValue = self.inputQueue[self.inputHead]
	self.inputHead = self.inputHead + 1
	local writeLocation = self.memory[self.ip + 1]
	self.memory[writeLocation] = inputValue
	self.ip = self.ip + 2
end

function IntComputer:setOutput()
	local instructionString = string.format("%05d", self.memory[self.ip])
	local param1 = 0
	if string.sub(instructionString, -3, -3) == "0" then
		param1 = self.memory[self.memory[self.ip + 1]]
	else
		param1 = self.memory[self.ip + 1]
	end
	self.output[#self.output + 1] = param1
	self.ip = self.ip + 2
end

function IntComputer:jumpIfTrue()
	local instructionString = string.format("%05d", self.memory[self.ip])
	local param1 = 0
	local param2 = 0
	if string.sub(instructionString, -3, -3) == "0" then
		param1 = self.memory[self.memory[self.ip + 1]]
	else
		param1 = self.memory[self.ip + 1]
	end
	if string.sub(instructionString, -4, -4) == "0" then
		param2 = self.memory[self.memory[self.ip + 2]]
	else
		param2 = self.memory[self.ip + 2]
	end
	if param1 ~= 0 then
		self.ip = param2
	else
		self.ip = self.ip + 3
	end
end

function IntComputer:jumpIfFalse()
	local instructionString = string.format("%05d", self.memory[self.ip])
	local param1 = 0
	local param2 = 0
	if string.sub(instructionString, -3, -3) == "0" then
		param1 = self.memory[self.memory[self.ip + 1]]
	else
		param1 = self.memory[self.ip + 1]
	end
	if string.sub(instructionString, -4, -4) == "0" then
		param2 = self.memory[self.memory[self.ip + 2]]
	else
		param2 = self.memory[self.ip + 2]
	end
	if param1 == 0 then
		self.ip = param2
	else
		self.ip = self.ip + 3
	end
end

function IntComputer:lessThan()
	local instructionString = string.format("%05d", self.memory[self.ip])
	local param1 = 0
	local param2 = 0
	if string.sub(instructionString, -3, -3) == "0" then
		param1 = self.memory[self.memory[self.ip + 1]]
	else
		param1 = self.memory[self.ip + 1]
	end
	if string.sub(instructionString, -4, -4) == "0" then
		param2 = self.memory[self.memory[self.ip + 2]]
	else
		param2 = self.memory[self.ip + 2]
	end
	local writeLocation = self.memory[self.ip + 3]
	if param1 < param2 then
		self.memory[writeLocation] = 1
	else
		self.memory[writeLocation] = 0
	end
	self.ip = self.ip + 4
end

function IntComputer:equals()
	local instructionString = string.format("%05d", self.memory[self.ip])
	local param1 = 0
	local param2 = 0
	if string.sub(instructionString, -3, -3) == "0" then
		param1 = self.memory[self.memory[self.ip + 1]]
	else
		param1 = self.memory[self.ip + 1]
	end
	if string.sub(instructionString, -4, -4) == "0" then
		param2 = self.memory[self.memory[self.ip + 2]]
	else
		param2 = self.memory[self.ip + 2]
	end
	local writeLocation = self.memory[self.ip + 3]
	if param1 == param2 then
		self.memory[writeLocation] = 1
	else
		self.memory[writeLocation] = 0
	end
	self.ip = self.ip + 4
end

-- user interface functions

function IntComputer:setValue(index, value)
	self.memory[index] = value
end

function IntComputer:getValue(index)
	return self.memory[index]
end

function IntComputer:queueInput(value)
	self.inputQueue[self.inputTail] = value
	self.inputTail = self.inputTail + 1
end

function IntComputer:getOutput()
	return self.output
end

-- main function

function IntComputer:execute()
	while (self.memory[self.ip] ~= 99) do
		if self.memory[self.ip] % 100 == 1 then
			self:add()
		elseif self.memory[self.ip] % 100 == 2 then
			self:multiply()
		elseif self.memory[self.ip] % 100 == 3 then
			self:getInput()
		elseif self.memory[self.ip] % 100 == 4 then
			self:setOutput()
		elseif self.memory[self.ip] % 100 == 5 then
			self:jumpIfTrue()
		elseif self.memory[self.ip] % 100 == 6 then
			self:jumpIfFalse()
		elseif self.memory[self.ip] % 100 == 7 then
			self:lessThan()
		elseif self.memory[self.ip] % 100 == 8 then
			self:equals()
		end
	end
end

local function part1(allLines)
	local computer = IntComputer:new(nil, allLines[1])
	computer:queueInput(1)
	computer:execute()
	local output = computer:getOutput()
	return output[#output] or -1
end

local function part2(allLines)
	local computer = IntComputer:new(nil, allLines[1])
	computer:queueInput(5)
	computer:execute()
	local output = computer:getOutput()
	return output[#output] or -1
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