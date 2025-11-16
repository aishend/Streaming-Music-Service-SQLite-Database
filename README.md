# Music Streaming Service - Database Design

Database Systems course project at Faculty of Engineering, University of Porto (FEUP).

**Course:** Bases de Dados (Database Systems)

**Instructor:** Prof. Lázaro Costa

**Academic Year:** 2025

**Team Members:** Leandro Moreira, Ricardo Silva

## Overview

This project involves the complete design and implementation of a relational database for a music streaming service, similar to platforms like Spotify. The database supports users, artists, tracks, albums, playlists, podcasts, subscriptions, and listening history.

## Project Structure

```
├── docs/
│   ├── uml.drawio
│   └── report.pdf
├── sql/
│   ├── schema.sql
│   └── data.sql
└── README.md
```

## Key Features

- **User Management**: Free and Premium user types with subscription control
- **Music Catalog**: Tracks, albums, artists, genres, and record labels
- **Playlists**: User-created playlists with collaborative features
- **Podcasts**: Episodes, participants, and podcast-specific metadata
- **Listening History**: Track and episode playback tracking
- **Multi-device Support**: Session management across devices

## Database Schema Highlights

The relational schema includes 25+ tables organized around core entities:

- Users (Free/Premium specialization)
- Artists and Collaborations
- Tracks, Albums, and Genres
- Playlists and Access Control
- Podcasts, Episodes, and Participants
- Subscriptions and Payments
- Device Sessions and Listening History

## Normalization

The schema adheres to **Third Normal Form (3NF)** and **Boyce-Codd Normal Form (BCNF)**, ensuring minimal redundancy and optimal data integrity.

## AI Integration

This project incorporated generative AI tools for:

- Schema validation and consistency checking
- Identification of naming inconsistencies
- Detection of missing attributes from UML to relational conversion
- Functional dependency analysis
- Final Implementation

## Technology Stack

- **Database**: SQLite
- **Modeling**: draw.io
- **Documentation**: docx, Markdown

## Setup Instructions

1. Clone this repository

2. Run the schema creation script:

```
sqlite3 music_streaming.db < sql/schema.sql
```

3. Load sample data (optional):

```
sqlite3 music_streaming.db < sql/data.sql
```

## Documentation

For detailed information about the conceptual model, functional dependencies, normalization analysis, and AI integration process, please refer to the full report in `docs/report.pdf` (portuguese).


## License

This is an academic project developed for the Database Systems course at FEUP.
The code is provided for educational purposes only.

© 2025 Leandro Moreira, Ricardo Silva - FEUP
Academic project - FEUP 2025

