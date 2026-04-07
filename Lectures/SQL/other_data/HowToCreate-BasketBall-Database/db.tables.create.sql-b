-- Data from http://www.basketballgeek.com/data/
-- 2008-2009 NBA season

IF OBJECT_ID('conference') IS NOT NULL
DROP TABLE conference
GO

-- Championship conferences
CREATE TABLE conference
(
	-- Unique ID
	id char(1) NOT NULL,
	-- Conference name
	name varchar(50) NOT NULL,

	CONSTRAINT PK_conference PRIMARY KEY (id)
)

GO

IF OBJECT_ID('division') IS NOT NULL
DROP TABLE division
GO

-- Championship divisions
CREATE TABLE division
(
	-- Unique ID
	id char(2) NOT NULL,
	-- Conference ID
	conference_id char(1) NOT NULL,
	-- Division name
	name varchar(50) NOT NULL,

	CONSTRAINT PK_division PRIMARY KEY (id),
	CONSTRAINT FK_division_conference FOREIGN KEY (conference_id) REFERENCES conference(id)
)

GO

IF OBJECT_ID('team') IS NOT NULL
DROP TABLE team
GO

-- Teams
CREATE TABLE team
(
	-- Unique ID
	id char(3) NOT NULL,
	-- Division ID
	division_id char(2) NOT NULL,
	-- Team name
	name varchar(50) NOT NULL,

	CONSTRAINT PK_team PRIMARY KEY (id),
	CONSTRAINT FK_team_division FOREIGN KEY (division_id) REFERENCES division(id)
)

GO

IF OBJECT_ID('person') IS NOT NULL
DROP TABLE person
GO

-- Real persons who play in the league
CREATE TABLE person
(
	-- Unique ID
	[id] int IDENTITY(1, 1),
	-- Name
	[name] varchar(50) NOT NULL,
	-- Age
	[age] int NOT NULL,

	CONSTRAINT PK_person PRIMARY KEY (id)
)

GO

IF OBJECT_ID('position') IS NOT NULL
DROP TABLE position
GO

-- Play positions
CREATE TABLE position
(
	-- Position ID
	id varchar(2) NOT NULL,
	-- Position description
	description varchar(50) NOT NULL,

	CONSTRAINT PK_position PRIMARY KEY (id)
)

IF OBJECT_ID('player') IS NOT NULL
DROP TABLE player
GO

-- Players, i.e. persons associated with teams
CREATE TABLE player
(
	-- Unique ID
	[id] int IDENTITY(1, 1),
	-- Team the player plays for
	[team_id] char(3) NOT NULL,
	-- Jersey number
	[number] varchar(2) NOT NULL,
	-- Play position
	[position_id] varchar(2) NOT NULL,
	-- Person ID
	[person_id] int NOT NULL,
	
	CONSTRAINT PK_player PRIMARY KEY (id),
	CONSTRAINT FK_player_team FOREIGN KEY (team_id) REFERENCES team(id),
	CONSTRAINT FK_player_position FOREIGN KEY (position_id) REFERENCES position(id),
	CONSTRAINT FK_player_person FOREIGN KEY (person_id) REFERENCES person(id)
)

GO

---------------------------------------------------------------

IF OBJECT_ID('game') IS NOT NULL
DROP TABLE game
GO

-- Games during the season, does not include play-off
CREATE TABLE game
(
	-- Unique game identifier
	[id] int IDENTITY(1, 1),
	-- Game date
	[date] date NOT NULL,
	-- Home team ID
	[home_team_id] char(3) NOT NULL,
	-- Away team ID
	[away_team_id] char(3) NOT NULL,

	CONSTRAINT PK_game PRIMARY KEY (id),
	CONSTRAINT FK_game_team_1 FOREIGN KEY (home_team_id) REFERENCES team(id),
	CONSTRAINT FK_game_team_2 FOREIGN KEY (away_team_id) REFERENCES team(id),
)

GO

---------------------------------------------------------------

IF OBJECT_ID('start') IS NOT NULL
DROP TABLE start
GO

