//
//  VehicleListViewController.swift
//  AutoMate-VehicleMonitor-iOS
//
//  Created by Jaren Hamblin on 9/13/18.
//  Copyright © 2018 HamblinSoft. All rights reserved.
//

import UIKit
import TeslaKit

let teslaAPI = TeslaAPI(debugMode: true)
let userDefaults = UserDefaults.standard

class VehicleListViewController: UITableViewController {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    private var vehicle: Vehicle?

    private var vehicles: [Vehicle] = [] {
        didSet {
            if vehicleUpdaters.count != vehicles.count {
                tableView.reloadData()
                vehicleUpdaters.forEach{$0.stopUpdating()}
                vehicleUpdaters = vehicles.map { vehicle in
                    let updater = VehicleUpdater(teslaAPI: teslaAPI)
                    updater.setVehicle(vehicle)
                    return updater
                }
                vehicleUpdaters.forEach{$0.startUpdating()}
            }
        }
    }

    private var vehicleUpdaters: [VehicleUpdater] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        teslaAPI.delegate = self

        headerLabel.text = "Vehicle Monitor"

        descriptionLabel.text = userDefaults.lastUpdatedAt

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Actions", style: .plain, target: self, action: #selector(actionsButtonAction))

        NotificationCenter.default.addObserver(self, selector: #selector(vehicleDidUpdate), name: VehicleUpdater.didUpdateNotification, object: self)

        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshHandler(_:)), for: .valueChanged)

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            self.restoreSession()
        }
    }

    @objc private func refreshHandler(_ sender: UIRefreshControl?) {
        reloadVehicles { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
            sender?.endRefreshing()
        }
    }

    @objc private func vehicleDidUpdate() {
        tableView.reloadData()
        userDefaults.lastUpdatedAt = String(describing: Date())
        self.descriptionLabel.text = userDefaults.lastUpdatedAt
    }

    @objc private func actionsButtonAction() {
        guard let vehicle = self.vehicle else { return }
        let actionSheet = UIAlertController(title: vehicle.displayName, message: nil, preferredStyle: .actionSheet)

        actionSheet.addAction(UIAlertAction(title: "Wake", style: .default, handler: { _ in

            teslaAPI.forceWake(vehicle) { (isAwake, response) in

                self.displayAlert(title: isAwake ? "Success" : "Failed",
                                  message: response.error?.localizedDescription ?? response.localizedStatusCodeDescription,
                                  completion: nil)
            }

        }))

        actionSheet.addAction(UIAlertAction(title: "Sentry Mode On", style: .default, handler: { _ in

            teslaAPI.send(.sentryMode(SentryModeOptions(isOn: true)), to: vehicle) { response in

                self.displayAlert(title: response.result ? "Success" : "Failed",
                                  message: response.allErrorMessages,
                                  completion: nil)
            }
        }))

        actionSheet.addAction(UIAlertAction(title: "Sentry Mode Off", style: .default, handler: { _ in

            teslaAPI.send(.sentryMode(SentryModeOptions(isOn: false)), to: vehicle) { response in

                self.displayAlert(title: response.result ? "Success" : "Failed",
                                  message: response.allErrorMessages,
                                  completion: nil)
            }
        }))

        actionSheet.addAction(UIAlertAction(title: "Send Address", style: .default, handler: { _ in
            let address: String = """
            3995 Alton Pkwy
            Irvine, CA  92606
            United States
            """

            teslaAPI.send(.navigationRequest(NavigationRequestOptions(address: address)), to: vehicle) { response in
                self.displayAlert(title: response.result ? "Success" : "Failed",
                                  message: response.allErrorMessages,
                                  completion: nil)
            }
        }))

        actionSheet.addAction(UIAlertAction(title: "Start AC", style: .default, handler: { _ in

            teslaAPI.send(Command.startHVAC, to: vehicle, completion: { response in

                self.displayAlert(title: response.result ? "Success" : "Failed",
                                  message: response.allErrorMessages,
                                  completion: nil)
            })

        }))



        let mediaCommands: [Command] = [
            .togglePlayback,
            .nextTrack,
            .previousTrack,
            .nextFavorite,
            .previousFavorite,
            .volumeUp,
            .volumeDown
        ]

        mediaCommands.forEach { command in

            actionSheet.addAction(UIAlertAction(title: command.rawValue, style: .default, handler: { _ in

                teslaAPI.send(command, to: vehicle, completion: { response in

                    self.displayAlert(title: response.result ? "Success" : "Failed",
                                      message: response.allErrorMessages,
                                      completion: nil)
                })

            }))
        }


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
        cell.detailTextLabel?.text = vehicle.state.description
        return cell
    }

    private func restoreSession() {

        let accessToken = userDefaults.accessToken ?? AccessToken.Response(accessToken: nil, tokenType: nil, expiresIn: nil, createdAt: nil, refreshToken: nil)
        let accessTokenIsExpired = accessToken.isExpired

        if accessTokenIsExpired {

            if let email = userDefaults.email, let password = userDefaults.password {

                self.login(email: email, password: password)

            } else {

                self.presentLoginAlert()
            }

        } else {

            teslaAPI.setAccessToken(accessToken.accessToken)
            reloadVehicles(completion: nil)
        }
    }

    private func reloadVehicles(completion: (() -> Void)?) {

        teslaAPI.vehicles { [weak self] res in

            guard let self = self else { return }

            if let data = res.data {
                self.vehicles = data.vehicles

                if self.vehicle == nil {
                    self.vehicle = self.vehicles.first
                }

                completion?()
            }
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

        teslaAPI.getAccessToken(email: email, password: password) { response in

            guard let data = response.data, response.statusCode == 200 else {
                self.displayAlert(title: "Authentication Failed", message: response.error?.localizedDescription ?? HTTPURLResponse.localizedString(forStatusCode: response.statusCode)) {
                    self.presentLoginAlert()
                }
                return
            }

            userDefaults.email = email
            userDefaults.password = password
            userDefaults.accessToken = data

            teslaAPI.setAccessToken(data.accessToken)

            self.refreshHandler(nil)
        }
    }

    @objc private func updateVehicles() {

        let isExpired = userDefaults.accessToken?.isExpired ?? true
        guard !isExpired else { return }

        teslaAPI.vehicles { response in

            guard let data = response.data, response.statusCode == 200 else { return }

            self.vehicles = data.vehicles

            userDefaults.lastUpdatedAt = String(describing: Date())

            self.descriptionLabel.text = userDefaults.lastUpdatedAt

            guard let vehicle = data.vehicles.first else { return }

            teslaAPI.wake(vehicle) { (isAwake, _) in

                guard isAwake else { return }

                teslaAPI.getData(for: vehicle) { response in

                    self.vehicle = response.data
                    print(data)
                }
            }
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
            guard let jsonData = self.data(forKey: "access_token") else { return nil }
            return JSONDecoder().decode(jsonData)
        }
        set {
            self.set(newValue?.toJSONData(), forKey: "access_token")
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
