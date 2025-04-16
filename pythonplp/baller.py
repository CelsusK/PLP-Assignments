class Footballteam:
    def __init__(self, manager, teamname, teamID):
        self.manager = manager
        self.teamname = teamname
        self.__teamID = teamID

class Barcelona(Footballteam):
    def __init__(self, manager, teamname, teamID, stadium):
        super().__init__(manager, teamname, teamID)
        self.stadium = stadium

    def __str__(self):
        return f"Manager: {self.manager}, Team Name: {self.teamname}, Team ID: {self.__teamID}, Stadium: {self.stadium}"
team = Barcelona("Xavi", "FC Barcelona", 1, "Camp Nou")
print(team)
