/*
 * Copyright (C) 2008 - 2010 Trinity <http://www.trinitycore.org/>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 */

#ifndef _LFGMGR_H
#define _LFGMGR_H

#include "Common.h"
#include <ace/Singleton.h>
#include "LFG.h"

class Group;
class Player;

enum LFGenum
{
    LFG_TIME_ROLECHECK         = 2*MINUTE,
    LFG_TIME_BOOT              = 2*MINUTE,
    LFG_TIME_PROPOSAL          = 2*MINUTE,
    LFG_TIME_JOIN_WARNING      = 1*IN_MILLISECONDS,
    LFG_TANKS_NEEDED           = 1,
    LFG_HEALERS_NEEDED         = 1,
    LFG_DPS_NEEDED             = 3,
    LFG_QUEUEUPDATE_INTERVAL   = 15*IN_MILLISECONDS,
    LFG_SPELL_DUNGEON_COOLDOWN = 71328,
    LFG_SPELL_DUNGEON_DESERTER = 71041,
    LFG_SPELL_LUCK_OF_THE_DRAW = 72221,
};

enum LfgType
{
    LFG_TYPE_DUNGEON = 1,
    LFG_TYPE_RAID    = 2,
    LFG_TYPE_QUEST   = 3,
    LFG_TYPE_ZONE    = 4,
    LFG_TYPE_HEROIC  = 5,
    LFG_TYPE_RANDOM  = 6,
};

enum LfgProposalState
{
    LFG_PROPOSAL_INITIATING = 0,
    LFG_PROPOSAL_FAILED     = 1,
    LFG_PROPOSAL_SUCCESS    = 2,
};

enum LfgLockStatusType
{
    LFG_LOCKSTATUS_OK                        = 0,           // Internal use only
    LFG_LOCKSTATUS_INSUFFICIENT_EXPANSION    = 1,
    LFG_LOCKSTATUS_TOO_LOW_LEVEL             = 2,
    LFG_LOCKSTATUS_TOO_HIGH_LEVEL            = 3,
    LFG_LOCKSTATUS_TOO_LOW_GEAR_SCORE        = 4,
    LFG_LOCKSTATUS_TOO_HIGH_GEAR_SCORE       = 5,
    LFG_LOCKSTATUS_RAID_LOCKED               = 6,
    LFG_LOCKSTATUS_ATTUNEMENT_TOO_LOW_LEVEL  = 1001,
    LFG_LOCKSTATUS_ATTUNEMENT_TOO_HIGH_LEVEL = 1002,
    LFG_LOCKSTATUS_QUEST_NOT_COMPLETED       = 1022,
    LFG_LOCKSTATUS_MISSING_ITEM              = 1025,
    LFG_LOCKSTATUS_NOT_IN_SEASON             = 1031,
};

enum LfgTeleportError
{
    //LFG_TELEPORTERROR_UNK1           = 0,                 // No reaction
    LFG_TELEPORTERROR_PLAYER_DEAD      = 1,
    LFG_TELEPORTERROR_FALLING          = 2,
    //LFG_TELEPORTERROR_UNK2           = 3,                 // You can't do that right now
    LFG_TELEPORTERROR_FATIGUE          = 4,
    //LFG_TELEPORTERROR_UNK3           = 5,                 // No reaction
    LFG_TELEPORTERROR_INVALID_LOCATION = 6,
    //LFG_TELEPORTERROR_UNK4           = 7,                 // You can't do that right now
    //LFG_TELEPORTERROR_UNK5           = 8,                 // You can't do that right now
};

