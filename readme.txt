## Fonctions Serveur

- gServerCalculateExpForLevel(level) - Calcule l'XP nécessaire pour un niveau donné
- gServerResetAllLevels() - Réinitialise tous les joueurs au niveau 1 avec 0 XP
- gServerGetPlayerCount() - Retourne le nombre de joueurs dans la base de données
- gServerFindHighestLevelPlayer() - Retourne le SteamID et niveau du joueur le plus élevé
- gServerSyncPlayerData(ply) - Synchronise les données du joueur vers son client

- ply:gServerSetLevel(level) - Définit le niveau d'un joueur
- ply:gServerGetLevel() - Retourne le niveau actuel d'un joueur
- ply:gServerSetExp(exp) - Définit l'expérience d'un joueur
- ply:gServerGetExp() - Retourne l'expérience actuelle d'un joueur
- ply:gServerAddExp(amount) - Ajoute de l'expérience et gère les montées de niveau

## Fonctions Client

- gClientCalculateExpForLevel(level) - Calcule l'XP nécessaire pour un niveau donné (côté client)

- ply:gClientGetLevel() - Retourne le niveau du joueur local
- ply:gClientGetExp() - Retourne l'expérience du joueur local
- ply:gClientGetNextLevelExp() - Retourne l'XP nécessaire pour le prochain niveau
- ply:gClientGetExpProgress() - Retourne le pourcentage de progression vers le niveau suivant (0-100)

⚠️ ATTENTION : Glibs obligatoire ⚠️
https://github.com/GPymousss/GMOD-GLIBS

Sinon FF15