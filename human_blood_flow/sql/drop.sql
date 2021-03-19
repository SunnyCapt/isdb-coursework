-- noinspection SqlResolveForFile

DROP FUNCTION check_speedBlood() CASCADE;
DROP FUNCTION check_harmfulness() CASCADE;

DROP FUNCTION getPossibleDeadPeople();
DROP FUNCTION getRichPeople();
DROP FUNCTION getSubstances(integer);

DROP INDEX bloodcell_index CASCADE;
DROP INDEX speed_index CASCADE;
DROP INDEX harmfulness_index CASCADE;
DROP INDEX organism_owner_index CASCADE;

DROP TABLE human_blood_flow_biologicalsystem CASCADE;
DROP TABLE human_blood_flow_humanactivity CASCADE;
DROP TABLE human_blood_flow_humanrole CASCADE;
DROP TABLE human_blood_flow_humanwealthlvl CASCADE;
DROP TABLE human_blood_flow_organismstatus CASCADE;
DROP TABLE human_blood_flow_substance CASCADE;
DROP TABLE human_blood_flow_organism CASCADE;
DROP TABLE human_blood_flow_human CASCADE;
DROP TABLE human_blood_flow_circulatorysystem CASCADE;
DROP TABLE human_blood_flow_circulatorysystem_substances CASCADE;
DROP TABLE human_blood_flow_bloodcell CASCADE;
DROP TABLE human_blood_flow_action CASCADE;