enum LfgJoinResult
{
    LFG_JOIN_OK                    = 0,                     // Joined (no client msg)
    LFG_JOIN_FAILED                = 1,                     // RoleCheck Failed
    LFG_JOIN_GROUPFULL             = 2,                     // Your group is full
    //LFG_JOIN_UNK3                = 3,                     // No client reaction
    LFG_JOIN_INTERNAL_ERROR        = 4,                     // Internal LFG Error
    LFG_JOIN_NOT_MEET_REQS         = 5,                     // You do not meet the requirements for the chosen dungeons
    LFG_JOIN_PARTY_NOT_MEET_REQS   = 6,                     // One or more party members do not meet the requirements for the chosen dungeons
    LFG_JOIN_MIXED_RAID_DUNGEON    = 7,                     // You cannot mix dungeons, raids, and random when picking dungeons
    LFG_JOIN_MULTI_REALM           = 8,                     // The dungeon you chose does not support players from multiple realms
    LFG_JOIN_DISCONNECTED          = 9,                     // One or more party members are pending invites or disconnected
    LFG_JOIN_PARTY_INFO_FAILED     = 10,                    // Could not retrieve information about some party members
    LFG_JOIN_DUNGEON_INVALID       = 11,                    // One or more dungeons was not valid
    LFG_JOIN_DESERTER              = 12,                    // You can not queue for dungeons until your deserter debuff wears off
    LFG_JOIN_PARTY_DESERTER        = 13,                    // One or more party members has a deserter debuff
    LFG_JOIN_RANDOM_COOLDOWN       = 14,                    // You can not queue for random dungeons while on random dungeon cooldown
    LFG_JOIN_PARTY_RANDOM_COOLDOWN = 15,                    // One or more party members are on random dungeon cooldown
    LFG_JOIN_TOO_MUCH_MEMBERS      = 16,                    // You can not enter dungeons with more that 5 party members
    LFG_JOIN_USING_BG_SYSTEM       = 17,                    // You can not use the dungeon system while in BG or arenas
    //LFG_JOIN_FAILED2             = 18,                    // RoleCheck Failed
};

enum LfgRoleCheckResult
{
    LFG_ROLECHECK_FINISHED     = 1,                         // Role check finished
    LFG_ROLECHECK_INITIALITING = 2,                         // Role check begins
    LFG_ROLECHECK_MISSING_ROLE = 3,                         // Someone didn't selected a role after 2 mins
    LFG_ROLECHECK_WRONG_ROLES  = 4,                         // Can't form a group with that role selection
    LFG_ROLECHECK_ABORTED      = 5,                         // Someone leave the group
    LFG_ROLECHECK_NO_ROLE      = 6,                         // Someone selected no role
};

enum LfgAnswer
{
    LFG_ANSWER_PENDING = -1,
    LFG_ANSWER_DENY    = 0,
    LFG_ANSWER_AGREE   = 1,
};

// Dungeon and reason why player can't join
struct LfgLockStatus
{
    uint32 dungeon;
    LfgLockStatusType lockstatus;
};

// Reward info
struct LfgReward
{
    uint32 maxLevel;
    struct
    {
        uint32 questId;
        uint32 variableMoney;
        uint32 variableXP;
    } reward[2];

    LfgReward(uint32 _maxLevel, uint32 firstQuest, uint32 firstVarMoney, uint32 firstVarXp, uint32 otherQuest, uint32 otherVarMoney, uint32 otherVarXp)
        : maxLevel(_maxLevel)
    {
        reward[0].questId = firstQuest;
        reward[0].variableMoney = firstVarMoney;
        reward[0].variableXP = firstVarXp;
        reward[1].questId = otherQuest;
        reward[1].variableMoney = otherVarMoney;
        reward[1].variableXP = otherVarXp;
    }
};

typedef std::map<uint32, uint8> LfgRolesMap;
typedef std::map<uint32, LfgAnswer> LfgAnswerMap;
typedef std::list<uint64> LfgGuidList;
typedef std::map<uint64, LfgDungeonSet*> LfgDungeonMap;

// Stores player or group queue info
struct LfgQueueInfo
{
    LfgQueueInfo(): tanks(LFG_TANKS_NEEDED), healers(LFG_HEALERS_NEEDED), dps(LFG_DPS_NEEDED) {};
    time_t joinTime;                                        // Player queue join time (to calculate wait times)
    uint8 tanks;                                            // Tanks needed
    uint8 healers;                                          // Healers needed
    uint8 dps;                                              // Dps needed
    LfgDungeonSet dungeons;                                 // Selected Player/Group Dungeon/s
    LfgRolesMap roles;                                      // Selected Player Role/s
};

