-- Insert list of conferences and divisions

INSERT conference
VALUES
( 'E', 'Eastern Conference' ),
( 'W', 'Western Conference' )

GO

---------------------------------------------------------------

INSERT division
VALUES
( 'AT', 'E', 'Atlantic Division' ),
( 'CE', 'E', 'Central Division' ),
( 'SE', 'E', 'Southeast Division' ),
( 'NW', 'W', 'Northwest Division' ),
( 'PA', 'W', 'Pacific Division' ),
( 'SW', 'W', 'Southwest Division' )

GO

---------------------------------------------------------------

-- Insert list of teams

INSERT team
VALUES
('CLE', 'CE', 'Cleveland Cavaliers'),
('BOS', 'AT', 'Boston Celtics'),
('ORL', 'SE', 'Orlando Magic'),
('ATL', 'SE', 'Atlanta Hawks'),
('MIA', 'SE', 'Miami Heat'),
('PHI', 'AT', 'Philadelphia 76ers'),
('CHI', 'CE', 'Chicago Bulls'),
('DET', 'CE', 'Detroit Pistons'),
('IND', 'CE', 'Indiana Pacers'),
('CHA', 'SE', 'Charlotte Bobcats'),
('NJN', 'AT', 'New Jersey Nets'),
('MIL', 'CE', 'Milwaukee Bucks'),
('TOR', 'AT', 'Toronto Raptors'),
('NYK', 'AT', 'New York Knicks'),
('WAS', 'SE', 'Washington Wizards'),
('LAL', 'PA', 'Los Angeles Lakers'),
('DEN', 'NW', 'Denver Nuggets'),
('SAS', 'SW', 'San Antonio Spurs'),
('POR', 'NW', 'Portland Trail Blazers'),
('HOU', 'SW', 'Houston Rockets'),
('DAL', 'SW', 'Dallas Mavericks'),
('NOH', 'SW', 'New Orleans Hornets'),
('UTA', 'NW', 'Utah Jazz'),
('PHX', 'PA', 'Phoenix Suns'),
('GSW', 'PA', 'Golden State Warriors'),
('MIN', 'NW', 'Minnesota Timberwolves'),
('MEM', 'SW', 'Memphis Grizzlies'),
('OKC', 'NW', 'Oklahoma City Thunder'),
('LAC', 'PA', 'Los Angeles Clippers'),
('SAC', 'PA', 'Sacramento Kings')

GO

---------------------------------------------------------------

-- Fix player names imported from basketball-reference

/*
UPDATE load.player
SET name = REPLACE(name, '*', '')

GO
*/

---------------------------------------------------------------

-- Compare names in the two sets

/*
WITH names AS
(
	SELECT DISTINCT a1 AS name FROM load.play
	UNION
	SELECT DISTINCT a2 FROM load.play
	UNION
	SELECT DISTINCT a3 FROM load.play
	UNION
	SELECT DISTINCT a4 FROM load.play
	UNION
	SELECT DISTINCT a5 FROM load.play
	UNION
	SELECT DISTINCT h1 FROM load.play
	UNION
	SELECT DISTINCT h2 FROM load.play
	UNION
	SELECT DISTINCT h3 FROM load.play
	UNION
	SELECT DISTINCT h4 FROM load.play
	UNION
	SELECT DISTINCT h5 FROM load.play
	UNION
	SELECT DISTINCT assist FROM load.play
	UNION
	SELECT DISTINCT away FROM load.play
	UNION
	SELECT DISTINCT [block] FROM load.play
	UNION
	SELECT DISTINCT [entered] FROM load.play
	UNION
	SELECT DISTINCT [home] FROM load.play
	UNION
	SELECT DISTINCT [left] FROM load.play
	UNION
	SELECT DISTINCT [opponent] FROM load.play
	-- 447

	-- these can contain team names as well as player names
	/*UNION
	SELECT DISTINCT player FROM load.play
	UNION
	SELECT DISTINCT possession FROM load.play
	UNION
	SELECT DISTINCT steal FROM load.play*/
	-- 525
),
players AS
(
	SELECT DISTINCT name, age FROM load.player
	-- 445
),
numbers AS
(
	SELECT DISTINCT name FROM load.number
	-- 444
)
SELECT names.name, players.name, numbers.name
FROM names
FULL OUTER JOIN players ON players.name = names.name
FULL OUTER JOIN numbers ON numbers.name = names.name 
ORDER BY names.name
-- 452
*/

