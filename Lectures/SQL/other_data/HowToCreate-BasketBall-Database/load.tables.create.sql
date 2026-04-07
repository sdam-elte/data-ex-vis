CREATE SCHEMA load

GO

CREATE TABLE load.play
(
	[game] varchar(20),	-- YYYYMMDD.AAAHHH.csv
	[cntr] smallint,
	[a1] varchar(50),
	[a2] varchar(50),
	[a3] varchar(50),
	[a4] varchar(50),
	[a5] varchar(50),
	[h1] varchar(50),
	[h2] varchar(50),
	[h3] varchar(50),
	[h4] varchar(50),
	[h5] varchar(50),
	[period] tinyint,
		-- can be up to 7!
	[time] varchar(5),
	[team] char(3),					-- can be 'OFF' for the beginning of the game
	[etype] varchar(50),
		/*
		ejection					-- defined: player, reason [first flagrant type 2|second technical|other]
									--          player name can be coach
		foul						-- defined: player, opponent, type [!see column!]
		free throw					-- defined: num, outof, player, 
											    reason [!see column!],
												result [made|missed]
		jump ball					-- only with first event with team OFF
									-- defined: away, home, possession
		rebound						-- defined: player, type [NULL|def|off]
		shot						-- defined: assist, block, player, points, 
												result [made|missed], 
												type [!see column!],
												x, y
		sub							-- defined: entered, left
		timeout						-- defined: type [official|regular|short]
		turnover					-- defined: player, reason [!see column!], steal
		violation					-- defined: player, 
												type [defensive goaltending|delay of game|double lane|jump ball|kicked ball|lane]
		*/
	[assist] varchar(50) NULL,		-- player name
	[away] varchar(50) NULL,		-- player name
	[block] varchar(50) NULL,		-- player name
	[entered] varchar(50) NULL,		-- player name
	[home] varchar(50) NULL,		-- player name
	[left] varchar(50) NULL,		-- player name
	[num] tinyint NULL,				-- points (1, 2 or 3)
	[opponent] varchar(50) NULL,	-- player name	
	[outof] tinyint NULL,			-- points (1, 2 or 3)
	[player] varchar(50) NULL,		-- player name -- NEEDS MAPPING! sometimes it's just last name
	[points] tinyint NULL,			-- points (2 or 3)
	[possession] varchar(50) NULL,	-- player name OR TEAM NAME, NEEDS MAPPING
	[reason] varchar(50) NULL,		-- reason or etype 'free throw', 'turnover', 'ejection'
		/*
			free throw:
				clear path
				flagrant
				foul
				technical
			turnover:
				3 second violation
				5 second inbound turnover
				5 second violation
				8 second violation
				backcourt turnover
				bad pass
				discontinue dribble
				double dribble
				double personal turnover
				foul
				illegal assist turnover
				illegal screen turnover
				inbound turnover
				jump ball violation
				kicked ball violation
				lane violation
				lost ball
				no turnover
				offensive goaltending
				out of bounds lost ball turnover
				palming turnover
				poss lost ball turnover
				punched ball turnover
				shot clock turnover
				step out of bounds turnover
				swinging elbows turnover
				traveling
				unknown
		*/
	[result] varchar(50) NULL,		-- outcome of etype 'free throw' or 'shot'
		/*
		made
		missed
		*/
	[steal] varchar(50) NULL,		-- player name	
	[type] varchar(50) NULL,		-- type of etype 'foul', 'shot', timeout', 'violati', 'rebou', 
		/*
			foul:
				away from play
				clear path
				defense 3 second
				double personal
				double technical
				flagrant type 1
				flagrant type 2
				hanging technical
				inbound
				loose ball
				non supported technical
				offensive
				personal
				shooting
				technical
			shot:
				3pt
				alley oop dunk
				alley oop layup
				driving bank
				driving bank hook
				driving dunk
				driving finger roll layup
				driving hook
				driving jump
				driving layup
				driving reverse layup
				driving slam dunk
				dunk
				fade away bank
				fade away jumper
				finger roll layup
				floating jump
				hook
				hook bank
				jump
				jump bank
				jump bank hook
				jump hook
				layup
				pullup bank
				pullup jump
				putback dunk
				putback layup
				putback slam dunk
				reverse dunk
				reverse layup
				reverse slam dunk
				running bank
				running bank hook
				running dunk
				running finger roll layup
				running hook
				running jump
				running layup
				running reverse layup
				running slam dunk
				running tip
				slam dunk
				step back jump
				tip
				turnaround bank
				turnaround bank hook
				turnaround fade away
				turnaround hook
				turnaround jump
		*/
	[x] int,
	[y] int
		/*
		If you are standing behind the offensive team’s hoop then 
		the X axis runs from left to right and the Y axis runs from 
		bottom to top. The center of the hoop is located at (25, 5.25).
		*/
)

GO

IF OBJECT_ID('load.player') IS NOT NULL
DROP TABLE load.player
GO

CREATE TABLE load.player
(
	[name] varchar(50),
	[position] varchar(2),
	[age] int,
	[team] char(3)
)

GO

IF OBJECT_ID('load.number') IS NOT NULL
DROP TABLE load.number
GO

CREATE TABLE load.number
(
	[number] varchar(2),
	[name] varchar(50),
	[team] char(3)
)

GO