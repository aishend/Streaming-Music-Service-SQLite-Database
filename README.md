# Music Streaming Service - Database Design

## Overview

This project involves the complete design and implementation of a relational database for a music streaming service, similar to platforms like Spotify. The database supports users, artists, tracks, albums, playlists, podcasts, subscriptions, and listening history.

## Project Structure

```
SQL/
├── docs/
│   └── images/
├── sql/
│   └── data/
│       ├── create/
│       │   ├── create1.sql
│       │   └── create2.sql
│       └── populate/
│           ├── populate1.sql
│           └── populate2.sql
├── LICENSE
└── README.md
```

## Key Features

- **User Management**: Free and Premium user types with subscription control
- **Music Catalog**: Tracks, albums, artists, genres, and record labels
- **Playlists**: User-created playlists with collaborative features
- **Podcasts**: Episodes, participants, and podcast-specific metadata
- **Listening History**: Track and episode playback tracking
- **Multi-device Support**: Session management across devices

## Database Schema

The relational schema includes 25+ tables organized around core entities:

- **Users**: Free/Premium user specialization with role-based access control
- **Artists**: Artist profiles, debut years, and country information
- **Tracks & Albums**: Music catalog with duration and release data
- **Genres**: Classification system for tracks and albums
- **Playlists**: User-created playlists with public/private access control
- **Podcasts & Episodes**: Podcast catalog with episode management
- **Subscriptions**: Four plan types (Free, Individual, Duo, Family) with payments
- **Devices & Sessions**: Multi-device support with session tracking
- **Listening History**: Track and episode playback records
- **Collaborations**: Artist roles in tracks
- **Record Labels**: Artist contracts with labels
- **Participants**: Podcast hosts and guests with roles

## Normalization

The schema adheres to **Third Normal Form (3NF)** and **Boyce-Codd Normal Form (BCNF)**, ensuring minimal redundancy and optimal data integrity.

## AI Integration

This project incorporated generative AI tools for:

- Schema validation and consistency checking
- Identification of naming inconsistencies
- Detection of missing attributes from UML to relational conversion
- Functional dependency analysis
- Final Implementation

## Database Versions

This project includes two versions of the database schema:

- **Version 1** (`create1.sql`, `populate1.sql`): Initial schema design with basic constraints
- **Version 2** (`create2.sql`, `populate2.sql`): Enhanced schema with improved data types (TEXT instead of CHAR), better constraints, and refined validation rules

Version 2 includes improvements such as:
- Email format validation
- Enhanced CHECK constraints with IN clauses
- Better handling of BOOLEAN types (0/1 INTEGER)
- More robust date and numeric validations

## Technology Stack

- **Database**: SQLite 3
- **Language**: SQL
- **Documentation**: Markdown

## Setup Instructions

### Using Version 2 (Recommended)

1. Clone this repository

2. Create and populate the database:

```bash
sqlite3 music_streaming.db < sql/data/create/create2.sql
sqlite3 music_streaming.db < sql/data/populate/populate2.sql
```

### Using Version 1

```bash
sqlite3 music_streaming.db < sql/data/create/create1.sql
sqlite3 music_streaming.db < sql/data/populate/populate1.sql
```

## Sample Data

The database includes sample data with:
- 13 users (listeners, creators, admins, moderators)
- 12 artists (international music artists)
- 10 podcasts with episodes
- 7 albums with 10 tracks
- 10 genres
- 8 playlists
- 10 devices across different locations
- Subscription plans and payment records
- Listening history for tracks and episodes


## License

This is an academic project developed for the Database Systems course at FEUP.
The code is provided for educational purposes only.

© 2025 Leandro Moreira - FEUP