GO

/*

D.J. Mbenga						Didier Ilunga-Mbenga		D.J. Mbenga
Luc Richard Mbah a Moute		Luc Mbah a Moute			Luc Mbah a Moute
Amare Stoudemire				Amar'e Stoudemire			Amar'e Stoudemire
Louis Amundson					Lou Amundson				Lou Amundson
Yue Sun							Sun Yue						Sun Yue
Jose Juan Barea					J.J. Barea					J.J. Barea
Bill Walker						Henry Walker				Henry Walker
Ron Artest						Metta World Peace			Ron Artest
*/

IF OBJECT_ID('load.MapName') IS NOT NULL
DROP FUNCTION load.MapName
GO

CREATE FUNCTION load.MapName
(
	@name varchar(50)
)
RETURNS varchar(50)
AS
BEGIN
	RETURN CASE @name
		WHEN 'Didier Ilunga-Mbenga' THEN 'D.J. Mbenga'
		WHEN 'Luc Richard Mbah a Moute' THEN 'Luc Mbah a Moute'
		WHEN 'Amare Stoudemire' THEN 'Amar''e Stoudemire'
		WHEN 'Louis Amundson' THEN 'Lou Amundson'
		WHEN 'Yue Sun' THEN 'Sun Yue'
		WHEN 'Jose Juan Barea' THEN 'J.J. Barea'
		WHEN 'Bill Walker' THEN 'Henry Walker'
		WHEN 'Metta World Peace' THEN 'Ron Artest'
		ELSE @name
	END
END

GO

---------------------------------------------------------------

-- Someone has two different ages in load.player

/*
WITH q AS
(
	SELECT DISTINCT load.MapName(name) AS name, age FROM load.player
)
SELECT name
FROM q
GROUP BY name
HAVING COUNT(*) > 1
-- Marcus Williams

SELECT DISTINCT load.MapName(name) AS name, age FROM load.player
WHERE name = 'Marcus Williams'

GO

UPDATE load.player
SET Age = 22
WHERE name = 'Marcus Williams'

GO
*/

---------------------------------------------------------------

-- Copy players into target table

INSERT dbo.person
(name, age)
SELECT DISTINCT load.MapName(name) AS name, age FROM load.player
ORDER BY 1
-- 444

---------------------------------------------------------------

-- sometimes team abreviations are off

IF OBJECT_ID('load.MapTeam') IS NOT NULL
DROP FUNCTION load.MapTeam
GO

CREATE FUNCTION load.MapTeam
(
	@team_id char(3)
)
RETURNS char(3)
AS
BEGIN
	RETURN CASE @team_id
		WHEN 'PHO' THEN 'PHX'
		ELSE @team_id
	END
END

GO

---------------------------------------------------------------

-- Copy play positions

INSERT dbo.position
VALUES
('C', 'center'),
('PF', 'power forward'),
('PG', 'point guard'),
('SF', 'small forward'),
('SG', 'shooting guard')

-- Copy person -- team assignments

INSERT dbo.player
	(team_id, number, position_id, person_id)
SELECT DISTINCT load.MapTeam(number.team), number, player.position, person.id
FROM load.player
INNER JOIN load.number
	ON load.MapName(player.name) = load.MapName(number.name) AND
	   load.MapTeam(player.team) = load.MapTeam(number.team)
