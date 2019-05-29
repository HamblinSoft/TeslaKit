//
//  CommandTests.swift
//  Tests
//
//  Created by Jaren Hamblin on 7/11/18.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//


import XCTest
@testable import TeslaKit

class CommandTests: TKTestCase {

//    func testSetSpeedLimit() {
//
//        let expect = expectation(description: #function)
//
//        self.signIn { api in
//
//            api.vehicles { res in
//
//                guard let vehicle = res.data?.vehicles.first else {
//                    expect.fulfill()
//                    XCTFail()
//                    return
//                }
//
//                let req: SetSpeedLimit = SetSpeedLimit(limitMPH: 75)
//
//                api.send(.setSpeedLimit(req), to: vehicle) { response in
//
//                    guard response.result else {
//                        XCTFail(response.allErrorMessages)
//                        expect.fulfill()
//                        return
//                    }
//
//                    api.data(for: vehicle) { res in
//
//                        guard let vehicle = res.data else {
//                            expect.fulfill()
//                            XCTFail()
//                            return
//                        }
//
//                        XCTAssertEqual(vehicle.vehicleState.speedLimitMode.currentLimitMPH, req.limitMPH)
//
//                        let req: SetSpeedLimit = SetSpeedLimit(limitMPH: vehicle.vehicleState.speedLimitMode.maxLimitMPH)
//
//                        api.send(.setSpeedLimit(req), to: vehicle) { response in
//
//                            api.getData(for: vehicle) { (response, vehicle, error) in
//
//                                guard let vehicle = vehicle else {
//                                    expect.fulfill()
//                                    XCTFail()
//                                    return
//                                }
//
//                                XCTAssertEqual(vehicle.vehicleState.speedLimitMode.currentLimitMPH, vehicle.vehicleState.speedLimitMode.maxLimitMPH)
//                                expect.fulfill()
//                            }
//                        }
//                    }
//                }
//            }
//        }
//
//        waitForExpectations(timeout: 10) { error in
//            if let error = error {
//                XCTFail(error.localizedDescription)
//            }
//        }
//    }

}
