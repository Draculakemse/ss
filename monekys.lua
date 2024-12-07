-- ARCEUS, CODEX ETC
script_key="HMahVSgbjuqyRmBuwHSLLHbDaKXxGUVU";
getgenv().Config = {
    ["Winter_EVENT"] = true,
    ["PetFarmActive"] = false,
    ["EggFarmActive"] = false,
    ["Blur_username"] = true,
    ["Blazing_Lion_Log"] = false,
    ["DiscordId"] = "123456",
    ["Webhook"] = "https://discord.com/api/webhooks/123456",
}
loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/66567bfd337b57eb059b58dbe1badb89.lua"))()

task.spawn(function()
    getgenv().Config = {
        ["inventory"] = "pets", -- Adapt to stickers, gifts, toys, pet_accessories, transport
        ["username"] = "WINTERMEM1",
        ["pets_to_trade"] = {"winterfest_2024_bauble_buddies"} -- or lures_2023_blazing_lion cant auto trade gifts with pet ONLY 1
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
