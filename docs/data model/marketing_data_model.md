# Marketing Entity Data Model 
This **data model** is specifically designed to store marketing entity labels at scale. The objective of this structure is to enable marketing organization to operate on 100,000+ entity lables (segments) where entity could be defined as any unit of marketing targeting (**entity examples**: household address, zipcode, email address, cookie ID, mobile ID, etc).

# Main Tables:

## Segment_Current_State
- **Table description**: Reflects most recent state of entity, where labels can update historically (**example**: customer preference, age), otherwise (**example**: customer gender, product entry) reflects first entry point into the system.

| Field    | Field Type | Description | Example |
| -------- | ------- |------- |------- |
| Segment_ID  | varchar    | Secondary Key, joins to segment_dim table   | 1234567890   |
| Entity_ID | varchar     |Primary Key    | AB123435423   |
| Entity_Type   | Varchar   | Email    | bunnyl@gmail.com   |
| Last_Updated_Dt | timestamp   | timestamp of last record update for the segment_ID    | 01/01/2025 00:00:00    |
| Value   | decimal    | value associated with segment_id label   |420    |
| Value_unit   | varchar   | type of value    |Currency_USD   |

## Segment_Dim
- **Table description**: Reflects segment or label taxonomy logic to enable generatizations and aggregation for the similar label cohorts.

| Field    | Field Type | Description | Example |
| -------- | ------- |------- |------- |
| Segment_ID  | varchar    | Primary Key  | 1234567890   |
| Segment_Type| varchar     | Top level dim    | Geographic  |
| Segment_Desc   | varchar   | zip+4 with income over USD 20,000 but below 40,000  | zip_4_income20_40k |
| Segment_Cat| varchar  | Geographic affluence | Income brackets  |
| Segment_Subcat   | varchar  | Geographic affluence | Income brackets  |
| Segment_source  | varchar   | source of the segment data  | US census|
| First_Loaded_Dt   | timestamp   | timestamp of first record update for the segment_ID    | 01/01/2025 00:00:00    |
| Last_Loaded_Dt  | timestamp   | timestamp of last record update for the segment_ID    | 01/01/2025 00:00:00    |

## Entity_Resolution
- **Table description**: Identity resolution table that maintains all relationships between deterministic and probabilistic entities and their marketing target / analytics unit. For example: all consumers in a household are mapped to household master ID, all devices are mapped to inidividual master ID, all lat/long coordinates are mapped to a zip4, etc.

| Field    | Field Type | Description | Example |
| -------- | ------- |------- |------- |
| Master_ID  | varchar    | Primary Key  | M1234567890   |
| Entity_ID | varchar    | Secondary Key  | E1234567890   |
| Entity_Type  | varchar   | Type of entity data | email |
| Entity_Source  | varchar   | Source of entity data | CRM |
| Resolution_Value | Decimal  | 1 for deterministic, <1 for probabilistic  | 97% |
| Master_Type  | varchar  | customer | household_ID |

## Master_ID_Type
- **Table description**: Dim table that describes Master_ID types including origination and current mapping

| Field    | Field Type | Description | Example |
| -------- | ------- |------- |------- |
| Master_Type  | varchar  | customer | household_ID |
| Type_Description | varchar    | describes master ID logic | Household based on mailing address  |
| Type_Marketing_Channels_Avails  | JSON  | All channels mapped to the master_ID resolution in datainc environment| Meta:  |
| Type_Source_Avails | JSON  | All sources of data mapped to the master_ID resolution in datainc environment | Geo:|

## Entity_Type
- **Table description**: Dim table that describes Entity_ID types including origination and current mapping

| Field    | Field Type | Description | Example |
| -------- | ------- |------- |------- |
| Entity_Type  | varchar  | customer | email |
| Type_Description | varchar    | current customer email | customer is based on inidividuals with at least one transaction in last 12 months   |
| Type_Marketing_Channels_Avails  | JSON  | All channels mapped to the entity_ID resolution in datainc environment| Meta:  |
| Type_Source_Avails | JSON  | All sources of data mapped to the entity_ID resolution in datainc environment | Geo:|

# Utility Tables: