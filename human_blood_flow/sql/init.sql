BEGIN;

CREATE TABLE "human_blood_flow_biologicalsystem"
(
    "id"        integer PRIMARY KEY,
    "shortname" varchar(32) NOT NULL
);
CREATE TABLE "human_blood_flow_humanactivity"
(
    "id"          integer PRIMARY KEY,
    "shortname"   varchar(32)  NOT NULL,
    "description" varchar(256) NULL
);
CREATE TABLE "human_blood_flow_humanrole"
(
    "id"          integer PRIMARY KEY,
    "shortname"   varchar(32)  NOT NULL,
    "description" varchar(256) NULL
);
CREATE TABLE "human_blood_flow_humanwealthlvl"
(
    "id"          integer PRIMARY KEY,
    "lvl"         integer      NOT NULL CHECK ("lvl" >= 0 and lvl <= 100),
    "description" varchar(128) NULL
);
CREATE TABLE "human_blood_flow_organismstatus"
(
    "id"          integer PRIMARY KEY,
    "shortname"   varchar(32)  NOT NULL,
    "description" varchar(256) NULL
);
CREATE TABLE "human_blood_flow_substance"
(
    "id"          integer PRIMARY KEY,
    "shortname"   varchar(32)  NOT NULL,
    "description" varchar(256) NULL,
    "harmfulness" integer      NOT NULL CHECK ("harmfulness" >= 0 and "harmfulness" <= 100)
);
CREATE TABLE "human_blood_flow_human"
(
    "id"          integer PRIMARY KEY,
    "first_name"  varchar(32) NOT NULL,
    "last_name"   varchar(32) NOT NULL,
    "activity_id" integer     NULL REFERENCES "human_blood_flow_humanactivity" ("id"),
    "role_id"     integer     NULL REFERENCES "human_blood_flow_humanrole" ("id"),
    "wealth_id"   integer     NULL REFERENCES "human_blood_flow_humanwealthlvl" ("id")
);
CREATE TABLE "human_blood_flow_organism"
(
    "id"          integer PRIMARY KEY,
    "birthday"    date           NOT NULL,
    "date_to_die" date           NOT NULL,
    "sex"         varchar(5)     NOT NULL,
    "weight"      integer        NOT NULL CHECK ("weight" >= 0),
    "height"      integer        NOT NULL CHECK ("height" >= 0),
    "owner_id"    integer        NOT NULL UNIQUE REFERENCES "human_blood_flow_human" ("id"),
    "status_id"   integer UNIQUE NULL REFERENCES "human_blood_flow_organismstatus" ("id")
);
CREATE TABLE "human_blood_flow_circulatorysystem"
(
    "id"          integer PRIMARY KEY,
    "speed"       integer NOT NULL CHECK ("speed" >= 0 and speed <= 1488),
    "organism_id" integer NOT NULL UNIQUE REFERENCES "human_blood_flow_organism" ("id")
);
CREATE TABLE "human_blood_flow_circulatorysystem_substances"
(
    "id"                   integer PRIMARY KEY,
    "circulatorysystem_id" integer NOT NULL REFERENCES "human_blood_flow_circulatorysystem" ("id"),
    "substance_id"         integer NOT NULL REFERENCES "human_blood_flow_substance" ("id")
);
CREATE TABLE "human_blood_flow_bloodcell"
(
    "id"                    integer PRIMARY KEY,
    "cell_type"             varchar(32) NOT NULL,
    "circulatory_system_id" integer     NULL REFERENCES "human_blood_flow_circulatorysystem" ("id"),
    "place_id"              integer     NULL REFERENCES "human_blood_flow_biologicalsystem" ("id")
);
CREATE TABLE "human_blood_flow_action"
(
    "id"          integer PRIMARY KEY,
    "action_name" varchar(32)  NOT NULL,
    "cause"       varchar(128) NULL,
    "target_id"   integer      NOT NULL REFERENCES "human_blood_flow_human" ("id")
);
-- index
create index bloodcell_index on human_blood_flow_bloodcell using hash (circulatory_system_id);
create index speed_index on human_blood_flow_circulatorysystem using btree (speed);
create index harmfulness_index on human_blood_flow_substance using btree (harmfulness);
create index organism_owner_index on human_blood_flow_organism using hash (owner_id);
-- trigger
create or replace function check_speedBlood() returns trigger AS
$check_speedBlood$
BEGIN
    IF NEW.speed >= 80
    THEN
        UPDATE human_blood_flow_organismstatus as status
        SET shortname='U will die',
            description = 'please dont drink and use'
        WHERE status.id = (
            SELECT status_id
            FROM human_blood_flow_organism AS org
            WHERE org.id = new.organism_id
        );
    END IF;
    IF NEW.speed < 80
    THEN
        UPDATE human_blood_flow_organismstatus as status
        SET shortname='Alright',
            description = 'person is alive'
        WHERE status.id = (
            SELECT status_id
            FROM human_blood_flow_organism AS org
            WHERE org.id = new.organism_id
        );
    END IF;
    RETURN NEW;
