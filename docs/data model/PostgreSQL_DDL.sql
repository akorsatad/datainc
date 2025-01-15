------------------------------------------------------------------------------
-- Drop Tables if needed (optional)
------------------------------------------------------------------------------
DROP TABLE IF EXISTS Segment_Current_State CASCADE;
DROP TABLE IF EXISTS Entity_Resolution CASCADE;
DROP TABLE IF EXISTS Segment_Dim CASCADE;
DROP TABLE IF EXISTS Master_ID_Type CASCADE;
DROP TABLE IF EXISTS Entity_Type CASCADE;

------------------------------------------------------------------------------
-- 1. Create Dimension Tables (referenced by other tables)
------------------------------------------------------------------------------

-- A. Segment_Dim
--    Reflects segment or label taxonomy logic for grouping similar labels
CREATE TABLE Segment_Dim (
    Segment_ID         VARCHAR(50)    NOT NULL,
    Segment_Type       VARCHAR(100)   NULL,
    Segment_Desc       VARCHAR(255)   NULL,
    Segment_Cat        VARCHAR(100)   NULL,
    Segment_Subcat     VARCHAR(100)   NULL,
    Segment_Source     VARCHAR(100)   NULL,
    First_Loaded_Dt    TIMESTAMP      NULL,
    Last_Loaded_Dt     TIMESTAMP      NULL,
    CONSTRAINT PK_Segment_Dim PRIMARY KEY (Segment_ID)
);

-- B. Master_ID_Type
--    Describes Master_ID types (e.g., 'customer', 'household_ID')
CREATE TABLE Master_ID_Type (
    Master_Type                    VARCHAR(50)   NOT NULL,
    Type_Description               VARCHAR(255)  NULL,
    Type_Marketing_Channels_Avails JSONB         NULL, 
    Type_Source_Avails             JSONB         NULL, 
    CONSTRAINT PK_Master_ID_Type PRIMARY KEY (Master_Type)
);

-- C. Entity_Type
--    Describes Entity_ID types (e.g., 'email', 'cookie', 'customer')
CREATE TABLE Entity_Type (
    Entity_Type                    VARCHAR(50)   NOT NULL,
    Type_Description               VARCHAR(255)  NULL,
    Type_Marketing_Channels_Avails JSONB         NULL, 
    Type_Source_Avails             JSONB         NULL, 
    CONSTRAINT PK_Entity_Type PRIMARY KEY (Entity_Type)
);

------------------------------------------------------------------------------
-- 2. Create Fact / Relationship Tables
------------------------------------------------------------------------------

-- D. Segment_Current_State
--    Reflects most recent state of an entity for a given segment
CREATE TABLE Segment_Current_State (
    Segment_ID       VARCHAR(50)    NOT NULL,  -- references Segment_Dim
    Entity_ID        VARCHAR(50)    NOT NULL,  -- entity identifier
    Entity_Type      VARCHAR(50)    NOT NULL,  
    Last_Updated_Dt  TIMESTAMP      NULL,
    Value            DECIMAL(18,2)  NULL,
    Value_Unit       VARCHAR(50)    NULL,
    CONSTRAINT PK_Segment_Current_State 
        PRIMARY KEY (Entity_ID, Segment_ID),
    CONSTRAINT FK_SCS_Segment_ID
        FOREIGN KEY (Segment_ID) REFERENCES Segment_Dim (Segment_ID),
    CONSTRAINT FK_SCS_Entity_Type
        FOREIGN KEY (Entity_Type) REFERENCES Entity_Type (Entity_Type)
);

-- E. Entity_Resolution
--    Maps various entity IDs to a single master identity
CREATE TABLE Entity_Resolution (
    Master_ID         VARCHAR(50)   NOT NULL,  -- references Master_ID_Type
    Entity_ID         VARCHAR(50)   NOT NULL,  
    Entity_Type       VARCHAR(50)   NOT NULL,
    Entity_Source     VARCHAR(100)  NULL,
    Resolution_Value  DECIMAL(5,2)  NULL,      -- 1=deterministic, <1=probabilistic
    Master_Type       VARCHAR(50)   NOT NULL,  -- references Master_ID_Type
    CONSTRAINT PK_Entity_Resolution
        PRIMARY KEY (Master_ID, Entity_ID),
    CONSTRAINT FK_ER_Entity_Type
        FOREIGN KEY (Entity_Type) REFERENCES Entity_Type (Entity_Type),
    CONSTRAINT FK_ER_Master_Type
        FOREIGN KEY (Master_Type) REFERENCES Master_ID_Type (Master_Type)
);

------------------------------------------------------------------------------

-- Script end
------------------------------------------------------------------------------