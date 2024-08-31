local function reverseStack(stack)
	local top = stack[1]
	local newStack = {top}
	for i = 2, top do
		newStack[i] = stack[top - i + 2]
	end
	return newStack
end

local function push(stack, newChar)
	local top = stack[1] + 1
	stack[1] = top
	stack[top] = newChar
end

local function pop(stack)
	local top = stack[1]
	local topChar = stack[top]
	stack[1] = top - 1
	return topChar
end

local function peek(stack)
	return stack[stack[1]]
end

local function part1(allLines)
	local stacks = {}
	for i = 1, 9 do
		stacks[i] = {1}
	end
	local commands = {}
	local isBuildingStacks = true
	for i = 1, #allLines do
		if #allLines[i] == 0 then
			isBuildingStacks = false
		elseif isBuildingStacks then
			for j = 1, 9 do
				local thisChar = string.sub(allLines[i], (j - 1) * 4 + 2, (j - 1) * 4 + 2)
				if string.match(thisChar, "^[A-Z]$") then
					push(stacks[j], thisChar)
				end
			end
		else
			local temp = {}
			for num in string.gmatch(allLines[i], "%d+") do
				table.insert(temp, tonumber(num))
			end
			commands[#commands + 1] = temp
		end
	end
	for i = 1, 9 do
		stacks[i] = reverseStack(stacks[i])
	end
	for _, thisCommand in ipairs(commands) do
		local moveCount = thisCommand[1]
		local fromStack = thisCommand[2]
		local toStack = thisCommand[3]
		for i = 1, moveCount do
			local thisChar = pop(stacks[fromStack])
			push(stacks[toStack], thisChar)
		end
	end
	local result = ""
	for i = 1, 9 do
		result = result .. peek(stacks[i])
	end
	return result
end

local function part2(allLines)
	local stacks = {}
	for i = 1, 9 do
		stacks[i] = {1}
	end
	local commands = {}
	local isBuildingStacks = true
	for i = 1, #allLines do
		if #allLines[i] == 0 then
			isBuildingStacks = false
		elseif isBuildingStacks then
			for j = 1, 9 do
				local thisChar = string.sub(allLines[i], (j - 1) * 4 + 2, (j - 1) * 4 + 2)
				if string.match(thisChar, "^[A-Z]$") then
					push(stacks[j], thisChar)
				end
			end
		else
			local temp = {}
			for num in string.gmatch(allLines[i], "%d+") do
				table.insert(temp, tonumber(num))
			end
			commands[#commands + 1] = temp
		end
	end
	for i = 1, 9 do
		stacks[i] = reverseStack(stacks[i])
	end
	for _, thisCommand in ipairs(commands) do
		local moveCount = thisCommand[1]
		local fromStack = thisCommand[2]
		local toStack = thisCommand[3]
		local temp = {1}
		for i = 1, moveCount do
			local thisChar = pop(stacks[fromStack])
			push(temp, thisChar)
		end
		for i = 1, moveCount do
			local thisChar = pop(temp)
			push(stacks[toStack], thisChar)
		end
	end
	local result = ""
	for i = 1, 9 do
		result = result .. peek(stacks[i])
	end
	return result
end

io.input("input/input05.txt")
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