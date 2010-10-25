#ifndef BATTLEFIELD_WG_
#define BATTLEFIELD_WG_

#include "../Battlefield.h"
#include "Group.h"
#include "WorldPacket.h"
#include "World.h"

const uint32 WG_MARK_OF_HONOR = 43589;
const uint32 VehNumWorldState[2] = {3680,3490};
const uint32 MaxVehNumWorldState[2] = {3681,3491};
const uint32 ClockWorldState[2] = {3781,4354};
const uint32 WintergraspFaction[3] = {1732, 1735, 35};



class BattlefieldWG;
class BfCapturePointWG;

struct BfWGGameObjectBuilding;
struct BfWGWorkShopData;

typedef std::set<GameObject*> GameObjectSet;
typedef std::set<BfWGGameObjectBuilding*> GameObjectBuilding;
typedef std::set<Creature*> CreatureSet;
typedef std::set<BfWGWorkShopData*> WorkShop;
typedef std::set<BfCapturePointWG*> CapturePointSet;
typedef std::set<Group*> GroupSet;

enum eWGpell
{
    // Wartime auras
    SPELL_RECRUIT                                = 37795,
    SPELL_CORPORAL                               = 33280,
    SPELL_LIEUTENANT                             = 55629,
    SPELL_TENACITY                               = 58549,
    SPELL_TENACITY_VEHICLE                       = 59911,
    SPELL_TOWER_CONTROL                          = 62064,
    SPELL_SPIRITUAL_IMMUNITY                     = 58729,
    SPELL_GREAT_HONOR                            = 58555,
    SPELL_GREATER_HONOR                          = 58556,
    SPELL_GREATEST_HONOR                         = 58557,

    // Reward spells
    SPELL_VICTORY_REWARD                         = 56902,
    SPELL_DEFEAT_REWARD                          = 58494,
    SPELL_DAMAGED_TOWER                          = 59135,
    SPELL_DESTROYED_TOWER                        = 59136,
    SPELL_DAMAGED_BUILDING                       = 59201,
    SPELL_INTACT_BUILDING                        = 59203,

    SPELL_TELEPORT_BRIDGE                        = 59096,
    SPELL_TELEPORT_FORTRESS                      = 60035,

    SPELL_TELEPORT_DALARAN                       = 53360,
    SPELL_VICTORY_AURA                           = 60044,
};
enum eWGData32
{
    BATTLEFIELD_WG_DATA_DAMAGED_TOWER_DEF,
    BATTLEFIELD_WG_DATA_BROKEN_TOWER_DEF,
    BATTLEFIELD_WG_DATA_DAMAGED_TOWER_ATT,
    BATTLEFIELD_WG_DATA_BROKEN_TOWER_ATT,
    BATTLEFIELD_WG_DATA_MAX_VEHICLE_A,
    BATTLEFIELD_WG_DATA_MAX_VEHICLE_H,
    BATTLEFIELD_WG_DATA_VEHICLE_A,
    BATTLEFIELD_WG_DATA_VEHICLE_H,
    BATTLEFIELD_WG_DATA_MAX,
};

enum WB_ACHIEVEMENTS
{
	ACHIEVEMENTS_WIN_WG                  = 1717,
	ACHIEVEMENTS_WIN_WG_100              = 1718, //todo
	ACHIEVEMENTS_WG_GNOMESLAUGHTER	  = 1723, //todo
	ACHIEVEMENTS_WG_TOWER_DESTROY        = 1727,
	ACHIEVEMENTS_DESTRUCTION_DERBY_A     = 1737, //todo
	ACHIEVEMENTS_WG_TOWER_CANNON_KILL    = 1751, //todo
	ACHIEVEMENTS_WG_MASTER_A	         = 1752, //todo
	ACHIEVEMENTS_WIN_WG_TIMER_10         = 1755,
	ACHIEVEMENTS_STONE_KEEPER_50	  = 2085, //todo
	ACHIEVEMENTS_STONE_KEEPER_100	  = 2086, //todo
	ACHIEVEMENTS_STONE_KEEPER_250	  = 2087, //todo
	ACHIEVEMENTS_STONE_KEEPER_500	  = 2088, //todo
	ACHIEVEMENTS_STONE_KEEPER_1000	  = 2089, //todo
	ACHIEVEMENTS_WG_RANGER		  = 2199, //todo
	ACHIEVEMENTS_DESTRUCTION_DERBY_H     = 2476, //todo
	ACHIEVEMENTS_WG_MASTER_H	         = 2776, //todo

};

/*#########################
*####### Graveyards ######*
#########################*/

class BfGraveYardWG: public BfGraveYard
{
public:
    BfGraveYardWG(BattlefieldWG* Bf);
    void SetTextId(uint32 textid){m_GossipTextId=textid;}
    uint32 GetTextId(){return m_GossipTextId;}
protected:
    uint32 m_GossipTextId;
};

enum eWGGraveyardId
{
    BATTLEFIELD_WG_GY_WORKSHOP_NE,
    BATTLEFIELD_WG_GY_WORKSHOP_NW,
    BATTLEFIELD_WG_GY_WORKSHOP_SE,
    BATTLEFIELD_WG_GY_WORKSHOP_SW,
    BATTLEFIELD_WG_GY_KEEP,
    BATTLEFIELD_WG_GY_HORDE,
    BATTLEFIELD_WG_GY_ALLIANCE,
    BATTLEFIELD_WG_GY_MAX,
};

enum eWGGossipText
{
    BATTLEFIELD_WG_GOSSIPTEXT_GY_NE = -1850501,
    BATTLEFIELD_WG_GOSSIPTEXT_GY_NW = -1850502,
    BATTLEFIELD_WG_GOSSIPTEXT_GY_SE = -1850504,
    BATTLEFIELD_WG_GOSSIPTEXT_GY_SW = -1850503,
    BATTLEFIELD_WG_GOSSIPTEXT_GY_KEEP = -1850500,
    BATTLEFIELD_WG_GOSSIPTEXT_GY_HORDE = -1850505,
    BATTLEFIELD_WG_GOSSIPTEXT_GY_ALLIANCE = -1850506,
};
enum eWGNpc
{
    BATTLEFIELD_WG_NPC_GUARD_H = 30739,
    BATTLEFIELD_WG_NPC_GUARD_A = 30740,
};

struct BfWGCoordGY
{
    float x;
    float y;
    float z;
    float o;
    uint32 gyid;
    uint8 type;
    uint32 textid;//for gossip menu
    TeamId startcontrol;
};

const BfWGCoordGY WGGraveYard[BATTLEFIELD_WG_GY_MAX]=
{
    {5104.750,2300.940,368.579,0.733038,1329,BATTLEFIELD_WG_GY_WORKSHOP_NE,BATTLEFIELD_WG_GOSSIPTEXT_GY_NE,TEAM_NEUTRAL},
    {5099.120,3466.036,368.484,5.317802,1330,BATTLEFIELD_WG_GY_WORKSHOP_NW,BATTLEFIELD_WG_GOSSIPTEXT_GY_NW,TEAM_NEUTRAL},
    {4314.648,2408.522,392.642,6.268125,1333,BATTLEFIELD_WG_GY_WORKSHOP_SE,BATTLEFIELD_WG_GOSSIPTEXT_GY_SE,TEAM_NEUTRAL},
    {4331.716,3235.695,390.251,0.008500,1334,BATTLEFIELD_WG_GY_WORKSHOP_SW,BATTLEFIELD_WG_GOSSIPTEXT_GY_SW,TEAM_NEUTRAL},
    {5537.986,2897.493,517.057,4.819249,1285,BATTLEFIELD_WG_GY_KEEP,BATTLEFIELD_WG_GOSSIPTEXT_GY_KEEP,TEAM_NEUTRAL},
    {5032.454,3711.382,372.468,3.971623,1331,BATTLEFIELD_WG_GY_HORDE,BATTLEFIELD_WG_GOSSIPTEXT_GY_HORDE,TEAM_HORDE},
    {5140.790,2179.120,390.950,1.972220,1332,BATTLEFIELD_WG_GY_ALLIANCE,BATTLEFIELD_WG_GOSSIPTEXT_GY_ALLIANCE,TEAM_ALLIANCE},
};

/*#########################
* BfCapturePointWG       *
#########################*/

class BfCapturePointWG: public BfCapturePoint
{
public:
    BfCapturePointWG(BattlefieldWG* bf,TeamId control);
    void LinkToWorkShop(BfWGWorkShopData* ws) {m_WorkShop=ws;}

    void ChangeTeam(TeamId oldteam);
    TeamId GetTeam() const { return m_team; }

protected:
    BfWGWorkShopData* m_WorkShop;
};
/*#########################
* WinterGrasp Battlefield *
#########################*/