INNER JOIN dbo.person ON person.name = load.MapName(player.name)
ORDER BY 1, 2
-- 515

---------------------------------------------------------------

-- Copy list of games

INSERT dbo.game
	([date], home_team_id, away_team_id)
SELECT DISTINCT
	CAST(SUBSTRING(game, 1, 8) AS date) AS [date],
	SUBSTRING(game, 13, 3) AS home_team_id,
	SUBSTRING(game, 10, 3) AS away_team_id
FROM load.play
ORDER BY 1
-- 1176

---------------------------------------------------------------

-- Create a function to get play-to-play file name

IF OBJECT_ID('load.P2Pname') IS NOT NULL
DROP FUNCTION load.P2Pname
GO

CREATE FUNCTION load.P2Pname
(
	@date date,
	@home_team_id char(3),
	@away_team_id char(3)
)
RETURNS varchar(20)
AS
BEGIN
	RETURN 
		FORMAT(@date, 'yyyyMMdd') + '.' +
		@away_team_id + @home_team_id + '.csv'
END

GO

SELECT load.P2Pname('2009-01-02', 'MIN', 'WAS')

---------------------------------------------------------------

-- Verify possible column values

/*
SELECT DISTINCT team
FROM load.play


SELECT steal
FROM load.play
WHERE load.MapName(steal) NOT IN (SELECT name FROM person)


SELECT DISTINCT etype, type
FROM load.play
*/

---------------------------------------------------------------

-- Add enter/leave events instead of substitution and renumber the counter
/*
WITH [event_subs] AS
(
	SELECT 
		[game], [cntr],
		[a1], [a2], [a3], [a4], [a5],
		[h1], [h2], [h3], [h4], [h5],
		[period], [time], [team], 
		CASE WHEN [etype] = 'sub' THEN 'enter' ELSE [etype] END AS [etype], 
		[assist], [away], [block], [entered], [home], [left], [num], [opponent],
        [outof], [player], [points], [possession], [reason], [result], [steal], [type], [x], [y]
	FROM load.play
	UNION ALL
	SELECT
		[game], [cntr],
		[a1], [a2], [a3], [a4], [a5],
		[h1], [h2], [h3], [h4], [h5],
		[period], [time], [team], 
		'leave', 
		[assist], [away], [block], [entered], [home], [left], [num], [opponent],
        [outof], [player], [points], [possession], [reason], [result], [steal], [type], [x], [y]
	FROM load.play WHERE etype = 'sub'
),
[event_renum] AS
(
	SELECT 
		[game], ROW_NUMBER() OVER (PARTITION BY game ORDER BY cntr, etype) AS cntr,
		[a1], [a2], [a3], [a4], [a5],
		[h1], [h2], [h3], [h4], [h5],
		[period], [time], [team], [etype], 
		[assist], [away], [block], [entered], [home], [left], [num], [opponent],
        [outof], [player], [points], [possession], [reason], [result], [steal], [type], [x], [y]
	FROM event_subs
)
SELECT * 
INTO load.event_renum
FROM event_renum
*/

GO

-- Add starting players from the very first entry in each period

WITH pp AS
(
	SELECT *, ROW_NUMBER() OVER (PARTITION BY game, period ORDER BY cntr) AS rn
	FROM load.play
), 
start AS
(
	SELECT * FROM pp
	WHERE rn = 1
),
starters AS
(
	SELECT 1 AS pos, 1 AS team, game, period, a1 AS name FROM start
	UNION ALL
	SELECT 2, 1, game, period, a2 AS name FROM start
	UNION ALL
	SELECT 3, 1, game, period, a3 AS name FROM start
	UNION ALL
	SELECT 4, 1, game, period, a4 AS name FROM start
	UNION ALL
	SELECT 5, 1, game, period, a5 AS name FROM start
	UNION ALL
	SELECT 1, 2, game, period, h1 AS name FROM start
	UNION ALL
	SELECT 2, 2, game, period, h2 AS name FROM start
	UNION ALL
	SELECT 3, 2, game, period, h3 AS name FROM start
	UNION ALL
	SELECT 4, 2, game, period, h4 AS name FROM start
	UNION ALL
	SELECT 5, 2, game, period, h5 AS name FROM start
)
INSERT dbo.[start]
SELECT
	game.id,
	period, 
	pos,
	player.team_id,
	player.id