-- Starter players for each period of every game
CREATE TABLE [start]
(
	-- Game ID
	[game_id] int NOT NULL,
	-- Game period
	[period] tinyint NOT NULL,
	-- Ordinal position (not game position) of starter
	[position] tinyint NOT NULL,
	-- Team ID
	[team_id] char(3) NOT NULL,
	-- Player ID
	[player_id] int NOT NULL,

	CONSTRAINT PK_start PRIMARY KEY (game_id, period, team_id, position),
	CONSTRAINT FK_start_game FOREIGN KEY (game_id) REFERENCES game(id),
	CONSTRAINT FK_start_player FOREIGN KEY (player_id) REFERENCES player(id),
	CONSTRAINT FK_start_team FOREIGN KEY (team_id) REFERENCES team(id),
)

GO

---------------------------------------------------------------

IF OBJECT_ID('event') IS NOT NULL
DROP TABLE event
GO

-- Game events by period and time
CREATE TABLE [event]
(
	-- Game ID
	[game_id] int NOT NULL,
	-- Event counter, starts with one for each game (but not period)
	[cntr] int NOT NULL,
	-- Game period
	[period] tinyint NOT NULL,
	-- Game time remaining, starts from 12:00 or 5:00 for each period
	[time] time NOT NULL,
	-- Event type
	[type] varchar(10) NOT NULL,
		/*
		ejection
		foul
		free throw
		jump ball
		rebound
		shot
		sub
		timeout
		turnover
		violation
		*/

	CONSTRAINT PK_event PRIMARY KEY (game_id, cntr),
	CONSTRAINT FK_event_game FOREIGN KEY (game_id) REFERENCES game(id),
)

GO

---------------------------------------------------------------

IF OBJECT_ID('ejection_reason') IS NOT NULL
DROP TABLE [ejection_reason]
GO

-- Ejection reason
CREATE TABLE [ejection_reason]
(
	-- Reason ID
	id tinyint IDENTITY(1,1),
	-- Description
	description varchar(50) NOT NULL,

	CONSTRAINT PK_ejection_reason PRIMARY KEY (id)
)

GO

IF OBJECT_ID('ejection') IS NOT NULL
DROP TABLE [ejection]
GO

-- Ejection event
CREATE TABLE [ejection]
(
	-- Game ID
	[game_id] int NOT NULL,
	-- Event counter
	[cntr] int NOT NULL,
	-- Ejection reason
	[reason] tinyint NOT NULL,
	-- Player team ID
	[team_id] char(3) NOT NULL,
	-- Player ID
	[player_id] int NULL,

	CONSTRAINT PK_ejection PRIMARY KEY (game_id, cntr),
	CONSTRAINT FK_ejection_reason FOREIGN KEY (reason) REFERENCES ejection_reason(id),
	CONSTRAINT FK_ejection_team FOREIGN KEY (team_id) REFERENCES team(id),
	CONSTRAINT FK_ejection_player FOREIGN KEY (player_id) REFERENCES player(id)
)

GO

---------------------------------------------------------------

IF OBJECT_ID('foul_type') IS NOT NULL
DROP TABLE [foul_type]
GO

-- Foul type
CREATE TABLE [foul_type]
(
	-- Type ID
	id tinyint IDENTITY(1,1),
	-- Description
	description varchar(50) NOT NULL,

	CONSTRAINT PK_foul_type PRIMARY KEY (id)
)

GO

IF OBJECT_ID('foul') IS NOT NULL
DROP TABLE [foul]
GO

-- Foul events
CREATE TABLE [foul]
(
	-- Game ID
	[game_id] int NOT NULL,
	-- Event counter
	[cntr] int NOT NULL,
	-- Foul type ID
	[type] tinyint NOT NULL,
	-- Player team
	[team_id] char(3) NOT NULL,
	-- Player ID, if NULL, foul is against team or coach
	[player_id] int NULL,
	-- Opponent player
	[opponent_id] int NULL,

	CONSTRAINT PK_foul PRIMARY KEY (game_id, cntr),
	CONSTRAINT FK_foul_event FOREIGN KEY (game_id, cntr) REFERENCES event(game_id, cntr),
	CONSTRAINT FK_foul_type FOREIGN KEY (type) REFERENCES foul_type(id),
	CONSTRAINT FK_foul_team FOREIGN KEY (team_id) REFERENCES team(id),
	CONSTRAINT FK_foul_player FOREIGN KEY (player_id) REFERENCES player(id),
	CONSTRAINT FK_foul_opponent FOREIGN KEY (opponent_id) REFERENCES player(id)
)

