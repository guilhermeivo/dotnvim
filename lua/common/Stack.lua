local Node = {}
function Node:create(val, next)
    return { 
        val = val, 
        next = next 
    }
end

Stack = {}

function Stack:create()
    local object = {}
  
    object.first = nil
    object.last = nil
    object.size = 0

    self.__index = self
    self.__type = "stack"
    self.__tostring = self.show
    self.__len = self.size
    self.__iter = self.iterator

    return setmetatable(object, self)
end

function Stack:length()
    return self.size
end

function Stack:isempty()
    return self.first == nil
end

function Stack:iterator()
    return function()
        return self:pop()
    end, nil
end

function Stack:push(item)
    local node = Node:create(item)
    if self.first ~= nil then
        node.next = self.first
    end
    self.first = node
    self.size = self.size + 1
    return self
end

function Stack:pop()
    if self:isempty() then 
        return nil
    end
    local ret = self.first
	self.first = ret.next
    self.size = self.size - 1
	return ret.val
end

function Stack:peek()
    if self:isempty() then 
        return nil
    end
    return self.first.val
end

function Stack:totable()
    local nodes = {}
	local it = self.first
    local len = self:length()
    local k = 1
	while it ~= nil do
		nodes[len + 1 - k] = it.val
        k = k + 1
		it = it.next
	end
    return nodes
end

function Stack:show(divisions)
    divisions = divisions or ','

	local nodes = self:totable()
	return table.concat(nodes, divisions)
end

return Stack