FROM starters
INNER JOIN game ON starters.game = load.P2Pname(game.date, game.home_team_id, game.away_team_id)
INNER JOIN person ON person.name = starters.name
INNER JOIN player ON player.person_id = person.id AND
					 (team = 1 AND player.team_id = game.away_team_id OR
					  team = 2 AND player.team_id = game.home_team_id)
ORDER BY 1, 2, team

-- (47065 rows affected)

----

INSERT [event]
SELECT
	game.id,
	play.cntr,
	play.period,
	CAST('00:' + play.time AS time),
	etype
FROM load.play
INNER JOIN game ON play.game = load.P2Pname(game.date, game.home_team_id, game.away_team_id)

-- (510994 rows affected)

---------------------------------------------------------------

-- ejection events

INSERT ejection_reason
	(description)
SELECT DISTINCT reason
FROM load.play
WHERE etype = 'ejection'

--

INSERT ejection
SELECT
	game.id,
	play.cntr,	-- since startes are added at the beginning of each period
	ejection_reason.id,
	play.team,
	player.id
FROM load.play
INNER JOIN game ON play.game = load.P2Pname(game.date, game.home_team_id, game.away_team_id)
INNER JOIN ejection_reason ON ejection_reason.description = play.reason
LEFT OUTER JOIN person ON person.name = load.MapName(play.player)
LEFT OUTER JOIN player ON player.person_id = person.id AND player.team_id = play.team
WHERE etype = 'ejection'

-- (55 rows affected)

---------------------------------------------------------------

-- foul events

INSERT foul_type
	(description)
SELECT 'unknown'
UNION ALL
SELECT DISTINCT type
FROM load.play
WHERE etype = 'foul' AND type IS NOT NULL

--

INSERT [foul]
SELECT
	game.id,
	play.cntr,	-- since startes are added at the beginning of each period
	ISNULL(foul_type.id, 1),
	play.team,
	player.id,
	opponent_player.id
FROM load.play
INNER JOIN game ON play.game = load.P2Pname(game.date, game.home_team_id, game.away_team_id)
LEFT OUTER JOIN foul_type ON foul_type.description = play.type
LEFT OUTER JOIN person ON person.name = load.MapName(play.player)
LEFT OUTER JOIN player ON player.person_id = person.id AND player.team_id = play.team
LEFT OUTER JOIN person AS opponent_person ON opponent_person.name = load.MapName(play.opponent)
LEFT OUTER JOIN player AS opponent_player ON opponent_player.person_id = opponent_person.id 
	AND opponent_player.team_id = CASE WHEN player.team_id = game.home_team_id THEN game.away_team_id ELSE game.home_team_id END
WHERE etype = 'foul'

-- (51068 rows affected)

---------------------------------------------------------------

-- jump ball events

INSERT jumpball
SELECT
	game.id,
	play.cntr,
	player.team_id,
	player.id,
	home_player.id,
	away_player.id
FROM load.play
INNER JOIN game ON play.game = load.P2Pname(game.date, game.home_team_id, game.away_team_id)
LEFT OUTER JOIN person ON person.name = load.MapName(play.possession)
LEFT OUTER JOIN player ON player.person_id = person.id AND 
	-- figure out which team possesses the ball; not trivial due to players changing teams during season
	(player.team_id = game.home_team_id AND play.possession IN (play.h1, play.h2, play.h3, play.h4, play.h5) OR
	 player.team_id = game.away_team_id AND play.possession IN (play.a1, play.a2, play.a3, play.a4, play.a5))