struct LfgProposalPlayer
{
    LfgProposalPlayer(): role(0), accept(LFG_ANSWER_PENDING), groupLowGuid(0) {};
    uint8 role;                                             // Proposed role
    LfgAnswer accept;                                       // Accept status (-1 not answer | 0 Not agree | 1 agree)
    uint32 groupLowGuid;                                    // Original group guid (Low guid) 0 if no original group
};

typedef std::map<uint32, LfgProposalPlayer*> LfgProposalPlayerMap;

// Stores all Dungeon Proposal after matching candidates
struct LfgProposal
{
    LfgProposal(uint32 dungeon): dungeonId(dungeon), state(LFG_PROPOSAL_INITIATING), groupLowGuid(0), leaderLowGuid(0) {}

    ~LfgProposal()
    {
        for (LfgProposalPlayerMap::iterator it = players.begin(); it != players.end(); ++it)
            delete it->second;
        players.clear();
        queues.clear();
    };
    uint32 dungeonId;                                       // Dungeon to join
    LfgProposalState state;                                 // State of the proposal
    uint32 groupLowGuid;                                    // Proposal group (0 if new)
    uint32 leaderLowGuid;                                   // Leader guid.
    time_t cancelTime;                                      // Time when we will cancel this proposal
    LfgGuidList queues;                                     // Queue Ids to remove/readd
    LfgProposalPlayerMap players;                           // Player current groupId

};

// Stores all rolecheck info of a group that wants to join LFG
struct LfgRoleCheck
{
    time_t cancelTime;
    LfgRolesMap roles;
    LfgRoleCheckResult result;
    LfgDungeonSet dungeons;
    uint32 leader;
};

// Stores information of a current vote to kick someone from a group
struct LfgPlayerBoot
{
    time_t cancelTime;                                      // Time left to vote
    bool inProgress;                                        // Vote in progress
    LfgAnswerMap votes;                                     // Player votes (-1 not answer | 0 Not agree | 1 agree)
    uint32 victimLowGuid;                                   // Player guid to be kicked (can't vote)
    uint8 votedNeeded;                                      // Votes needed to kick the player
    std::string reason;                                     // kick reason
};

typedef std::set<Player*> PlayerSet;
typedef std::set<LfgLockStatus*> LfgLockStatusSet;
typedef std::vector<LfgProposal*> LfgProposalList;
typedef std::map<uint32, LfgLockStatusSet*> LfgLockStatusMap;
typedef std::map<uint64, LfgQueueInfo*> LfgQueueInfoMap;
typedef std::map<uint32, LfgRoleCheck*> LfgRoleCheckMap;
typedef std::map<uint32, LfgProposal*> LfgProposalMap;
typedef std::map<uint32, LfgPlayerBoot*> LfgPlayerBootMap;
typedef std::multimap<uint32, LfgReward const*> LfgRewardMap;
typedef std::pair<LfgRewardMap::const_iterator, LfgRewardMap::const_iterator> LfgRewardMapBounds;
typedef std::list<Player*> LfgPlayerList;
typedef std::set<uint64> LfgGuidSet;
typedef std::map<std::string, LfgAnswer> LfgCompatibleMap;


class LFGMgr
{
    friend class ACE_Singleton<LFGMgr, ACE_Null_Mutex>;
    public:
        LFGMgr();
        ~LFGMgr();

        void Join(Player* plr);
        void Leave(Player* plr, Group* grp = NULL);
        void OfferContinue(Group* grp);
        void TeleportPlayer(Player* plr, bool out);
        void UpdateProposal(uint32 proposalId, uint32 lowGuid, bool accept);
        void UpdateBoot(Player* plr, bool accept);
        void UpdateRoleCheck(Group* grp, Player* plr = NULL);
        void Update(uint32 diff);

