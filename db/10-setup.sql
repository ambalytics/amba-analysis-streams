-- SQL dump generated using DBML (dbml-lang.org)
-- Database: PostgreSQL
-- Generated at: 2021-08-31T10:04:33.412Z

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

CREATE TABLE "Publication" (
  "id" SERIAL PRIMARY KEY,
  "doi" varchar UNIQUE NOT NULL,
  "type" publication_type,
  "pubDate" varchar,
  "year" int,
  "publisher" varchar,
  "citationCount" int,
  "title" varchar,
  "normalizedTitle" varchar,
  "abstract" text
);

CREATE TABLE "Source" (
  "id" SERIAL PRIMARY KEY,
  "title" varchar,
  "url" varchar,
  "license" varchar
);

CREATE TABLE "FieldOfStudy" (
  "id" SERIAL PRIMARY KEY,
  "name" varchar,
  "normalizedName" varchar,
  "level" int
);

CREATE TABLE "Author" (
  "id" SERIAL PRIMARY KEY,
  "name" varchar,
  "normalizedName" varchar
);

CREATE TABLE "PublicationCitation" (
  "publicationDoi" varchar,
  "citationId" varchar,
  PRIMARY KEY ("publicationDoi", "citationId")
);

CREATE TABLE "PublicationReference" (
  "publicationDoi" varchar,
  "referenceId" varchar,
  PRIMARY KEY ("publicationDoi", "referenceId")
);

CREATE TABLE "PublicationFieldOfStudy" (
  "publicationDoi" varchar,
  "fieldOfStudyId" int,
  PRIMARY KEY ("publicationDoi", "fieldOfStudyId")
);

CREATE TABLE "PublicationAuthor" (
  "publicationDoi" varchar,
  "authorId" int,
  PRIMARY KEY ("publicationDoi", "authorId")
);

CREATE TABLE "PublicationSource" (
  "publicationDoi" varchar,
  "sourceId" int,
  PRIMARY KEY ("publicationDoi", "sourceId")
);

CREATE TABLE "DiscussionData" (
  "id" SERIAL PRIMARY KEY,
  "publicationDoi" varchar,
  "createdAt" timestamp,
  "score" float,
  "time_score" float,
  "type_score" float,
  "user_score" float,
  "abstractDifference" float,
  "length" int,
  "questions" int,
  "exclamations" int,
  "type" varchar,
  "sentiment" float,
  "subjId" int,
  "followers" int,
  "verified" boolean,
  "botScore" float,
  "authorName" varchar,
  "authorLocation" varchar,
  "sourceId" varchar
);

CREATE TABLE "DiscussionEntity" (
  "id" SERIAL PRIMARY KEY,
  "entity" varchar
);

CREATE TABLE "DiscussionHashtag" (
  "id" SERIAL PRIMARY KEY,
  "hashtag" varchar
);

CREATE TABLE "DiscussionWord" (
  "id" SERIAL PRIMARY KEY,
  "word" varchar
);

CREATE TABLE "DiscussionAuthor" (
  "id" SERIAL PRIMARY KEY,
  "name" varchar
);

CREATE TABLE "DiscussionEntityData" (
  "discussionDataId" int,
  "discussionEntityId" int,
  PRIMARY KEY ("discussionDataId", "discussionEntityId")
);

CREATE TABLE "DiscussionAuthorData" (
  "discussionDataId" int,
  "discussionAuthorId" int,
  PRIMARY KEY ("discussionDataId", "discussionAuthorId")
);

CREATE TABLE "DiscussionWordData" (
  "discussionDataId" int,
  "discussionWordId" int,
  "count" int,
  PRIMARY KEY ("discussionDataId", "discussionWordId")
);

CREATE TABLE "DiscussionHashtagData" (
  "discussionDataId" int,
  "discussionHashtagId" int,
  PRIMARY KEY ("discussionDataId", "discussionHashtagId")
);

ALTER TABLE "PublicationCitation" ADD FOREIGN KEY ("publicationDoi") REFERENCES "Publication" ("doi");

ALTER TABLE "PublicationCitation" ADD FOREIGN KEY ("citationId") REFERENCES "Publication" ("doi");

ALTER TABLE "PublicationReference" ADD FOREIGN KEY ("publicationDoi") REFERENCES "Publication" ("doi");

ALTER TABLE "PublicationReference" ADD FOREIGN KEY ("referenceId") REFERENCES "Publication" ("doi");

ALTER TABLE "PublicationFieldOfStudy" ADD FOREIGN KEY ("publicationDoi") REFERENCES "Publication" ("doi");

ALTER TABLE "PublicationFieldOfStudy" ADD FOREIGN KEY ("fieldOfStudyId") REFERENCES "FieldOfStudy" ("id");

ALTER TABLE "PublicationAuthor" ADD FOREIGN KEY ("publicationDoi") REFERENCES "Publication" ("doi");

ALTER TABLE "PublicationAuthor" ADD FOREIGN KEY ("authorId") REFERENCES "Author" ("id");

ALTER TABLE "PublicationSource" ADD FOREIGN KEY ("publicationDoi") REFERENCES "Publication" ("doi");

ALTER TABLE "PublicationSource" ADD FOREIGN KEY ("sourceId") REFERENCES "Source" ("id");

ALTER TABLE "DiscussionData" ADD FOREIGN KEY ("publicationDoi") REFERENCES "Publication" ("doi");

ALTER TABLE "DiscussionEntityData" ADD FOREIGN KEY ("discussionDataId") REFERENCES "DiscussionData" ("id");

ALTER TABLE "DiscussionEntityData" ADD FOREIGN KEY ("discussionEntityId") REFERENCES "DiscussionEntity" ("id");

ALTER TABLE "DiscussionAuthorData" ADD FOREIGN KEY ("discussionDataId") REFERENCES "DiscussionData" ("id");

ALTER TABLE "DiscussionAuthorData" ADD FOREIGN KEY ("discussionAuthorId") REFERENCES "DiscussionAuthor" ("id");

ALTER TABLE "DiscussionWordData" ADD FOREIGN KEY ("discussionDataId") REFERENCES "DiscussionData" ("id");

ALTER TABLE "DiscussionWordData" ADD FOREIGN KEY ("discussionWordId") REFERENCES "DiscussionWord" ("id");

ALTER TABLE "DiscussionHashtagData" ADD FOREIGN KEY ("discussionDataId") REFERENCES "DiscussionData" ("id");

ALTER TABLE "DiscussionHashtagData" ADD FOREIGN KEY ("discussionHashtagId") REFERENCES "DiscussionHashtag" ("id");


COMMENT ON COLUMN "Publication"."id" IS 'start with high value';
