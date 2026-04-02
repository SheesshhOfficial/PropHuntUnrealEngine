# 🎮 Prop Hunt Multiplayer Game (Unreal Engine 5)

A fully functional **multiplayer Prop Hunt game** built using **Unreal Engine 5 Blueprints**, featuring real-time gameplay, prop transformation, shooting mechanics, session system, and UI.

---

## 🌟 Overview

This project is a **hide-and-seek multiplayer game** where:

- 🪑 **Props (Hiders)** disguise themselves as objects in the environment
- 🔫 **Hunters (Seekers)** must find and eliminate them
- ⏱️ The game runs on a timed round system
- 🌐 Supports multiplayer sessions (create, find, join)

---

## 🎥 Gameplay Features

### 🧍 Player Roles

- **Prop Player**
  - Can transform into environmental objects
  - Limited number of prop changes
  - Can taunt enemies

- **Hunter Player**
  - Uses weapon to detect and eliminate props
  - Shooting system with line tracing

---

## ⚙️ Core Systems Implemented

### 🔁 Multiplayer System

- Session creation & discovery
- Join via server list or IP
- Replicated gameplay logic
- Server-authoritative actions

> Example: Prop switching is executed via server RPC

---

### 🔫 Shooting System

- Automatic fire using timers
- Line trace-based hit detection
- Camera-based aiming
- Server-side validation

---

### 🪑 Prop Transformation System

- Change into different meshes dynamically
- Controlled via input action (`IA_ChangeProp`)
- Server-controlled to maintain sync

---

### 🧠 Game Mode Logic

- Tracks:
  - Players
  - Hunters / Props
  - Alive prop count

- Determines win conditions

> Example: Game end logic updates `Prop Won?` state

---

### 🎮 Input System (Enhanced Input)

- Uses Unreal's **Enhanced Input System**
- Mapping context added at runtime

>

---

## 🖥️ UI System

### 🧩 Main HUD

- Health bar
- Timer
- Crosshair
- Role display (Prop / Hunter)

> HUD updates dynamically based on role

---

### 📋 Multiplayer Menu

- Create Session
- Find Sessions
- Join via IP
- Server list display (scrollable)

>

---

### ⚙️ Settings Menu

- Graphics settings (quality, shadows, anti-aliasing, etc.)
- Player name input
- Map selection
- Hunter count selection

---

## 🧱 Project Structure

```
/Core
 ├── Blueprints
 │   ├── BP_propChar
 │   ├── BP_ThirdPersonCharacter
 │   ├── BP_ThirdPersonPlayerController
 │   ├── GM_ProphuntGameMode
 │
 ├── Widgets
 │   ├── UW_MainHUD
 │   ├── WBP_Menu
 │   ├── WBP_MainMenu
```

---

## 🧩 Key Blueprint Systems

### 📌 BP_propChar

- Handles:
  - Prop switching
  - Damage logic
  - Rotation lock
  - Taunt system

---

### 📌 GameMode (GM_ProphuntGameMode)

- Match start/end logic
- Player tracking
- Win condition evaluation

---

### 📌 Player Controller

- UI initialization
- Input mapping setup
- Game state handling

---

## 🚀 How to Run

1. Open project in **Unreal Engine 5**
2. Set default map
3. Play in:
   - **Standalone** (single player testing)
   - **Listen Server + Clients** (multiplayer testing)

---

## 🌐 Multiplayer Setup

- Create session from menu
- Other players:
  - Find sessions
  - Or join using IP

---

## 🛠️ Technologies Used

- Unreal Engine 5
- Blueprint Visual Scripting
- Enhanced Input System
- Multiplayer Replication (RPC, Server/Client)

---

## ⚠️ Known Issues

- Some RPC events may require replication fixes
- Optimization needed for high-frequency server calls
- UI polish improvements pending

---

## 📸 Screenshots

### 🎮 Gameplay Blueprint

- Complex event graph handling prop logic & damage

### 🧠 Game Mode Logic

- Handles full match lifecycle

### 🖥️ UI System

- Custom main HUD and multiplayer menu

---

## 💡 Future Improvements

- Voice chat integration
- Better matchmaking system
- Animation improvements
- Anti-cheat validation for client input

---

## 🙌 Author

**@sheeshh**

---

## ⭐ If you like this project

Give it a star ⭐ on GitHub!

---

## 📜 License

This project is for educational and portfolio use.
