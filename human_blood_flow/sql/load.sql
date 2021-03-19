-- noinspection SqlResolveForFile

INSERT INTO human_blood_flow_biologicalsystem (id, shortname)
VALUES (1, 'покушоть');
INSERT INTO human_blood_flow_biologicalsystem (id, shortname)
VALUES (2, 'думать');
INSERT INTO human_blood_flow_biologicalsystem (id, shortname)
VALUES (3, 'дышать');
INSERT INTO human_blood_flow_biologicalsystem (id, shortname)
VALUES (4, 'размножаться');
INSERT INTO human_blood_flow_humanactivity (id, shortname, description)
VALUES (1, 'грустит', 'депрессируют по разным причинам');
INSERT INTO human_blood_flow_humanactivity (id, shortname, description)
VALUES (2, 'спит', 'спит сладким сном');
INSERT INTO human_blood_flow_humanactivity (id, shortname, description)
VALUES (3, 'бухает', 'выпивает по скотски');
INSERT INTO human_blood_flow_humanactivity (id, shortname, description)
VALUES (4, 'едет домой', 'катится домой на рогатом хлебушке');
INSERT INTO human_blood_flow_humanrole (id, shortname, description)
VALUES (1, 'депутат', 'свинья');
INSERT INTO human_blood_flow_humanrole (id, shortname, description)
VALUES (2, 'программист', 'раб');
INSERT INTO human_blood_flow_humanrole (id, shortname, description)
VALUES (3, 'студент', 'пустое место');
INSERT INTO human_blood_flow_humanrole (id, shortname, description)
VALUES (4, 'ВУ', 'Я');
INSERT INTO human_blood_flow_humanwealthlvl (id, lvl, description)
VALUES (1, 10, 'low');
INSERT INTO human_blood_flow_humanwealthlvl (id, lvl, description)
VALUES (2, 50, 'middle');
INSERT INTO human_blood_flow_humanwealthlvl (id, lvl, description)
VALUES (3, 90, 'hight');
INSERT INTO human_blood_flow_organismstatus (id, shortname, description)
VALUES (1, 'живет', 'спокойно');
INSERT INTO human_blood_flow_organismstatus (id, shortname, description)
VALUES (2, 'пишет', 'пишет лекции');
INSERT INTO human_blood_flow_organismstatus (id, shortname, description)
VALUES (3, 'жив', 'живее всех живых');
INSERT INTO human_blood_flow_organismstatus (id, shortname, description)
VALUES (4, 'непонятно', 'то ли мертв то ли жив');
INSERT INTO human_blood_flow_substance (id, shortname, description, harmfulness)
VALUES (1, 'бензоилэкгонин', 'активное вещество кокаина', 99);
INSERT INTO human_blood_flow_substance (id, shortname, description, harmfulness)
VALUES (2, 'кофеин', 'активное вещество энергетиков', 30);
INSERT INTO human_blood_flow_human (id, first_name, last_name, activity_id, role_id, wealth_id)
VALUES (2, 'Ислам', 'Принятый', 1, 4, 1);
INSERT INTO human_blood_flow_human (id, first_name, last_name, activity_id, role_id, wealth_id)
VALUES (3, 'Игнатий', 'Безымянный', 1, 3, 3);
INSERT INTO human_blood_flow_human (id, first_name, last_name, activity_id, role_id, wealth_id)
VALUES (4, 'Неопознанный', 'Барс', 3, 4, 3);
INSERT INTO human_blood_flow_human (id, first_name, last_name, activity_id, role_id, wealth_id)
VALUES (1, 'Иванов', 'Иванов', 1, 3, 2);
INSERT INTO human_blood_flow_organism (id, birthday, date_to_die, sex, weight, height, owner_id, status_id)
VALUES (1, '1991-01-01', '2021-03-02', 'man', 60, 180, 1, 1);
INSERT INTO human_blood_flow_organism (id, birthday, date_to_die, sex, weight, height, owner_id, status_id)
VALUES (2, '1991-01-01', '2024-12-27', 'man', 69, 228, 2, 2);
INSERT INTO human_blood_flow_organism (id, birthday, date_to_die, sex, weight, height, owner_id, status_id)
VALUES (3, '1991-01-01', '2021-03-25', 'woman', 545, 180, 3, 3);
INSERT INTO human_blood_flow_organism (id, birthday, date_to_die, sex, weight, height, owner_id, status_id)
VALUES (4, '1991-01-01', '2022-04-20', 'woman', 128, 180, 4, 4);
INSERT INTO human_blood_flow_circulatorysystem (id, speed, organism_id)
VALUES (1, 228, 1);
INSERT INTO human_blood_flow_circulatorysystem (id, speed, organism_id)
VALUES (2, 128, 2);
INSERT INTO human_blood_flow_circulatorysystem (id, speed, organism_id)
VALUES (3, 28, 3);
INSERT INTO human_blood_flow_circulatorysystem (id, speed, organism_id)
VALUES (4, 222, 4);
INSERT INTO human_blood_flow_circulatorysystem_substances (id, circulatorysystem_id, substance_id)
VALUES (1, 1, 1);
INSERT INTO human_blood_flow_circulatorysystem_substances (id, circulatorysystem_id, substance_id)
VALUES (2, 3, 2);
INSERT INTO human_blood_flow_bloodcell (id, cell_type, circulatory_system_id, place_id)
VALUES (1, 'erythrocytes', 3, 1);
INSERT INTO human_blood_flow_bloodcell (id, cell_type, circulatory_system_id, place_id)
VALUES (2, 'leukocytes', 2, 1);
INSERT INTO human_blood_flow_bloodcell (id, cell_type, circulatory_system_id, place_id)
VALUES (3, 'thrombocyte', 2, 4);
INSERT INTO human_blood_flow_bloodcell (id, cell_type, circulatory_system_id, place_id)
VALUES (4, 'leukocytes', 1, 1);
INSERT INTO human_blood_flow_bloodcell (id, cell_type, circulatory_system_id, place_id)
VALUES (5, 'leukocytes', 2, 2);
INSERT INTO human_blood_flow_bloodcell (id, cell_type, circulatory_system_id, place_id)
VALUES (6, 'thrombocyte', 4, 4);
INSERT INTO human_blood_flow_bloodcell (id, cell_type, circulatory_system_id, place_id)
VALUES (7, 'erythrocytes', 4, 2);
INSERT INTO human_blood_flow_action (id, action_name, cause, target_id)
VALUES (1, 'Летит', 'unknown', 1);
INSERT INTO human_blood_flow_action (id, action_name, cause, target_id)
VALUES (2, 'Ползет', 'unknown', 2);
INSERT INTO human_blood_flow_action (id, action_name, cause, target_id)
VALUES (3, 'Плывет', 'unknown', 3);
INSERT INTO human_blood_flow_action (id, action_name, cause, target_id)
VALUES (4, 'едет', 'unknown', 4);