class BattlefieldWG: public Battlefield
{
public:
    void OnBattleStart();
    void OnBattleEnd(bool endbytimer);
    void OnStartGrouping();
    void OnPlayerJoinWar(Player* plr);
    void OnPlayerLeaveWar(Player* plr);
    void OnPlayerLeaveZone(Player* plr);
    void OnPlayerEnterZone(Player* plr);
    bool Update(uint32 diff);
    void OnCreatureCreate(Creature *creature, bool add);
    void AddDamagedTower(TeamId team);
    void AddBrokenTower(TeamId team);
    void DoCompleteOrIncrementAchievement(uint32 achievement, Player* player, uint8 incrementNumber = 1);
    virtual void AddPlayerToResurrectQueue(uint64 npc_guid, uint64 player_guid);
    bool SetupBattlefield();
    GameObject* GetRelic() {return m_relic;}
    void SetRelic(GameObject* relic){m_relic=relic;}

    bool CanClickOnOrb() {return m_bCanClickOnOrb;}
    void AllowToClickOnOrb(bool allow) {m_bCanClickOnOrb = allow;}
    
    void RewardMarkOfHonor(Player *plr, uint32 count);
    
    void UpdateVehicleCountWG();

    WorldPacket BuildInitWorldStates();
    void SendInitWorldStatesTo(Player* plr);
    void SendInitWorldStatesToAll();
    
    void HandleKill(Player *killer, Unit *victim);
    void PromotePlayer(Player *killer);

    void UpdateTenacity();
    void ProcessEvent(GameObject *obj, uint32 eventId);
protected:
    bool m_bCanClickOnOrb;
    GameObject* m_relic;
    GameObjectBuilding BuildingsInZone;
    CreatureSet KeepCreature[2];
    WorkShop WorkShopList; 
    CreatureSet CanonList;
    GameObjectSet DefenderPortalList;
    GameObjectSet m_KeepGameObject[2];
    CreatureSet m_vehicles[2];
    GuidSet m_PlayersIsSpellImu;  //Player is dead
    uint32 m_tenacityStack;
    uint32 m_saveTimer;
};

#define NORTHREND_WINTERGRASP 4197

enum eWGGameObjectBuildingType
{
    BATTLEFIELD_WG_OBJECTTYPE_DOOR,
    BATTLEFIELD_WG_OBJECTTYPE_TITANRELIC,
    BATTLEFIELD_WG_OBJECTTYPE_WALL,
    BATTLEFIELD_WG_OBJECTTYPE_DOOR_LAST,
    BATTLEFIELD_WG_OBJECTTYPE_KEEP_TOWER,
    BATTLEFIELD_WG_OBJECTTYPE_TOWER,
};

enum eWGGameObjectState
{
    BATTLEFIELD_WG_OBJECTSTATE_NONE,
    BATTLEFIELD_WG_OBJECTSTATE_NEUTRAL_INTACT,
    BATTLEFIELD_WG_OBJECTSTATE_NEUTRAL_DAMAGE,
    BATTLEFIELD_WG_OBJECTSTATE_NEUTRAL_DESTROY,
    BATTLEFIELD_WG_OBJECTSTATE_HORDE_INTACT,
    BATTLEFIELD_WG_OBJECTSTATE_HORDE_DAMAGE,
    BATTLEFIELD_WG_OBJECTSTATE_HORDE_DESTROY,
    BATTLEFIELD_WG_OBJECTSTATE_ALLIANCE_INTACT,
    BATTLEFIELD_WG_OBJECTSTATE_ALLIANCE_DAMAGE,
    BATTLEFIELD_WG_OBJECTSTATE_ALLIANCE_DESTROY,
};

enum eWGWorkShopType
{
    BATTLEFIELD_WG_WORKSHOP_NE,
    BATTLEFIELD_WG_WORKSHOP_NW,
    BATTLEFIELD_WG_WORKSHOP_SE,
    BATTLEFIELD_WG_WORKSHOP_SW,
    BATTLEFIELD_WG_WORKSHOP_KEEP_WEST,
    BATTLEFIELD_WG_WORKSHOP_KEEP_EAST,
};

enum eWGTeamControl
{
    BATTLEFIELD_WG_TEAM_ALLIANCE,
    BATTLEFIELD_WG_TEAM_HORDE,
    BATTLEFIELD_WG_TEAM_NEUTRAL,    
};
enum eWGText
{
    BATTLEFIELD_WG_TEXT_WORKSHOP_NAME_NE = 12055,
    BATTLEFIELD_WG_TEXT_WORKSHOP_NAME_NW = 12052,
    BATTLEFIELD_WG_TEXT_WORKSHOP_NAME_SE = 12053,
    BATTLEFIELD_WG_TEXT_WORKSHOP_NAME_SW = 12054,
    BATTLEFIELD_WG_TEXT_WORKSHOP_ATTACK = 12051,
    BATTLEFIELD_WG_TEXT_WORKSHOP_TAKEN = 12050,
    BATTLEFIELD_WG_TEXT_ALLIANCE = 12057,
    BATTLEFIELD_WG_TEXT_HORDE = 12056,
    BATTLEFIELD_WG_TEXT_WILL_START = 12058,
    BATTLEFIELD_WG_TEXT_START = 12067,
    BATTLEFIELD_WG_TEXT_FIRSTRANK = 12059,
    BATTLEFIELD_WG_TEXT_SECONDRANK = 12060,
    BATTLEFIELD_WG_TEXT_KEEPTOWER_NAME_NE = 12062,
    BATTLEFIELD_WG_TEXT_KEEPTOWER_NAME_NW = 12064,
    BATTLEFIELD_WG_TEXT_KEEPTOWER_NAME_SE = 12061,
    BATTLEFIELD_WG_TEXT_KEEPTOWER_NAME_SW = 12063,
    BATTLEFIELD_WG_TEXT_TOWER_DAMAGE = 12065,
    BATTLEFIELD_WG_TEXT_TOWER_DESTROY = 12066,
    BATTLEFIELD_WG_TEXT_TOWER_NAME_S = 12069,
    BATTLEFIELD_WG_TEXT_TOWER_NAME_E = 12070,
    BATTLEFIELD_WG_TEXT_TOWER_NAME_W = 12071,
    BATTLEFIELD_WG_TEXT_DEFEND_KEEP = 12068,
    BATTLEFIELD_WG_TEXT_WIN_KEEP = 12072,
};

enum eWGObject
{
    BATTLEFIELD_WG_GAMEOBJECT_FACTORY_BANNER_NE = 190475,
    BATTLEFIELD_WG_GAMEOBJECT_FACTORY_BANNER_NW = 190487,
    BATTLEFIELD_WG_GAMEOBJECT_FACTORY_BANNER_SE = 194959,
    BATTLEFIELD_WG_GAMEOBJECT_FACTORY_BANNER_SW = 194962,
    BATTLEFIELD_WG_GAMEOBJECT_TITAN_RELIC = 192829,
};
struct BfWGObjectPosition
{
    float x;
    float y;
    float z;
    float o;
    uint32 entryh;
    uint32 entrya;
};

//*********************************************************
//************Destructible (Wall,Tower..)******************
//*********************************************************

