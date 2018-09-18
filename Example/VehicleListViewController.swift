//
//  VehicleListViewController.swift
//  AutoMate-VehicleMonitor-iOS
//
//  Created by Jaren Hamblin on 9/13/18.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import UIKit
import TeslaKit
import ObjectMapper

let teslaAPI = TeslaAPI(debugMode: true)
let userDefaults = UserDefaults.standard

class VehicleListViewController: UITableViewController {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!


    private lazy var timer: Timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(updateVehicles), userInfo: nil, repeats: true)

    private var vehicles: [Vehicle] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        teslaAPI.delegate = self
        headerLabel.text = "Vehicle Monitor"
        descriptionLabel.text = userDefaults.lastUpdatedAt
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Actions", style: .plain, target: self, action: #selector(actionsButtonAction))
        restoreSession()
    }

    @objc private func actionsButtonAction() {
        guard let vehicle = self.vehicles.first else { return }
        let actionSheet = UIAlertController(title: vehicle.displayName, message: nil, preferredStyle: .actionSheet)

        actionSheet.addAction(UIAlertAction(title: "Wake", style: .default, handler: { _ in

            teslaAPI.forceWake(vehicle) { (result, error) in

                if result {
                    self.getData(vehicle: vehicle)
                }

                self.displayAlert(title: result ? "Success" : "Failed", message: error, completion: nil)
            }

        }))
        actionSheet.addAction(UIAlertAction(title: "Unlock", style: .default, handler: { _ in

            teslaAPI.send(Command.unlockDoors, to: vehicle, completion: { response in

                self.displayAlert(title: response.result ? "Success" : "Failed", message: response.allErrorMessages, completion: nil)
            })

        }))

        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vehicles.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "default", for: indexPath)
        let vehicle = self.vehicles[indexPath.row]
        cell.textLabel?.text = vehicle.displayName
        cell.detailTextLabel?.text = vehicle.status.description
        return cell
    }

    private func restoreSession() {

        let accessToken = userDefaults.accessToken ?? AccessToken.Response()
        let accessTokenIsExpired = accessToken.isExpired

        if accessTokenIsExpired {

            if let email = userDefaults.email, let password = userDefaults.password {

                self.login(email: email, password: password)

            } else {

                self.presentLoginAlert()
            }

        } else {

            teslaAPI.setAccessToken(accessToken.accessToken)
            timer.fire()
        }
    }

    private func presentLoginAlert() {

        let alert = UIAlertController(title: "", message: "Enter your Tesla account credentials", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Email"
        }

        alert.addTextField { textField in
            textField.placeholder = "Password"
            textField.isSecureTextEntry = true
        }
        alert.addAction(UIAlertAction(title: "Login", style: .default, handler: { _ in
            let email = alert.textFields?.first?.text ?? ""
            let password = alert.textFields?.last?.text ?? ""
            self.login(email: email, password: password)
        }))

        self.present(alert, animated: true, completion: nil)
    }

    private func login(email: String, password: String) {

        teslaAPI.getAccessToken(email: email, password: password) { (response, data, error) in

            guard let data = data, response.statusCode == 200 else {
                self.displayAlert(title: "Authentication Failed", message: error?.localizedDescription ?? HTTPURLResponse.localizedString(forStatusCode: response.statusCode)) {
                    self.presentLoginAlert()
                }
                return
            }

            userDefaults.email = email
            userDefaults.password = password
            userDefaults.accessToken = data

            teslaAPI.setAccessToken(data.accessToken)

            self.timer.fire()
        }
    }

    @objc private func updateVehicles() {

        let isExpired = userDefaults.accessToken?.isExpired ?? true
        guard !isExpired else { return }

        teslaAPI.getVehicles { (response, data, error) in

            guard let data = data, response.statusCode == 200 else { return }

            self.vehicles = data.vehicles

            userDefaults.lastUpdatedAt = String(describing: Date())

            self.descriptionLabel.text = userDefaults.lastUpdatedAt
        }
    }

    func displayAlert(title: String, message: String?, completion: (() -> Void)?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: { _ in
                completion?()
            }))
            self.present(alert, animated: true)
        }
    }

    private func getData(vehicle: Vehicle) {

        let maxAttempts = 10
        var attempts = 0

        guard attempts < maxAttempts else {
            print("forceWake", "data request max attempts reached")
            return
        }

        print("forceWake", "requesting data")

        teslaAPI.getData(for: vehicle) { (response, data, error) in

            attempts += 1

            guard response.statusCode == 200 else {
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                    self.getData(vehicle: vehicle)
                }
                return
            }

            print("forceWake", "received data!")
        }
    }
}

extension VehicleListViewController: TeslaAPIDelegate {

    func teslaApiActivityDidBegin(_ teslaAPI: TeslaAPI) {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
    }

    func teslaApiActivityDidEnd(_ teslaAPI: TeslaAPI, response: HTTPURLResponse, error: Error?) {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }

    func teslaApi(_ teslaAPI: TeslaAPI, didSend command: Command, data: CommandResponse?, result: CommandResponse) {

    }
}

extension TeslaAPI {

    func forceWake(_ vehicle: Vehicle, completion: @escaping (Bool, String?) -> Void) {

        let maxAttempts: Int = 5
        var attempts: Int = 0
        var errorMessages: [String] = []


        func completionHandler(result: Bool, errorMessage: String?) {
            DispatchQueue.main.async {
                completion(result, errorMessage)
            }
        }

        func performForceWake() {

            print("forceWake", "waking")

            self.wake(vehicle) { (result, data, error) in
                let status = data?.status ?? .asleep
                if let error = error {
                    errorMessages.append(error)
                }


                if let error = error {
                    errorMessages.append(error)
                }

                print("forceWake", status.description)

                guard result else {
                    attempts += 1
                    if attempts >= maxAttempts {
                        print("forceWake", "max attempts reached")
                        completionHandler(result: false, errorMessage: errorMessages.joined(separator: ".\n"))
                    } else {
                        print("forceWake", "retrying")
                    }
                    return
                }

                switch status {
                case .asleep, .offline:
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                        performForceWake()
                    }
                case .online:
                    print("forceWake", "success!")
                    completionHandler(result: true, errorMessage: nil)
                }
            }
        }

        performForceWake()
    }
}

extension UserDefaults {

    var email: String? {
        get {
            return self.string(forKey: "email")
        }
        set {
            self.set(newValue, forKey: "email")
            self.synchronize()
        }
    }

    var password: String? {
        get {
            return self.string(forKey: "password")
        }
        set {
            self.set(newValue, forKey: "password")
            self.synchronize()
        }
    }

    var accessToken: AccessToken.Response? {
        get {
            guard let jsonString = self.string(forKey: "access_token") else { return nil }
            return Mapper<AccessToken.Response>().map(JSONString: jsonString)
        }
        set {
            self.set(newValue?.toJSONString(), forKey: "access_token")
            self.synchronize()
        }
    }

    var lastUpdatedAt: String? {
        get {
            return self.string(forKey: "lastUpdatedAt")
        }
        set {
            self.set(newValue, forKey: "lastUpdatedAt")
            self.synchronize()
        }
    }
}

