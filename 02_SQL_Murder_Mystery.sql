-- The folowing queries where used to solve the SQL Murder Mystery game at https://mystery.knightlab.com/

/*The only thing you remember about the crime scene report was that it was a murder
on 15 Jan 2018 that took place in SQL City */

SELECT * FROM crime_scene_report
WHERE type = 'murder' AND date = 20180115 AND city = 'SQL City';

--Find the two witnesses
SELECT * FROM person
WHERE address_street_name = 'Northwestern Dr'
ORDER BY address_number DESC
LIMIT 1;

SELECT * FROM person
WHERE name LIKE 'Annabel%'
AND address_street_name = 'Franklin Ave';

--View the interview statements
SELECT * FROM interview
WHERE person_id IN (14887,16371);

--Use the information from the interview to find potential suspects
SELECT* FROM get_fit_now_member
INNER JOIN get_fit_now_check_in
ON get_fit_now_member.id = get_fit_now_check_in.membership_id
WHERE get_fit_now_check_in.check_in_date = 20180109
AND membership_status = 'gold'
AND get_fit_now_check_in.membership_id LIKE '48Z%';

--Use the partial license plate number to find the murderer from the two suspects
SELECT * FROM drivers_license
INNER JOIN person
ON drivers_license.id = person.license_id
WHERE plate_number LIKE '%H42W%'
AND name IN ('Joe Germuska','Jeremy Bowers');

--The murderer is Jeremy Bowers, however there appears to be more to this case
--Lets review his interview statement
SELECT * FROM interview
WHERE person_id = 67318;

--Find the woman who hired him based on the information provided
SELECT * FROM drivers_license
INNER JOIN person
ON drivers_license.id = person.license_id
WHERE hair_color = 'red'
AND car_make = 'Tesla'
AND height BETWEEN 65 AND 67;

--The first check returns three suspects, now to single out the culprit
SELECT * FROM facebook_event_checkin
INNER JOIN person
ON facebook_event_checkin.person_id = person.id
WHERE person.id IN (78881,90700,99716)
AND date BETWEEN 20171201 AND 20171231;

--The woman who hired Jeremy Bowere to commit the murder is Miranda Priestly