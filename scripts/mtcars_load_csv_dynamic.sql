DROP TABLE mtcars_auto;

CREATE TABLE  mtcars_auto (
  model VARCHAR(20) NOT NULL PRIMARY KEY,
  mpg FLOAT(2) NOT NULL,
  cyc INT NOT NULL,
  disp FLOAT(2) NOT NULL,
  hp INT NOT NULL,
  drat FLOAT(2) NOT NULL,
  wt FLOAT(3) NOT NULL,
  qsec FLOAT(2) NOT NULL,
  vs INT NOT NULL,
  am INT NOT NULL,
  gear INT NOT NULL,
  carb INT NOT NULL
);

SELECT * FROM mtcars_auto; 

COPY mtcars_auto (
  model, mpg, cyc, disp, hp, drat, wt, qsec, vs, am, gear, carb
  )

FROM :file_name
DELIMITER ','
CSV HEADER;

SELECT * FROM mtcars_auto LIMIT 10;
