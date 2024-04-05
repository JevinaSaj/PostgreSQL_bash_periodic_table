------------------------------------------------------------
1.Create Database and connect to it
------------------------------------------------------------
 psql --username=freecodecamp --dbname=periodic_table;

------------------------------------------------------------
2. Edit the existing databade
------------------------------------------------------------
ALTER TABLE properties RENAME weight TO atomic_mass;
ALTER TABLE properties RENAME melting_point TO melting_point_celsius;
ALTER TABLE properties RENAME boiling_point TO boiling_point_celsius;
ALTER TABLE properties ALTER COLUMN melting_point_celsius SET NOT NULL, ALTER COLUMN boiling_point_celsius SET NOT NULL;
ALTER TABLE elements ADD CONSTRAINT unique_symbol UNIQUE (symbol), ADD CONSTRAINT unique_name UNIQUE (name);
ALTER TABLE elements ALTER COLUMN symbol SET NOT NULL, ALTER COLUMN name SET NOT NULL;
ALTER TABLE properties ALTER COLUMN type_id SET NOT NULL;
ALTER TABLE properties ALTER COLUMN atomic_mass TYPE DECIMAL;
ALTER TABLE properties DROP COLUMN type;
DELETE FROM properties WHERE atomic_number = 1000;
DELETE FROM elements WHERE atomic_number = 1000;
------------------------------------------------------------
3. Create tables as required conditions
------------------------------------------------------------
CREATE TABLE types (
  type_id INT PRIMARY KEY, 
  type VARCHAR(30) NOT NULL
);

------------------------------------------------------------
4. Foreign Key assignment
------------------------------------------------------------
ALTER TABLE properties ADD FOREIGN KEY(type_id) REFERENCES types(type_id);
ALTER TABLE properties ADD FOREIGN KEY(atomic_number) REFERENCES elements(atomic_number);

------------------------------------------------------------
5. Create rows as required 
------------------------------------------------------------
INSERT INTO types(type_id, type) VALUES(1,'nonmetal'), (2, 'metal'), (3, 'metalloid');
INSERT INTO elements(atomic_number, symbol, name) VALUES(9, 'F', 'Fluorine'), (10, 'Ne', 'Neon');
INSERT INTO properties(atomic_number, type, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id) VALUES(9, 'nonmetal', 18.998, -220, -188.1, 1), (10, 'nonmetal', 20.18, -248.6, -246.1, 1);
  
------------------------------------------------------------
6.Update the existing table
------------------------------------------------------------
UPDATE properties SET type_id = 1 WHERE type = 'nonmetal';
UPDATE properties SET type_id = 2 WHERE type = 'metal';
UPDATE properties SET type_id = 3 WHERE type = 'metalloid';

------------------------------------------------------------
7. Update first letter of the periodic table elements symbol to capital 
------------------------------------------------------------
UPDATE elements SET symbol = CONCAT(UPPER(LEFT(symbol, 1)), SUBSTRING(symbol, 2));


------------------------------------------------------------
8. Remove trailing zeros after the decimal place 
------------------------------------------------------------
 UPDATE properties SET atomic_mass = TRIM(TRAILING '0' FROM CAST(atomic_mass AS TEXT))::DECIMAL;

------------------------------------------------------------
9. initialise a git repository 
------------------------------------------------------------
mkdir periodic_table
cd periodic_table
git init

------------------------------------------------------------
10. Create and switch to the main branch
------------------------------------------------------------
git checkout -b main

------------------------------------------------------------
11. Create repo file
------------------------------------------------------------
touch element.sh

------------------------------------------------------------
12.Give executable permission to shell scipt files
------------------------------------------------------------
chmod +x element.sh

------------------------------------------------------------
13.Copy & Run shell script files (NOTE : insert data first)
------------------------------------------------------------
./element.sh
