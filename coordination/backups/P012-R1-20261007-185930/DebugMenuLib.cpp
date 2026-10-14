// Fill out your copyright notice in the Description page of Project Settings.

#include "DebugMenuLib.h"
#include "Engine/World.h"
#include "Engine/Engine.h"
#include "GameFramework/PlayerController.h"
#include "GameFramework/PlayerState.h"
#include "GameFramework/GameStateBase.h"
#include "Kismet/GameplayStatics.h"

bool UDebugMenuLib::IsDeveloperDebugAllowed()
{
#if UE_BUILD_SHIPPING
	return false;
#else
	return true;
#endif
}

FDeveloperDebugInfo UDebugMenuLib::GetDeveloperDebugInfo(const UObject* WorldContextObject)
{
	FDeveloperDebugInfo Info;

#if UE_BUILD_SHIPPING
	// In Shipping builds, completely deny data gathering
	Info.bIsAvailable = false;
	return Info;
#else
	Info.bIsAvailable = true;

#if UE_EDITOR
	Info.BuildConfiguration = TEXT("Editor");
#elif UE_BUILD_DEVELOPMENT
	Info.BuildConfiguration = TEXT("Development");
#elif UE_BUILD_DEBUG
	Info.BuildConfiguration = TEXT("Debug");
#else
	Info.BuildConfiguration = TEXT("Test");
#endif

	if (!WorldContextObject)
	{
		return Info;
	}

	UWorld* World = GEngine ? GEngine->GetWorldFromContextObject(WorldContextObject, EGetWorldErrorMode::ReturnNull) : nullptr;
	if (!World)
	{
		return Info;
	}

	// FPS & Frame time
	extern ENGINE_API float GAverageFPS;
	extern ENGINE_API float GAverageMS;
	Info.CurrentFPS = GAverageFPS;
	Info.FrameTimeMs = GAverageMS;

	// Current Map
	Info.CurrentMap = World->GetMapName();
	Info.CurrentMap.RemoveFromStart(World->StreamingLevelsPrefix);

	// Net Mode
	switch (World->GetNetMode())
	{
	case NM_Standalone:
		Info.NetMode = TEXT("Standalone");
		break;
	case NM_DedicatedServer:
		Info.NetMode = TEXT("Dedicated Server");
		break;
	case NM_ListenServer:
		Info.NetMode = TEXT("Listen Server");
		break;
	case NM_Client:
		Info.NetMode = TEXT("Client");
		break;
	default:
		Info.NetMode = TEXT("Unknown");
		break;
	}

	// Player Controller / Local Role
	APlayerController* PC = World->GetFirstPlayerController();
	if (PC)
	{
		switch (PC->GetLocalRole())
		{
		case ROLE_Authority:
			Info.LocalRole = TEXT("Authority");
			break;
		case ROLE_AutonomousProxy:
			Info.LocalRole = TEXT("Autonomous Proxy");
			break;
		case ROLE_SimulatedProxy:
			Info.LocalRole = TEXT("Simulated Proxy");
			break;
		default:
			Info.LocalRole = TEXT("None");
			break;
		}

		if (PC->PlayerState)
		{
			Info.PingMs = FMath::RoundToInt(PC->PlayerState->GetPingInMilliseconds());
		}
	}

	// Player Count from GameState
	if (World->GetGameState())
	{
		Info.PlayerCount = World->GetGameState()->PlayerArray.Num();
	}
	else
	{
		Info.PlayerCount = 1;
	}

	return Info;
#endif
}