struct BfWGBuildingSpawnData
{
    uint32 entry;
    uint32 WorldState;
    float x;
    float y;
    float z;
    float o;
    uint32 type;
    uint32 nameid;
};
#define WG_MAX_OBJ 32
const BfWGBuildingSpawnData WGGameObjectBuillding[WG_MAX_OBJ] = 
{
    // Wall
    // Entry WS    X        Y        Z        O         type                          NameID
    {190219, 3749, 5371.46, 3047.47, 407.571, 3.14159,  BATTLEFIELD_WG_OBJECTTYPE_WALL, 0},
    {190220, 3750, 5331.26, 3047.1,  407.923, 0.052359, BATTLEFIELD_WG_OBJECTTYPE_WALL, 0},
    {191795, 3764, 5385.84, 2909.49, 409.713, 0.00872,  BATTLEFIELD_WG_OBJECTTYPE_WALL, 0},
    {191796, 3772, 5384.45, 2771.84, 410.27,  3.14159,  BATTLEFIELD_WG_OBJECTTYPE_WALL, 0},
    {191799, 3762, 5371.44, 2630.61, 408.816, 3.13286,  BATTLEFIELD_WG_OBJECTTYPE_WALL, 0},
    {191800, 3766, 5301.84, 2909.09, 409.866, 0.008724, BATTLEFIELD_WG_OBJECTTYPE_WALL, 0},
    {191801, 3770, 5301.06, 2771.41, 409.901, 3.14159,  BATTLEFIELD_WG_OBJECTTYPE_WALL, 0},
    {191802, 3751, 5280.2,  2995.58, 408.825, 1.61443,  BATTLEFIELD_WG_OBJECTTYPE_WALL, 0},
    {191803, 3752, 5279.14, 2956.02, 408.604, 1.5708,   BATTLEFIELD_WG_OBJECTTYPE_WALL, 0},
    {191804, 3767, 5278.69, 2882.51, 409.539, 1.5708,   BATTLEFIELD_WG_OBJECTTYPE_WALL, 0},
    {191806, 3769, 5279.5,  2798.94, 409.998, 1.5708,   BATTLEFIELD_WG_OBJECTTYPE_WALL, 0},
    {191807, 3759, 5279.94, 2724.77, 409.945, 1.56207,  BATTLEFIELD_WG_OBJECTTYPE_WALL, 0},
    {191808, 3760, 5279.6,  2683.79, 409.849, 1.55334,  BATTLEFIELD_WG_OBJECTTYPE_WALL, 0},
    {191809, 3761, 5330.96, 2630.78, 409.283, 3.13286,  BATTLEFIELD_WG_OBJECTTYPE_WALL, 0},
    {190369, 3753, 5256.08, 2933.96, 409.357, 3.13286,  BATTLEFIELD_WG_OBJECTTYPE_WALL, 0},
    {190370, 3758, 5257.46, 2747.33, 409.743, -3.13286, BATTLEFIELD_WG_OBJECTTYPE_WALL, 0},
    {190371, 3754, 5214.96, 2934.09, 409.19,  -0.008724,BATTLEFIELD_WG_OBJECTTYPE_WALL, 0},
    {190372, 3757, 5215.82, 2747.57, 409.188, -3.13286, BATTLEFIELD_WG_OBJECTTYPE_WALL, 0},
    {190374, 3755, 5162.27, 2883.04, 410.256, 1.57952,  BATTLEFIELD_WG_OBJECTTYPE_WALL, 0},
    {190376, 3756, 5163.72, 2799.84, 409.227, 1.57952,  BATTLEFIELD_WG_OBJECTTYPE_WALL, 0},

    //Tower of keep
    {190221, 3711, 5281.15, 3044.59, 407.843, 3.11539,  BATTLEFIELD_WG_OBJECTTYPE_KEEP_TOWER, BATTLEFIELD_WG_TEXT_KEEPTOWER_NAME_NW},
    {190373, 3713, 5163.76, 2932.23, 409.19,  3.12412,  BATTLEFIELD_WG_OBJECTTYPE_KEEP_TOWER, BATTLEFIELD_WG_TEXT_KEEPTOWER_NAME_SW},
    {190377, 3714, 5166.4,  2748.37, 409.188, -1.5708,  BATTLEFIELD_WG_OBJECTTYPE_KEEP_TOWER, BATTLEFIELD_WG_TEXT_KEEPTOWER_NAME_SE},
    {190378, 3712, 5281.19, 2632.48, 409.099, -1.58825, BATTLEFIELD_WG_OBJECTTYPE_KEEP_TOWER, BATTLEFIELD_WG_TEXT_KEEPTOWER_NAME_NE},

    //Wall (with passage)
    {191797, 3765, 5343.29, 2908.86, 409.576, 0.008724, BATTLEFIELD_WG_OBJECTTYPE_WALL, 0},
    {191798, 3771, 5342.72, 2771.39, 409.625, 3.14159,  BATTLEFIELD_WG_OBJECTTYPE_WALL, 0},
    {191805, 3768, 5279.13, 2840.8,  409.783, 1.57952,  BATTLEFIELD_WG_OBJECTTYPE_WALL, 0},

    //South tower
    {190356, 3704, 4557.17, 3623.94, 395.883, 1.67552,  BATTLEFIELD_WG_OBJECTTYPE_TOWER, BATTLEFIELD_WG_TEXT_TOWER_NAME_W},
    {190357, 3705, 4398.17, 2822.5,  405.627, -3.12412, BATTLEFIELD_WG_OBJECTTYPE_TOWER, BATTLEFIELD_WG_TEXT_TOWER_NAME_S},
    {190358, 3706, 4459.1,  1944.33, 434.991, -2.00276, BATTLEFIELD_WG_OBJECTTYPE_TOWER, BATTLEFIELD_WG_TEXT_TOWER_NAME_E},

    //Door of forteress
    {190375, 3763, 5162.99, 2841.23, 410.162, -3.13286, BATTLEFIELD_WG_OBJECTTYPE_DOOR, 0},

    //Last door
    {191810, 3773, 5397.11, 2841.54, 425.899, 3.14159,  BATTLEFIELD_WG_OBJECTTYPE_DOOR_LAST, 0},
};


//*********************************************************
//**********Keep Element(GameObject,Creature)**************
//*********************************************************

//Keep gameobject
#define WG_KEEPGAMEOBJECT_MAX 44
const BfWGObjectPosition WGKeepGameObject[WG_KEEPGAMEOBJECT_MAX]={
	{5262.540039, 3047.949951, 432.054993, 3.106650, 192488, 192501}, // Flag on tower
	{5272.939941, 2976.550049, 444.492004, 3.124120, 192374, 192416}, // Flag on Wall Intersect
	{5235.189941, 2941.899902, 444.278015, 1.588250, 192375, 192416}, // Flag on Wall Intersect
	{5163.129883, 2952.590088, 433.502991, 1.535890, 192488, 192501}, // Flag on tower
	{5145.109863, 2935.000000, 433.385986, 3.141590, 192488, 192501}, // Flag on tower
	{5158.810059, 2883.129883, 431.618011, 3.141590, 192488, 192416}, // Flag on wall
	{5154.490234, 2862.149902, 445.011993, 3.141590, 192336, 192416}, // Flag on Wall Intersect
	{5154.520020, 2853.310059, 409.183014, 3.141590, 192255, 192269}, // Flag on the floor
	{5154.459961, 2828.939941, 409.188995, 3.141590, 192254, 192269}, // Flag on the floor
	{5155.310059, 2820.739990, 444.979004, -3.13286, 192349, 192416}, // Flag on wall intersect
	{5160.339844, 2798.610107, 430.769012, 3.141590, 192488, 192416}, // Flag on wall
	{5146.040039, 2747.209961, 433.584015, 3.071770, 192488, 192501}, // Flag on tower
	{5163.779785, 2729.679932, 433.394012, -1.58825, 192488, 192501}, // Flag on tower
	{5236.270020, 2739.459961, 444.992004, -1.59698, 192366, 192416}, // Flag on wall intersect
	{5271.799805, 2704.870117, 445.183014, -3.13286, 192367, 192416}, // Flag on wall intersect
	{5260.819824, 2631.800049, 433.324005, 3.054330, 192488, 192501}, // Flag on tower
	{5278.379883, 2613.830078, 433.408997, -1.58825, 192488, 192501}, // Flag on tower
	{5350.879883, 2622.719971, 444.686005, -1.57080, 192364, 192416}, // Flag on wall intersect
	{5392.270020, 2639.739990, 435.330994, 1.509710, 192370, 192416}, // Flag on wall intersect
	{5350.950195, 2640.360107, 435.407990, 1.570800, 192369, 192416}, // Flag on wall intersect
	{5289.459961, 2704.679932, 435.875000, -0.01745, 192368, 192416}, // Flag on wall intersect
	{5322.120117, 2763.610107, 444.973999, -1.55334, 192362, 192416}, // Flag on wall intersect
	{5363.609863, 2763.389893, 445.023987, -1.54462, 192363, 192416}, // Flag on wall intersect
	{5363.419922, 2781.030029, 435.763000, 1.570800, 192379, 192416}, // Flag on wall intersect
	{5322.020020, 2781.129883, 435.811005, 1.570800, 192378, 192416}, // Flag on wall intersect
	{5288.919922, 2820.219971, 435.721008, 0.017452, 192355, 192416}, // Flag on wall intersect
	{5288.410156, 2861.790039, 435.721008, 0.017452, 192354, 192416}, // Flag on wall intersect
	{5322.229980, 2899.429932, 435.808014, -1.58825, 192358, 192416}, // Flag on wall intersect
	{5364.350098, 2899.399902, 435.838989, -1.57080, 192359, 192416}, // Flag on wall intersect
	{5397.759766, 2873.080078, 455.460999, 3.106650, 192338, 192416}, // Flag on keep
	{5397.390137, 2809.330078, 455.343994, 3.106650, 192339, 192416}, // Flag on keep
	{5372.479980, 2862.500000, 409.049011, 3.141590, 192284, 192269}, // Flag on floor
	{5371.490234, 2820.800049, 409.177002, 3.141590, 192285, 192269}, // Flag on floor
	{5364.290039, 2916.939941, 445.330994, 1.579520, 192371, 192416}, // Flag on wall intersect
	{5322.859863, 2916.949951, 445.153992, 1.562070, 192372, 192416}, // Flag on wall intersect
	{5290.350098, 2976.560059, 435.221008, 0.017452, 192373, 192416}, // Flag on wall intersect
	{5352.370117, 3037.090088, 435.252014, -1.57080, 192360, 192416}, // Flag on wall intersect
	{5392.649902, 3037.110107, 433.713013, -1.52716, 192361, 192416}, // Flag on wall intersect
	{5237.069824, 2757.030029, 435.795990, 1.518440, 192356, 192416}, // Flag on wall intersect
	{5173.020020, 2820.929932, 435.720001, 0.017452, 192352, 192416}, // Flag on wall intersect
	{5172.109863, 2862.570068, 435.721008, 0.017452, 192353, 192416}, // Flag on wall intersect
	{5235.339844, 2924.340088, 435.040009, -1.57080, 192357, 192416}, // Flag on wall intersect
	{5270.689941, 2861.780029, 445.058014, -3.11539, 192350, 192416}, // Flag on wall intersect
	{5271.279785, 2820.159912, 445.200989, -3.13286, 192351, 192416} // Flag on wall intersect
};

