-- +goose Up
-- SQL in this section is executed when the migration is applied.
CREATE TABLE IF NOT EXISTS `companies` (
  `company_id` INT NOT NULL AUTO_INCREMENT,
  `company_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`company_id`))
ENGINE = InnoDB;

ALTER TABLE users ADD COLUMN company_id integer(11) NULL DEFAULT NULL,
                  ADD INDEX fk_users_companies_idx (company_id),
                  ADD CONSTRAINT fk_users_companies FOREIGN KEY (company_id) REFERENCES companies (company_id);


-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
ALTER TABLE users DROP FOREIGN KEY fk_users_companies,
                  DROP INDEX fk_users_companies_idx,
                  DROP COLUMN company_id;

DROP TABLE IF EXISTS `companies`;
