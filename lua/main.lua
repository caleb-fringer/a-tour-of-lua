--[[
    Author: Caleb Fringer
    This file provides the driver program for testing the BST module.
    Please make sure bst.lua is available in the same directory as this file.
    Written for Professor Ray Maleh's CS 311 class at CSU East Bay, Fall 2023
]]
local BST = require("bst") -- This is how Lua implements modules

local myTree = BST:new(9)
local toAdd = { 5, 11, 2, 7, 10, 12, 1, 3, 6, 8 }
for _, v in ipairs(toAdd) do
	myTree:add(v)
end

print("Removing 11")
myTree:remove(11)
print("Inorder traversal:")
myTree:inorder()
print("Preorder traversal:")
myTree:preorder()
print("Postorder traversal:")
myTree:postorder()


print("Removing 5")
myTree:remove(5)
print("Inorder traversal:")
myTree:inorder()
print("Preorder traversal:")
myTree:preorder()
print("Postorder traversal:")
myTree:postorder()


print("Removing 3")
myTree:remove(3)
print("Inorder traversal:")
myTree:inorder()