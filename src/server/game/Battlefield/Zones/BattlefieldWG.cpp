#include "BattlefieldWG.h"
#include "SpellAuras.h"
bool BattlefieldWG::SetupBattlefield()
{
    m_TypeId = BATTLEFIELD_WG;    //View enum BattlefieldTypes
    m_BattleId = BATTLEFIELD_BATTLEID_WG;
    m_ZoneId = 4197; // Wintergrasp
    m_MapId = 571; // Norfendre
    m_MaxPlayer = 100;
    m_MinPlayer = 20;
    m_MinLevel = 77;
    m_BattleTime = 30*60*1000; // Time of battle (in ms)
    m_NoWarBattleTime = (2*60*60*1000) + (30*60*1000);//Time between to battle (in ms)
    m_TimeForAcceptInvite = 20;//in second
    m_StartGroupingTimer = 15*60*1000; //in ms
    m_StartGrouping=false;
    m_tenacityStack=0;
    KickPosition.Relocate(5728.117,2714.346,697.733,0) ;
    KickPosition.m_mapId=m_MapId;
    RegisterZone(m_ZoneId);
    m_Data32.resize(BATTLEFIELD_WG_DATA_MAX);
    m_saveTimer = 60000;
  
    // Init GraveYards
    SetGraveyardNumber(BATTLEFIELD_WG_GY_MAX);

    //Load from db
    QueryResult resultDB = CharacterDatabase.Query("SELECT Timer,WarTime,DefenderTeam FROM battlefield WHERE id = 1");
    if (resultDB)
      {
        Field *fields = resultDB->Fetch();
        m_Timer = fields[0].GetUInt32();
        m_WarTime = fields[1].GetBool();
        m_DefenderTeam = (TeamId) fields[2].GetInt8();
	if(m_WarTime)
	{
	  m_WarTime = false;
	  m_Timer = 10 * 60 * 1000;
	}
      }
    else
      {
	m_Timer = m_NoWarBattleTime ;
	m_WarTime = 0 ;
	m_DefenderTeam = TEAM_ALLIANCE ;
	CharacterDatabase.PExecute("INSERT INTO battlefield (id, Timer, Wartime, DefenderTeam) VALUES ('1', '%u', '%u', '%u')",m_Timer,m_WarTime,m_DefenderTeam);
      }
    for(int i=0;i<BATTLEFIELD_WG_GY_MAX;i++)
    {
        BfGraveYardWG* gy = new BfGraveYardWG(this);
        if(WGGraveYard[i].startcontrol==TEAM_NEUTRAL)
        {
            //In no war time Gy is control by defender
            gy->Init(31841,31842,WGGraveYard[i].x,WGGraveYard[i].y,WGGraveYard[i].z,WGGraveYard[i].o,m_DefenderTeam,WGGraveYard[i].gyid);
        }
        else
            gy->Init(31841,31842,WGGraveYard[i].x,WGGraveYard[i].y,WGGraveYard[i].z,WGGraveYard[i].o,WGGraveYard[i].startcontrol,WGGraveYard[i].gyid);
        gy->SetTextId(WGGraveYard[i].textid);
        m_GraveYardList[i]=gy;
    }


    //Pop des gameobject et creature du workshop
    for(int i=0;i<WG_MAX_WORKSHOP;i++)
    {
        BfWGWorkShopData* ws=new BfWGWorkShopData(this);//Create new object
        //Init:setup variable
        ws->Init(WGWorkShopDataBase[i].worldstate,WGWorkShopDataBase[i].type,WGWorkShopDataBase[i].nameid);
        //Spawn associate npc on this point (Guard/Engineer)
        for (int c=0;c<WGWorkShopDataBase[i].nbcreature;c++)
            ws->AddCreature(WGWorkShopDataBase[i].CreatureData[c]);
        //Spawn associate gameobject on this point (Horde/Alliance flags)
        for (int g=0;g<WGWorkShopDataBase[i].nbgob;g++)
            ws->AddGameObject(WGWorkShopDataBase[i].GameObjectData[g]);

        //Create PvPCapturePoint
        if( WGWorkShopDataBase[i].type < BATTLEFIELD_WG_WORKSHOP_KEEP_WEST )
        {
            ws->ChangeControl(GetAttackerTeam(),true);//Update control of this point 
            //Create Object
            BfCapturePointWG *workshop = new BfCapturePointWG(this,GetAttackerTeam());

            //Spawn gameobject associate (see in OnGameObjectCreate, of OutdoorPvP for see association)
            workshop->SetCapturePointData(WGWorkShopDataBase[i].CapturePoint.entryh, 571,
                WGWorkShopDataBase[i].CapturePoint.x,
                WGWorkShopDataBase[i].CapturePoint.y,
                WGWorkShopDataBase[i].CapturePoint.z,
                0);
            workshop->LinkToWorkShop(ws);//Link our point to the capture point (for faction changement)
            AddCapturePoint(workshop);//Add this capture point to list for update this (view in Update() of OutdoorPvP)
        }
        else{
            ws->ChangeControl(GetDefenderTeam(),true);//Update control of this point (Keep workshop= to deffender team)
        }
        WorkShopList.insert(ws);
    }

    //Spawning npc in keep
    for(int i=0;i<WG_MAX_KEEP_NPC;i++)
    {
        //Horde npc
        if(Creature* creature = SpawnCreature(WGKeepNPC[i].entryh, WGKeepNPC[i].x, WGKeepNPC[i].y, WGKeepNPC[i].z, WGKeepNPC[i].o, TEAM_HORDE))
            KeepCreature[TEAM_HORDE].insert(creature);
        //Alliance npc
        if(Creature* creature = SpawnCreature(WGKeepNPC[i].entrya, WGKeepNPC[i].x, WGKeepNPC[i].y, WGKeepNPC[i].z, WGKeepNPC[i].o, TEAM_ALLIANCE))
            KeepCreature[TEAM_ALLIANCE].insert(creature);
    }
    
    //Hide keep npc
    for(CreatureSet::const_iterator itr = KeepCreature[GetAttackerTeam()].begin(); itr != KeepCreature[GetAttackerTeam()].end(); ++itr)
    {
        (*itr)->SetVisibility(VISIBILITY_OFF);
        (*itr)->SetReactState(REACT_PASSIVE);
        (*itr)->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE | UNIT_FLAG_NOT_SELECTABLE);
    }

    for(int i=0;i<WG_MAX_TURRET;i++)
    {
        if(Creature* creature = SpawnCreature(28366, WGTurret[i].x, WGTurret[i].y, WGTurret[i].z, WGTurret[i].o, 0))
        {
            CanonList.insert(creature);
            creature->DisappearAndDie();
            creature->SetVisibility(VISIBILITY_OFF);
            creature->SetRespawnDelay(30*MINUTE*1000);
        }
    }

    //Spawning Buiding
    for(int i=0;i<WG_MAX_OBJ;i++)
    {
        GameObject* go=SpawnGameObject(WGGameObjectBuillding[i].entry, WGGameObjectBuillding[i].x, WGGameObjectBuillding[i].y, WGGameObjectBuillding[i].z, WGGameObjectBuillding[i].o);
        BfWGGameObjectBuilding* b=new BfWGGameObjectBuilding(this);
        b->Init(go,WGGameObjectBuillding[i].type,WGGameObjectBuillding[i].WorldState,WGGameObjectBuillding[i].nameid);
        BuildingsInZone.insert(b);
    }

    //Spawning portal defender
    for(int i=0;i<WG_MAX_TELEPORTER;i++)
    {
        GameObject* go=SpawnGameObject(WGPortalDefenderData[i].entry,WGPortalDefenderData[i].x, WGPortalDefenderData[i].y, WGPortalDefenderData[i].z, WGPortalDefenderData[i].o);
        DefenderPortalList.insert(go);
        go->SetUInt32Value(GAMEOBJECT_FACTION,WintergraspFaction[GetDefenderTeam()]);
    }

    for(int i=0;i<WG_KEEPGAMEOBJECT_MAX;i++)
     {
         if(GameObject* go=SpawnGameObject(WGKeepGameObject[i].entryh,WGKeepGameObject[i].x, WGKeepGameObject[i].y, WGKeepGameObject[i].z, WGKeepGameObject[i].o))
         {
        	 go->SetRespawnTime(GetDefenderTeam()?RESPAWN_ONE_DAY:RESPAWN_IMMEDIATELY);
        	 m_KeepGameObject[1].insert(go);
         }
         if(GameObject* go=SpawnGameObject(WGKeepGameObject[i].entrya,WGKeepGameObject[i].x, WGKeepGameObject[i].y, WGKeepGameObject[i].z, WGKeepGameObject[i].o))
         {
        	 go->SetRespawnTime(GetDefenderTeam()?RESPAWN_IMMEDIATELY:RESPAWN_ONE_DAY);
        	 m_KeepGameObject[0].insert(go);
         }
     }
     for(GameObjectSet::const_iterator itr = m_KeepGameObject[GetDefenderTeam()].begin(); itr != m_KeepGameObject[GetDefenderTeam()].end(); ++itr)
        (*itr)->SetRespawnTime(RESPAWN_IMMEDIATELY);
     
    for(GameObjectSet::const_iterator itr = m_KeepGameObject[GetAttackerTeam()].begin(); itr != m_KeepGameObject[GetAttackerTeam()].end(); ++itr)
        (*itr)->SetRespawnTime(RESPAWN_ONE_DAY);

     return true;
}

