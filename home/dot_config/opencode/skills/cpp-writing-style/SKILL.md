# C++ Writing Style Skill

This skill enforces a high-performance, explicit, and modern C++20 coding standard. Agents must apply these rules when writing or reviewing C++ code.

## Core Rules

### 1. Standard & Performance
- **C++ Standard**: Use the latest version of C++ available for the project.
- **Compile-Time Evaluation**: Maximize the use of `constexpr` and `consteval` to eliminate runtime overhead.
- **Non-Owning Data Access**: Use `std::span` and `std::string_view` for non-owning data access. Prefer these over `const std::string&` or `const std::vector<T>&`.

### 2. Move Semantics & Resource Management
- **Priority**: Prioritize move constructors and move assignment operators.
- **Noexcept Requirements**: Move members MUST be marked `noexcept` to ensure STL containers do not fall back to copies.
- **Const Correctness**: Maintain strict const correctness. However, `const` qualifiers must not prevent a move operation from occurring.
- **RAII**: Use the Resource Acquisition Is Initialization (RAII) idiom for all resource management (including memory, file handles, locks, etc.).

### 3. Explicitness & Class Design
- **Constructors**: Single-argument constructors must be marked `explicit` by default.
    - *Exception*: Primitive wrappers (e.g., `NonZero`) should be implicit to facilitate seamless transformations.
- **Responsibility**: Keep classes small, logically grouped, and adherent to the Single Responsibility Principle (SRP).

### 4. Error Handling
- **Errors as Values**: Use `std::optional` or `std::variant` for expected failures.
- **Exceptions**: Use exceptions ONLY for "WTF" scenarios (unrecoverable critical failures).
- **Fallible Construction**: If a constructor can fail, make the constructor private/protected and provide a static `create()` factory method that returns the object wrapped in an error-value (e.g., `std::optional<T>`).

### 5. Interface & Type Safety
- **Design**: Prefer Composition over Inheritance.
- **Inheritance**: Use inheritance primarily to concretize strong, simple interfaces.
- **Casting**: C-style casts are strictly forbidden. Use `static_cast`, `reinterpret_cast`, or `const_cast`.
- **Type Erasure**: `void*` is permitted only when no other type-safe alternative exists.

### 6. Compiler Guidance & Templates
- **Constraints**: Use C++20 Concepts to constrain templates for better error messaging and clarity.
- **Attributes**: Aggressively use attributes: `[[nodiscard]]`, `[[maybe_unused]]`, and `[[likely]]`/`[[unlikely]]`. If a tool like clang-tidy would suggest it, it must be used.

### 7. Safety and Defensive Programming
- **The Power of 10 (JPL Rules)**: Adhere to the spirit of the JPL 'Power of 10' rules for safety-critical code.
    - Key constraints: Avoid dynamic memory allocation after initialization; avoid multiple inheritance; use `const` and `constexpr` rigorously; avoid complex pointer arithmetic.
    - All invariants and assumptions must be explicitly asserted.
- **Defensive Macros (`ALWAYS` and `NEVER`)**:
    - If these macros do not exist, create them.
    - **`ALWAYS(X)`**: Use when a condition *should* always be true. In debug, it asserts the condition; in release, it evaluates the expression. Used for defensive checks tested in debug but functional in release.
    - **`NEVER(X)`**: Use when a condition *should never* be true. In debug, it asserts the condition is false; in release, it evaluates the expression. Used for 'impossible' paths that must remain executable for safety.
    - Style: Follow the SQLite approach to mark defensive paths intended for testing but logically unexpected in normal operation.

### 8. Security and Defensive Fortification
- **Boundaries and Memory Safety**:
    - Absolute prohibition of unchecked array/pointer access.
    - All accesses to buffers, including `std::span` and `std::vector`, must be bounds-checked or validated against the size.
    - Use `at()` instead of `[]` when bounds cannot be statically guaranteed and the cost of an exception is preferable to a breach.
- **Input Validation (Trust No One)**:
    - All data originating from outside the current module or from an external source (network, file, user) must be treated as untrusted/tainted.
    - Mandatory validation and sanitization of all inputs before they are used in logic, memory allocation, or as indices.
- **Data Scrubbing**:
    - Sensitive information (keys, credentials, private data) must be explicitly cleared/zeroed out of memory as soon as it is no longer needed, using `std::fill` or a volatile-safe clearing method, to prevent leakage in core dumps or memory scrapes.
- **Banishment of Unsafe Functions**:
    - Strict prohibition of unsafe C-style string and memory functions (e.g., `strcpy`, `strcat`, `sprintf`, `gets`). Use the `n` versions (e.g., `strncpy`) or, preferably, `std::string` and `std::format` (C++20).
- **Integer Overflow Prevention**:
    - All calculations involving memory sizes, offsets, or loop counters must be checked for potential overflow or underflow, especially when dealing with external input.

### 9. Ownership, Lifetimes, and Null Safety
- **Reference Preference**:
    - Prefer passing by reference (`T&` or `const T&`) over pointers (`T*`) whenever an object is required to exist.
    - Pointers should only be used as arguments if the function legitimately accepts a `nullptr` as a valid input state.
- **Dangling Reference Prohibition**:
    - Do not store unowned, dereferenced references (e.g., storing a reference to a local variable or a temporary object in a class member).
    - Every stored reference must have a guaranteed, statically verifiable lifetime that exceeds the lifetime of the object storing it.
