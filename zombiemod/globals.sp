/**
 * =============================================================================
 * Zombie Mod for Day of Defeat Source
 *
 * By: Andersso
 *
 * SourceMod (C)2004-2008 AlliedModders LLC.  All rights reserved.
 * =============================================================================
 *
 * This program is free software; you can redistribute it and/or modify it under
 * the terms of the GNU General Public License, version 3.0, as published by the
 * Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
 * details.
 *
 * You should have received a copy of the GNU General Public License along with
 * this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * As a special exception, AlliedModders LLC gives you permission to link the
 * code of this program (as well as its derivative works) to "Half-Life 2," the
 * "Source Engine," the "SourcePawn JIT," and any Game MODs that run on software
 * by the Valve Corporation.  You must obey the GNU General Public License in
 * all respects for all other code used.  Additionally, AlliedModders LLC grants
 * this exception to all derivative works.  AlliedModders LLC defines further
 * exceptions, found in LICENSE.txt (as of this writing, version JULY-31-2007),
 * or <http://www.sourcemod.net/license.php>.
 */

new	bool:g_bModActive,
#if defined _steamtools_included
	bool:g_bUseSteamTools,
#endif
#if defined _SENDPROXYMANAGER_INC_
	bool:g_bUseSendProxy,
#endif
	bool:g_bRoundEnded,
	bool:g_bBlockChangeClass,
	g_iZombie,
	g_iLastHuman,
	g_iRoundWins,
	g_iBeamSprite,
	g_iHaloSprite,
	g_iRoundTimer,
	g_iBeaconTicks,
	g_iNumZombieSpawns,
	Handle:g_hRoundTimer,
	Float:g_vecZombieSpawnOrigin[MAX_SPAWNPOINTS][3];

enum ClientInfo
{
	ClientInfo_KillsAsHuman,         // Total number of kills as human
	ClientInfo_KillsAsZombie,        // Total number of kills as zombie

	bool:ClientInfo_GermanSkin,       // True if player should wear the axis player skin
	
	bool:ClientInfo_IsCritial,       // True if player is critical
	bool:ClientInfo_SniperCrit,      // True if player is critical from a sniper
	ClientInfo_Critter,              // The user-id of the player who scored the critical hit

	bool:ClientInfo_SelectedClass,   // True if player has selected a player-class

	ClientInfo_Pistol,               // Selected pistol
	ClientInfo_PrimaryWeapon,        // Selected primary weapon
	ClientInfo_EquipmentItem,        // Selected equipment item
	bool:ClientInfo_HasCustomClass,  // True if the player has created a custom class
	bool:ClientInfo_HasEquipped,     // True if the player has equipped once during the current round
	bool:ClientInfo_ShouldAutoEquip, // True if the player has chosen to auto-equip with the custom class

	Float:ClientInfo_DamageScale,    // The value that the damaged done to the player should be scaled down to
	Float:ClientInfo_Health,         // The amount of health relative to the damage scale

	bool:ClientInfo_WeaponCanUse     // If true the WeaponCanUse() hook will run
};

new	g_ClientInfo[DOD_MAXPLAYERS + 1][ClientInfo];