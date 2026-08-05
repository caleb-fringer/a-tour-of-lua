function foo() 
    --return -- causes a syntax error, expects an end immediately following return
    print("bar")

    do return end
    print("baz")
end

foo()