- **Borrowing Philosophy (Rust-inspired)**:
    - Adhere to the concept of "Ownership and Borrowing."
    - Ensure that an object is not used after it has been moved from (use-after-move is strictly forbidden).
    - When designing interfaces, clearly distinguish between "taking ownership" (passing by value/unique_ptr) and "borrowing" (passing by reference/span).
    - Avoid creating multiple mutable aliases to the same data if it risks violating the logic of exclusive access.


## Implementation Examples

### Fallible Construction
```cpp
class SecureBuffer {
    SecureBuffer() { /* ... */ } // Private constructor
public:
    static std::optional<SecureBuffer> create(size_t size) {
        if (size == 0) return std::nullopt;
        return SecureBuffer(size);
    }
};
```

### Move Semantics
```cpp
class DataPacket {
    std::vector<uint8_t> buffer;
public:
    DataPacket(DataPacket&& other) noexcept : buffer(std::move(other.buffer)) {}
    DataPacket& operator=(DataPacket&& other) noexcept {
        buffer = std::move(other.buffer);
        return *this;
    }
};
```

### The Art of the View
```cpp
[[nodiscard]]
constexpr size_t count_occurrences(std::string_view text, std::string_view target) {
    // Logic using views instead of const std::string&
}
```

### Explicit vs Implicit Wrapper
```cpp
struct NonZero {
    int value;
    NonZero(int v) : value(v) { // Implicit: allowed for primitive wrapper
        if (v == 0) throw std::runtime_error("Zero not allowed");
    }
};

class UserProfile {
    explicit UserProfile(int id) {} // Explicit: required by default
};
```

### Defensive Programming
```cpp
void processPacket(const Packet& packet) {
    // We expect the packet to always have a valid header
    if (ALWAYS(packet.hasHeader())) {
        // Normal processing logic
    }

    // This state should logically never be reached in normal operation
    if (NEVER(packet.isCorrupt())) {
        // Recovery logic that must exist for safety in release,
        // but should trigger an assertion in debug.
        handleCorruptPacket(packet);
    }
}

### Secure Input Pattern
```cpp
void handleUserRequest(std::span<const uint8_t> rawInput) {
    // 1. Validate: Check bounds and basic structure
    if (rawInput.size() < MIN_REQUEST_SIZE || rawInput.size() > MAX_REQUEST_SIZE) {
        return; // Log error and reject
    }

    // 2. Sanitize: Extract and validate specific fields
    uint32_t requestId = decode_uint32(rawInput.subspan(0, 4));
    if (requestId == 0) return; // Invalid ID

    // 3. Use: Now the data is trusted within this scope
    processRequest(requestId);
}
```

### Ownership and Borrowing
```cpp
// Dangerous: Storing a reference to a temporary or unowned object
struct Dangerous {
    const std::string& name;
    Dangerous(const std::string& n) : name(n) {} // RISK: 'n' could be a temporary
};

// Safe: Borrowing via span/view for short-term access, or taking ownership
struct Safe {
    std::string name; // Ownership
    Safe(std::string n) : name(std::move(n)) {}
};

void processData(std::span<const uint8_t> data) { // Borrowing
    // ...
}
```

## Agent Checklist

- [ ] Does the code use the latest version of C++ available for the project?
- [ ] Are `constexpr` and `consteval` used wherever possible?
- [ ] Are `std::span` and `std::string_view` used for non-owning access instead of `const std::string&`/`const std::vector<T>&`?
- [ ] Are move constructors and move assignment operators implemented and marked `noexcept`?
- [ ] Is RAII used for all resource management?
- [ ] Are single-argument constructors `explicit` (unless they are primitive wrappers)?
- [ ] Do classes follow SRP and remain small?
- [ ] Are expected failures handled via `std::optional` or `std::variant`?
- [ ] Are exceptions reserved for unrecoverable critical failures?
- [ ] Does fallible construction use the `create()` factory pattern with a private constructor?
- [ ] Is composition preferred over inheritance?
- [ ] Are C-style casts avoided in favor of `static_cast`, `reinterpret_cast`, or `const_cast`?
- [ ] Is `void*` used only as a last resort?
- [ ] Are templates constrained with C++20 Concepts?
- [ ] Are `[[nodiscard]]`, `[[maybe_unused]]`, `[[likely]]`, and `[[unlikely]]` applied where appropriate?
- [ ] Does the code adhere to JPL Power of 10 rules (e.g., no dynamic memory after init, no multiple inheritance)?
- [ ] Are invariants and assumptions explicitly asserted?
- [ ] Are `ALWAYS(X)` and `NEVER(X)` macros used for defensive checks and impossible paths?
- [ ] Are buffer accesses bounds-checked or validated (e.g., using `at()` when static guarantees are missing)?
- [ ] Is all external/cross-module data validated and sanitized before use?
- [ ] Is sensitive information explicitly scrubbed/zeroed from memory when no longer needed?
- [ ] Are unsafe C-style string/memory functions (`strcpy`, etc.) avoided in favor of `std::string` and `std::format`?
- [ ] Are calculations for memory sizes, offsets, and counters checked for integer overflow/underflow?
- [ ] Are pointers used only when `nullptr` is a valid input state?
- [ ] Are there no unowned references stored in classes?
- [ ] Is it guaranteed that no objects are used after a `std::move`?
