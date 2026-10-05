---
name: cpp-gtest-doubles
description: Standard for implementing test doubles (fakes, mocks) in C++ using GTest and GoogleMock, focusing on constructor injection and naming discipline.
---

# C++ Test Doubles & GTest Implementation

This skill provides the standard for creating test doubles (Fakes, Mocks, Stubs) within C++. The primary goal is to maintain test maintainability and reduce fragility.
Refer to the `test-double-principles` skill for guidance on which doubles to use when.

## Technical Constraints

### 1. Double Selection Strategy

- **Prefer Fakes over Mocks**: Use handwritten Fake implementations (state-based verification) by default.
- **Use GMock only for Interaction Verification**: Only use `MOCK_METHOD` when you must verify *that* a call occurred, the *order* of calls, or specific *arguments* of a call (behavioral verification).
- **Avoid Over-Mocking**: Do not mock simple data holders or value types.

### 2. Dependency Injection

- **Constructor Injection**: All dependencies for the Unit Under Test (UUT) must be passed via the constructor.
- **Interface-Based**: Use abstract interfaces (pure virtual classes) for all injected dependencies to decouple the UUT from concrete implementations.

### 3. Naming Discipline

- **Casing**: All classes (Interfaces, Fakes, Mocks) must use `PascalCase`.
- **Interface Naming**: Prefix with `I` (e.g., `ITelemetryService`).
- **Double Naming**: Explicitly name the double based on its type (e.g., `FakeTelemetryService`, `MockTelemetryService`).
- **Forbidden Terms**: The use of `Common`, `Utils`, `Helper`, or `Support` in test double filenames or class names is strictly prohibited.
- **Header Naming**: Shared fakes must be in headers named exactly after the entity they fake (e.g., `FakeTelemetryService.hpp`).

### 4. Placement & Scope

- **Local Fakes**: If a fake is only used by one test suite, implement it directly within the `.cpp` test file.
- **Shared Fakes**: If a fake is used across multiple test suites, place it in a dedicated header/source pair in the test directory.

## Implementation Pattern

Follow this sequence for implementing a test double and injecting it into the UUT.

### Example Pattern

**1. The Interface (`IEntity.hpp`)**

```cpp
class IEntity {
public:
    virtual ~IEntity() = default;
    virtual bool performAction(int value) = 0;
};
```

**2. The Fake Implementation (`FakeEntity.hpp/cpp`)**

```cpp
class FakeEntity : public IEntity {
public:
    bool performAction(int value) override {
        lastValue = value;
        return mockReturn;
    }
    // State for verification
    int lastValue = 0;
    bool mockReturn = true;
};
```

**3. The Unit Under Test (`UUT.hpp/cpp`)**

```cpp
class UUT {
public:
    explicit UUT(IEntity& entity) : entity_(entity) {}

    bool execute() {
        return entity_.performAction(42);
    }
private:
    IEntity& entity_;
};
```

**4. The GTest (`uut_test.cpp`)**

```cpp
TEST(UutTest, ExecuteCallsEntityWithCorrectValue) {
    FakeEntity fake;
    fake.mockReturn = true;

    UUT uut(fake);

    EXPECT_TRUE(uut.execute());
    EXPECT_EQ(fake.lastValue, 42);
}
```

## Verification Checklist for Reviews

- [ ] Is the dependency injected via the constructor?
- [ ] Does the UUT depend on an interface (`I...`) rather than a concrete class?
- [ ] Is a handwritten Fake used instead of a Mock where interaction verification is unnecessary?
- [ ] Are there any forbidden terms (`Helper`, `Utils`, etc.) in the names?
- [ ] Are classes named using `PascalCase`?
- [ ] Is the fake placed correctly (local vs. shared)?