GO

---------------------------------------------------------------

IF OBJECT_ID('jumpball') IS NOT NULL
DROP TABLE jumpball
GO

-- Jump ball events, usually at start of period
CREATE TABLE jumpball
(
	-- Game ID
	[game_id] int NOT NULL,
	-- Event counter
	[cntr] int NOT NULL,
	-- Team possessing ball
	[team_id] char(3) NULL,
	-- Player possessing ball
	[player_id] int NULL,
	-- Home team player jumping for ball
	[home_player_id] int NOT NULL,
	-- Away team player jumping for ball
	[away_player_id] int NOT NULL,

	CONSTRAINT PK_jumpball PRIMARY KEY (game_id, cntr),
	CONSTRAINT FK_jumpball_event FOREIGN KEY (game_id, cntr) REFERENCES event(game_id, cntr),
	CONSTRAINT FK_jumpball_team FOREIGN KEY (team_id) REFERENCES team(id),
	CONSTRAINT FK_jumpball_player FOREIGN KEY (player_id) REFERENCES player(id),
	CONSTRAINT FK_jumpball_home_player FOREIGN KEY (home_player_id) REFERENCES player(id),
	CONSTRAINT FK_jumpball_away_player FOREIGN KEY (home_player_id) REFERENCES player(id)
)

GO

---------------------------------------------------------------

IF OBJECT_ID('rebound_type') IS NOT NULL
DROP TABLE [rebound_type]
GO

-- Rebound types
CREATE TABLE [rebound_type]
(
	-- Rebound type ID
	id tinyint IDENTITY(1,1),
	-- Description
	description varchar(50) NOT NULL,

	CONSTRAINT PK_rebound_type PRIMARY KEY (id)
)

GO

IF OBJECT_ID('rebound') IS NOT NULL
DROP TABLE rebound
GO

-- Rebound events
CREATE TABLE rebound
(
	-- Game ID
	[game_id] int NOT NULL,
	-- Event counter
	[cntr] int NOT NULL,
	-- Rebound type ID
	[type] tinyint NOT NULL,
	-- Team of player retreiving the ball
	[team_id] char(3) NULL,
	-- Player retreiving the ball
	[player_id] int NULL,
	
	CONSTRAINT PK_rebound PRIMARY KEY (game_id, cntr),
	CONSTRAINT FK_rebound_event FOREIGN KEY (game_id, cntr) REFERENCES event(game_id, cntr),
	CONSTRAINT FK_rebound_type FOREIGN KEY (type) REFERENCES rebound_type(id),
	CONSTRAINT FK_rebound_team FOREIGN KEY (team_id) REFERENCES team(id),
	CONSTRAINT FK_rebound_player FOREIGN KEY (player_id) REFERENCES player(id)
)

GO

---------------------------------------------------------------

IF OBJECT_ID('point') IS NOT NULL
DROP TABLE point
GO

-- Points scored
CREATE TABLE [point]
(
	-- Game ID
	[game_id] int NOT NULL,
	-- Event counter
	[cntr] int NOT NULL,
	-- Points scored (1, 2 or 3)
	[points] tinyint NULL,

	CONSTRAINT PK_point PRIMARY KEY (game_id, cntr),
	CONSTRAINT FK_point_event FOREIGN KEY (game_id, cntr) REFERENCES event(game_id, cntr)
)

GO

---------------------------------------------------------------

IF OBJECT_ID('shot_type') IS NOT NULL
DROP TABLE [shot_type]
GO

-- Shot types
CREATE TABLE [shot_type]
(
	-- Type ID
	id tinyint IDENTITY(1,1),
	-- Description
	description varchar(50) NOT NULL,

	CONSTRAINT PK_shot_type PRIMARY KEY (id)
)

GO

IF OBJECT_ID('shot') IS NOT NULL
DROP TABLE shot
GO