END;
$check_speedBlood$ LANGUAGE plpgsql;
CREATE TRIGGER count_power
    BEFORE INSERT OR UPDATE
    ON human_blood_flow_circulatorysystem
    FOR EACH ROW
EXECUTE PROCEDURE
    check_speedBlood();

create or replace function check_harmfulness() returns trigger AS
$check_harmfulness$
BEGIN
    IF NEW.harmfulness > 60 then
        update human_blood_flow_organism as org
        set date_to_die = date_to_die - interval '1 day'
        where org.id = (
            select organism_id
            from human_blood_flow_circulatorysystem as a
                     inner join human_blood_flow_circulatorysystem_substances as b
                         on a.id = b.circulatorysystem_id
            where b.substance_id = NEW.id
        );
    END IF;
    RETURN NEW;
END;
$check_harmfulness$ LANGUAGE plpgsql;
CREATE TRIGGER check_harmfulness
    BEFORE INSERT OR UPDATE
    ON human_blood_flow_substance
    FOR EACH ROW
EXECUTE PROCEDURE
    check_harmfulness();
-- function
CREATE OR REPLACE function getPossibleDeadPeople()
    returns table
            (
                id         integer,
                first_name varchar(32),
                last_name  varchar(32)
            )
AS
$$
SELECT a.id, first_name, last_name
from human_blood_flow_human AS a
         inner join human_blood_flow_organism as b on a.id = b.owner_id
         inner join human_blood_flow_circulatorysystem as c on b.id = c.organism_id
         inner join human_blood_flow_circulatorysystem_substances as d on c.id = d.circulatorysystem_id
         inner join human_blood_flow_substance as t on t.id = d.substance_id
where t.harmfulness > 60
$$ LANGUAGE SQL;

CREATE OR REPLACE function getRichPeople()
    returns table
            (
                id          integer,
                first_name  varchar(32),
                last_name   varchar(32),
                lvl         integer
            )
as
$$
select a.id, first_name, last_name, lvl
from human_blood_flow_human as a
         inner join human_blood_flow_humanwealthlvl as b on a.wealth_id = b.id
where lvl > 40
$$
    language SQL;

CREATE OR REPLACE function getSubstances(human_id integer)
    returns table
            (
                id          integer,
                shortname   varchar(32),
                description varchar(256),
                harmfulness integer
            )
as
$$
select a.id, shortname, description, harmfulness
from human_blood_flow_substance as a
    inner join human_blood_flow_circulatorysystem_substances as b on a.id = b.substance_id
    inner join human_blood_flow_circulatorysystem as c on c.id = b.circulatorysystem_id
    inner join human_blood_flow_organism as d on c.organism_id = d.id
where d.owner_id = $1
$$
    language SQL;

COMMIT;