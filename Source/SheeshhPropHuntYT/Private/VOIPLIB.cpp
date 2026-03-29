// Fill out your copyright notice in the Description page of Project Settings.


#include "VOIPLIB.h"
//extra added below
#include "Engine/Engine.h"
#include "Engine/World.h"

#include "OnlineSubsystem.h"
#include "OnlineSubsystemUtils.h"
#include "Interfaces/VoiceInterface.h"

void UVOIPLIB::ClearVoicePackets(UObject* WorldContextObject)
{
    if (!WorldContextObject)
    {
        return;
    }

    UWorld* World = GEngine->GetWorldFromContextObject(
        WorldContextObject,
        EGetWorldErrorMode::LogAndReturnNull
    );

    if (!World)
    {
        return;
    }

    IOnlineSubsystem* Subsystem = Online::GetSubsystem(World);
    if (!Subsystem)
    {
        return;
    }

    IOnlineVoicePtr VoiceInterface = Subsystem->GetVoiceInterface();
    if (!VoiceInterface.IsValid())
    {
        return;
    }

    VoiceInterface->ClearVoicePackets();
}
