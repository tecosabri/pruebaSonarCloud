//
//  RemoteDataSourceTests.swift
//  iOSSuperPoderesTests
//
//  Created by Ismael Sabri Pérez on 28/7/23.
//

import XCTest
import Combine
import Foundation
@testable import iOSSuperPoderes

final class RemoteDataSourceTests: XCTestCase {
    
    var cancellables = Set<AnyCancellable>()

    func testRemoteDataSource_whenLoginWithSuccessResult_expectsToken() {
        // GIVEN
        let myToken = "eyJhbGciOiJIUzI1NiIsImtpZCI6InByaXZhdGUiLCJ0eXAiOiJKV1QifQ.eyJlbWFpbCI6ImJlamxAa2VlcGNvZGluZy5lcyIsImlkZW50aWZ5IjoiN0FCOEFDNEQtQUQ4Ri00QUNFLUFBNDUtMjFFODRBRThCQkU3IiwiZXhwaXJhdGlvbiI6NjQwOTIyMTEyMDB9.PHf8uuTCyM638Ehd--tt0B5M6sbp-XLAApoeMHc-yZw"
        let data = myToken.data(using: .utf8)
        let sut = RemoteDataSourceImpl(session: NetworkFetchingStub(returning: .success(data!)))
        let expectation = XCTestExpectation(description: "RECEIVES TOKEN")
        
        // WHEN
        sut.login(user: "", password: "")
            .sink { completion in
                switch completion {
                case .finished:
                    print("finished")
                case .failure:
                    print("failure")
                }
            } receiveValue: { token in
                XCTAssertEqual(myToken, token)
                expectation.fulfill()
            }.store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }

    
}