LEFT OUTER JOIN person AS home_person ON home_person.name = load.MapName(play.home)
LEFT OUTER JOIN player AS home_player ON home_player.person_id = home_person.id AND home_player.team_id = game.home_team_id
LEFT OUTER JOIN person AS away_person ON away_person.name = load.MapName(play.away)
LEFT OUTER JOIN player AS away_player ON away_player.person_id = away_person.id AND away_player.team_id = game.away_team_id
WHERE etype = 'jump ball'

-- (1929 rows affected)

---------------------------------------------------------------

-- rebound events

INSERT [rebound_type]
	(description)
SELECT 'unknown'
UNION
SELECT DISTINCT type
FROM load.play
WHERE etype = 'rebound' AND type IS NOT NULL

--

INSERT rebound
SELECT
	game.id,
	play.cntr,
	rebound_type.id,
	play.team,
	player.id
FROM load.play
INNER JOIN game ON play.game = load.P2Pname(game.date, game.home_team_id, game.away_team_id)
INNER JOIN rebound_type ON rebound_type.description = ISNULL(play.type, 'unknown')
LEFT OUTER JOIN person ON person.name = load.MapName(play.player)
LEFT OUTER JOIN player ON player.person_id = person.id AND player.team_id = play.team
WHERE etype = 'rebound'

---------------------------------------------------------------

INSERT [shot_type]
	(description)
SELECT DISTINCT type
FROM load.play
WHERE etype = 'shot'

--

INSERT shot
SELECT
	game.id,
	play.cntr,
	shot_type.id,
	player.team_id,
	player.id,
	assist_player.id,
	block_player.id,
	x, y
FROM load.play
INNER JOIN game ON play.game = load.P2Pname(game.date, game.home_team_id, game.away_team_id)
INNER JOIN shot_type ON shot_type.description = play.type
LEFT OUTER JOIN person ON person.name = load.MapName(play.player)
LEFT OUTER JOIN player ON player.person_id = person.id AND player.team_id = play.team

LEFT OUTER JOIN person AS assist_person ON assist_person.name = load.MapName(play.assist)
LEFT OUTER JOIN player AS assist_player ON assist_player.person_id = assist_person.id AND assist_player.team_id = play.team
LEFT OUTER JOIN person AS block_person ON block_person.name = load.MapName(play.block)
LEFT OUTER JOIN player AS block_player ON block_player.person_id = block_person.id AND 
	-- figure out which team possesses the ball; not trivial due to players changing teams during season
	(block_player.team_id = game.home_team_id AND play.block IN (play.h1, play.h2, play.h3, play.h4, play.h5) OR
	 block_player.team_id = game.away_team_id AND play.block IN (play.a1, play.a2, play.a3, play.a4, play.a5))
WHERE etype = 'shot'

-- add points

INSERT point
SELECT 
	game.id,
	play.cntr,
	play.points
FROM load.play
INNER JOIN game ON play.game = load.P2Pname(game.date, game.home_team_id, game.away_team_id)
WHERE etype = 'shot' AND points IS NOT NULL

-- (87084 rows affected)

---------------------------------------------------------------

-- free throw events

INSERT [freethrow_reason]
SELECT DISTINCT reason
FROM load.play
WHERE etype = 'free throw'

--

INSERT [freethrow]
SELECT
	game.id,
	play.cntr,
	freethrow_reason.id,
	play.team,
	player.id,
	play.num,
	play.outof
FROM load.play
INNER JOIN game ON play.game = load.P2Pname(game.date, game.home_team_id, game.away_team_id)
INNER JOIN freethrow_reason ON freethrow_reason.description = play.reason
LEFT OUTER JOIN person ON person.name = load.MapName(play.player)
LEFT OUTER JOIN player ON player.person_id = person.id AND player.team_id = play.team
WHERE etype = 'free throw'

-- (58007 rows affected)

-- Add points

