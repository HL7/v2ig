# Search V2.9.1 Extracted Data

You are helping the user search the HL7 V2.9.1 extracted data located in `/workspace/v291-extracted/`.

## Your Task

Parse the user's query and search the extracted V2.9.1 data to provide a helpful, formatted answer.

**User's query:** $ARGUMENTS

## Available Data

The extracted data contains:
- **Segments** (175 files): `/workspace/v291-extracted/segments/{CODE}.json`
- **Message Structures** (389 files): `/workspace/v291-extracted/message-structures/{STRUCT_ID}_{CH}_{IDX}.json`
- **Events** (143 files): `/workspace/v291-extracted/events/{EVENT}_{CH}_{IDX}.json`
- **Complex Data Types** (71 files): `/workspace/v291-extracted/data-types/complex/{CODE}.json`
- **Query Parameters** (24 files): `/workspace/v291-extracted/query-parameters/query_params_{CH}_{IDX}.json`

## Reference Guide

**IMPORTANT:** Before searching, read the complete guide at `/workspace/v291-extracted/GUIDE.md` to understand the exact JSON structure, field names, and search strategies. The guide contains:
- Complete JSON schemas for each file type
- Explanation of all field meanings
- Search patterns for common queries
- Examples of how to navigate the data
- Cross-reference strategies

## Query Pattern Recognition

Analyze the user's query to determine what they're looking for:

### 1. Segment Field Lookup
**Patterns:** "What is MSH-9?", "Find PID-3", "Show me OBX-5"

**Strategy:**
1. Extract segment code and field number from query
2. Read `/workspace/v291-extracted/segments/{CODE}.json`
3. Find field where `occurrences[0].fields[].sequence === "{number}"`
4. Return field name, data type, optionality, and description

### 2. Field Name Search
**Patterns:** "Find fields named 'Patient'", "What segment has 'Message Type'", "Search for 'Observation'"

**Strategy:**
1. Use Grep with pattern `"name":.*{search_term}` (case-insensitive)
2. Search path: `/workspace/v291-extracted/segments`
3. Use `output_mode: "content"` with context to show matches
4. Read matching files to provide full context
5. Return segment code, field sequence, field name, and data type

### 3. Data Type Lookup
**Patterns:** "What data type is PID-5?", "Show data type for MSH-9", "What type is OBX-3?"

**Strategy:**
1. Read segment file
2. Find field by sequence number
3. Extract `dataType` field
4. Optionally read data type definition from `/workspace/v291-extracted/data-types/complex/{CODE}.json`

### 4. Data Type Components
**Patterns:** "Show components of CWE", "What's in XPN?", "CWE structure", "XAD components"

**Strategy:**
1. Read `/workspace/v291-extracted/data-types/complex/{CODE}.json`
2. Extract `occurrences[0].components[]` array
3. Present in table format: sequence, name, data type, optionality, table binding

### 5. Message Structure Lookup
**Patterns:** "Show ADT_A01 structure", "What segments in ORU_R01?", "Message structure for ADT_A04"

**Strategy:**
1. Use Glob pattern `{STRUCT_ID}_*.json` in `/workspace/v291-extracted/message-structures/`
2. Read matching file(s)
3. Present `rawRows[]` with segment codes and descriptions (preserves bracket notation)
4. Optionally show `parsedStructure[]` for normalized view with optionality flags

**Note:** There may be multiple occurrences - check provenance to identify the most relevant one, or show all if differences exist.

### 6. Event Lookup
**Patterns:** "What is event A01?", "Show A04 acknowledgment", "Find event for ADT^A05"

**Strategy:**
1. Use Glob pattern `{EVENT}_*.json` in `/workspace/v291-extracted/events/`
2. Read matching file(s)
3. Show event code, message type, structure ID, and acknowledgment choreography
4. Parse acknowledgment table if user asks about ack requirements

### 7. Reverse Lookup: Structure to Events
**Patterns:** "What events use ADT_A01?", "Find events for structure ORU_R01", "Which events use ACK?"

**Strategy:**
1. Grep for `"structureId": "{STRUCT_ID}"` in `/workspace/v291-extracted/events/`
2. Use `output_mode: "files_with_matches"`
3. Read matching event files
4. Return list of event codes, message types, and names

### 8. Field Filtering by Attribute
**Patterns:** "Find required fields in MSH", "Show optional fields in PID", "What fields in OBX are repeating?"

**Strategy:**
1. Read segment file
2. Filter `occurrences[0].fields[]` array by attribute:
   - Required: `optionality === "R"`
   - Optional: `optionality === "O"`
   - Conditional: `optionality === "C"`
   - Withdrawn: `optionality === "W"`
   - Repeating: `repetition === "Y"`
3. Return filtered list with sequence, name, data type, and optionality

### 9. Value Set/Table Binding Search
**Patterns:** "What fields use table 0001?", "Find fields bound to table 0363", "Show table bindings for PID"

**Strategy:**
1. For specific table: Grep for `"tableBinding": "{table_number}"`
2. For segment table bindings: Read segment and extract `tableBinding` for each field
3. Return field sequence, name, data type, and table number

**Note:** The extracted data includes table numbers but not the actual value set contents.

