// Fill out your copyright notice in the Description page of Project Settings.

using UnrealBuildTool;

public class SheeshhPropHuntYT : ModuleRules
{
    public SheeshhPropHuntYT(ReadOnlyTargetRules Target) : base(Target)
    {
        PCHUsage = PCHUsageMode.UseExplicitOrSharedPCHs;

        // =========================
        // PUBLIC DEPENDENCIES
        // =========================
        PublicDependencyModuleNames.AddRange(new string[]
        {
            "Core",
            "CoreUObject",
            "Engine",
            "InputCore"
        });

        // =========================
        // PRIVATE DEPENDENCIES
        // =========================
        PrivateDependencyModuleNames.AddRange(new string[]
        {
            "OnlineSubsystem",
            "OnlineSubsystemUtils",
            "Voice"
        });

        // =========================
        // STEAM (DO NOT put in Public)
        // =========================
        DynamicallyLoadedModuleNames.Add("OnlineSubsystemSteam");
    }
}
