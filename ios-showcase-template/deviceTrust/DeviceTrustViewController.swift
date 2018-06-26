//
//  DeviceTrustViewController.swift
//  ios-showcase-template
//
//  Created by Tom Jackman on 30/11/2017.
//

import AGSSecurity
import Foundation
import Floaty

protocol DeviceTrustListener {
    func performTrustChecks() -> [SecurityCheckResult]
}

/* The view controller for the device trust view. */
class DeviceTrustViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FloatyDelegate {
    
    let RED_COLOR = UIColor(named: "Red")
    let GREEN_COLOR = UIColor(named: "Green")
    
    let CHECKS_RESULT = [DeviceLockCheck().name: [true: "Device Lock Enabled", false: "No Device Lock Enabled"],
                         NonDebugCheck().name: [true: "No Debugger Detected", false: "Debugger Detected"],
                         NonEmulatorCheck().name: [true: "No Emulator Detected", false: "Emulator Detected"],
                         NonJailbrokenCheck().name: [true: "No Jailbreak Detected", false: "Jailbreak Detected"]]
    
    let SECURE_SCORE_THREASHOLD = 70
    
    var deviceTrustListener: DeviceTrustListener?
    var deviceChecks = [SecurityCheckResult]()
    var currentScore = 0
    
    @IBOutlet var deviceTrustScore: UILabel!
    @IBOutlet weak var deviceTrustScoreLabel: UILabel!
    @IBOutlet weak var deviceTrustTestsNumberLabel: UILabel!
    @IBOutlet weak var deviceTrustRerunButton: UIButton!
    
    @IBOutlet weak var deviceTrustTableView: UITableView!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.renderRefreshButton()
        
        // don't show empty table items
        self.deviceTrustTableView.tableFooterView = UIView()
        
        // perform the detection checks
        self.performTrustChecks()
    }

    /**
     - Run the device trust checks in the service and refresh the table view with the results.
     */
    func performTrustChecks() {
        if let listener = self.deviceTrustListener {
            self.deviceChecks = listener.performTrustChecks()
            self.deviceTrustTableView.reloadData()
            self.setTrustScore()
            self.showWarningMessage()
        }
    }
    
    /**
     - Render the refresh button in the view with the create/delete all actions
     */
    func renderRefreshButton() {
        let floaty = Floaty()
        floaty.sticky = true
        floaty.buttonColor = UIColor(named: "Orange")!
        floaty.buttonImage = UIImage(named: "ic_refresh_white")!
        floaty.fabDelegate = self
        self.view.addSubview(floaty)
    }

    /**
     - Set the trust score header value in the UI.
     */
    func setTrustScore() {
        let totalTestPassed = self.deviceChecks.filter { $0.passed }.count
        self.deviceTrustTestsNumberLabel?.text = "(\(totalTestPassed) out of \(self.deviceChecks.count) Checks Passing)"
        currentScore = Int(Double(totalTestPassed) / Double(deviceChecks.count) * 100)
        self.deviceTrustScoreLabel?.text = "\(currentScore)%"
    }
    
    /**
     - Set the number of sections required in the table
     
     - Returns: The number of sections
     */
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /**
     - Set the number of rows required in the section
     
     - Returns: The number of device checks
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.deviceChecks.count
    }
    
    /**
     - Setup of the table view to reference the table in the storyboard
     
     - Returns: An individual cell in the table list
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "deviceTrustChecks"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        // Fetches the appropriate note for the data source layout.
        let detection = self.deviceChecks[indexPath.row]
        let imageView = cell.imageView!
        let textView = cell.textLabel!
        textView.isEnabled = true
        
        // set the text colouring
        if detection.passed {
            textView.text = CHECKS_RESULT[detection.name]![detection.passed]!
            textView.textColor = GREEN_COLOR
            imageView.image = UIImage(named: "ic_verified_user_white")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
            imageView.tintColor = GREEN_COLOR
        } else {
            textView.text = CHECKS_RESULT[detection.name]![!detection.passed]!
            textView.textColor = RED_COLOR
            imageView.image = UIImage(named: "ic_warning_white")?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
            imageView.tintColor = RED_COLOR
        }
        
        return cell
    }
    
    func emptyFloatySelected(_ floaty: Floaty) {
        self.performTrustChecks()
    }
    
    func showWarningMessage() {
        if self.currentScore < SECURE_SCORE_THREASHOLD {
            let alert = UIAlertController(title: "Warning", message: "Your current device trust score \(self.currentScore)% is below the specified target of \(SECURE_SCORE_THREASHOLD)%, do you want to continue or exit the app?", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Continue".uppercased(), style: .cancel)
            let exitAction = UIAlertAction(title: "Exit".uppercased(), style: .default) { action in
                exit(0)
            }
            alert.addAction(cancelAction)
            alert.addAction(exitAction)
            self.present(alert, animated: true, completion: nil)
        }
    }

    
}
