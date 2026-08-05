local Node = require("node")
local BST = {}

-- Constructor function
function BST:new(v)
	local o = { -- The object to be created
		root = Node:new(v)
	}

	self.__index = self   -- This allows constructed objects to inherit undefined members
	setmetatable(o, self) -- We have to set the metatable of the constructed object for inheritance to work
	return o
end

-- Kick off the inorder traversal
function BST:inorder()
	self:inorder_helper(self.root)
	io.write("\n")
end

-- Recursive helper for inorder traversal
function BST:inorder_helper(root)
	if not root then
		return
	else
		self:inorder_helper(root.left)
		io.write(root.value, " ")
		self:inorder_helper(root.right)
	end
end

-- Kick off the preorder traversal
function BST:preorder()
	self:preorder_helper(self.root)
	io.write("\n")
end

-- Recursive helper for preorder traversal
function BST:preorder_helper(root)
	if not root then
		return
	else
		io.write(root.value, " ")
		self:preorder_helper(root.left)
		self:preorder_helper(root.right)
	end
end

-- Kick off the postorder traversal
function BST:postorder()
	self:postorder_helper(self.root)
	io.write("\n")
end

-- Recursive helper for postorder traversal
function BST:postorder_helper(root)
	if not root then
		return
	else
		self:postorder_helper(root.left)
		self:postorder_helper(root.right)
		io.write(root.value, " ")
	end
end

-- Add a node to the tree
function BST:add(v)
	local curr = self.root
	local parent
	-- Look for the spot to insert the node
	while curr do
		if v > curr.value then
			parent = curr
			curr = curr.getRightChild()
		else
			parent = curr
			curr = curr.getLeftChild()
		end
	end

	-- Attach the node as the parent's appropriate child
	if v > parent.value then
		parent.setRightChild(v)
	else
		parent.setLeftChild(v)
	end
end

-- Remove a node from a tree, maintaining the BST property
function BST:remove(v)
	local toRemove = self.root

	-- Look for the value to remove
	while toRemove.getValue() ~= v do
		toRemove = v > toRemove.getValue() and toRemove.getRightChild() or toRemove.getLeftChild() -- This Lua-ism works as a ternary operator
	end

	-- If the value to remove has two children, we must replace it with its smallest right descendant
	if toRemove.getLeftChild() and toRemove.getRightChild() then
		local rightChild = toRemove.getRightChild()
		local curr = rightChild

		-- This will find the smallest right descendant
		while curr.getLeftChild() do
			curr = curr.getLeftChild()
		end

		toRemove.setValue(curr.getValue()) -- Replace deleted element with its smallest right descendant

		if curr == rightChild then -- In this case where the smallest right descendant was its right child, we need to set the right child of the replaced node to nil to prevent a circular reference
			toRemove.setRightChild(nil)
		else                 -- Otherwise, delete the the smallest right descendant
			rightChild.setLeftChild(nil)
		end
	-- If the node to remove only had a left child, simply replace it with that child
	elseif toRemove.getLeftChild() then
		local leftChild = toRemove.getLeftChild()
		local newLeft, newRight = leftChild.getLeftChild(), leftChild.getRightChild()
		toRemove.setValue(leftChild.getValue())
		toRemove.left = newLeft
		toRemove.right = newRight
	-- If the node to remove only had a right child, simply replace it with that child
	elseif toRemove.right then
		local rightChild = toRemove.right
		local newLeft, newRight = rightChild.left, rightChild.right
		toRemove.value = rightChild.value
		toRemove.left = newLeft
		toRemove.right = newRight
	-- The node to remove was a leaf node
	else 
		toRemove.value = nil
		toRemove.left = nil
		toRemove.right = nil
		toRemove = nil
	end
end


local myTree = BST:new(9)
local toAdd = { 5, 11, 2, 7, 10, 12, 1, 3, 6, 8 }
for _, v in ipairs(toAdd) do
	myTree:add(v)
end

print("Removing 3")
myTree:remove(3)
myTree:inorder()