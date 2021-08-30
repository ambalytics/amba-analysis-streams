-- SQL dump generated using DBML (dbml-lang.org)
-- Database: PostgreSQL
-- Generated at: 2021-08-30T20:28:17.608Z

CREATE TYPE "PublicationType" AS ENUM (
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
  "type" PublicationType,
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
  "publicationDoi" int,
  "citationId" int
);

CREATE TABLE "PublicationReference" (
  "publicationDoi" int,
  "referenceId" int
);

CREATE TABLE "PublicationFieldOfStudy" (
  "publicationDoi" int,
  "fieldOfStudyId" int
);

CREATE TABLE "PublicationAuthor" (
  "publicationDoi" int,
  "authorId" int
);

CREATE TABLE "PublicationSource" (
  "publicationDoi" int,
  "sourceId" int
);

CREATE TABLE "DiscussionData" (
  "id" SERIAL PRIMARY KEY,
  "publicationId" int,
  "createdAt" timestamp,
  "score" int,
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
  "discussionEntityId" int
);

CREATE TABLE "DiscussionAuthorData" (
  "discussionDataId" int,
  "discussionAuthorId" int
);

CREATE TABLE "DiscussionWordData" (
  "discussionDataId" int,
  "discussionWordId" int
);

CREATE TABLE "DiscussionHashtagData" (
  "discussionDataId" int,
  "iscussionHashtagId" int
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

ALTER TABLE "DiscussionData" ADD FOREIGN KEY ("publicationId") REFERENCES "Publication" ("id");

ALTER TABLE "DiscussionEntityData" ADD FOREIGN KEY ("discussionDataId") REFERENCES "DiscussionData" ("id");

ALTER TABLE "DiscussionEntityData" ADD FOREIGN KEY ("discussionEntityId") REFERENCES "DiscussionEntity" ("id");

ALTER TABLE "DiscussionAuthorData" ADD FOREIGN KEY ("discussionDataId") REFERENCES "DiscussionData" ("id");

ALTER TABLE "DiscussionAuthorData" ADD FOREIGN KEY ("discussionAuthorId") REFERENCES "DiscussionAuthor" ("id");

ALTER TABLE "DiscussionWordData" ADD FOREIGN KEY ("discussionDataId") REFERENCES "DiscussionData" ("id");

ALTER TABLE "DiscussionWordData" ADD FOREIGN KEY ("discussionWordId") REFERENCES "DiscussionWord" ("id");

ALTER TABLE "DiscussionHashtagData" ADD FOREIGN KEY ("discussionDataId") REFERENCES "DiscussionData" ("id");

ALTER TABLE "DiscussionHashtagData" ADD FOREIGN KEY ("iscussionHashtagId") REFERENCES "DiscussionHashtag" ("id");

COMMENT ON COLUMN "Publication"."id" IS 'start with high value';
