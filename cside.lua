RegisterNetEvent("Essa:CrashMe", function() -- This Can Be Exploited, So Change The Trigger's Name And Obfuscate The File
    repeat
        Citizen.Trace("\nEssaPrimeWasHere\n")  -- Pressures Client Which Forces A Crash
    until false
end)