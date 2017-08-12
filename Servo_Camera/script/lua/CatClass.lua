CatClass = Appkit.class(CatClass)

function CatClass:init()
    print("CatClass Init")
end

function CatClass:Meow(aSound)
    print("Cat: ", aSound)
end

function CatClass:Mathy(aFirstValue, aSecondValue)
   print("Cat counts " .. aFirstValue .. " + " .. aSecondValue .. " = " .. (aFirstValue + aSecondValue)) 
end