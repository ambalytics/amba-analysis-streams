-- SQL dump generated using DBML (dbml-lang.org)
-- Database: PostgreSQL
-- Generated at: 2021-09-19T15:06:01.571Z

CREATE TYPE "publication_type" AS ENUM (
  'UNKNOWN',
  'BOOK',
  'BOOK_CHAPTER',
  'CONFERENCE_PAPER',
  'DATASET',
  'JOURNAL_ARTICLE',
  'PATENT',
  'REPOSITORY',
  'BOOK_REFERENCE_ENTRY',
  'THESIS'
);

CREATE TABLE "publication" (
  "id" BIGSERIAL PRIMARY KEY,
  "doi" varchar UNIQUE NOT NULL,
  "type" publication_type,
  "pub_date" varchar,
  "year" int,
  "publisher" varchar,
  "citation_count" int,
  "title" varchar,
  "normalized_title" varchar,
  "abstract" text
);

CREATE TABLE "publication_citation" (
  "publication_doi" varchar,
  "citation_doi" varchar,
  PRIMARY KEY ("publication_doi", "citation_doi")
);

CREATE TABLE "publication_reference" (
  "publication_doi" varchar,
  "reference_doi" varchar,
  PRIMARY KEY ("publication_doi", "reference_doi")
);

CREATE TABLE "source" (
  "id" BIGSERIAL PRIMARY KEY,
  "title" varchar,
  "url" varchar,
  "license" varchar
);

CREATE TABLE "publication_source" (
  "publication_doi" varchar,
  "source_id" bigint,
  PRIMARY KEY ("publication_doi", "source_id")
);

CREATE TABLE "author" (
  "id" BIGSERIAL PRIMARY KEY,
  "name" varchar,
  "normalized_name" varchar
);

CREATE TABLE "publication_author" (
  "publication_doi" varchar,
  "author_id" bigint,
  PRIMARY KEY ("publication_doi", "author_id")
);

CREATE TABLE "field_of_study" (
  "id" BIGSERIAL PRIMARY KEY,
  "name" varchar,
  "normalized_name" varchar,
  "level" int
);

CREATE TABLE "publication_field_of_study" (
  "publication_doi" varchar,
  "field_of_study_id" bigint,
  PRIMARY KEY ("publication_doi", "field_of_study_id")
);

CREATE TABLE "field_of_study_children" (
  "field_of_study_id" bigint,
  "child_field_of_study_id" bigint,
  PRIMARY KEY ("field_of_study_id", "child_field_of_study_id")
);

CREATE TABLE "discussion_entity" (
  "id" BIGSERIAL PRIMARY KEY,
  "entity" varchar
);

CREATE TABLE "discussion_entity_data" (
  "publication_doi" varchar,
  "discussion_entity_id" bigint,
  "count" int,
  PRIMARY KEY ("publication_doi", "discussion_entity_id")
);

CREATE TABLE "discussion_hashtag" (
  "id" BIGSERIAL PRIMARY KEY,
  "hashtag" varchar
);

CREATE TABLE "discussion_hashtag_data" (
  "publication_doi" varchar,
  "discussion_hashtag_id" bigint,
  "count" int,
  PRIMARY KEY ("publication_doi", "discussion_hashtag_id")
);

CREATE TABLE "discussion_word" (
  "id" BIGSERIAL PRIMARY KEY,
  "word" varchar
);

CREATE TABLE "discussion_word_data" (
  "publication_doi" varchar,
  "discussion_word_id" bigint,
  "count" int,
  PRIMARY KEY ("publication_doi", "discussion_word_id")
);

CREATE TABLE "discussion_location" (
  "id" BIGSERIAL PRIMARY KEY,
  "location" varchar
);

CREATE TABLE "discussion_location_data" (
  "publication_doi" varchar,
  "discussion_location_id" bigint,
  "count" int,
  PRIMARY KEY ("publication_doi", "discussion_location_id")
);

CREATE TABLE "discussion_author" (
  "id" BIGSERIAL PRIMARY KEY,
  "author" varchar
);

CREATE TABLE "discussion_author_data" (
  "publication_doi" varchar,
  "discussion_author_id" bigint,
  "count" int,
  PRIMARY KEY ("publication_doi", "discussion_author_id")
);

CREATE TABLE "discussion_lang" (
  "id" BIGSERIAL PRIMARY KEY,
  "lang" varchar
);

CREATE TABLE "discussion_lang_data" (
  "publication_doi" varchar,
  "discussion_lang_id" bigint,
  "count" int,
  PRIMARY KEY ("publication_doi", "discussion_lang_id")
);

CREATE TABLE "discussion_type" (
  "id" BIGSERIAL PRIMARY KEY,
  "type" varchar
);

CREATE TABLE "discussion_type_data" (
  "publication_doi" varchar,
  "discussion_type_id" bigint,
  "count" int,
  PRIMARY KEY ("publication_doi", "discussion_type_id")
);

