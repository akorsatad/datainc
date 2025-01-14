# Marketing Data Model 
This **data model** is specifically designed to store marketing entity labels at scale. The objective of this structure is to enable marketing organization to operate on 100,000+ entity lables (segments) where entity could be defined as any unit of marketing targeting (**entity examples**: household address, zipcode, email address, cookie ID, mobile ID, etc).

# Tables:

## Segment_Current_State
- **Table description**: Reflects most recent state of entity, where labels can update historically (**example**: customer preference, age), otherwise (**example**: customer gender, product entry) reflects first entry point into the system.

| Field    | Field Type | Description | Example |
| -------- | ------- |------- |------- |
| Segment_ID  | varchar    | Secondary Key, joins to segment_dim table   | 1234567890   |
| Entity_ID | varchar     |Primary Key    | AB123435423   |
| Entity_Type   | Varchar   | Email    | jondoe@gmail.com   |
| Last_Updated_Dt | timestamp   | timestamp of last record update for the segment_ID    | 01/01/2025 00:00:00    |
| Value   | decimal    | value associated with segment_id label   |420    |
| Value_unit   | varchar   | type of value    |Currency_USD   |

## Segment_Dim
- **Table description**: Reflects most recent state of entity, where labels can update historically (**example**: customer preference, age), otherwise (**example**: customer gender, product entry) reflects first entry point into the system.

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

