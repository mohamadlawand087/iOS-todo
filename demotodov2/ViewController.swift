//
//  ViewController.swift
//  demotodov2
//
//  Created by Mohamad Lawand on 09/03/2022.
//

import UIKit

class ViewController: UIViewController {

    // Initialising an empty TodoItem Array
    var allItems = [TodoItem]()
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        
        loadItems()
    }
    
    func loadItems() {
        let apiUrl = "http://localhost:5000/api/Todo"
        
        // Checking if the apiUrl is empty or not
        if let url = URL(string: apiUrl)
        {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    print(String(data: safeData, encoding: .utf8))
                    self.parseJson(todoData: safeData)
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
            
            task.resume()
            self.tableView.reloadData()
        }
        
    }
    
    func parseJson(todoData: Data) {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode([TodoItem].self, from: todoData)
            allItems = decodedData
        } catch {
            print(error)
        }
        
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProtoCell", for: indexPath)
        cell.textLabel?.text = allItems[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allItems.count
    }
}