CREATE TABLE "discussion_source" (
  "id" BIGSERIAL PRIMARY KEY,
  "source" varchar
);

CREATE TABLE "discussion_source_data" (
  "publication_doi" varchar,
  "discussion_source_id" bigint,
  "count" int,
  PRIMARY KEY ("publication_doi", "discussion_source_id")
);

CREATE TABLE "trending" (
  "id" BIGSERIAL PRIMARY KEY,
  "publication_doi" varchar,
  "duration" int,
  "score" float,
  "count" int,
  "median_sentiment" float,
  "sum_follower" int,
  "abstract_difference" float,
  "tweet_author_eveness" float,
  "lang_eveness" float,
  "location_eveness" float,
  "median_age" float,
  "median_length" float,
  "mean_questions" float,
  "mean_exclamations" float,
  "mean_bot_rating" float,
  "projected_change" float,
  "trending" float,
  "ema" float,
  "kama" float,
  "ker" float,
  "mean_score" float,
  "stddev" float,
);

ALTER TABLE "publication_citation" ADD FOREIGN KEY ("publication_doi") REFERENCES "publication" ("doi");

ALTER TABLE "publication_citation" ADD FOREIGN KEY ("citation_doi") REFERENCES "publication" ("doi");

ALTER TABLE "publication_reference" ADD FOREIGN KEY ("publication_doi") REFERENCES "publication" ("doi");

ALTER TABLE "publication_reference" ADD FOREIGN KEY ("reference_doi") REFERENCES "publication" ("doi");

ALTER TABLE "publication_source" ADD FOREIGN KEY ("publication_doi") REFERENCES "publication" ("doi");

ALTER TABLE "publication_source" ADD FOREIGN KEY ("source_id") REFERENCES "source" ("id");

ALTER TABLE "publication_author" ADD FOREIGN KEY ("publication_doi") REFERENCES "publication" ("doi");

ALTER TABLE "publication_author" ADD FOREIGN KEY ("author_id") REFERENCES "author" ("id");

ALTER TABLE "publication_field_of_study" ADD FOREIGN KEY ("publication_doi") REFERENCES "publication" ("doi");

ALTER TABLE "publication_field_of_study" ADD FOREIGN KEY ("field_of_study_id") REFERENCES "field_of_study" ("id");

ALTER TABLE "field_of_study_children" ADD FOREIGN KEY ("field_of_study_id") REFERENCES "field_of_study" ("id");

ALTER TABLE "field_of_study_children" ADD FOREIGN KEY ("child_field_of_study_id") REFERENCES "field_of_study" ("id");

ALTER TABLE "discussion_entity_data" ADD FOREIGN KEY ("publication_doi") REFERENCES "publication" ("doi");

ALTER TABLE "discussion_entity_data" ADD FOREIGN KEY ("discussion_entity_id") REFERENCES "discussion_entity" ("id");

ALTER TABLE "discussion_hashtag_data" ADD FOREIGN KEY ("publication_doi") REFERENCES "publication" ("doi");

ALTER TABLE "discussion_hashtag_data" ADD FOREIGN KEY ("discussion_hashtag_id") REFERENCES "discussion_hashtag" ("id");

ALTER TABLE "discussion_word_data" ADD FOREIGN KEY ("publication_doi") REFERENCES "publication" ("doi");

ALTER TABLE "discussion_word_data" ADD FOREIGN KEY ("discussion_word_id") REFERENCES "discussion_word" ("id");

ALTER TABLE "discussion_location_data" ADD FOREIGN KEY ("publication_doi") REFERENCES "publication" ("doi");

ALTER TABLE "discussion_location_data" ADD FOREIGN KEY ("discussion_location_id") REFERENCES "discussion_location" ("id");

ALTER TABLE "discussion_author_data" ADD FOREIGN KEY ("publication_doi") REFERENCES "publication" ("doi");

ALTER TABLE "discussion_author_data" ADD FOREIGN KEY ("discussion_author_id") REFERENCES "discussion_author" ("id");

ALTER TABLE "discussion_lang_data" ADD FOREIGN KEY ("publication_doi") REFERENCES "publication" ("doi");

ALTER TABLE "discussion_lang_data" ADD FOREIGN KEY ("discussion_lang_id") REFERENCES "discussion_lang" ("id");

ALTER TABLE "discussion_type_data" ADD FOREIGN KEY ("publication_doi") REFERENCES "publication" ("doi");

ALTER TABLE "discussion_type_data" ADD FOREIGN KEY ("discussion_type_id") REFERENCES "discussion_type" ("id");

ALTER TABLE "discussion_source_data" ADD FOREIGN KEY ("publication_doi") REFERENCES "publication" ("doi");

ALTER TABLE "discussion_source_data" ADD FOREIGN KEY ("discussion_source_id") REFERENCES "discussion_source" ("id");

ALTER TABLE "trending" ADD FOREIGN KEY ("publication_doi") REFERENCES "publication" ("doi");


COMMENT ON COLUMN "publication"."id" IS 'start with high value';