bool BattlefieldWG::Update(uint32 diff)
{
    bool m_return = Battlefield::Update(diff);

    if (m_saveTimer <= diff)
    {
        CharacterDatabase.PExecute("UPDATE battlefield SET Timer = '%u', WarTime = '%u', DefenderTeam = '%u' WHERE id = '%u'",m_Timer,m_WarTime,m_DefenderTeam,1);
        m_saveTimer = 60 * IN_MILLISECONDS;
    } else m_saveTimer -= diff;

        for (GuidSet::const_iterator itr = m_PlayersIsSpellImu.begin(); itr != m_PlayersIsSpellImu.end(); ++itr)
            if (Player* plr = sObjectMgr.GetPlayer((*itr))) {
                if(plr->HasAura(SPELL_SPIRITUAL_IMMUNITY))
                {
                    const WorldSafeLocsEntry *graveyard = GetClosestGraveYard(plr);
                    if(graveyard)
                    {
                        if(plr->GetDistance2d(graveyard->x, graveyard->y) > 10.0f)
			{
                            plr->RemoveAurasDueToSpell(SPELL_SPIRITUAL_IMMUNITY);
			    m_PlayersIsSpellImu.erase(plr->GetGUID());
			}
                    }
                }
            }
    
    return m_return;
}

void BattlefieldWG::AddPlayerToResurrectQueue(uint64 npc_guid, uint64 player_guid)
{
    Battlefield::AddPlayerToResurrectQueue(npc_guid, player_guid);
    if(IsWarTime())
    {
        if(Player *plr = sObjectMgr.GetPlayer(player_guid))
        {
            if(!plr->HasAura(SPELL_SPIRITUAL_IMMUNITY))
            {
                plr->CastSpell(plr, SPELL_SPIRITUAL_IMMUNITY, true);
                m_PlayersIsSpellImu.insert(plr->GetGUID());
            }
        }
    }
}

