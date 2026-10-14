// Fill out your copyright notice in the Description page of Project Settings.

#pragma once

#include "CoreMinimal.h"
#include "Kismet/BlueprintFunctionLibrary.h"
#include "DebugMenuLib.generated.h"

USTRUCT(BlueprintType)
struct FDeveloperDebugInfo
{
	GENERATED_BODY()

	UPROPERTY(BlueprintReadOnly, Category = "Debug")
	bool bIsAvailable = false;

	UPROPERTY(BlueprintReadOnly, Category = "Debug")
	float CurrentFPS = 0.0f;

	UPROPERTY(BlueprintReadOnly, Category = "Debug")
	float FrameTimeMs = 0.0f;

	UPROPERTY(BlueprintReadOnly, Category = "Debug")
	FString CurrentMap = TEXT("Unavailable");

	UPROPERTY(BlueprintReadOnly, Category = "Debug")
	FString NetMode = TEXT("Unavailable");

	UPROPERTY(BlueprintReadOnly, Category = "Debug")
	FString LocalRole = TEXT("Unavailable");

	UPROPERTY(BlueprintReadOnly, Category = "Debug")
	int32 PlayerCount = 0;

	UPROPERTY(BlueprintReadOnly, Category = "Debug")
	int32 PingMs = 0;

	UPROPERTY(BlueprintReadOnly, Category = "Debug")
	FString BuildConfiguration = TEXT("Unavailable");
};

/**
 * Developer Debug Blueprint Function Library with compile-time Shipping guard
 */
UCLASS()
class SHEESHHPROPHUNTYT_API UDebugMenuLib : public UBlueprintFunctionLibrary
{
	GENERATED_BODY()

public:
	/** Returns true only in non-shipping builds (Editor, Development, Debug) */
	UFUNCTION(BlueprintPure, Category = "Developer Debug")
	static bool IsDeveloperDebugAllowed();

	/** Gathers non-invasive diagnostics in non-shipping builds */
	UFUNCTION(BlueprintCallable, Category = "Developer Debug", meta = (WorldContext = "WorldContextObject"))
	static FDeveloperDebugInfo GetDeveloperDebugInfo(const UObject* WorldContextObject);
};
