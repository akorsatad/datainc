# Marketing Data Model 
This **data model** is specifically created to store marketing entity labels at scale. The objective of this structure is to enable marketing organization to operate on 100,000+ entity lables (segments) where entity could be defined as any unit of marketing targeting (**entity examples**: household address, zipcode, email address, cookie ID, mobile ID, etc).

# Tables:

## Segment_Current_State
- **Table description**: Reflect most recent state of entity, where labels can update historically (**example**: customer preference, age), otherwise (**example**: customer gender, product entry) reflects first entry point into the system.

| Field    | Field Type | Description | Example |
| -------- | ------- |------- |------- |
| Segment_ID  | $250    |$250    |$250    |
| Entity_ID | $80     |$80     |$80     |
| Entity_Type   | $420    |$420    |$420    |
| Last_Updated_Dt | $420    |$420    |$420    |
| Value   | $420    |$420    |$420    |