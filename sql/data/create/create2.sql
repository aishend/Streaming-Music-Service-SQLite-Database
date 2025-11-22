PRAGMA foreign_keys = off;

DROP TABLE IF EXISTS User;
DROP TABLE IF EXISTS Artist;
DROP TABLE IF EXISTS ArtistFollowing;
DROP TABLE IF EXISTS Podcast;
DROP TABLE IF EXISTS PodcastFollowing;
DROP TABLE IF EXISTS Device;
DROP TABLE IF EXISTS Subscription;
DROP TABLE IF EXISTS SessionInfo;
DROP TABLE IF EXISTS FreeUser;
DROP TABLE IF EXISTS PremiumUser;
DROP TABLE IF EXISTS Track;
DROP TABLE IF EXISTS TrackListeningHistory;
DROP TABLE IF EXISTS Playlist;
DROP TABLE IF EXISTS TrackInPlaylist;
DROP TABLE IF EXISTS UserAccessPlaylist;
DROP TABLE IF EXISTS Collaboration;
DROP TABLE IF EXISTS RecordLabel;
DROP TABLE IF EXISTS ContractWithLabel;
DROP TABLE IF EXISTS Genre;
DROP TABLE IF EXISTS TrackOfGenre;
DROP TABLE IF EXISTS Album;
DROP TABLE IF EXISTS AlbumOfGenre;
DROP TABLE IF EXISTS Participant;
DROP TABLE IF EXISTS PodcastRole;
DROP TABLE IF EXISTS Episode;
DROP TABLE IF EXISTS Payment;
DROP TABLE IF EXISTS EpisodeListeningHistory;


CREATE TABLE User 
(
    UserID INTEGER PRIMARY KEY NOT NULL,
    Name TEXT NOT NULL,
    Email TEXT NOT NULL CONSTRAINT ValidEmailFormat CHECK (Email LIKE '%_@__%.__%'),
    Role TEXT NOT NULL 
        CONSTRAINT ValidUserRole CHECK (Role IN ('Listener', 
                                                 'Creator', 
                                                 'Admin', 
                                                 'Moderator')),
    Password TEXT NOT NULL,
    DateJoined DATE NOT NULL
);


CREATE TABLE Artist
(
    ArtistID INTEGER PRIMARY KEY NOT NULL,
    Name TEXT NOT NULL,
    Country TEXT NOT NULL,
    DebutYear INTEGER NOT NULL
        CONSTRAINT ValidDebutYear CHECK (DebutYear > 1900 AND DebutYear <= 2025)
);