void BattlefieldWG::OnBattleStart()
{
    // Pop titan relic
    m_relic = SpawnGameObject(BATTLEFIELD_WG_GAMEOBJECT_TITAN_RELIC, 5440.0f, 2840.8f, 430.43f, 0);
    if(m_relic)
    {
        // Update faction of relic, only attacker can click on
        m_relic->SetUInt32Value(GAMEOBJECT_FACTION,WintergraspFaction[GetAttackerTeam()]);
        // Set in use (not allow to click on before last door is broken)
        m_relic->SetFlag(GAMEOBJECT_FLAGS, GO_FLAG_IN_USE);
    }
    else
        sLog.outError("Impossible de pop la relique");

  
    // Update tower visibility and update faction
    for(CreatureSet::const_iterator itr = CanonList.begin(); itr != CanonList.end(); ++itr)
    {
        (*itr)->SetVisibility(VISIBILITY_ON);
        (*itr)->setFaction(WintergraspFaction[GetDefenderTeam()]);
        (*itr)->Respawn(true);
    }
    
    // Rebuild all wall
    for(GameObjectBuilding::const_iterator itr = BuildingsInZone.begin(); itr != BuildingsInZone.end(); ++itr)
        (*itr)->Rebuild();
        
    m_Data32[BATTLEFIELD_WG_DATA_BROKEN_TOWER_ATT]=0;
    m_Data32[BATTLEFIELD_WG_DATA_BROKEN_TOWER_DEF]=0;
    m_Data32[BATTLEFIELD_WG_DATA_DAMAGED_TOWER_ATT]=0;
    m_Data32[BATTLEFIELD_WG_DATA_DAMAGED_TOWER_DEF]=0;
    
    for (uint32 team = 0; team < 2; ++team)
        for (PlayerSet::const_iterator p_itr = m_players[team].begin(); p_itr != m_players[team].end(); ++p_itr)
        {
            //Kick player in orb room, TODO: offline player ?
            float x,y,z;
            (*p_itr)->GetPosition(x,y,z);
            if(5500>x && x>5392 && y<2880  && y>2800 && z<480)
                (*p_itr)->TeleportTo(571,5349.8686,2838.481,409.240,0.046328);
            SendInitWorldStatesTo(*p_itr);
        }

    // Update graveyard (in no war time all graveyard is to deffender, in war time, depend of base)
    for(WorkShop::const_iterator itr = WorkShopList.begin(); itr != WorkShopList.end(); ++itr)
    {
        (*itr)->UpdateGraveYard();
    }

    //Warnin message
    SendWarningToAllInZone(BATTLEFIELD_WG_TEXT_START);

}

