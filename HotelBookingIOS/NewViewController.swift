//
//  NewViewController.swift
//  HotelBookingIOS
//
//  Created by Ricardo T. F. Numa on 11/09/23.
//

import UIKit

class NewViewController: UIViewController, URLSessionTaskDelegate {
    let urlString = "https://ricardonumahotelbookingapi.azurewebsites.net/api/HotelBooking/CreateEdit"
    let urlEncodedHeaderField = "application/x-www-form-urlencoded"
    let contentTypeField = "Content-Type"
    let jsonHeaderField = "application/json"
    let acceptField = "Accept"
    let httpMethod = "POST"
    let clientNameJsonKey = "ClientName"
    let roomNumberJsonKey = "RoomNumber"
    let screenTitle = "New Booking"
    @IBOutlet weak var ClientNameInput: UITextField!
    @IBOutlet weak var RoomNumberInput: UITextField!
    
    
    @IBAction func CreateBookingButtonClick(_ sender: UIBarButtonItem) {
        if let clientName = ClientNameInput.text {
            if let roomNumber = RoomNumberInput.text {
                
                let url = URL(string: urlString)!
                var request = URLRequest(url: url)
                request.setValue(urlEncodedHeaderField, forHTTPHeaderField: contentTypeField)
                request.setValue(jsonHeaderField, forHTTPHeaderField: acceptField)
                request.httpMethod = httpMethod
                

                let parameters: [String: Any] = [
                    clientNameJsonKey: clientName,
                    roomNumberJsonKey: roomNumber
                ]
                request.httpBody = parameters.percentEncoded()

                let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                    
                    // Check for Error
                    if let error = error {
                        print("Error took place \(error)")
                        return
                    }
                    
                    // Convert HTTP Response Data to a String
                    if let data = data, let dataString = String(data: data, encoding: .utf8) {
                        print("Response data string:\n \(dataString)")
                        DispatchQueue.main.async {
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                }
                task.resume()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = screenTitle
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension Dictionary {
    func percentEncoded() -> Data? {
        map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowed: CharacterSet = .urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}
