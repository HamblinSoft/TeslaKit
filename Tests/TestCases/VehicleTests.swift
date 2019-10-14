//
//  VehicleTests.swift
//  Tests
//
//  Created by Jaren Hamblin on 4/10/18.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import XCTest
@testable import TeslaKit

class VehicleTests: TKTestCase {


    // MARK: - Vehicle List

    func testVehicleList() {

        let expect = expectation(description: #function)

        self.signIn { teslaAPI in

            teslaAPI.vehicles { res in

                XCTAssertEqual(res.httpResponse.statusCode, 200)
                XCTAssertNil(res.error)
                XCTAssertNotNil(res.data)

                let vehicles = res.data?.vehicles ?? []
                XCTAssertGreaterThan(vehicles.count, 0)

                expect.fulfill()
            }
        }

        waitForExpectations()
    }


    // MARK: - Vehicle Data

    func testVehicleData() {

        let expect = expectation(description: #function)

        self.signIn { teslaAPI in

            teslaAPI.vehicles { res in

                guard let vehicle = res.data?.vehicles.first else {
                    expect.fulfill()
                    XCTFail("At least one vehicle must be assiciated with the credential test account to run this test")
                    return
                }

                teslaAPI.getData(for: vehicle) { res in

                    XCTAssertEqual(res.httpResponse.statusCode, 200)
                    XCTAssertNil(res.error)
                    XCTAssertNotNil(res.data)

                    expect.fulfill()
                }
            }
        }

        waitForExpectations()
    }

    func testJsonMapping() {

        let jsonString = """
{
  "response" : {
    "state" : "online",
    "tokens" : [
      "",
      ""
    ],
    "climate_state" : {
      "is_rear_defroster_on" : false,
      "seat_heater_rear_center" : 0,
      "is_front_defroster_on" : false,
      "max_avail_temp" : 28,
      "climate_keeper_mode" : "off",
      "wiper_blade_heater" : false,
      "seat_heater_left" : 0,
      "min_avail_temp" : 15,
      "passenger_temp_setting" : 21.100000000000001,
      "battery_heater_no_power" : null,
      "driver_temp_setting" : 21.100000000000001,
      "is_preconditioning" : false,
      "is_climate_on" : false,
      "is_auto_conditioning_on" : false,
      "fan_status" : 0,
      "left_temp_direction" : 187,
      "outside_temp" : 26,
      "defrost_mode" : 0,
      "inside_temp" : 25.5,
      "remote_heater_control_enabled" : false,
      "right_temp_direction" : 187,
      "seat_heater_rear_right" : 0,
      "seat_heater_right" : 0,
      "smart_preconditioning" : false,
      "battery_heater" : false,
      "side_mirror_heaters" : false,
      "timestamp" : 1571024714720,
      "seat_heater_rear_left" : 0
    },
    "backseat_token" : null,
    "user_id" : 1,
    "color" : null,
    "id_s" : "abc123",
    "vehicle_state" : {
      "software_update" : {
        "status" : "",
        "install_perc" : 1,
        "download_perc" : 0,
        "expected_duration_sec" : 2700,
        "version" : ""
      },
      "center_display_state" : 0,
      "locked" : true,
      "df" : 0,
      "is_user_present" : false,
      "autopark_state_v3" : "unavailable",
      "car_version" : "2019.32.11.1 d39e85a",
      "media_state" : {
        "remote_control_enabled" : true
      },
      "parsed_calendar_supported" : true,
      "pf" : 0,
      "remote_start_supported" : true,
      "fp_window" : 0,
      "remote_start" : false,
      "remote_start_enabled" : true,
      "odometer" : 16217.485037,
      "fd_window" : 0,
      "vehicle_name" : "Model 3",
      "ft" : 0,
      "speed_limit_mode" : {
        "current_limit_mph" : 70,
        "pin_code_set" : true,
        "active" : false,
        "min_limit_mph" : 50,
        "max_limit_mph" : 90
      },
      "dr" : 0,
      "rt" : 0,
      "sentry_mode" : false,
      "pr" : 0,
      "timestamp" : 1571024714680,
      "valet_mode" : false,
      "calendar_supported" : true,
      "rd_window" : 0,
      "api_version" : 6,
      "rp_window" : 0,
      "notifications_supported" : true,
      "sentry_mode_available" : true
    },
    "vin" : "5YJ3E1EAXJF015171",
    "vehicle_id" : 1,
    "in_service" : false,
    "vehicle_config" : {
      "has_air_suspension" : false,
      "exterior_color" : "SolidBlack",
      "car_type" : "model3",
      "third_row_seats" : "<invalid>",
      "can_actuate_trunks" : true,
      "charge_port_type" : "US",
      "wheel_type" : "Stiletto19",
      "can_accept_navigation_requests" : true,
      "motorized_charge_port" : true,
      "rear_seat_heaters" : 1,
      "rhd" : false,
      "spoiler_type" : "None",
      "sun_roof_installed" : null,
      "use_range_badging" : true,
      "roof_color" : "Glass",
      "seat_type" : null,
      "timestamp" : 1571024714674,
      "plg" : false,
      "car_special_type" : "base",
      "key_version" : 2,
      "has_ludicrous_mode" : false,
      "rear_seat_type" : null,
      "eu_vehicle" : false
    },
    "calendar_enabled" : true,
    "display_name" : "Model 3",
    "id" : 22543022977241426,
    "backseat_token_updated_at" : null,
    "drive_state" : {
      "timestamp" : 1571024714645,
      "longitude" : -117.756636,
      "latitude" : 33.681953,
      "heading" : 312,
      "gps_as_of" : 1571024713,
      "power" : 0,
      "native_latitude" : 33.681953,
      "native_longitude" : -117.756636,
      "native_location_supported" : 1,
      "shift_state" : null,
      "speed" : null,
      "native_type" : "wgs"
    },
    "option_codes" : "AD15,MDL3,PBSB,RENA,BT37,ID3W,RF3G,S3PB,DRLH,DV2W,W39B,APF0,COUS,BC3B,CH07,PC30,FC3P,FG31,GLFR,HL31,HM31,IL31,LTPB,MR31,FM3B,RS3H,SA3P,STCP,SC04,SU3C,T3CA,TW00,TM00,UT3P,WR00,AU3P,APH3,AF00,ZCST,MI00,CDM0",
    "charge_state" : {
      "usable_battery_level" : 23,
      "battery_heater_on" : false,
      "charge_limit_soc_min" : 50,
      "max_range_charge_counter" : 0,
      "timestamp" : 1571024714650,
      "charge_enable_request" : false,
      "charge_limit_soc_max" : 100,
      "fast_charger_present" : false,
      "charge_limit_soc" : 90,
      "ideal_battery_range" : 70.760000000000005,
      "managed_charging_active" : false,
      "managed_charging_user_canceled" : false,
      "not_enough_power_to_heat" : null,
      "trip_charging" : false,
      "charge_miles_added_rated" : 0,
      "charge_energy_added" : 0,
      "charging_state" : "Stopped",
      "minutes_to_full_charge" : 0,
      "scheduled_charging_pending" : true,
      "time_to_full_charge" : 0,
      "charger_pilot_current" : 32,
      "charger_phases" : null,
      "charge_current_request_max" : 32,
      "charge_limit_soc_std" : 90,
      "charge_rate" : 0,
      "charger_actual_current" : 0,
      "charger_power" : 0,
      "est_battery_range" : 62.729999999999997,
      "battery_range" : 70.760000000000005,
      "charge_to_max_range" : false,
      "scheduled_charging_start_time" : 1571065200,
      "charge_port_door_open" : true,
      "fast_charger_brand" : "<invalid>",
      "charge_port_cold_weather_mode" : false,
      "managed_charging_start_time" : null,
      "charge_current_request" : 32,
      "conn_charge_cable" : "SAE",
      "charge_miles_added_ideal" : 0,
      "fast_charger_type" : "MCSingleWireCAN",
      "user_charge_enable_request" : null,
      "battery_level" : 23,
      "charge_port_latch" : "Engaged",
      "charger_voltage" : 2
    },
    "api_version" : 6,
    "gui_settings" : {
      "show_range_units" : false,
      "gui_temperature_units" : "F",
      "gui_charge_rate_units" : "mi\\/hr",
      "gui_24_hour_time" : false,
      "gui_range_display" : "Rated",
      "timestamp" : 1571024714673,
      "gui_distance_units" : "mi\\/hr"
    }
  }
}
"""

        do {
            let vehicleData = try JSONDecoder().decode(VehicleData.self, from: jsonString.data(using: .utf8)!)
            XCTAssertNotNil(vehicleData.id)
            XCTAssertFalse(vehicleData.id.isEmpty)
        } catch {
            print(error)
            XCTFail(error.localizedDescription)
        }
    }
}