//Keep turret
struct BfWGTurretPos
{
    float x;
    float y;
    float z;
    float o;
};
#define WG_MAX_TURRET 23
const BfWGTurretPos WGTurret[WG_MAX_TURRET]=
{
    {5163.84, 2723.74, 439.844, 1.3994},
    {5255.88, 3047.63, 438.499, 3.13677},
    {5280.9, 3071.32, 438.499, 1.62879},
    {5391.19, 3060.8, 419.616, 1.69557},
    {5266.75, 2976.5, 421.067, 3.20354},
    {5234.86, 2948.8, 420.88, 1.61311},
    {5323.05, 2923.7, 421.645, 1.5817},
    {5363.82, 2923.87, 421.709, 1.60527},
    {5264.04, 2861.34, 421.587, 3.21142},
    {5264.68, 2819.78, 421.656, 3.15645},
    {5322.16, 2756.69, 421.646, 4.69978},
    {5363.78, 2756.77, 421.629, 4.78226},
    {5236.2, 2732.68, 421.649, 4.72336},
    {5265.02, 2704.63, 421.7, 3.12507},
    {5350.87, 2616.03, 421.243, 4.72729},
    {5390.95, 2615.5, 421.126, 4.6409},
    {5278.21, 2607.23, 439.755, 4.71944},
    {5255.01, 2631.98, 439.755, 3.15257},
    {5163.06, 2959.52, 439.846, 1.47258},
    {5138.59, 2935.16, 439.845, 3.11723},
    {5139.69, 2747.4, 439.844, 3.17221},
    {5148.8, 2820.24, 421.621, 3.16043},
    {5147.98, 2861.93, 421.63, 3.18792},
};


//Here there is all npc keeper spawn point
#define WG_MAX_KEEP_NPC 38
const BfWGObjectPosition WGKeepNPC[WG_MAX_KEEP_NPC] =
{
    // X          Y            Z           O         horde                          alliance
    // North East 
    {5326.203125, 2660.026367, 409.100891, 2.543383, BATTLEFIELD_WG_NPC_GUARD_H, BATTLEFIELD_WG_NPC_GUARD_A}, // Roaming Guard
    {5298.430176, 2738.760010, 409.316010, 3.971740, 31102, 31052}, // Vieron Plumembrase /
    {5335.310059, 2764.110107, 409.274994, 4.834560, BATTLEFIELD_WG_NPC_GUARD_H, BATTLEFIELD_WG_NPC_GUARD_A}, // Standing Guard
    {5349.810059, 2763.629883, 409.333008, 4.660030, BATTLEFIELD_WG_NPC_GUARD_H, BATTLEFIELD_WG_NPC_GUARD_A}, // Standing Guard
    // North
    {5373.470215, 2789.060059, 409.322998, 2.600540, 32296, 32294}, // Garde de pierre Mukar /
    {5296.560059, 2789.870117, 409.274994, 0.733038, 31101, 31051}, // Ma?tre vodoun Fu'jin /
    {5368.709961, 2856.360107, 409.322998, 2.949610, BATTLEFIELD_WG_NPC_GUARD_H, BATTLEFIELD_WG_NPC_GUARD_A}, // Standing Guard
    {5367.910156, 2826.520020, 409.322998, 3.333580, BATTLEFIELD_WG_NPC_GUARD_H, BATTLEFIELD_WG_NPC_GUARD_A}, // Standing Guard
    {5389.270020, 2847.370117, 418.759003, 3.106690, BATTLEFIELD_WG_NPC_GUARD_H, BATTLEFIELD_WG_NPC_GUARD_A}, // Standing Guard
    {5388.560059, 2834.770020, 418.759003, 3.071780, BATTLEFIELD_WG_NPC_GUARD_H, BATTLEFIELD_WG_NPC_GUARD_A}, // Standing Guard
    {5359.129883, 2837.989990, 409.364014, 4.698930, 31091, 31036}, // Commandant Dardosh /
    {5366.129883, 2833.399902, 409.322998, 3.141590, 31151, 31153}, // Officier tactique Kilrath /
    // X          Y            Z           O         horde  alliance
    // North West
    {5350.680176, 2917.010010, 409.274994, 1.466080, BATTLEFIELD_WG_NPC_GUARD_H, BATTLEFIELD_WG_NPC_GUARD_A}, // Standing Guard
    {5335.120117, 2916.800049, 409.444000, 1.500980, BATTLEFIELD_WG_NPC_GUARD_H, BATTLEFIELD_WG_NPC_GUARD_A}, // Standing Guard
    {5295.560059, 2926.669922, 409.274994, 0.872665, 31106, 31108}, // Poliorc?te Sabot-puissant /
    {5371.399902, 3026.510010, 409.205994, 3.250030, 31053, 31054}, // Primaliste Mulfort /
    {5392.123535, 3031.110352, 409.187683, 3.677212, BATTLEFIELD_WG_NPC_GUARD_H, BATTLEFIELD_WG_NPC_GUARD_A}, // Roaming Guard
    // South
    {5270.060059, 2847.550049, 409.274994, 3.071780, BATTLEFIELD_WG_NPC_GUARD_H, BATTLEFIELD_WG_NPC_GUARD_A}, // Standing Guard
    {5270.160156, 2833.479980, 409.274994, 3.124140, BATTLEFIELD_WG_NPC_GUARD_H, BATTLEFIELD_WG_NPC_GUARD_A}, // Standing Guard
    {5179.109863, 2837.129883, 409.274994, 3.211410, BATTLEFIELD_WG_NPC_GUARD_H, BATTLEFIELD_WG_NPC_GUARD_A}, // Standing Guard
    {5179.669922, 2846.600098, 409.274994, 3.089230, BATTLEFIELD_WG_NPC_GUARD_H, BATTLEFIELD_WG_NPC_GUARD_A}, // Standing Guard
    {5234.970215, 2883.399902, 409.274994, 4.293510, 31107, 31109}, // Lieutenant Murp /
    // X          Y            Z           O         horde  alliance
    // Gardes des portails (autour de la forteresse)
    {5319.209473, 3055.947754, 409.176636, 1.020201, BATTLEFIELD_WG_NPC_GUARD_H, BATTLEFIELD_WG_NPC_GUARD_A}, // Standing Guard
    {5311.612305, 3061.207275, 408.734161, 0.965223, BATTLEFIELD_WG_NPC_GUARD_H, BATTLEFIELD_WG_NPC_GUARD_A}, // Standing Guard
    {5264.713379, 3017.283447, 408.479706, 3.482424, BATTLEFIELD_WG_NPC_GUARD_H, BATTLEFIELD_WG_NPC_GUARD_A}, // Standing Guard
    {5269.096191, 3008.315918, 408.826294, 3.843706, BATTLEFIELD_WG_NPC_GUARD_H, BATTLEFIELD_WG_NPC_GUARD_A}, // Standing Guard
    {5201.414551, 2945.096924, 409.190735, 0.945592, BATTLEFIELD_WG_NPC_GUARD_H, BATTLEFIELD_WG_NPC_GUARD_A}, // Standing Guard
    {5193.386230, 2949.617188, 409.190735, 1.145859, BATTLEFIELD_WG_NPC_GUARD_H, BATTLEFIELD_WG_NPC_GUARD_A}, // Standing Guard
    {5148.116211, 2904.761963, 409.193756, 3.368532, BATTLEFIELD_WG_NPC_GUARD_H, BATTLEFIELD_WG_NPC_GUARD_A}, // Standing Guard
    {5153.355957, 2895.501465, 409.199310, 3.549174, BATTLEFIELD_WG_NPC_GUARD_H, BATTLEFIELD_WG_NPC_GUARD_A}, // Standing Guard
    {5154.353027, 2787.349365, 409.250183, 2.555644, BATTLEFIELD_WG_NPC_GUARD_H, BATTLEFIELD_WG_NPC_GUARD_A}, // Standing Guard
    {5150.066406, 2777.876953, 409.343903, 2.708797, BATTLEFIELD_WG_NPC_GUARD_H, BATTLEFIELD_WG_NPC_GUARD_A}, // Standing Guard
    {5193.706543, 2732.882812, 409.189514, 4.845073, BATTLEFIELD_WG_NPC_GUARD_H, BATTLEFIELD_WG_NPC_GUARD_A}, // Standing Guard
    {5202.126953, 2737.570557, 409.189514, 5.375215, BATTLEFIELD_WG_NPC_GUARD_H, BATTLEFIELD_WG_NPC_GUARD_A}, // Standing Guard
    {5269.181152, 2671.174072, 409.098999, 2.457459, BATTLEFIELD_WG_NPC_GUARD_H, BATTLEFIELD_WG_NPC_GUARD_A}, // Standing Guard
    {5264.960938, 2662.332520, 409.098999, 2.598828, BATTLEFIELD_WG_NPC_GUARD_H, BATTLEFIELD_WG_NPC_GUARD_A}, // Standing Guard
    {5307.111816, 2616.006836, 409.095734, 5.355575, BATTLEFIELD_WG_NPC_GUARD_H, BATTLEFIELD_WG_NPC_GUARD_A}, // Standing Guard
    {5316.770996, 2619.430176, 409.027740, 5.363431, BATTLEFIELD_WG_NPC_GUARD_H, BATTLEFIELD_WG_NPC_GUARD_A} // Standing Guard
};

