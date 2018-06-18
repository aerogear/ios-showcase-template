import AGSCore
import AGSPush
import UIKit

struct PushNotificationListItem {
    static let NOTIFICATION_DATE_FORMAT = "EEE MMM dd yyyy"
    
    let dateFormatter: DateFormatter
    var body: String
    var receivedAt: Date
    var formattedReceivedAt: String {
        return self.dateFormatter.string(from: self.receivedAt)
    }
    
    init(_ body: String, _ receivedAt: Date) {
        self.body = body
        self.receivedAt = receivedAt
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateFormat = PushNotificationListItem.NOTIFICATION_DATE_FORMAT
    }
}

class PushViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!

    let notificationCellIdentifier = "PushNotificationCell"

    // holds the messages received and displayed on tableview
    var messages: Array<PushNotificationListItem> = []

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(PushViewController.messageReceived(_:)), name: Notification.Name(rawValue: "message_received"), object: nil)

//        messageReceived(Notification(name: Notification.Name(rawValue: "name"),
//                                     userInfo: ["aps": ["alert": "Local push message"]]))
    }

    @objc func messageReceived(_ notification: Notification) {
        if let userInfo = notification.userInfo!["user_info"] as? [AnyHashable: Any], let aps = userInfo["aps"] as? [String: Any], let receivedAt = notification.userInfo!["received_at"] as? Date {
            var pushMessage: String = "No data"
            // if alert is a flat string
            if let msg = aps["alert"] as? String {
                pushMessage = msg
            } else if let obj = aps["alert"] as? [String: Any], let msg = obj["body"] as? String {
                // if the alert is a dictionary we need to extract the value of the body key
                pushMessage = msg
            }
            messages.append(PushNotificationListItem(pushMessage, receivedAt))
            tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: notificationCellIdentifier)!
        let notificationIdx = (indexPath as IndexPath).row
        
        let notificationBodyLabel = cell.contentView.viewWithTag(1) as! UILabel
        let notificationReceivedLabel = cell.contentView.viewWithTag(2) as! UILabel
        
        notificationBodyLabel.text = messages[notificationIdx].body
        notificationReceivedLabel.text = messages[notificationIdx].formattedReceivedAt
        return cell
    }
}