void BattlefieldWG::OnBattleEnd(bool endbytimer)
{
    // Remove relic
    if(m_relic)
        m_relic->RemoveFromWorld();
    m_relic=NULL;
    
    // Remove turret
    for(CreatureSet::const_iterator itr = CanonList.begin(); itr != CanonList.end(); ++itr)
        HideNpc(*itr);
        
    if(!endbytimer){
        //Change all npc in keep
        for(CreatureSet::const_iterator itr = KeepCreature[GetAttackerTeam()].begin(); itr != KeepCreature[GetAttackerTeam()].end(); ++itr)
            HideNpc(*itr);
        
        for(CreatureSet::const_iterator itr = KeepCreature[GetDefenderTeam()].begin(); itr != KeepCreature[GetDefenderTeam()].end(); ++itr)
            ShowNpc(*itr,true);
    }

    // Update all graveyard, control is to defender when no wartime
    for(int i=0;i<BATTLEFIELD_WG_GY_HORDE;i++)
    {
        if(GetGraveYardById(i))
        {
            GetGraveYardById(i)->ChangeControl(GetDefenderTeam());
        }
    }

    for(GameObjectSet::const_iterator itr = m_KeepGameObject[GetDefenderTeam()].begin(); itr != m_KeepGameObject[GetDefenderTeam()].end(); ++itr)
        (*itr)->SetRespawnTime(RESPAWN_IMMEDIATELY);

    for(GameObjectSet::const_iterator itr = m_KeepGameObject[GetAttackerTeam()].begin(); itr != m_KeepGameObject[GetAttackerTeam()].end(); ++itr)
        (*itr)->SetRespawnTime(RESPAWN_ONE_DAY);

    //Update portal defender faction
    for(GameObjectSet::const_iterator itr = DefenderPortalList.begin(); itr != DefenderPortalList.end(); ++itr)
        (*itr)->SetUInt32Value(GAMEOBJECT_FACTION,WintergraspFaction[GetDefenderTeam()]);

    //Saving data
    for(GameObjectBuilding::const_iterator itr = BuildingsInZone.begin(); itr != BuildingsInZone.end(); ++itr)
        (*itr)->Save();
    for(WorkShop::const_iterator itr = WorkShopList.begin(); itr != WorkShopList.end(); ++itr)
        (*itr)->Save();

    uint32 WinerHonor = 0;
    uint32 LooserHonor = 0;

    if(!endbytimer)
    {
        WinerHonor =  3000 + 400 * m_Data32[BATTLEFIELD_WG_DATA_BROKEN_TOWER_ATT] + 100 * m_Data32[BATTLEFIELD_WG_DATA_DAMAGED_TOWER_ATT];
        LooserHonor = 1000 + 400 * m_Data32[BATTLEFIELD_WG_DATA_BROKEN_TOWER_DEF] + 100 * m_Data32[BATTLEFIELD_WG_DATA_DAMAGED_TOWER_DEF];
    }
    else
    {
        WinerHonor =  3000 + 400 * m_Data32[BATTLEFIELD_WG_DATA_BROKEN_TOWER_DEF] + 100 * m_Data32[BATTLEFIELD_WG_DATA_DAMAGED_TOWER_DEF];
        LooserHonor = 1000 + 400 * m_Data32[BATTLEFIELD_WG_DATA_BROKEN_TOWER_ATT] + 100 * m_Data32[BATTLEFIELD_WG_DATA_DAMAGED_TOWER_ATT];
    }

    for (GuidSet::const_iterator itr = m_PlayersInWar[GetDefenderTeam()].begin(); itr != m_PlayersInWar[GetDefenderTeam()].end(); ++itr)
        if (Player* plr=sObjectMgr.GetPlayer((*itr)))
        {
            plr->AddAura(58045,plr);
            if(plr->HasAura(SPELL_LIEUTENANT))
            {
            	 plr->RewardHonor(NULL, 1, WinerHonor);
             	 RewardMarkOfHonor(plr, 3);
            }
            else if(plr->HasAura(SPELL_CORPORAL))
            {
                plr->RewardHonor(NULL, 1, WinerHonor);
                RewardMarkOfHonor(plr, 2);
            }
        }


    for (GuidSet::const_iterator itr = m_PlayersInWar[GetAttackerTeam()].begin(); itr != m_PlayersInWar[GetAttackerTeam()].end(); ++itr)
        if (Player* plr=sObjectMgr.GetPlayer((*itr)))
        {
            if(plr->HasAura(SPELL_LIEUTENANT))
            {
            	 plr->RewardHonor(NULL, 1, LooserHonor);
             	 RewardMarkOfHonor(plr, 1);
            }
            else if(plr->HasAura(SPELL_CORPORAL))
            {
            	 plr->RewardHonor(NULL, 1, LooserHonor);
            	 RewardMarkOfHonor(plr, 1);
            }
            // Wintergrasp Victory
            DoCompleteOrIncrementAchievement(ACHIEVEMENTS_WIN_WG, plr);
            // Ployez sous notre joug
            if (GetTimer() <= 10000 && !endbytimer)
            DoCompleteOrIncrementAchievement(ACHIEVEMENTS_WIN_WG_TIMER_10, plr);
        }

    for(int team=0;team<2;team++)
        for (GuidSet::const_iterator itr = m_PlayersInWar[team].begin(); itr != m_PlayersInWar[team].end(); ++itr)
            if (Player* plr=sObjectMgr.GetPlayer((*itr)))
            {
                plr->RemoveAura(SPELL_TOWER_CONTROL);
                plr->RemoveAurasDueToSpell(SPELL_RECRUIT);
                plr->RemoveAurasDueToSpell(SPELL_CORPORAL);
                plr->RemoveAurasDueToSpell(SPELL_LIEUTENANT);
                if(plr->GetVehicle())
                    plr->GetVehicle()->RemoveAllPassengers();
            }

    for (uint32 team = 0; team < 2; ++team)
        for (PlayerSet::const_iterator p_itr = m_players[team].begin(); p_itr != m_players[team].end(); ++p_itr)
            SendInitWorldStatesTo(*p_itr);

    for (uint32 team = 0; team < 2; ++team)
    {
        for(CreatureSet::const_iterator itr = m_vehicles[team].begin(); itr != m_vehicles[team].end(); ++itr)
        {
            if(Creature *pCreature = *itr)
                HideNpc(pCreature);
        }
        m_vehicles[team].clear();
    }
    
    m_PlayersInWar[0].clear();
    m_PlayersInWar[1].clear();

    if(!endbytimer)
    {
        SendWarningToAllInZone(BATTLEFIELD_WG_TEXT_WIN_KEEP,
            sObjectMgr.GetTrinityStringForDBCLocale((GetDefenderTeam() == TEAM_ALLIANCE)
            ? BATTLEFIELD_WG_TEXT_ALLIANCE
            : BATTLEFIELD_WG_TEXT_HORDE));
    }
    else
    {
        SendWarningToAllInZone(BATTLEFIELD_WG_TEXT_DEFEND_KEEP,
            sObjectMgr.GetTrinityStringForDBCLocale((GetDefenderTeam() == TEAM_ALLIANCE)
            ? BATTLEFIELD_WG_TEXT_ALLIANCE
            : BATTLEFIELD_WG_TEXT_HORDE));
    }
}

