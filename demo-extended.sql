CREATE TABLE tx_myext_domain_model_company (
	uid int(11) NOT NULL auto_increment,
	pid int(11) DEFAULT '0' NOT NULL,
	tstamp int(11) DEFAULT '0' NOT NULL,
	crdate int(11) DEFAULT '0' NOT NULL,
	cruser_id int(11) DEFAULT '0' NOT NULL,
	hidden tinyint(4) DEFAULT '0' NOT NULL,

	name varchar(50) DEFAULT '' NOT NULL,
	
	PRIMARY KEY (uid),
	KEY parent (pid)
);

CREATE TABLE tx_myext_domain_model_department (
	uid int(11) NOT NULL auto_increment,
	pid int(11) DEFAULT '0' NOT NULL,
	tstamp int(11) DEFAULT '0' NOT NULL,
	crdate int(11) DEFAULT '0' NOT NULL,
	cruser_id int(11) DEFAULT '0' NOT NULL,
	hidden tinyint(4) DEFAULT '0' NOT NULL,

	company int(11) NOT NULL,
	number int(11) NOT NULL,
	
	PRIMARY KEY (uid),
	KEY parent (pid)
);

CREATE TABLE tx_myext_domain_model_department_service_mm (
	uid_local int(11) NOT NULL,
	uid_foreign int(11) NOT NULL
);

CREATE TABLE tx_myext_domain_model_service (
	uid int(11) NOT NULL auto_increment,
	pid int(11) DEFAULT '0' NOT NULL,
	tstamp int(11) DEFAULT '0' NOT NULL,
	crdate int(11) DEFAULT '0' NOT NULL,
	cruser_id int(11) DEFAULT '0' NOT NULL,
	hidden tinyint(4) DEFAULT '0' NOT NULL,

	name varchar(50) DEFAULT '' NOT NULL,
	
	PRIMARY KEY (uid),
	KEY parent (pid)
);

CREATE VIEW tx_myext_company_flat AS
SELECT
	c.uid, c.pid, c.tstamp, c.hidden, c.name AS company,
	CAST(GROUP_CONCAT(DISTINCT dpt.number) AS char) AS departments,
	GROUP_CONCAT(DISTINCT s.name) AS services
FROM
	tx_myext_domain_model_company c
INNER JOIN
	tx_myext_domain_model_department dpt
		ON dpt.company = c.uid
INNER JOIN
	tx_myext_domain_model_department_service_mm mm
		ON mm.uid_local = dpt.uid
INNER JOIN
	tx_myext_domain_model_service s
		ON s.uid = mm.uid_foreign
GROUP BY
	c.uid;

INSERT INTO tx_myext_domain_model_company VALUES (1, 19, 1293308232, 1293308232, 1, 0, 'company1');
INSERT INTO tx_myext_domain_model_company VALUES (2, 19, 1293308232, 1293308232, 1, 0, 'company2');
INSERT INTO tx_myext_domain_model_company VALUES (3, 19, 1293308232, 1293308232, 1, 0, 'company3');

INSERT INTO tx_myext_domain_model_department VALUES (1, 19, 1293308232, 1293308232, 1, 0, 1, 10123);
INSERT INTO tx_myext_domain_model_department VALUES (2, 19, 1293308232, 1293308232, 1, 0, 1, 10324);
INSERT INTO tx_myext_domain_model_department VALUES (3, 19, 1293308232, 1293308232, 1, 0, 1, 11589);
INSERT INTO tx_myext_domain_model_department VALUES (4, 19, 1293308232, 1293308232, 1, 0, 2, 20001);
INSERT INTO tx_myext_domain_model_department VALUES (5, 19, 1293308232, 1293308232, 1, 0, 2, 20782);
INSERT INTO tx_myext_domain_model_department VALUES (6, 19, 1293308232, 1293308232, 1, 0, 3, 31983);
INSERT INTO tx_myext_domain_model_department VALUES (7, 19, 1293308232, 1293308232, 1, 0, 3, 32871);

INSERT INTO tx_myext_domain_model_service VALUES (1, 19, 1293308232, 1293308232, 1, 0, 'service1');
INSERT INTO tx_myext_domain_model_service VALUES (2, 19, 1293308232, 1293308232, 1, 0, 'service2');
INSERT INTO tx_myext_domain_model_service VALUES (3, 19, 1293308232, 1293308232, 1, 0, 'service3');
INSERT INTO tx_myext_domain_model_service VALUES (4, 19, 1293308232, 1293308232, 1, 0, 'service4');

INSERT INTO tx_myext_domain_model_department_service_mm VALUES (1, 1);
INSERT INTO tx_myext_domain_model_department_service_mm VALUES (1, 2);
INSERT INTO tx_myext_domain_model_department_service_mm VALUES (2, 1);
INSERT INTO tx_myext_domain_model_department_service_mm VALUES (3, 2);

INSERT INTO tx_myext_domain_model_department_service_mm VALUES (4, 2);
INSERT INTO tx_myext_domain_model_department_service_mm VALUES (4, 3);
INSERT INTO tx_myext_domain_model_department_service_mm VALUES (5, 2);
INSERT INTO tx_myext_domain_model_department_service_mm VALUES (5, 4);

INSERT INTO tx_myext_domain_model_department_service_mm VALUES (6, 1);
INSERT INTO tx_myext_domain_model_department_service_mm VALUES (7, 1);
INSERT INTO tx_myext_domain_model_department_service_mm VALUES (7, 4);