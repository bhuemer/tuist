import Foundation
import TSCBasic
import TuistCacheTesting
import TuistCore
import TuistCoreTesting
import TuistSupport
import XCTest
@testable import TuistCache
@testable import TuistSupportTesting

final class DeploymentTargetContentHasherTests: TuistUnitTestCase {
    private var subject: DeploymentTargetContentHasher!
    private var mockContentHasher: MockContentHashing!

    override func setUp() {
        super.setUp()
        mockContentHasher = MockContentHashing()
        subject = DeploymentTargetContentHasher(contentHasher: mockContentHasher)
    }

    override func tearDown() {
        subject = nil
        mockContentHasher = nil
        super.tearDown()
    }

    func test_hash_whenIosIphoneV1_callsContentHasherWithExpectedStrings() throws {
        // When
        let deploymentTarget = DeploymentTarget.iOS("v1", .iphone)

        // Then
        let hash = try subject.hash(deploymentTarget: deploymentTarget)
        XCTAssertEqual(hash, "iOS-v1-1-hash")
        XCTAssertEqual(mockContentHasher.hashStringCallCount, 1)
    }

    func test_hash_whenIosIpadV2_callsContentHasherWithExpectedStrings() throws {
        // When
        let deploymentTarget = DeploymentTarget.iOS("v2", .ipad)

        // Then
        let hash = try subject.hash(deploymentTarget: deploymentTarget)
        XCTAssertEqual(hash, "iOS-v2-2-hash")
        XCTAssertEqual(mockContentHasher.hashStringCallCount, 1)
    }

    func test_hash_whenMacOSV2_callsContentHasherWithExpectedStrings() throws {
        // When
        let deploymentTarget = DeploymentTarget.macOS("v2")

        // Then
        let hash = try subject.hash(deploymentTarget: deploymentTarget)
        XCTAssertEqual(hash, "macOS-v2-hash")
        XCTAssertEqual(mockContentHasher.hashStringCallCount, 1)
    }
}