-- Attempted shots
-- Succeded only if corresponding key present in 'point' table, otherwise missed.
-- If you are standing behind the offensive team’s hoop then the 
-- X axis runs from left to right and the Y axis runs from bottom to top. 
-- The center of the hoop is located at (25, 5.25).
CREATE TABLE [shot]
(
	-- Game ID
	[game_id] int NOT NULL,
	-- Event counter
	[cntr] int NOT NULL,
	-- Shot type
	[type] tinyint NOT NULL,
	-- Team attempting shot
	[team_id] char(3) NOT NULL,
	-- Player attempting shot
	[player_id] int NOT NULL,
	-- Player assisting (same team)
	[assist_player_id] int NULL,
	-- Player blocking (other team)
	[block_player_id] int NULL,
	-- X location of shot attempt
	[x] int NULL,
	-- Y location of shot attempt
	[y] int NULL,

	CONSTRAINT PK_shot PRIMARY KEY (game_id, cntr),
	CONSTRAINT FK_shot_event FOREIGN KEY (game_id, cntr) REFERENCES event(game_id, cntr),
	CONSTRAINT FK_shot_type FOREIGN KEY (type) REFERENCES shot_type(id),
	CONSTRAINT FK_shot_team FOREIGN KEY (team_id) REFERENCES team(id),
	CONSTRAINT FK_shot_player_1 FOREIGN KEY (player_id) REFERENCES player(id),
	CONSTRAINT FK_shot_player_2 FOREIGN KEY (assist_player_id) REFERENCES player(id),
	CONSTRAINT FK_shot_player_3 FOREIGN KEY (block_player_id) REFERENCES player(id)
)

GO

---------------------------------------------------------------

IF OBJECT_ID('freethrow_reason') IS NOT NULL
DROP TABLE [freethrow_reason]
GO

-- Free throw reasons
CREATE TABLE [freethrow_reason]
(
	-- Reason ID
	id tinyint IDENTITY(1,1),
	-- Description
	description varchar(50) NOT NULL,

	CONSTRAINT PK_freethrow_reason PRIMARY KEY (id)
)

GO

IF OBJECT_ID('freethrow') IS NOT NULL
DROP TABLE freethrow
GO

-- Free throw attempts
-- Succeded only if corresponding key present in 'point' table, otherwise missed.
CREATE TABLE [freethrow]
(
	-- Game ID
	[game_id] int NOT NULL,
	-- Event counter
	[cntr] int NOT NULL,
	-- Free throw reason
	[reason] tinyint NOT NULL,
	-- Team attempting free throw
	[team_id] char(3) NOT NULL,
	-- Player attempting free throw
	[player_id] int NULL,
	-- Ordinal number of free throw (of out 'outof')
	[num] tinyint NOT NULL,
	-- Total number of free throws awarded
	[outof] tinyint NOT NULL,

	CONSTRAINT PK_freethrow PRIMARY KEY (game_id, cntr),
	CONSTRAINT FK_freethrow_reason FOREIGN KEY (reason) REFERENCES freethrow_reason(id),
	CONSTRAINT FK_freethrow_event FOREIGN KEY (game_id, cntr) REFERENCES event(game_id, cntr),
	CONSTRAINT FK_freethrow_team FOREIGN KEY (team_id) REFERENCES team(id),
	CONSTRAINT FK_freethrow_player FOREIGN KEY (player_id) REFERENCES player(id)
)

GO

---------------------------------------------------------------

IF OBJECT_ID('substitution') IS NOT NULL
DROP TABLE substitution
GO

-- Substitutions during period
CREATE TABLE substitution
(
	-- Game ID
	[game_id] int NOT NULL,
	-- Event counter
	[cntr] int NOT NULL,
	-- Team replacing players
	[team_id] char(3) NOT NULL,
	-- Player entering the game
	[enter_player_id] int NOT NULL,
	-- Player leaving the game
	[leave_player_id] int NOT NULL,

	CONSTRAINT PK_substitution PRIMARY KEY (game_id, cntr),
	CONSTRAINT FK_substitution_event FOREIGN KEY (game_id, cntr) REFERENCES event(game_id, cntr),
	CONSTRAINT FK_substitution_team FOREIGN KEY (team_id) REFERENCES team(id),
	CONSTRAINT FK_substitution_player_1 FOREIGN KEY (enter_player_id) REFERENCES player(id),
	CONSTRAINT FK_substitution_player_2 FOREIGN KEY (leave_player_id) REFERENCES player(id)
)

GO

---------------------------------------------------------------