//*****************************************************
//*******************Reward System*********************
//*****************************************************
void BattlefieldWG::DoCompleteOrIncrementAchievement(uint32 achievement, Player * player, uint8 incrementNumber)
{
    AchievementEntry const* AE = GetAchievementStore()->LookupEntry(achievement);

    if(player->GetAchievementMgr().HasAchieved(AE))
      return;
    
    switch(achievement)
    {
      case ACHIEVEMENTS_WIN_WG_100 :
      {
	//player->GetAchievementMgr().UpdateAchievementCriteria();
      }
      default:
      {
        if (player)
           player->CompletedAchievement(AE);
      }
      break;
    }

}

void BattlefieldWG::RewardMarkOfHonor(Player *plr, uint32 count)
{
    // 'Inactive' this aura prevents the player from gaining honor points and battleground tokens
    if (count == 0)
        return;
 
    ItemPosCountVec dest;
    uint32 no_space_count = 0;
    uint8 msg = plr->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, WG_MARK_OF_HONOR, count, &no_space_count);

    if (msg == EQUIP_ERR_ITEM_NOT_FOUND)
    {
        return;
    }

    if (msg != EQUIP_ERR_OK) // convert to possible store amount
        count -= no_space_count;

    if (count != 0 && !dest.empty()) // can add some
        if (Item* item = plr->StoreNewItem(dest, WG_MARK_OF_HONOR, true, 0))
            plr->SendNewItem(item, count, true, false);
}

void BattlefieldWG::OnStartGrouping()
{
	//Warn
    SendWarningToAllInZone(BATTLEFIELD_WG_TEXT_WILL_START);
}

void BattlefieldWG::OnCreatureCreate(Creature *creature, bool add)
{
    switch(creature->GetEntry())
    {
        case 28312:
        case 32627:
        case 27881:
        case 28094:
        {
            uint8 team;
             if (creature->getFaction() == WintergraspFaction[TEAM_ALLIANCE])
                team = TEAM_ALLIANCE;
            else if (creature->getFaction() == WintergraspFaction[TEAM_HORDE])
                team = TEAM_HORDE;
            else
                return;

            if(add)
            {
                if(team == TEAM_HORDE )
                {
                	if(GetData(BATTLEFIELD_WG_DATA_VEHICLE_H) < GetData(BATTLEFIELD_WG_DATA_MAX_VEHICLE_H))
                	{
                		m_vehicles[team].insert(creature);
				m_Data32[BATTLEFIELD_WG_DATA_VEHICLE_H]++;
                		UpdateVehicleCountWG();
                	}
                	else
                	{
                		creature->setDeathState(DEAD);
                		creature->SetRespawnTime(RESPAWN_ONE_DAY);
                		return;
                	}
                }
                else
                {
                        if(GetData(BATTLEFIELD_WG_DATA_VEHICLE_A) < GetData(BATTLEFIELD_WG_DATA_MAX_VEHICLE_A) )
                	{
                    		m_vehicles[team].insert(creature);
				m_Data32[BATTLEFIELD_WG_DATA_VEHICLE_A]++;
                    		UpdateVehicleCountWG();
                	}
                	else
                	{
                    		creature->setDeathState(DEAD);
                    		creature->SetRespawnTime(RESPAWN_ONE_DAY);
                    		return;
                	}
                }
            }
            else
            {
                m_vehicles[team].erase(creature);
		if(team == TEAM_HORDE )
		  m_Data32[BATTLEFIELD_WG_DATA_VEHICLE_H]--;
		else
		  m_Data32[BATTLEFIELD_WG_DATA_VEHICLE_A]--;
                UpdateVehicleCountWG();
            }
            break;
        }
    }


}


