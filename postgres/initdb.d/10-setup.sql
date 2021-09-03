-- SQL dump generated using DBML (dbml-lang.org)
-- Database: PostgreSQL
-- Generated at: 2021-08-31T13:44:27.861Z

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
  "id" BIGSERIAL PRIMARY KEY,
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
  "id" BIGSERIAL PRIMARY KEY,
  "title" varchar,
  "url" varchar,
  "license" varchar
);

CREATE TABLE "FieldOfStudy" (
  "id" BIGSERIAL PRIMARY KEY,
  "name" varchar,
  "normalizedName" varchar,
  "level" int
);

CREATE TABLE "Author" (
  "id" BIGSERIAL PRIMARY KEY,
  "name" varchar,
  "normalizedName" varchar
);

CREATE TABLE "PublicationCitation" (
  "publicationDoi" varchar NOT NULL,
  "citationId" varchar NOT NULL,
  PRIMARY KEY ("publicationDoi", "citationId")
);

CREATE TABLE "PublicationReference" (
  "publicationDoi" varchar NOT NULL,
  "referenceId" varchar NOT NULL,
  PRIMARY KEY ("publicationDoi", "referenceId")
);

CREATE TABLE "PublicationFieldOfStudy" (
  "publicationDoi" varchar NOT NULL,
  "fieldOfStudyId" bigint NOT NULL,
  PRIMARY KEY ("publicationDoi", "fieldOfStudyId")
);

CREATE TABLE "PublicationAuthor" (
  "publicationDoi" varchar NOT NULL,
  "authorId" bigint NOT NULL,
  PRIMARY KEY ("publicationDoi", "authorId")
);

CREATE TABLE "PublicationSource" (
  "publicationDoi" varchar NOT NULL,
  "sourceId" bigint NOT NULL,
  PRIMARY KEY ("publicationDoi", "sourceId")
);

CREATE TABLE "DiscussionData" (
  "id" BIGSERIAL PRIMARY KEY,
  "publicationDoi" varchar,
  "createdAt" timestamp,
  "score" float,
  "timeScore" float,
  "typeScore" float,
  "userScore" float,
  "language" varchar,
  "source" varchar,
  "abstractDifference" float,
  "length" int,
  "questions" int,
  "exclamations" int,
  "type" varchar,
  "sentiment" float,
  "subjId" bigint,
  "followers" int,
  "botScore" float,
  "authorName" varchar,
  "authorLocation" varchar,
  "sourceId" varchar
);

CREATE TABLE "DiscussionEntity" (
  "id" BIGSERIAL PRIMARY KEY,
  "entity" varchar
);

CREATE TABLE "DiscussionHashtag" (
  "id" BIGSERIAL PRIMARY KEY,
  "hashtag" varchar
);

CREATE TABLE "DiscussionWord" (
  "id" BIGSERIAL PRIMARY KEY,
  "word" varchar
);

CREATE TABLE "DiscussionAuthor" (
  "id" BIGSERIAL PRIMARY KEY,
  "name" varchar
);

CREATE TABLE "DiscussionEntityData" (
  "discussionDataId" bigint NOT NULL,
  "discussionEntityId" bigint NOT NULL,
  PRIMARY KEY ("discussionDataId", "discussionEntityId")
);

CREATE TABLE "DiscussionAuthorData" (
  "discussionDataId" bigint NOT NULL,
  "discussionAuthorId" bigint NOT NULL,
  PRIMARY KEY ("discussionDataId", "discussionAuthorId")
);

CREATE TABLE "DiscussionWordData" (
  "discussionDataId" bigint NOT NULL,
  "discussionWordId" bigint NOT NULL,
  "count" int,
  PRIMARY KEY ("discussionDataId", "discussionWordId")
);

CREATE TABLE "DiscussionHashtagData" (
  "discussionDataId" bigint NOT NULL,
  "discussionHashtagId" bigint NOT NULL,
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