struct BfWGWGTeleporterData
{
    uint32 entry;   //Entry of GameObject
    float x;        //Position where must be spawn the GameObject
    float y;        //  --
    float z;        //  --
    float o;        //  --
};
#define WG_MAX_TELEPORTER 10
const BfWGWGTeleporterData WGPortalDefenderData[WG_MAX_TELEPORTER] = 
{
    {190763, 5153.41, 2901.35, 409.191, -0.069812},
    {190763, 5268.7,  2666.42, 409.099, -0.715585},
    {190763, 5197.05, 2944.81, 409.191, 2.33874},
    {190763, 5196.67, 2737.34, 409.189, -2.93214},
    {190763, 5314.58, 3055.85, 408.862, 0.541051},
    {190763, 5391.28, 2828.09, 418.675, -2.16421},
    {190763, 5153.93, 2781.67, 409.246, 1.65806},
    {190763, 5311.44, 2618.93, 409.092, -2.37364},
    {190763, 5269.21, 3013.84, 408.828, -1.76278},
    {190763, 5401.62, 2853.66, 418.674, 2.635440}
};

//*********************************************************
//**********Tower Element(GameObject,Creature)*************
//*********************************************************

struct BfWGTowerData {
	uint32 towerentry; //Gameobject id of tower // TODO: needed ? 
	uint8 nbObject; //Number of gameobject spawned on this point
	BfWGObjectPosition GameObject[6];//Gameobject position and entry (Horde/Alliance)
    //Creature : Turrets and Guard, TODO: check if killed on tower destroy ? tower damage ?
	uint8 nbCreatureBottom;//Number of Creature spawned on Bottom (4 turrets and some guard)
    BfWGObjectPosition CreatureBottom[9]; // bottom creaturer
    uint8 nbCreatureTop; //Number of Creature spawned on Top (4 turrets and 1 guard ? need confirm)
    BfWGObjectPosition CreatureTop[5]; // tor creature 
};

const BfWGTowerData AttackTowers[3]={
	//Tower west
    {
        190356,
        6,
        {
            {4559.109863, 3606.219971, 419.998993, -1.483530, 192488, 192501},// Flag on tower
            {4539.419922, 3622.489990, 420.033997, -3.071770, 192488, 192501},// Flag on tower
            {4555.259766, 3641.649902, 419.973999, 1.675510, 192488, 192501},// Flag on tower
            {4574.870117, 3625.909912, 420.079010, 0.080117, 192488, 192501},// Flag on tower
            {4433.899902, 3534.139893, 360.274994, -1.850050, 192269, 192278},// Flag near workshop
            {4572.930176, 3475.520020, 363.009003, 1.42240, 192269, 192278}// Flag near bridge
        },
        1,
        {
            {4418.688477, 3506.251709, 358.975494, 4.293305, BATTLEFIELD_WG_NPC_GUARD_H, BATTLEFIELD_WG_NPC_GUARD_A},// Roaming Guard
            {0			, 0			 , 0 	     , 0	   , 0    , 0    },
            {0			, 0			 , 0 	     , 0	   , 0    , 0    },
            {0			, 0			 , 0 	     , 0	   , 0    , 0    },
            {0			, 0			 , 0 	     , 0	   , 0    , 0    },
            {0			, 0			 , 0 	     , 0	   , 0    , 0    },
            {0			, 0			 , 0 	     , 0	   , 0    , 0    },
            {0			, 0			 , 0 	     , 0	   , 0    , 0    },
            {0			, 0			 , 0 	     , 0	   , 0    , 0    },
        },
        0,
        {
            {0			, 0			 , 0 	     , 0	   , 0    , 0    },
            {0			, 0			 , 0 	     , 0	   , 0    , 0    },
            {0			, 0			 , 0 	     , 0	   , 0    , 0    },
            {0			, 0			 , 0 	     , 0	   , 0    , 0    },
            {0			, 0			 , 0 	     , 0	   , 0    , 0    },
        }
    },
    //Tower South
    {
        190357,
        5,
        {
			{4416.000000, 2822.669922, 429.851013, -0.017452, 192488, 192501},// Flag on tower
			{4398.819824, 2804.699951, 429.791992, -1.588250, 192488, 192501},// Flag on tower
			{4387.620117, 2719.570068, 389.934998, -1.544620, 192366, 192414},// Flag near tower
			{4464.120117, 2855.449951, 406.110992, 0.829032, 192366, 192429},// Flag near tower
			{4526.459961, 2810.179932, 391.200012, -2.993220, 192269, 192278},// Flag near bridge
			{0			, 0			 , 0 	     , 0	   , 0    , 0    },
        },
        6,
        {
			{4452.859863, 2808.870117, 402.604004, 6.056290, BATTLEFIELD_WG_NPC_GUARD_H, BATTLEFIELD_WG_NPC_GUARD_A},// Standing Guard
			{4455.899902, 2835.958008, 401.122559, 0.034907, BATTLEFIELD_WG_NPC_GUARD_H, BATTLEFIELD_WG_NPC_GUARD_A},// Standing Guard
			{4412.649414, 2953.792236, 374.799957, 0.980838, BATTLEFIELD_WG_NPC_GUARD_H, BATTLEFIELD_WG_NPC_GUARD_A},// Roaming Guard
			{4362.089844, 2811.510010, 407.337006, 3.193950, BATTLEFIELD_WG_NPC_GUARD_H, BATTLEFIELD_WG_NPC_GUARD_A},// Standing Guard
			{4412.290039, 2753.790039, 401.015015, 5.829400, BATTLEFIELD_WG_NPC_GUARD_H, BATTLEFIELD_WG_NPC_GUARD_A},// Standing Guard
			{4421.939941, 2773.189941, 400.894989, 5.707230, BATTLEFIELD_WG_NPC_GUARD_H, BATTLEFIELD_WG_NPC_GUARD_A},// Standing Guard
			{0			, 0			 , 0 	     , 0	   , 0    , 0    },
			{0			, 0			 , 0 	     , 0	   , 0    , 0    },
			{0			, 0			 , 0 	     , 0	   , 0    , 0    },
        },
        0,
        {
			{0			, 0			 , 0 	     , 0	   , 0    , 0    },
			{0			, 0			 , 0 	     , 0	   , 0    , 0    },
			{0			, 0			 , 0 	     , 0	   , 0    , 0    },
			{0			, 0			 , 0 	     , 0	   , 0    , 0    },
			{0			, 0			 , 0 	     , 0	   , 0    , 0    },
        }
    },
    //Tower east
    {
        190358,
        4,
        {
        	{4466.790039, 1960.420044, 459.144012, 1.151920, 192488, 192501},// Flag on tower
			{4475.350098, 1937.030029, 459.070007, -0.43633, 192488, 192501},// Flag on tower
			{4451.759766, 1928.099976, 459.075989, -2.00713, 192488, 192501},// Flag on tower
			{4442.990234, 1951.900024, 459.092987, 2.740160, 192488, 192501},// Flag on tower
			{0			, 0			 , 0 	     , 0	   , 0    , 0    },
			{0			, 0			 , 0 	     , 0	   , 0    , 0    },
		},
		5,
		{
			{4501.060059, 1990.280029, 431.157013, 1.029740, BATTLEFIELD_WG_NPC_GUARD_H, BATTLEFIELD_WG_NPC_GUARD_A},// Standing Guard
			{4463.830078, 2015.180054, 430.299988, 1.431170, BATTLEFIELD_WG_NPC_GUARD_H, BATTLEFIELD_WG_NPC_GUARD_A},// Standing Guard
			{4494.580078, 1943.760010, 435.627014, 6.195920, BATTLEFIELD_WG_NPC_GUARD_H, BATTLEFIELD_WG_NPC_GUARD_A},// Standing Guard
			{4450.149902, 1897.579956, 435.045013, 4.398230, BATTLEFIELD_WG_NPC_GUARD_H, BATTLEFIELD_WG_NPC_GUARD_A},// Standing Guard
			{4428.870117, 1906.869995, 432.648010, 3.996800, BATTLEFIELD_WG_NPC_GUARD_H, BATTLEFIELD_WG_NPC_GUARD_A},// Standing Guard
			{0			, 0			 , 0 	     , 0	   , 0    , 0    },
			{0			, 0			 , 0 	     , 0	   , 0    , 0    },
			{0			, 0			 , 0 	     , 0	   , 0    , 0    },
			{0			, 0			 , 0 	     , 0	   , 0    , 0    },
        },
        0,
        {
			{0			, 0			 , 0 	     , 0	   , 0    , 0    },
			{0			, 0			 , 0 	     , 0	   , 0    , 0    },
			{0			, 0			 , 0 	     , 0	   , 0    , 0    },
			{0			, 0			 , 0 	     , 0	   , 0    , 0    },
			{0			, 0			 , 0 	     , 0	   , 0    , 0    },
		},
    },
};


//*********************************************************
//*****************WorkShop Data & Element*****************
//*********************************************************

struct BfWGWorkShopDataBase
{
    uint32 entry;
    uint32 worldstate;
    uint32 type;
    uint32 nameid;
    BfWGObjectPosition CapturePoint;
    uint8 nbcreature;
    BfWGObjectPosition CreatureData[10];
    uint8 nbgob;
    BfWGObjectPosition GameObjectData[10];
};