INSERT point
SELECT 
	game.id,
	play.cntr,
	1
FROM load.play
INNER JOIN game ON play.game = load.P2Pname(game.date, game.home_team_id, game.away_team_id)
WHERE etype = 'free throw' AND result = 'made'

---------------------------------------------------------------

-- Substitution

INSERT substitution
SELECT 
	game.id,
	play.cntr,
	play.team,
	enter_player.id,
	leave_player.id
FROM load.play
INNER JOIN game ON play.game = load.P2Pname(game.date, game.home_team_id, game.away_team_id)
LEFT OUTER JOIN person enter_person ON enter_person.name = load.MapName(play.entered)
LEFT OUTER JOIN player enter_player ON enter_player.person_id = enter_person.id AND enter_player.team_id = play.team
LEFT OUTER JOIN person leave_person ON leave_person.name = load.MapName(play.[left])
LEFT OUTER JOIN player leave_player ON leave_player.person_id = leave_person.id AND leave_player.team_id = play.team
WHERE etype = 'sub'

-- (44007 rows affected)

---------------------------------------------------------------

-- timeout

INSERT [timeout_type]
	(description)
SELECT DISTINCT type
FROM load.play
WHERE etype = 'timeout'

--

INSERT [timeout]
SELECT 
	game.id,
	play.cntr,
	timeout_type.id,
	CASE WHEN play.team = 'OFF' THEN NULL ELSE play.team END
FROM load.play
INNER JOIN game ON play.game = load.P2Pname(game.date, game.home_team_id, game.away_team_id)
INNER JOIN timeout_type ON timeout_type.description = play.type
WHERE etype = 'timeout'

-- (15290 rows affected)

---------------------------------------------------------------

-- turnover

INSERT [turnover_reason]
	(description)
SELECT DISTINCT reason
FROM load.play
WHERE etype = 'turnover'

--

INSERT [turnover]
SELECT
	game.id,
	play.cntr,
	turnover_reason.id,
	player.team_id,
	player.id,
	steal_player.id
FROM load.play
INNER JOIN game ON play.game = load.P2Pname(game.date, game.home_team_id, game.away_team_id)
INNER JOIN turnover_reason ON turnover_reason.description = play.reason
LEFT OUTER JOIN person ON person.name = load.MapName(play.player)
LEFT OUTER JOIN player ON player.person_id = person.id AND player.team_id = play.team
LEFT OUTER JOIN person AS steal_person ON steal_person.name = load.MapName(play.steal)
LEFT OUTER JOIN player AS steal_player ON steal_player.person_id = steal_person.id AND 
	-- figure out which team possesses the ball; not trivial due to players changing teams during season
	(steal_player.team_id = game.home_team_id AND play.steal IN (play.h1, play.h2, play.h3, play.h4, play.h5) OR
	 steal_player.team_id = game.away_team_id AND play.steal IN (play.a1, play.a2, play.a3, play.a4, play.a5))
WHERE etype = 'turnover'

-- (32999 rows affected)

---------------------------------------------------------------

-- violation

INSERT [violation_type]
	(description)
SELECT DISTINCT type
FROM load.play
WHERE etype = 'violation'

--

INSERT [violation]
SELECT
	game.id,
	play.cntr,
	violation_type.id,
	player.team_id,
	player.id
FROM load.play
INNER JOIN game ON play.game = load.P2Pname(game.date, game.home_team_id, game.away_team_id)
INNER JOIN violation_type ON violation_type.description = play.type
LEFT OUTER JOIN person ON person.name = load.MapName(play.player)
LEFT OUTER JOIN player ON player.person_id = person.id AND player.team_id = play.team
WHERE etype = 'violation'

-- (1645 rows affected)

---------------------------------------------------------------

-- Some final renames

UPDATE [rebound_type]
SET description = 'offensive'
WHERE description = 'off'

UPDATE [rebound_type]
SET description = 'defensive'
WHERE description = 'def'