void BattlefieldWG::HandleKill(Player *killer, Unit *victim)
{
    if(killer==victim)
        return;

    if(IsWarTime())
    {
        for (GuidSet::const_iterator p_itr = m_PlayersInWar[killer->GetTeamId()].begin(); p_itr != m_PlayersInWar[killer->GetTeamId()].end(); ++p_itr)
        {
            if(Player* plr=sObjectAccessor.FindPlayer(*p_itr))
                if(plr->GetDistance2d(killer)<40)
                    PromotePlayer(plr);
        }
    }
    //TODO:Recent PvP activity worldstate
}

//Update rank for player
void BattlefieldWG::PromotePlayer(Player *killer)
{

    //Updating rank of player
    if (Aura * aur = killer->GetAura(SPELL_RECRUIT))
    {
        if (aur->GetStackAmount() >= 5)//7 or more TODO:
        {
            killer->RemoveAura(SPELL_RECRUIT);
            killer->CastSpell(killer, SPELL_CORPORAL, true);
            SendWarningToPlayer(killer,BATTLEFIELD_WG_TEXT_FIRSTRANK);
        }
        else
            killer->CastSpell(killer, SPELL_RECRUIT, true);
    }
    else if (Aura * aur = killer->GetAura(SPELL_CORPORAL))
    {
        if (aur->GetStackAmount() >= 5)//7 or more TODO:
        {
            killer->RemoveAura(SPELL_CORPORAL);
            killer->CastSpell(killer, SPELL_LIEUTENANT, true);
            SendWarningToPlayer(killer,BATTLEFIELD_WG_TEXT_SECONDRANK);
        }
        else
            killer->CastSpell(killer, SPELL_CORPORAL, true);
    }
}

void BattlefieldWG::OnPlayerJoinWar(Player* plr)
{
    plr->RemoveAurasDueToSpell(SPELL_RECRUIT);
    plr->RemoveAurasDueToSpell(SPELL_CORPORAL);
    plr->RemoveAurasDueToSpell(SPELL_LIEUTENANT);
    plr->RemoveAurasDueToSpell(SPELL_TOWER_CONTROL);
    plr->RemoveAurasDueToSpell(SPELL_SPIRITUAL_IMMUNITY);
    plr->RemoveAurasDueToSpell(SPELL_TENACITY);
    plr->RemoveAurasDueToSpell(58045);

    plr->CastSpell(plr, SPELL_RECRUIT, true);
    
    if(plr->GetZoneId()!=m_ZoneId){
        if(plr->GetTeamId()==GetDefenderTeam())
        {
            plr->TeleportTo(571,5345,2842,410,3.14);
        }
        else
        {
            if(plr->GetTeamId()==TEAM_HORDE)
                plr->TeleportTo(571,5025.857422,3674.628906,362.737122,4.135169);
            else
                plr->TeleportTo(571,5101.284,2186.564,373.549,3.812);
        }   
    }

    UpdateTenacity();

    if(plr->GetTeamId()==GetAttackerTeam())
    {
        if(3-m_Data32[BATTLEFIELD_WG_DATA_BROKEN_TOWER_ATT]>0)
            plr->SetAuraStack(SPELL_TOWER_CONTROL,plr,3-m_Data32[BATTLEFIELD_WG_DATA_BROKEN_TOWER_ATT]);
    }
    else
    {
        if(m_Data32[BATTLEFIELD_WG_DATA_BROKEN_TOWER_ATT]>0)
            plr->SetAuraStack(SPELL_TOWER_CONTROL,plr,m_Data32[BATTLEFIELD_WG_DATA_BROKEN_TOWER_ATT]);
    }
    SendInitWorldStatesTo(plr);
}

void BattlefieldWG::OnPlayerLeaveWar(Player* plr)
{
    //Remove all aura from WG //TODO: false we can go out of this zone on retail and keep Rank buff, remove on end of WG)
    if (!plr->GetSession()->PlayerLogout())
    {
        if (plr->GetVehicle()) //Remove vehicle of player if he go out.
            plr->GetVehicle()->Dismiss();
        plr->RemoveAurasDueToSpell(SPELL_RECRUIT);
        plr->RemoveAurasDueToSpell(SPELL_CORPORAL);
        plr->RemoveAurasDueToSpell(SPELL_LIEUTENANT);
        plr->RemoveAurasDueToSpell(SPELL_TOWER_CONTROL);
        plr->RemoveAurasDueToSpell(SPELL_SPIRITUAL_IMMUNITY);
        plr->RemoveAurasDueToSpell(SPELL_TENACITY);
        plr->RemoveAurasDueToSpell(58045);
        plr->RemoveAurasDueToSpell(58730);
        plr->RemoveAurasDueToSpell(SPELL_TOWER_CONTROL);
    }
}

void BattlefieldWG::OnPlayerLeaveZone(Player* plr)
{
    plr->RemoveAurasDueToSpell(58045);
}

