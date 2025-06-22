local Node = {}
function Node:create(val, next)
    return { 
        val = val, 
        next = next 
    }
end

Queue = {}

function Queue:create()
    local object = {}
  
    object.first = nil
    object.last = nil

    self.__index = self
    self.__type = "queue"
    self.__tostring = self.show
    self.__len = self.length
    self.__iter = self.iterator

    return setmetatable(object, self)
end

function Queue:length()
    local length = 0
    local it = self.first
	while it ~= nil do
		it = it.next
        length = length + 1
	end
    return length
end

function Queue:isempty()
    return self.last == nil
end

function Queue:iterator()
    return function()
        return self:pop()
    end, nil
end

function Queue:push(item)
    local node = Node:create(item)
    if self.last == nil then
        self.first = node
    else 
        self.last.next = node
    end
    self.last = node
    return self
end

function Queue:pop()
    if self:isempty() then 
        return nil
    end
    local ret = self.first
	self.first = ret.next
    if self.first == nil then
        self.last = nil
    end
	return ret.val
end

function Queue:peek()
    if self:isempty() == true then 
        return nil
    end
    return self.first.val
end

function Queue:totable()
    local nodes = {}
	local it = self.first
	while it ~= nil do
		table.insert(nodes, it.val)
		it = it.next
	end
    return nodes
end

function Queue:show(divisions)
    divisions = divisions or ','

	local nodes = self:totable()
	for i, node in ipairs(nodes) do
		nodes[i] = tostring(node)
	end
	return table.concat(nodes, divisions)
end