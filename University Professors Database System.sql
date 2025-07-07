CREATE TABLE university_professors (
    firstname TEXT,
    lastname TEXT,
    university TEXT,
    university_shortname TEXT,
    university_city TEXT,
    function TEXT,
    organization TEXT,
    organization_sector TEXT
);


CREATE TABLE universities (
    id SERIAL PRIMARY KEY,
    university TEXT NOT NULL,
    university_city TEXT NOT NULL,
    university_shortname TEXT UNIQUE NOT NULL
);


CREATE TABLE professors (
    professor_id SERIAL PRIMARY KEY,
    firstname TEXT NOT NULL,
    lastname TEXT NOT NULL,
    university_shortname TEXT NOT NULL,
    FOREIGN KEY (university_shortname) REFERENCES universities(university_shortname)
);



CREATE TABLE organizations (
    id SERIAL PRIMARY KEY,
    organization TEXT NOT NULL,
    organization_sector TEXT
);


CREATE TABLE affiliations (
    affiliation_id SERIAL PRIMARY KEY,
    professor_id INT NOT NULL,
    organization_id INT NOT NULL,
    function TEXT NOT NULL,
    FOREIGN KEY (professor_id) REFERENCES professors(professor_id),
    FOREIGN KEY (organization_id) REFERENCES organizations(id)
);



INSERT INTO universities (university, university_city, university_shortname)
SELECT DISTINCT university, university_city, university_shortname
FROM university_professors
WHERE university IS NOT NULL;


INSERT INTO professors (firstname, lastname, university_shortname)
SELECT DISTINCT firstname, lastname, university_shortname
FROM university_professors
WHERE firstname IS NOT NULL AND lastname IS NOT NULL;


INSERT INTO organizations (organization, organization_sector)
SELECT DISTINCT organization, organization_sector
FROM university_professors
WHERE organization IS NOT NULL;


INSERT INTO affiliations (professor_id, organization_id, function)
SELECT p.professor_id, o.id AS organization_id, up.function
FROM university_professors up
JOIN professors p ON up.firstname = p.firstname AND up.lastname = p.lastname
JOIN organizations o ON up.organization = o.organization;



SELECT * FROM universities

SELECT * FROM professors

SELECT * FROM organizations

SELECT * FROM affiliations