#define WG_MAX_WORKSHOP  6
const BfWGWorkShopDataBase WGWorkShopDataBase[WG_MAX_WORKSHOP]=
{
    {192031, 3701, BATTLEFIELD_WG_WORKSHOP_NE,BATTLEFIELD_WG_TEXT_WORKSHOP_NAME_NE,
        { 4949.344238, 2432.585693, 320.176971, 1.386214, BATTLEFIELD_WG_GAMEOBJECT_FACTORY_BANNER_NE, BATTLEFIELD_WG_GAMEOBJECT_FACTORY_BANNER_NE},
        1,
        //creature
        {
            {4939.759766, 2389.060059, 326.153015, 3.263770, 30400, 30499},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0}
        },
        6,
        //gameobject
        {
            {4778.189,2438.060,345.644,-2.940,192280,192274},
            {5024.569,2532.750,344.023,-1.937,192280,192274},
            {4811.399,2441.899,358.207,-2.003,192435,192406},
            {4805.669,2407.479,358.191, 1.780,192435,192406},
            {5004.350,2486.360,358.449, 2.172,192435,192406},
            {4983.279,2503.090,358.177,-0.427,192435,192406},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0}
        }
    },

    {192030, 3700, BATTLEFIELD_WG_WORKSHOP_NW,BATTLEFIELD_WG_TEXT_WORKSHOP_NAME_NW,
        { 4948.524414, 3342.337891, 376.875366, 4.400566, BATTLEFIELD_WG_GAMEOBJECT_FACTORY_BANNER_NW, BATTLEFIELD_WG_GAMEOBJECT_FACTORY_BANNER_NW},
        1,
        //creature
        {
            {4964.890137, 3383.060059, 382.911011, 6.126110, 30400, 30499},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0}
        },
        4,
        //gameobject
        {
            {5006.339,3280.399,371.162, 2.225,192280,192274},
            {5041.609,3294.399,382.149,-1.631,192434,192406},
            {4857.970,3335.439,368.881,-2.945,192280,192274},
            {4855.629,3297.620,376.739,-3.132,192435,192406},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0}
        }
    },
    {192033, 3703, BATTLEFIELD_WG_WORKSHOP_SE,BATTLEFIELD_WG_TEXT_WORKSHOP_NAME_SE,
        {4398.076660, 2356.503662, 376.190491, 0.525406, BATTLEFIELD_WG_GAMEOBJECT_FACTORY_BANNER_SE, BATTLEFIELD_WG_GAMEOBJECT_FACTORY_BANNER_SE},
        9,
        //creature
        {
            {4417.919922, 2331.239990, 370.919006, 5.846850, BATTLEFIELD_WG_NPC_GUARD_H, BATTLEFIELD_WG_NPC_GUARD_A},
            {4418.609863, 2355.290039, 372.490997, 6.021390, BATTLEFIELD_WG_NPC_GUARD_H, BATTLEFIELD_WG_NPC_GUARD_A},
            {4391.669922, 2300.610107, 374.743011, 4.921830, BATTLEFIELD_WG_NPC_GUARD_H, BATTLEFIELD_WG_NPC_GUARD_A},
            {4349.120117, 2299.280029, 374.743011, 4.904380, BATTLEFIELD_WG_NPC_GUARD_H, BATTLEFIELD_WG_NPC_GUARD_A},
            {4333.549805, 2333.909912, 376.156006, 0.973007, BATTLEFIELD_WG_NPC_GUARD_H, BATTLEFIELD_WG_NPC_GUARD_A},
            {4413.430176, 2393.449951, 376.359985, 1.064650, BATTLEFIELD_WG_NPC_GUARD_H, BATTLEFIELD_WG_NPC_GUARD_A},
            {4388.129883, 2411.979980, 374.743011, 1.640610, BATTLEFIELD_WG_NPC_GUARD_H, BATTLEFIELD_WG_NPC_GUARD_A},
            {4349.540039, 2411.260010, 374.743011, 2.059490, BATTLEFIELD_WG_NPC_GUARD_H, BATTLEFIELD_WG_NPC_GUARD_A},
            {4357.669922, 2357.989990, 382.006989, 1.675520, 30400, 30499},
            {0,0,0,0,0,0}
        },
        2,
        {
        //gameobject
            {4417.250,2301.139,377.213, 0.026,192435,192406},
            {4417.939,2324.810,371.576, 3.080,192280,192274},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0}
        }
    },

    {192032, 3702, BATTLEFIELD_WG_WORKSHOP_SW,BATTLEFIELD_WG_TEXT_WORKSHOP_NAME_SW,
        {4390.776367, 3304.094482, 372.429077, 6.097023, BATTLEFIELD_WG_GAMEOBJECT_FACTORY_BANNER_SW, BATTLEFIELD_WG_GAMEOBJECT_FACTORY_BANNER_SW},
        9,
        //creature
        {
            {4425.290039, 3291.510010, 370.773987, 0.122173, BATTLEFIELD_WG_NPC_GUARD_H, BATTLEFIELD_WG_NPC_GUARD_A},
            {4424.609863, 3321.100098, 369.800995, 0.034907, BATTLEFIELD_WG_NPC_GUARD_H, BATTLEFIELD_WG_NPC_GUARD_A},
            {4392.399902, 3354.610107, 369.597992, 1.570800, BATTLEFIELD_WG_NPC_GUARD_H, BATTLEFIELD_WG_NPC_GUARD_A},
            {4370.979980, 3355.020020, 371.196991, 1.675520, BATTLEFIELD_WG_NPC_GUARD_H, BATTLEFIELD_WG_NPC_GUARD_A},
            {4394.660156, 3231.989990, 369.721985, 4.625120, BATTLEFIELD_WG_NPC_GUARD_H, BATTLEFIELD_WG_NPC_GUARD_A},
            {4366.979980, 3233.560059, 371.584991, 4.939280, BATTLEFIELD_WG_NPC_GUARD_H, BATTLEFIELD_WG_NPC_GUARD_A},
            {4337.029785, 3261.659912, 373.524994, 3.263770, BATTLEFIELD_WG_NPC_GUARD_H, BATTLEFIELD_WG_NPC_GUARD_A},
            {4323.779785, 3287.100098, 378.894989, 2.862340, BATTLEFIELD_WG_NPC_GUARD_H, BATTLEFIELD_WG_NPC_GUARD_A},
            {4354.149902, 3312.820068, 378.045990, 1.675520, 30400, 30499},
            {0,0,0,0,0,0}
        },
        3,
        //gameobject
        {
            {4438.299,3361.080,371.567,-0.017,192435,192406},
            {4448.169,3235.629,370.411,-1.562,192435,192406},
            {4424.149,3286.540,371.545, 3.124,192280,192274},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0}
        }
    },

    {192028, 3698, BATTLEFIELD_WG_WORKSHOP_KEEP_WEST,0,
        {0,0,0,0,0,0},
        1,
        //creature
        {
            {5392.910156, 2975.260010, 415.222992, 4.555310, 30400, 30499},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0}
        },
        //gameobject
        0,
        {
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0}
        }
    },

    {192029, 3699, BATTLEFIELD_WG_WORKSHOP_KEEP_EAST,0,
        {0,0,0,0,0,0},
        //creature
        1,
        {
            {5391.609863, 2707.719971, 415.050995, 4.555310, 30400, 30499},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0}
        },
        //gameobject
        0,
        {
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0},
            {0,0,0,0,0,0}
        }
    }
};





//*********************************


//********************************************************************
//*                Structs using for Building,Graveyard,Workshop         *
//********************************************************************

//Structure for different building witch can be destroy during battle
struct BfWGGameObjectBuilding
{
    BfWGGameObjectBuilding(BattlefieldWG* WG)
    {
        m_WG = WG;
        m_Team = 0;
        m_Build = NULL;
        m_Type = 0;
        m_WorldState = 0;
        m_State = 0;
        m_NameId = 0;

    }

    //Team witch control this point
    uint8 m_Team;

    // WG object
    BattlefieldWG* m_WG;

    //Linked gameobject
    GameObject* m_Build; 

    //eWGGameObjectBuildingType
    uint32 m_Type;

    //WorldState
    uint32 m_WorldState;

    //eWGGameObjectState
    uint32 m_State;
    
    //Name id for warning text
    uint32 m_NameId;

	//GameObject associate
	GameObjectSet m_GameObjectList[2];

	//Creature associate
	CreatureSet m_CreatureBottomList[2];
	CreatureSet m_CreatureTopList[2];