### 10. Cross-Segment Data Type Search
**Patterns:** "Find all fields using CWE", "What segments use XPN?", "Show all CX fields"

**Strategy:**
1. Grep for `"dataType": "{TYPE}"` in `/workspace/v291-extracted/segments/`
2. Use `output_mode: "content"` to see context
3. Parse results to identify segment codes and field sequences
4. Return comprehensive list

### 11. Query Parameter Lookup
**Patterns:** "Show query parameters for {message}", "What are the QPD fields for {query}?"

**Strategy:**
1. Use Glob in `/workspace/v291-extracted/query-parameters/`
2. Read matching files
3. Check `provenance.sectionHeading` to confirm query type
4. Present `parameters[]` array with field names, types, and segment field references

## Output Format Guidelines

### For Field Lookups
Present results in a clear, structured format:
```
{SEGMENT}-{SEQ}: {Field Name}
- Data Type: {dataType}
- Optionality: {optionality} ({R=Required, O=Optional, C=Conditional})
- Repetition: {repetition} ({Y=Yes, blank=No})
- Length: {length}
- Table Binding: {tableBinding} ({or "None" if empty})
- Item Number: {itemNumber}
```

### For Data Type Components
Use a table format:
```
{DATA_TYPE} - {Name}

| Seq | Component Name | Type | Opt | Table | Length |
|-----|----------------|------|-----|-------|--------|
| ... | ...            | ...  | ... | ...   | ...    |
```

### For Message Structures
Show the structure with indentation for groups:
```
{STRUCTURE_ID}: {Caption}

Segments:
MSH - Message Header (Required)
[{ SFT }] - Software Segment (Optional, Repeating)
EVN - Event Type (Required)
PID - Patient Identification (Required)
[ - VISIT_GROUP (Optional Group)
  PV1 - Patient Visit (Required)
  [ PV2 ] - Patient Visit Additional (Optional)
]
```

### For Event Information
```
Event: {eventCode}
Message Type: {messageType}
Structure: {structureId}
Full Name: {name}

Acknowledgment Choreography:
MSH.15: {values}
MSH.16: {values}
Immediate Ack: {values}
Application Ack: {values}
```

### For Lists and Searches
Use tables when presenting multiple results:
```
| Segment | Field | Name | Data Type | Opt | Rep |
|---------|-------|------|-----------|-----|-----|
| ...     | ...   | ...  | ...       | ... | ... |
```

## Handling Edge Cases

1. **Multiple occurrences**: If you find multiple files (e.g., ADT_A01_03_15.json and ADT_A01_04_22.json):
   - Note that multiple occurrences exist
   - Check provenance to identify context
   - Show the most relevant one or note differences if significant

2. **Empty fields**:
   - Empty `dataType` means withdrawn field
   - Empty `tableBinding` means no value set binding
   - Empty `repetition` means does not repeat

3. **Withdrawn fields**: Fields with `optionality: "W"` are deprecated
   - Note this clearly in results
   - Explain they should not be used in new implementations

4. **Special data types**:
   - `"varies"` (OBX-5) means type depends on another field
   - Note this and explain the dependency

5. **Query not found**:
   - Try alternative search strategies
   - Suggest related queries the user might mean
   - Check for typos in codes or field numbers

## Provenance Information

Always include provenance when relevant:
- Source chapter
- Source file (Word document)
- Table index within chapter

This helps users trace data back to source documents.

## Cross-References

When showing a field that references another resource:
- If field has a data type, offer to show data type components
- If field has a table binding, note the table number (but explain the value set contents aren't in the extraction)
- If showing a message structure, note which events use it
- If showing an event, note which message structure it uses

## Important Notes

1. **Read the guide first**: Always read `/workspace/v291-extracted/GUIDE.md` to understand the structure
2. **Use the right tool**:
   - Glob for finding files by name pattern
   - Grep for searching file contents
   - Read for loading JSON files
3. **Navigate JSON correctly**: Use the exact field names from the guide (e.g., `occurrences[0].fields[]`, not `fields[]`)
4. **Explain codes**: When showing optionality (R/O/C/W/B) or repetition (Y/N), explain what they mean
5. **Bracket notation**: When showing message structures, preserve and explain the bracket notation (`[ ]`, `{ }`, `[{ }]`)
6. **Be comprehensive**: For broad queries, show all relevant results in organized format
7. **Provide context**: Don't just dump JSON - format it in a human-readable way with explanations

## Example Workflows

**Example 1: "What is PID-3?"**
1. Read `/workspace/v291-extracted/segments/PID.json`
2. Find field where `sequence === "3"` in `occurrences[0].fields[]`
3. Format output showing field name, data type, optionality, etc.
4. Offer to show CX data type components (since PID-3 uses CX)

**Example 2: "Show ADT_A01 structure"**
1. Glob for `ADT_A01_*.json` in message-structures directory
2. Read matching file(s)
3. Format `rawRows[]` with proper indentation and bracket notation
4. Note which event(s) use this structure

**Example 3: "Find fields with 'Patient' in the name"**
1. Grep for `"name":.*Patient` in segments directory
2. Parse results to identify segment/field combinations
3. Read relevant segment files for full details
4. Present in table format

Now execute the search based on the user's query.
