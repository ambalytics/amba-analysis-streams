-- SQL dump generated using DBML (dbml-lang.org)
-- Database: PostgreSQL
-- Generated at: 2021-10-04T08:00:04.068Z

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
  "normalized_name" varchar
);

CREATE TABLE "publication_field_of_study" (
  "publication_doi" varchar,
  "field_of_study_id" bigint,
  PRIMARY KEY ("publication_doi", "field_of_study_id")
);

CREATE TABLE "publication_not_found" (
  "publication_doi" varchar PRIMARY KEY,
  "last_try" datetime
  "pub_missing" varchar
);

CREATE TABLE "discussion_data" (
  "id" BIGSERIAL PRIMARY KEY,
  "value" varchar,
  "type" varchar
);

CREATE TABLE "discussion_data_point" (
  "publication_doi" varchar,
  "discussion_data_point_id" bigint,
  "count" int,
  PRIMARY KEY ("publication_doi", "discussion_data_point_id")
);

CREATE TABLE "discussion_newest_subj" (
  "id" BIGSERIAL PRIMARY KEY,
  "type" varchar,
  "publication_doi" varchar,
  "sub_id" varchar,
  "created_at" datetime,
  "score" float,
  "bot_rating" float,
  "followers" int,
  "sentiment_raw" float,
  "contains_abstract_raw" float,
  "lang" varchar,
  "location" varchar,
  "source" varchar,
  "subj_type" varchar,
  "question_mark_count" int,
  "exclamation_mark_count" int,
  "length" int,
  "entities" json
);

CREATE TABLE "trending" (
  "id" BIGSERIAL PRIMARY KEY,
  "publication_doi" varchar,
  "duration" str,
  "score" float,
  "count" int,
  "mean_sentiment" float,
  "sum_followers" int,
  "abstract_difference" float,
  "mean_age" float,
  "mean_length" float,
  "mean_questions" float,
  "mean_exclamations" float,
  "mean_bot_rating" float,
  "projected_change" float,
  "trending" float,
  "ema" float,
  "kama" float,
  "ker" float,
  "mean_score" float,
  "stddev" float
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

ALTER TABLE "discussion_data_point" ADD FOREIGN KEY ("publication_doi") REFERENCES "publication" ("doi");

ALTER TABLE "discussion_data_point" ADD FOREIGN KEY ("discussion_data_point_id") REFERENCES "discussion_data" ("id");

ALTER TABLE "discussion_newest_subj" ADD FOREIGN KEY ("publication_doi") REFERENCES "publication" ("doi");

ALTER TABLE "trending" ADD FOREIGN KEY ("publication_doi") REFERENCES "publication" ("doi");

CREATE INDEX ON "publication" ("doi");

CREATE INDEX ON "discussion_data" ("type");

create index trending_publication_doi_duration_index
	on trending (publication_doi, duration);

create index discussion_newest_subj_created_at_index
    on discussion_newest_subj (created_at);

create index discussion_newest_subj_publication_doi_index
    on discussion_newest_subj (publication_doi);

COMMENT ON COLUMN "publication"."id" IS 'start with high value';