    void Rebuild()
    {
        switch(m_Type)
        {
        case BATTLEFIELD_WG_OBJECTTYPE_KEEP_TOWER:
        case BATTLEFIELD_WG_OBJECTTYPE_DOOR_LAST:
        case BATTLEFIELD_WG_OBJECTTYPE_DOOR:
        case BATTLEFIELD_WG_OBJECTTYPE_WALL:
            m_Team=m_WG->GetDefenderTeam();//Object of Keep has defender faction
            break;
        case BATTLEFIELD_WG_OBJECTTYPE_TOWER:
            m_Team=m_WG->GetAttackerTeam();//Tower in south are for attacker
            break;
        default: 
            m_Team=TEAM_NEUTRAL;
            break;
        }

        //Rebuild gameobject
        m_Build->Rebuild();
        //Updating worldstate
        m_State=BATTLEFIELD_WG_OBJECTSTATE_ALLIANCE_INTACT-(m_Team*3);
        m_WG->SendUpdateWorldState(m_WorldState,m_State);
        m_Build->SetUInt32Value(GAMEOBJECT_FACTION,WintergraspFaction[m_Team]);
    }

    //Called when associate gameobject is damaged
    void Damaged()
    {
        //Updating worldstate
        m_State=BATTLEFIELD_WG_OBJECTSTATE_ALLIANCE_DAMAGE-(m_Team*3);
        m_WG->SendUpdateWorldState(m_WorldState,m_State);
        //Send warning message
        if(m_NameId)
            m_WG->SendWarningToAllInZone(BATTLEFIELD_WG_TEXT_TOWER_DAMAGE,sObjectMgr.GetTrinityStringForDBCLocale(m_NameId));

        for (CreatureSet::const_iterator itr = m_CreatureTopList[m_WG->GetAttackerTeam()].begin(); itr != m_CreatureTopList[m_WG->GetAttackerTeam()].end(); ++itr)
            m_WG->HideNpc(*itr);

        if(m_Type==BATTLEFIELD_WG_OBJECTTYPE_KEEP_TOWER)
            m_WG->AddDamagedTower(m_WG->GetDefenderTeam());
        else if (m_Type==BATTLEFIELD_WG_OBJECTTYPE_TOWER)
            m_WG->AddDamagedTower(m_WG->GetAttackerTeam());
    }
    
    //Called when associate gameobject is destroy
    void Destroyed()
    {
        //Updating worldstate
        m_State=BATTLEFIELD_WG_OBJECTSTATE_ALLIANCE_DESTROY-(m_Team*3);
        m_WG->SendUpdateWorldState(m_WorldState,m_State);
        //Warning 
        if(m_NameId)
            m_WG->SendWarningToAllInZone(BATTLEFIELD_WG_TEXT_TOWER_DESTROY,sObjectMgr.GetTrinityStringForDBCLocale(m_NameId));
        switch(m_Type)
        {
        //If destroy tower, inform WG script of it (using for reward calculation and event with south towers)
        case BATTLEFIELD_WG_OBJECTTYPE_TOWER:
        case BATTLEFIELD_WG_OBJECTTYPE_KEEP_TOWER:
            m_WG->AddBrokenTower(TeamId(m_Team));
            break;
        case BATTLEFIELD_WG_OBJECTTYPE_DOOR_LAST:
            m_WG->AllowToClickOnOrb(true);
            if(m_WG->GetRelic())
                m_WG->GetRelic()->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_IN_USE);
            else
                sLog.outError("BATTLEFIELD: WG: Relic cant be clickable");
            break;
        }
    }

    void Init(GameObject* go,uint32 type,uint32 worldstate,uint32 nameid)
    {
        //GameObject associate to object
        m_Build = go;
        //Type of building (WALL/TOWER/DOOR)
        m_Type = type;
        //WorldState for client (icon on map)
        m_WorldState = worldstate;
        //NameId for Warning text
        m_NameId = nameid;
        switch(m_Type)
        {
        case BATTLEFIELD_WG_OBJECTTYPE_KEEP_TOWER:
        case BATTLEFIELD_WG_OBJECTTYPE_DOOR_LAST:
        case BATTLEFIELD_WG_OBJECTTYPE_DOOR:
        case BATTLEFIELD_WG_OBJECTTYPE_WALL:
            m_Team=m_WG->GetDefenderTeam();//Object of Keep has defender faction
            break;
        case BATTLEFIELD_WG_OBJECTTYPE_TOWER:
            m_Team=m_WG->GetAttackerTeam();//Tower in south are for attacker
            break;
        default: 
            m_Team=TEAM_NEUTRAL;
            break;
        }
        m_State=sWorld.getWorldState(m_WorldState);
        switch (m_State)
        {
            case BATTLEFIELD_WG_OBJECTSTATE_ALLIANCE_INTACT:
            case BATTLEFIELD_WG_OBJECTSTATE_HORDE_INTACT:
                if(m_Build)
                    m_Build->Rebuild();
                break;
            case BATTLEFIELD_WG_OBJECTSTATE_ALLIANCE_DESTROY:
            case BATTLEFIELD_WG_OBJECTSTATE_HORDE_DESTROY:
                if(m_Build){
                    m_Build->RemoveFlag(GAMEOBJECT_FLAGS, GO_FLAG_DAMAGED);
                    m_Build->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_DESTROYED);
                    m_Build->SetUInt32Value(GAMEOBJECT_DISPLAYID, m_Build->GetGOInfo()->building.destroyedDisplayId);
                }
                break;
            case BATTLEFIELD_WG_OBJECTSTATE_ALLIANCE_DAMAGE:
            case BATTLEFIELD_WG_OBJECTSTATE_HORDE_DAMAGE:
                if(m_Build){
                    m_Build->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_DAMAGED);
                    m_Build->SetUInt32Value(GAMEOBJECT_DISPLAYID, m_Build->GetGOInfo()->building.damagedDisplayId);
                }
                break;
        }

	    
        int32 towerid = -1;
	    switch(go->GetEntry())
	    {
		case 190356:
			towerid=0;
			break;
		case 190357:
			towerid=1;
			break;
		case 190358:
			towerid=2;
			break;
	    }
	    if(towerid>=0)
	    {
            //Spawn associate gameobject
            for(uint8 i = 0; i < AttackTowers[towerid].nbObject; i++)
            {
        	    BfWGObjectPosition gob = AttackTowers[towerid].GameObject[i];
        	    if(GameObject* go = m_WG->SpawnGameObject(gob.entryh, gob.x, gob.y, gob.z, gob.o))
        		    m_GameObjectList[TEAM_HORDE].insert(go);
        	    if(GameObject* go = m_WG->SpawnGameObject(gob.entrya, gob.x, gob.y, gob.z, gob.o))
        		    m_GameObjectList[TEAM_ALLIANCE].insert(go);
            }

            //Spawn associate npc bottom
            for(uint8 i = 0; i < AttackTowers[towerid].nbCreatureBottom; i++)
            {
        	    BfWGObjectPosition crea = AttackTowers[towerid].CreatureBottom[i];
        	    if(Creature* creature = m_WG->SpawnCreature(crea.entryh, crea.x, crea.y, crea.z, crea.o, TEAM_HORDE))
            	    m_CreatureBottomList[TEAM_HORDE].insert(creature);
	            if(Creature* creature = m_WG->SpawnCreature(crea.entrya, crea.x, crea.y, crea.z, crea.o, TEAM_ALLIANCE))
		            m_CreatureBottomList[TEAM_ALLIANCE].insert(creature);
            }
            //Spawn associate npc top
            for(uint8 i = 0; i < AttackTowers[towerid].nbCreatureTop; i++)
            {
        	    BfWGObjectPosition crea = AttackTowers[towerid].CreatureTop[i];
        	    if(Creature* creature = m_WG->SpawnCreature(crea.entryh, crea.x, crea.y, crea.z, crea.o, TEAM_HORDE))
            	    m_CreatureTopList[TEAM_HORDE].insert(creature);
	            if(Creature* creature = m_WG->SpawnCreature(crea.entrya, crea.x, crea.y, crea.z, crea.o, TEAM_ALLIANCE))
		            m_CreatureTopList[TEAM_ALLIANCE].insert(creature);
            }
            UpdateCreatureAndGo();
        }

        
    }

    void UpdateCreatureAndGo()
    {
    	for (CreatureSet::const_iterator itr = m_CreatureTopList[m_WG->GetDefenderTeam()].begin(); itr != m_CreatureTopList[m_WG->GetDefenderTeam()].end(); ++itr)
          	m_WG->HideNpc((*itr));
        
        for (CreatureSet::const_iterator itr = m_CreatureTopList[m_WG->GetAttackerTeam()].begin(); itr != m_CreatureTopList[m_WG->GetAttackerTeam()].end(); ++itr)
            m_WG->ShowNpc((*itr),true);

        for (CreatureSet::const_iterator itr = m_CreatureBottomList[m_WG->GetDefenderTeam()].begin(); itr != m_CreatureBottomList[m_WG->GetDefenderTeam()].end(); ++itr)
            m_WG->HideNpc((*itr));
        
        for (CreatureSet::const_iterator itr = m_CreatureBottomList[m_WG->GetAttackerTeam()].begin(); itr != m_CreatureBottomList[m_WG->GetAttackerTeam()].end(); ++itr)
            m_WG->ShowNpc((*itr),true);

        for (GameObjectSet::const_iterator itr = m_GameObjectList[m_WG->GetDefenderTeam()].begin(); itr != m_GameObjectList[m_WG->GetDefenderTeam()].end(); ++itr)
        	(*itr)->SetRespawnTime(RESPAWN_ONE_DAY);

        for (GameObjectSet::const_iterator itr = m_GameObjectList[m_WG->GetAttackerTeam()].begin(); itr != m_GameObjectList[m_WG->GetAttackerTeam()].end(); ++itr)
        	(*itr)->SetRespawnTime(RESPAWN_IMMEDIATELY);
    }

    void Save()
    {
        sWorld.setWorldState(m_WorldState,m_State);
    }
};