        bool isRandomDungeon(uint32 dungeonId);
        void InitBoot(Group* grp, uint32 plowGuid, uint32 vlowGuid, std::string reason);

        void LoadDungeonEncounters();
        void LoadRewards();
        void RewardDungeonDoneFor(const uint32 dungeonId, Player* player);
        uint32 GetDungeonIdForAchievement(uint32 achievementId);

        LfgLockStatusMap* GetPartyLockStatusDungeons(Player* plr, LfgDungeonSet* dungeons = NULL);
        LfgDungeonSet* GetRandomDungeons(uint8 level, uint8 expansion);
        LfgLockStatusSet* GetPlayerLockStatusDungeons(Player* plr, LfgDungeonSet* dungeons = NULL, bool useEntry = true);
        LfgReward const* GetRandomDungeonReward(uint32 dungeon, uint8 level);

        bool isJoining(uint64 guid);

    private:
        void Cleaner();
        void AddGuidToNewQueue(uint64 guid);
        void AddToQueue(uint64 guid, LfgRolesMap* roles, LfgDungeonSet* dungeons);

        bool RemoveFromQueue(uint64 guid);
        void RemoveProposal(LfgProposalMap::iterator itProposal, LfgUpdateType type);

        void FindNewGroups(LfgGuidList &check, LfgGuidList all, LfgProposalList* proposals);

        bool CheckGroupRoles(LfgRolesMap &groles, bool removeLeaderFlag = true);
        bool CheckCompatibility(LfgGuidList check, LfgProposalList* proposals);
        LfgDungeonSet* CheckCompatibleDungeons(LfgDungeonMap* dungeonsMap, PlayerSet* players);
        LfgLockStatusMap* CheckCompatibleDungeons(LfgDungeonSet* dungeons, PlayerSet* players, bool returnLockMap = true);
        void SetCompatibles(std::string concatenatedGuids, bool compatibles);
        LfgAnswer GetCompatibles(std::string concatenatedGuids);
        void RemoveFromCompatibles(uint64 guid);
        std::string ConcatenateGuids(LfgGuidList check);
        std::string ConcatenateDungeons(LfgDungeonSet* dungeons);

        LfgLockStatusMap* GetGroupLockStatusDungeons(PlayerSet* pPlayers, LfgDungeonSet* dungeons, bool useEntry = true);
        LfgDungeonSet* GetDungeonsByRandom(uint32 randomdungeon);
        LfgDungeonSet* GetAllDungeons();
        uint8 GetDungeonGroupType(uint32 dungeon);

        LfgRewardMap m_RewardMap;                           // Stores rewards for random dungeons
        std::map<uint32, uint32> m_EncountersByAchievement; // Stores dungeon ids associated with achievements (for rewards)
        LfgDungeonMap m_CachedDungeonMap;                   // Stores all dungeons by groupType
        LfgQueueInfoMap m_QueueInfoMap;                     // Queued groups
        LfgGuidList m_currentQueue;                         // Ordered list. Used to find groups
        LfgGuidList m_newToQueue;                           // New groups to add to queue
        LfgCompatibleMap m_CompatibleMap;                   // Compatible dungeons
        LfgProposalMap m_Proposals;                         // Current Proposals
        LfgPlayerBootMap m_Boots;                           // Current player kicks
        LfgRoleCheckMap m_RoleChecks;                       // Current Role checks
        uint32 m_QueueTimer;                                // used to check interval of update
        uint32 m_lfgProposalId;                             // used as internal counter for proposals
        int32 m_WaitTimeAvg;
        int32 m_WaitTimeTank;
        int32 m_WaitTimeHealer;
        int32 m_WaitTimeDps;
        uint32 m_NumWaitTimeAvg;
        uint32 m_NumWaitTimeTank;
        uint32 m_NumWaitTimeHealer;
        uint32 m_NumWaitTimeDps;
        bool m_update;
};

#define sLFGMgr (*ACE_Singleton<LFGMgr, ACE_Null_Mutex>::instance())
#endif