void BattlefieldWG::OnPlayerEnterZone(Player* plr)
{
    if(!m_WarTime && plr->GetTeamId()==GetDefenderTeam())
        plr->AddAura(58045,plr);

    //Send worldstate to player
    SendInitWorldStatesTo(plr);
}
//Method sending worldsate to player
WorldPacket BattlefieldWG::BuildInitWorldStates()
{
     WorldPacket data(SMSG_INIT_WORLD_STATES, (4+4+4+2+(BuildingsInZone.size()*8)+(WorkShopList.size()*8)));

    data << uint32(m_MapId);
    data << uint32(m_ZoneId);
    data << uint32(0);
    data << uint16(4+2+4+BuildingsInZone.size()+WorkShopList.size());

    data << uint32(3803) << uint32(GetAttackerTeam());
    data << uint32(3802) << uint32(GetDefenderTeam());
    data << uint32(3801) << uint32(IsWarTime() ? 0 : 1);
    data << uint32(3710) << uint32(IsWarTime() ? 1 : 0);

    for (uint32 i = 0; i < 2; ++i)
        data << ClockWorldState[i] << uint32(time(NULL)+(m_Timer / 1000));

    data << uint32(3490) << uint32(GetData(BATTLEFIELD_WG_DATA_VEHICLE_H));
    data << uint32(3491) << GetData(BATTLEFIELD_WG_DATA_MAX_VEHICLE_H);
    data << uint32(3680) << uint32(GetData(BATTLEFIELD_WG_DATA_VEHICLE_A));
    data << uint32(3681) << GetData(BATTLEFIELD_WG_DATA_MAX_VEHICLE_A);

    for(GameObjectBuilding::const_iterator itr = BuildingsInZone.begin(); itr != BuildingsInZone.end(); ++itr)
    {
        data << (*itr)->m_WorldState << (*itr)->m_State;
    }
    for(WorkShop::const_iterator itr = WorkShopList.begin(); itr != WorkShopList.end(); ++itr)
    {
        data << (*itr)->m_WorldState << (*itr)->m_State;
    }
    return data;
}
void BattlefieldWG::SendInitWorldStatesTo(Player *player)
{
   WorldPacket data= BuildInitWorldStates();
   player->GetSession()->SendPacket(&data);
}
void BattlefieldWG::SendInitWorldStatesToAll()
{
   WorldPacket data= BuildInitWorldStates();
   for(int team=0;team<2;team++)
       for (PlayerSet::iterator itr = m_players[team].begin(); itr != m_players[team].end(); ++itr)
           (*itr)->GetSession()->SendPacket(&data);
}
void BattlefieldWG::AddBrokenTower(TeamId team)
{
    //Destroy an attack tower
    if(team==GetAttackerTeam())
    {
        m_Data32[BATTLEFIELD_WG_DATA_DAMAGED_TOWER_ATT]--;
        m_Data32[BATTLEFIELD_WG_DATA_BROKEN_TOWER_ATT]++;
        //Remove buff stack
        for (GuidSet::const_iterator itr = m_PlayersInWar[GetAttackerTeam()].begin(); itr != m_PlayersInWar[GetAttackerTeam()].end(); ++itr)
            if (Player* plr=sObjectMgr.GetPlayer((*itr)))
                plr->RemoveAuraFromStack(SPELL_TOWER_CONTROL);
        
        //Add buff stack
         for (GuidSet::const_iterator itr = m_PlayersInWar[GetDefenderTeam()].begin(); itr != m_PlayersInWar[GetDefenderTeam()].end(); ++itr)
            if (Player* plr=sObjectMgr.GetPlayer((*itr)))
	     {
                 plr->CastSpell(plr,SPELL_TOWER_CONTROL,true);
		 DoCompleteOrIncrementAchievement(ACHIEVEMENTS_WG_TOWER_DESTROY, plr);
	     }

         if(m_Data32[BATTLEFIELD_WG_DATA_BROKEN_TOWER_ATT]==3){
             if(int32(m_Timer-600000)<0)
             {
                 m_Timer=0;
             }
             else
             {
                 m_Timer-=600000;
             }
             SendInitWorldStatesToAll();
         }
    }
    else
    {
        m_Data32[BATTLEFIELD_WG_DATA_DAMAGED_TOWER_DEF]--;
        m_Data32[BATTLEFIELD_WG_DATA_BROKEN_TOWER_DEF]++;
    }
}
void BattlefieldWG::ProcessEvent(GameObject *obj, uint32 eventId)
{
    if (!obj)
        return;

    //On click on titan relic
    if (obj->GetEntry() == BATTLEFIELD_WG_GAMEOBJECT_TITAN_RELIC && IsWarTime())
    {
        if(m_bCanClickOnOrb)
     		EndBattle(false);
     	else
     		m_relic->SetRespawnTime(RESPAWN_IMMEDIATELY);
    }
    //if destroy or damage event, search the wall/tower and update worldstate/send warning message
    for(GameObjectBuilding::const_iterator itr = BuildingsInZone.begin(); itr != BuildingsInZone.end(); ++itr)
    {
        if(obj->GetEntry()==(*itr)->m_Build->GetEntry()){
            if((*itr)->m_Build->GetGOInfo()->building.damagedEvent==eventId)
                (*itr)->Damaged();        
            
            if((*itr)->m_Build->GetGOInfo()->building.destroyedEvent==eventId)
                (*itr)->Destroyed();    

            break;
        }
    }
}
void BattlefieldWG::AddDamagedTower(TeamId team)
{
    //Destroy an attack tower
    if(team==GetAttackerTeam())
    {
        m_Data32[BATTLEFIELD_WG_DATA_DAMAGED_TOWER_ATT]++;
        //Remove a stacck
    
    //Add a stack
    }
    else
    {
        m_Data32[BATTLEFIELD_WG_DATA_DAMAGED_TOWER_DEF]++;
    }
}
// Update vehicle count worldstate to player
void BattlefieldWG::UpdateVehicleCountWG()
{
    SendUpdateWorldState(3490,GetData(BATTLEFIELD_WG_DATA_VEHICLE_H));
    SendUpdateWorldState(3491,GetData(BATTLEFIELD_WG_DATA_MAX_VEHICLE_H));
    SendUpdateWorldState(3680,GetData(BATTLEFIELD_WG_DATA_VEHICLE_A));
    SendUpdateWorldState(3681,GetData(BATTLEFIELD_WG_DATA_MAX_VEHICLE_A));
}
void BattlefieldWG::UpdateTenacity()
{
    if (!IsWarTime())
        return;

    TeamId team = TEAM_NEUTRAL;
    uint32 allianceNum = m_PlayersInWar[TEAM_ALLIANCE].size();
    uint32 hordeNum = m_PlayersInWar[TEAM_HORDE].size();
    int32 newStack = 0;

    if (allianceNum && hordeNum)
    {
       if (allianceNum < hordeNum)
            newStack = int32((float(hordeNum) / float(allianceNum) - 1)*4); // positive, should cast on alliance
        else if (allianceNum > hordeNum)
            newStack = int32((1 - float(allianceNum) / float(hordeNum))*4); // negative, should cast on horde
    }

    if (newStack == int32(m_tenacityStack))
        return;

    if (m_tenacityStack > 0 && newStack <= 0) // old buff was on alliance
        team = TEAM_ALLIANCE;
    else if (newStack >= 0) // old buff was on horde
        team = TEAM_HORDE;

    m_tenacityStack = newStack;
    // Remove old buff
    if (team != TEAM_NEUTRAL)
    {
        for (PlayerSet::const_iterator itr = m_players[team].begin(); itr != m_players[team].end(); ++itr)
            if ((*itr)->getLevel() > 76)
                (*itr)->RemoveAurasDueToSpell(SPELL_TENACITY);

        for (CreatureSet::const_iterator itr = m_vehicles[team].begin(); itr != m_vehicles[team].end(); ++itr)
            (*itr)->RemoveAurasDueToSpell(SPELL_TENACITY_VEHICLE);
   }

    // Apply new buff
    if (newStack)
    {
        team = newStack > 0 ? TEAM_ALLIANCE : TEAM_HORDE;

        if (newStack < 0)
           newStack = -newStack;
        if (newStack > 20)
            newStack = 20;

        uint32 buff_honnor = SPELL_GREATEST_HONOR;
        buff_honnor = (newStack < 15) ? SPELL_GREATER_HONOR : buff_honnor;
        buff_honnor = (newStack < 10) ? SPELL_GREAT_HONOR : buff_honnor;
        buff_honnor = (newStack < 5) ? 0 : buff_honnor;

        for (GuidSet::const_iterator itr = m_PlayersInWar[team].begin(); itr != m_PlayersInWar[team].end(); ++itr)
            if (Player* plr=sObjectMgr.GetPlayer((*itr)))
                plr->SetAuraStack(SPELL_TENACITY, plr, newStack);
        for (CreatureSet::const_iterator itr = m_vehicles[team].begin(); itr != m_vehicles[team].end(); ++itr)
            (*itr)->SetAuraStack(SPELL_TENACITY_VEHICLE, (*itr), newStack);

        if(buff_honnor != 0)
        {
            for (GuidSet::const_iterator itr = m_PlayersInWar[team].begin(); itr != m_PlayersInWar[team].end(); ++itr)
                if (Player* plr=sObjectMgr.GetPlayer((*itr)))
                    plr->AddAura(buff_honnor, plr);
            for (CreatureSet::const_iterator itr = m_vehicles[team].begin(); itr != m_vehicles[team].end(); ++itr)
                (*itr)->AddAura(buff_honnor, (*itr));
        }
    }
}
void BfCapturePointWG::ChangeTeam(TeamId /*oldTeam*/)
{
    m_WorkShop->ChangeControl(m_team,false);
}

BfCapturePointWG::BfCapturePointWG(BattlefieldWG *bf,TeamId control) : BfCapturePoint(bf)
{
    m_Bf=bf;
    m_team=control;
}


BfGraveYardWG::BfGraveYardWG(BattlefieldWG* bf) : BfGraveYard(bf)
{
    m_Bf=bf;
}