//Structure for the 6 workshop
struct BfWGWorkShopData
{
    BattlefieldWG* m_WG; //Object du joug
    GameObject* m_Build;
    uint32 m_Type;
    uint32 m_State;//For worldstate
    uint32 m_WorldState;
    uint32 m_TeamControl;//Team witch control the workshop
    CreatureSet m_CreatureOnPoint[2];//Contain all Creature associate to this point
    GameObjectSet m_GameObjectOnPoint[2];//Contain all Gameobject associate to this point
    uint32 m_NameId;//Id of trinity_string witch contain name of this node, using for alert message

    BfWGWorkShopData(BattlefieldWG* WG)
    {
        m_WG = WG;
        m_Build = NULL;
        m_Type = 0;
        m_State = 0;
        m_WorldState = 0;
        m_TeamControl = 0;
        m_NameId = 0;
    }

    //Spawning associate creature and store them
    void AddCreature(BfWGObjectPosition obj)
    {
        if(Creature* creature = m_WG->SpawnCreature(obj.entryh, obj.x, obj.y, obj.z, obj.o, TEAM_HORDE))
        	m_CreatureOnPoint[TEAM_HORDE].insert(creature);

        if(Creature* creature = m_WG->SpawnCreature(obj.entrya, obj.x, obj.y, obj.z, obj.o, TEAM_ALLIANCE))
        	m_CreatureOnPoint[TEAM_ALLIANCE].insert(creature);

    }
    //Spawning Associate gameobject and store them
    void AddGameObject(BfWGObjectPosition obj)
    {
        if(GameObject* gameobject = m_WG->SpawnGameObject(obj.entryh, obj.x, obj.y, obj.z, obj.o))
            m_GameObjectOnPoint[TEAM_HORDE].insert(gameobject);
        if(GameObject* gameobject = m_WG->SpawnGameObject(obj.entrya, obj.x, obj.y, obj.z, obj.o))
            m_GameObjectOnPoint[TEAM_ALLIANCE].insert(gameobject);
    }
    
    //Init method, setup variable
    void Init(uint32 worldstate, uint32 type,uint32 nameid)
    {
        m_WorldState = worldstate;
        m_Type = type;
        m_NameId = nameid;
    }

    //Called on change faction in CapturePoint class
    void ChangeControl(uint8 team,bool init/* for first call in setup*/)
    {
        switch (team)
        {
            case BATTLEFIELD_WG_TEAM_NEUTRAL:
            {
                //Send warning message to all player for inform a faction attack a workshop
                m_WG->SendWarningToAllInZone(BATTLEFIELD_WG_TEXT_WORKSHOP_ATTACK,sObjectMgr.GetTrinityStringForDBCLocale(m_NameId),
                    sObjectMgr.GetTrinityStringForDBCLocale(m_TeamControl?BATTLEFIELD_WG_TEXT_ALLIANCE:BATTLEFIELD_WG_TEXT_HORDE));
                break;
            }
            case BATTLEFIELD_WG_TEAM_ALLIANCE:
            {
                //Show Alliance creature
                for(CreatureSet::const_iterator itr = m_CreatureOnPoint[TEAM_ALLIANCE].begin(); itr != m_CreatureOnPoint[TEAM_ALLIANCE].end(); ++itr)
                    m_WG->ShowNpc((*itr),(*itr)->GetEntry()!=30499);

                //Hide Horde creature
                for(CreatureSet::const_iterator itr = m_CreatureOnPoint[TEAM_HORDE].begin(); itr != m_CreatureOnPoint[TEAM_HORDE].end(); ++itr)
                    m_WG->HideNpc((*itr));

                //Show Alliance gameobject
                for(GameObjectSet::const_iterator itr = m_GameObjectOnPoint[TEAM_ALLIANCE].begin(); itr != m_GameObjectOnPoint[TEAM_ALLIANCE].end(); ++itr)
                    (*itr)->SetRespawnTime(RESPAWN_IMMEDIATELY);

                //Hide Horde gameobject
                for(GameObjectSet::const_iterator itr = m_GameObjectOnPoint[TEAM_HORDE].begin(); itr != m_GameObjectOnPoint[TEAM_HORDE].end(); ++itr)
                    (*itr)->SetRespawnTime(RESPAWN_ONE_DAY);


                //Updating worldstate
                m_State=BATTLEFIELD_WG_OBJECTSTATE_ALLIANCE_INTACT;
                m_WG->SendUpdateWorldState(m_WorldState,m_State);

                //Update maxnumber of vehicle 
                m_WG->SetData(BATTLEFIELD_WG_DATA_MAX_VEHICLE_A, m_WG->GetData(BATTLEFIELD_WG_DATA_MAX_VEHICLE_A)+4);
                if(!init){
                    m_WG->SetData(BATTLEFIELD_WG_DATA_MAX_VEHICLE_H, m_WG->GetData(BATTLEFIELD_WG_DATA_MAX_VEHICLE_H)-4);
                    m_WG->UpdateVehicleCountWG();
                }

                //Warning message
                if(!init)
                    m_WG->SendWarningToAllInZone(BATTLEFIELD_WG_TEXT_WORKSHOP_TAKEN,sObjectMgr.GetTrinityStringForDBCLocale(m_NameId),
                    sObjectMgr.GetTrinityStringForDBCLocale(BATTLEFIELD_WG_TEXT_ALLIANCE));
                
                //Found associate graveyard and update it
                if(m_Type < BATTLEFIELD_WG_WORKSHOP_KEEP_WEST)
                    if(m_WG && m_WG->GetGraveYardById(m_Type))
                        m_WG->GetGraveYardById(m_Type)->ChangeControl(TEAM_ALLIANCE);
                              
                m_TeamControl=team;
                break;
            }
            case BATTLEFIELD_WG_TEAM_HORDE:
            {
                //Show Horde creature
                for(CreatureSet::const_iterator itr = m_CreatureOnPoint[TEAM_HORDE].begin(); itr != m_CreatureOnPoint[TEAM_HORDE].end(); ++itr)
                    m_WG->ShowNpc((*itr),(*itr)->GetEntry()!=30400);
                
                //Hide Alliance creature
                for(CreatureSet::const_iterator itr = m_CreatureOnPoint[TEAM_ALLIANCE].begin(); itr != m_CreatureOnPoint[TEAM_ALLIANCE].end(); ++itr)
                    m_WG->HideNpc((*itr));

                //Hide Alliance gameobject
                for(GameObjectSet::const_iterator itr = m_GameObjectOnPoint[TEAM_ALLIANCE].begin(); itr != m_GameObjectOnPoint[TEAM_ALLIANCE].end(); ++itr)
                    (*itr)->SetRespawnTime(RESPAWN_ONE_DAY);

                //Show Horde gameobject
                for(GameObjectSet::const_iterator itr = m_GameObjectOnPoint[TEAM_HORDE].begin(); itr != m_GameObjectOnPoint[TEAM_HORDE].end(); ++itr)
                    (*itr)->SetRespawnTime(RESPAWN_IMMEDIATELY);

                //Update worlstate
                m_State=BATTLEFIELD_WG_OBJECTSTATE_HORDE_INTACT;
                m_WG->SendUpdateWorldState(m_WorldState,m_State);

                //Update maxnumber of vehicle 
                m_WG->SetData(BATTLEFIELD_WG_DATA_MAX_VEHICLE_H, m_WG->GetData(BATTLEFIELD_WG_DATA_MAX_VEHICLE_H)+4);
                if(!init){
                    m_WG->SetData(BATTLEFIELD_WG_DATA_MAX_VEHICLE_A, m_WG->GetData(BATTLEFIELD_WG_DATA_MAX_VEHICLE_A)-4);
                    m_WG->UpdateVehicleCountWG();
                }
                
                //Warning message
                if(!init)
                    m_WG->SendWarningToAllInZone(BATTLEFIELD_WG_TEXT_WORKSHOP_TAKEN,sObjectMgr.GetTrinityStringForDBCLocale(m_NameId),
                        sObjectMgr.GetTrinityStringForDBCLocale(BATTLEFIELD_WG_TEXT_HORDE));

                //Update graveyard control
                if(m_Type < BATTLEFIELD_WG_WORKSHOP_KEEP_WEST)
                    if(m_WG && m_WG->GetGraveYardById(m_Type))
                        m_WG->GetGraveYardById(m_Type)->ChangeControl(TEAM_HORDE);

                m_TeamControl=team;
                break;
            }
        }
        
    }

    void UpdateGraveYard()
    {
        if(m_Type < BATTLEFIELD_WG_WORKSHOP_KEEP_WEST)
            m_WG->GetGraveYardById(m_Type)->ChangeControl(TeamId(m_TeamControl));
    }
    void Save()
    {
        sWorld.setWorldState(m_WorldState,m_State);
    }
};
#endif
