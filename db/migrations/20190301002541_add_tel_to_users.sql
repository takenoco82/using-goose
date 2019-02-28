-- +goose Up
-- SQL in this section is executed when the migration is applied.
ALTER TABLE users ADD COLUMN tel varchar(14) NULL DEFAULT NULL AFTER email;


-- +goose Down
-- SQL in this section is executed when the migration is rolled back.
ALTER TABLE users DROP COLUMN tel;
