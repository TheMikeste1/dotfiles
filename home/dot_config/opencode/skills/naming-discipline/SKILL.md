---
name: naming-discipline
description: A rigorous workflow for naming and placing utility functions, preventing the use of generic containers like 'Helper', 'Utils', or 'Common'.
---

# Naming Discipline

This skill provides a rigorous workflow for identifying the correct placement and naming of utility functions. The objective is to avoid generic containers (e.g., `Helper`, `Utils`, `Common`) that obscure the purpose and ownership of the logic.

## Workflow

Follow these steps whenever implementing a new utility or helper function:

### 1. Identify the Function's Scope

Analyze the usage pattern of the function to determine its scope:

- **Single Entity**: Is the function used by only one class, struct, or entity?
- **Module Specific**: Is the function specific to the internal implementation details of a single module/file?
- **Shared**: Is the function shared across multiple distinct entities or different domains?

### 2. Apply the Placement Rubric

Based on the scope identified in Step 1, apply the following placement rules:

| Scope | Placement | Action |
| :--- | :--- | :--- |
| **Case A: Single Entity** | Primary Entity | Absorb the function into the primary entity (as a member function or private helper). |
| **Case B: Module Specific** | Local Module | Implement as a standalone, private function (static or in an anonymous namespace) within the module's source file. |
| **Case C: Shared** | Domain Module | Place in a dedicated module/namespace named after the specific domain it serves (e.g., `string_utils`, `date_validator`). |

### 3. Validate the Name

Ensure the name is descriptive of **WHAT** it does or **WHICH** domain it serves.

**Strict Rejection List:**
Reject any names containing the following terms when used as a container or qualifier:

- `Helper`
- `Utils` (unless part of a specific domain, e.g., `string_utils`)
- `Common`
- `Support`
- `Assistant`
- `Misc`

The name should be an action or a specialized domain, not a generic description of "utility".

## Examples

| Bad Pattern | Good Pattern | Reason |
| :--- | :--- | :--- |
| `Helper::trimString()` | `string_utils::trim()` | Focuses on the domain (`string`) and action (`trim`). |
| `Common::validateDate()` | `date_validator::validate()` | Defines the specific purpose (`date_validator`). |
| `ProjectHelper::getCoord()` | `coordinate_conversion::getCoord()` | Specifies the functional domain (`coordinate_conversion`). |
| `Utils::calcOffset()` | `memory_layout::calcOffset()` | Clarifies which part of the system the utility serves. |

## Guide for Agents

When reviewing or writing code, if you encounter a "Helper" or "Common" class/namespace:

1. Pause and apply the **Placement Rubric**.
2. Refactor the function to the most specific scope possible.
3. Rename the container to reflect the domain logic.