IF OBJECT_ID('timeout_type') IS NOT NULL
DROP TABLE [timeout_type]
GO

-- Timeout type
CREATE TABLE [timeout_type]
(
	-- Type ID
	id tinyint IDENTITY(1,1),
	-- Description
	description varchar(50) NOT NULL,

	CONSTRAINT PK_timeout_type PRIMARY KEY (id)
)

GO

IF OBJECT_ID('timeout') IS NOT NULL
DROP TABLE [timeout]
GO

-- Timeout events
CREATE TABLE [timeout]
(
	-- Game ID
	[game_id] int NOT NULL,
	-- Event counter
	[cntr] int NOT NULL,
	-- Timeout type
	[type] tinyint NOT NULL,
	-- Team causing timeout, might be NULL
	[team_id] char(3) NULL,
	
	CONSTRAINT PK_timeout PRIMARY KEY (game_id, cntr),
	CONSTRAINT FK_timeout_event FOREIGN KEY (game_id, cntr) REFERENCES event(game_id, cntr),
	CONSTRAINT FK_timeout_type FOREIGN KEY (type) REFERENCES timeout_type(id),
	CONSTRAINT FK_timeout_team FOREIGN KEY (team_id) REFERENCES team(id)
)

GO

---------------------------------------------------------------

IF OBJECT_ID('turnover_reason') IS NOT NULL
DROP TABLE [turnover_reason]
GO

-- Turnover reasons
CREATE TABLE [turnover_reason]
(
	-- Reason ID
	id tinyint IDENTITY(1,1),
	-- Description
	description varchar(50) NOT NULL,

	CONSTRAINT PK_tunrover_reason PRIMARY KEY (id)
)

GO

IF OBJECT_ID('turnover') IS NOT NULL
DROP TABLE turnover
GO

-- Turnovers
CREATE TABLE [turnover]
(
	-- Game ID
	[game_id] int NOT NULL,
	-- Event counter
	[cntr] int NOT NULL,
	-- Turnover reason
	[reason] tinyint NOT NULL,
	-- Team losing ball
	[team_id] char(3) NULL,
	-- Player causing turnover
	[player_id] int NULL,
	-- Player stealing ball
	[steal_player_id] int NULL

	CONSTRAINT PK_turnover PRIMARY KEY (game_id, cntr),
	CONSTRAINT FK_turnover_event FOREIGN KEY (game_id, cntr) REFERENCES event(game_id, cntr),
	CONSTRAINT FK_turnover_reason FOREIGN KEY (reason) REFERENCES turnover_reason(id),
	CONSTRAINT FK_turnover_team FOREIGN KEY (team_id) REFERENCES team(id),
	CONSTRAINT FK_turnover_player_1 FOREIGN KEY (player_id) REFERENCES player(id),
	CONSTRAINT FK_turnover_player_2 FOREIGN KEY (steal_player_id) REFERENCES player(id)
)

GO

---------------------------------------------------------------

IF OBJECT_ID('violation_type') IS NOT NULL
DROP TABLE [violation_type]
GO

-- Violation types
CREATE TABLE [violation_type]
(
	-- Type ID
	id tinyint IDENTITY(1,1),
	-- Description
	description varchar(50) NOT NULL,

	CONSTRAINT PK_violation_type PRIMARY KEY (id)
)

GO

IF OBJECT_ID('violation') IS NOT NULL
DROP TABLE [violation]
GO

-- Violations
CREATE TABLE [violation]
(
	-- Game ID
	[game_id] int NOT NULL,
	-- Event counter
	[cntr] int NOT NULL,
	-- Violation type
	[type] tinyint NOT NULL,
	-- Team causing violation
	[team_id] char(3) NULL,
	-- Player causing violation, can be null if caused by team or coach
	[player_id] int NULL,

	CONSTRAINT PK_violation PRIMARY KEY (game_id, cntr),
	CONSTRAINT FK_violation_event FOREIGN KEY (game_id, cntr) REFERENCES event(game_id, cntr),
	CONSTRAINT FK_violation_type FOREIGN KEY (type) REFERENCES violation_type(id),
	CONSTRAINT FK_violation_team FOREIGN KEY (team_id) REFERENCES team(id),
	CONSTRAINT FK_violation_player FOREIGN KEY (player_id) REFERENCES player(id)
)

GO