CREATE TABLE ArtistFollowing
(
    UserID INTEGER NOT NULL 
        REFERENCES User(UserID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    ArtistID INTEGER NOT NULL 
        REFERENCES Artist(ArtistID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    Date DATE NOT NULL,
    PRIMARY KEY
    (
        UserID,
        ArtistID
    )
);


CREATE TABLE Podcast
(
    PodcastID INTEGER PRIMARY KEY NOT NULL,
    Name TEXT NOT NULL,
    Description TEXT NOT NULL
);


CREATE TABLE PodcastFollowing
(
    UserID INTEGER NOT NULL 
        REFERENCES User(UserID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    PodcastID INTEGER NOT NULL 
        REFERENCES Podcast(PodcastID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    Date DATE NOT NULL,
    PRIMARY KEY
    (
        UserID,
        PodcastID
    )
);


CREATE TABLE Device
(
    DeviceID INTEGER PRIMARY KEY NOT NULL,
    IpAddress TEXT NOT NULL,
    OS TEXT NOT NULL
        CONSTRAINT ValidOS CHECK (OS IN ('Android', 
                                         'iOS', 
                                         'Windows', 
                                         'Linux')),
    Location TEXT NOT NULL
);


CREATE TABLE Subscription
(
    SubscriptionID INTEGER PRIMARY KEY NOT NULL,
    PlanType TEXT NOT NULL
        CONSTRAINT ValidPlanType CHECK (PlanType IN ('Free', 
                                                     'Individual', 
                                                     'Duo', 
                                                     'Family')),
    StartDate DATE NOT NULL,
    EndDate DATE
        CONSTRAINT ValidDateRange CHECK (EndDate IS NULL OR EndDate > StartDate),
        CONSTRAINT ValidFreeTierDate CHECK 
        ((PlanType = 'Free' AND EndDate IS NULL) OR (PlanType <> 'Free' AND EndDate IS NOT NULL))
);


CREATE TABLE SessionInfo
(
    UserID INTEGER NOT NULL 
        REFERENCES User(UserID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    DeviceID INTEGER NOT NULL 
        REFERENCES Device(DeviceID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    SubscriptionID INTEGER NOT NULL 
        REFERENCES Subscription(SubscriptionID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    IsActive INTEGER NOT NULL CHECK (IsActive IN (0, 1)),
    RevokedAt DATE NOT NULL,
    LastAccessAt DATE NOT NULL
        CONSTRAINT ValidAccessTime CHECK (LastAccessAt <= RevokedAt),
    PRIMARY KEY
    (
        UserID,
        DeviceID
    )
);


CREATE TABLE FreeUser
(
    UserID INTEGER NOT NULL 
        REFERENCES User(UserID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    LastAdTimestamp DATE NOT NULL,
    MaxDailySkips INTEGER NOT NULL
        CONSTRAINT ValidDailySkips CHECK (MaxDailySkips == 6),
    AdsWatchedCount INTEGER NOT NULL DEFAULT 0 CHECK (AdsWatchedCount >= 0),
    PRIMARY KEY (UserID)
);


CREATE TABLE PremiumUser
(
    UserID INTEGER NOT NULL 
        REFERENCES User(UserID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    MaxOfflineDevices INTEGER NOT NULL DEFAULT 1 CHECK (MaxOfflineDevices > 0),
    MaxDownloadedTracks INTEGER NOT NULL CHECK (MaxDownloadedTracks >= 0),
    PRIMARY KEY (UserID) 
);


CREATE TABLE Track
(
    TrackID INTEGER PRIMARY KEY NOT NULL,
    Title   TEXT NOT NULL,
    Duration INTEGER NOT NULL CHECK (Duration > 0),
    AlbumID INTEGER NOT NULL 
        REFERENCES Album(AlbumID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


CREATE TABLE TrackListeningHistory
(
    UserID INTEGER NOT NULL 
        REFERENCES User(UserID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    TrackID INTEGER NOT NULL 
        REFERENCES Track(TrackID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    TimePlayed INTEGER NOT NULL DEFAULT 0 CHECK (TimePlayed >= 0),
    PRIMARY KEY
    (
        UserID,
        TrackID
    )
);


CREATE TABLE Playlist
(
    PlaylistID INTEGER PRIMARY KEY NOT NULL,
    Title TEXT NOT NULL,
    CreationDate DATE NOT NULL,
    IsPublic INTEGER NOT NULL CHECK (IsPublic IN (0, 1)),
    NumberOfTracks INTEGER NOT NULL DEFAULT 0 CHECK (NumberOfTracks >= 0)
);


CREATE TABLE TrackInPlaylist
(
    PlaylistID INTEGER NOT NULL 
        REFERENCES Playlist(PlaylistID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    TrackID INTEGER NOT NULL 
        REFERENCES Track(TrackID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    PRIMARY KEY
    (
        PlaylistID,
        TrackID
    )
);


CREATE TABLE UserAccessPlaylist
(
    UserID INTEGER NOT NULL 
        REFERENCES User(UserID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    PlaylistID INTEGER NOT NULL 
        REFERENCES Playlist(PlaylistID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    PRIMARY KEY
    (
        UserID,
        PlaylistID
    )
);


CREATE TABLE Collaboration
(
    ArtistID INTEGER NOT NULL 
        REFERENCES Artist(ArtistID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    TrackID INTEGER NOT NULL 
        REFERENCES Track(TrackID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    Role TEXT NOT NULL,
    PRIMARY KEY
    (
        ArtistID,
        TrackID
    )
);


CREATE TABLE RecordLabel
(
    LabelID INTEGER PRIMARY KEY NOT NULL,
    Name TEXT NOT NULL,
    Country TEXT NOT NULL
);


CREATE TABLE ContractWithLabel
(
    ArtistID INTEGER NOT NULL 
        REFERENCES Artist(ArtistID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    LabelID INTEGER NOT NULL 
        REFERENCES RecordLabel(LabelID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    PRIMARY KEY
    (
        ArtistID,
        LabelID
    )
);


CREATE TABLE Genre
(
    GenreID INTEGER PRIMARY KEY NOT NULL,
    Name TEXT NOT NULL,
    Description TEXT NOT NULL
);


CREATE TABLE TrackOfGenre
(
    TrackID INTEGER PRIMARY KEY NOT NULL 
        REFERENCES Track(TrackID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    GenreID INTEGER NOT NULL 
        REFERENCES Genre(GenreID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


CREATE TABLE Album
(
    AlbumID INTEGER PRIMARY KEY NOT NULL,
    Title TEXT NOT NULL,
    ReleaseDate DATE NOT NULL,
    Duration INTEGER NOT NULL CHECK (Duration > 0)
);


CREATE TABLE AlbumOfGenre
(
    AlbumID INTEGER PRIMARY KEY NOT NULL 
        REFERENCES Album(AlbumID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    GenreID INTEGER NOT NULL 
        REFERENCES Genre(GenreID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


CREATE TABLE Participant
(
    ParticipantID INTEGER PRIMARY KEY NOT NULL,
    Name TEXT NOT NULL,
    Bio TEXT NOT NULL,
    Country TEXT NOT NULL,
    Contact TEXT NOT NULL
);


CREATE TABLE PodcastRole
(
    ParticipantID INTEGER NOT NULL 
        REFERENCES Participant(ParticipantID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    PodcastID INTEGER NOT NULL 
        REFERENCES Podcast(PodcastID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    Role TEXT NOT NULL,
    PRIMARY KEY
    (
        ParticipantID,
        PodcastID
    )
);


CREATE TABLE Episode
(
    EpisodeID INTEGER PRIMARY KEY NOT NULL,
    Title TEXT NOT NULL,
    Description TEXT NOT NULL,
    Duration INTEGER NOT NULL CHECK (Duration > 0),
    ReleaseDate DATE NOT NULL,
    EpisodeNumber INTEGER NOT NULL CHECK (EpisodeNumber > 0),
    PodcastID INTEGER NOT NULL 
        REFERENCES Podcast(PodcastID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


CREATE TABLE Payment
(
    PaymentID INTEGER PRIMARY KEY NOT NULL,
    Amount REAL NOT NULL CHECK (Amount >= 0),
    Method TEXT NOT NULL,
    Date DATE NOT NULL,
    SubscriptionID INTEGER NOT NULL 
        REFERENCES Subscription(SubscriptionID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


CREATE TABLE EpisodeListeningHistory
(
    UserID INTEGER NOT NULL 
        REFERENCES User(UserID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    EpisodeID INTEGER NOT NULL 
        REFERENCES Episode(EpisodeID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    TimePlayed INTEGER NOT NULL DEFAULT 0 CHECK (TimePlayed >= 0), 
    PRIMARY KEY
    (
        UserID,
        EpisodeID
    )
);


PRAGMA foreign_keys = on;
