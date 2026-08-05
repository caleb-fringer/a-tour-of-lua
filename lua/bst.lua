--[[
	Author: Caleb Fringer
	This library provides all of the basic operations for a Binary Search Tree.
	Written for Professor Ray Maleh's CS 311 class at CSU East Bay, Fall 2023
]]
local BST = {}

-- Constructor function
function BST:new(v)
	local o = { -- The object to be created
		root = { value = v }
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
			curr = curr.right
		else
			parent = curr
			curr = curr.left
		end
	end

	-- Attach the node as the parent's appropriate child
	if v > parent.value then
		parent.right = { value = v }
	else
		parent.left = { value = v }
	end
end

-- Remove a node from a tree, maintaining the BST property
function BST:remove(v)
	local parent = nil
	local toRemove = self.root

	-- Look for the value to remove
	while toRemove.value ~= v do
		parent = toRemove
		toRemove = v > toRemove.value and toRemove.right or toRemove.left -- This Lua-ism works as a ternary operator
	end

	-- If the value to remove has two children, we must replace it with its smallest right descendant
	if toRemove.left and toRemove.right then
		local rightChild = toRemove.right
		local curr = rightChild

		-- This will find the smallest right descendant
		while curr.left do
			curr = curr.left
		end

		toRemove.value = curr.value -- Replace deleted element with its smallest right descendant

		if curr == rightChild then -- In this case where the smallest right descendant was its right child, we need to set the right child of the replaced node to nil to prevent a circular reference
			toRemove.right = nil
		else                 -- Otherwise, delete the the smallest right descendant
			rightChild.left = nil
		end
	-- If the node to remove only had a left child, simply replace it with that child
	elseif toRemove.left then
		local leftChild = toRemove.left
		local newLeft, newRight = leftChild.left, leftChild.right
		toRemove.value = leftChild.value
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
		-- We can only remove it by referencing the parent.
		if parent.left == v then
			parent.left = nil
		else
			parent.right = nil
		end
	end
end

return BST