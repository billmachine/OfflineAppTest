import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(OfflineAppTestTests.allTests),
    ]
}
#endif
